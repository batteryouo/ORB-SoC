// orb_accelerator_top.sv
// Top-level AXI-Stream Wrapper with Grid-based NMS and Pipelined EOF

module orb_accelerator_top (
  input  logic    clk,
  input  logic    resetn,

  input  logic [15:0] image_width,
  input  logic [7:0]  threshold,

  input  logic [7:0]  s_axis_tdata,
  input  logic    s_axis_tvalid,
  output logic    s_axis_tready,
  input  logic    s_axis_tlast,

  output logic [31:0] m_axis_tdata,
  output logic    m_axis_tvalid,
  input  logic    m_axis_tready,
  output logic    m_axis_tlast,

  output logic    irq_done
);

  // 1. FAST Detector
  logic    fast_is_corner;
  logic [15:0] fast_x;
  logic [15:0] fast_y;
  logic [7:0]  fast_score;
  logic    fast_valid;
  logic    nms_ready; 

  fast_detector_top inst_fast (
    .clk       (clk),
    .resetn    (resetn),
    .image_width   (image_width),
    .threshold   (threshold),
    .s_axis_tdata  (s_axis_tdata),
    .s_axis_tvalid (s_axis_tvalid & nms_ready),
    .out_is_corner (fast_is_corner),
    .out_x     (fast_x),
    .out_y     (fast_y),
    .out_score   (fast_score),
    .out_valid   (fast_valid)
  );

  assign s_axis_tready = nms_ready; 

  // Pipelined EOF Detection
  logic    eof_active;
  logic [15:0] eof_delay_counter;
  logic    fast_eof;

  always_ff @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      eof_active    <= 1'b0;
      eof_delay_counter <= 16'd0;
      fast_eof      <= 1'b0;
    end else begin
      fast_eof <= 1'b0; 
      
      if (s_axis_tvalid && s_axis_tready && s_axis_tlast) begin
        eof_active <= 1'b1;
        // Delay roughly covers the line buffers + pipeline depth
        eof_delay_counter <= (image_width * 16'd3) + 16'd10;
      end 
      else if (eof_active && s_axis_tready) begin
        if (eof_delay_counter > 0) begin
          eof_delay_counter <= eof_delay_counter - 16'd1;
        end else begin
          fast_eof   <= 1'b1; 
          eof_active <= 1'b0;
        end
      end
    end
  end

  // 2. Grid-based NMS Filter
  logic    nms_out_valid;
  logic [15:0] nms_out_x;
  logic [15:0] nms_out_y;
  logic [7:0]  nms_out_score;
  logic    nms_out_eof;
  logic    pkt_ready; 

  fast_nms_filter #(
    .GRID_SIZE_LOG2(4),
    .MAX_GRIDS_X(40)
  ) inst_nms (
    .clk    (clk),
    .resetn   (resetn),
    .in_valid   (fast_valid), 
    .in_x     (fast_x),
    .in_y     (fast_y),
    .in_score   (fast_score),
    .in_eof   (fast_eof),
    .in_ready   (nms_ready),
    .out_valid  (nms_out_valid),
    .out_x    (nms_out_x),
    .out_y    (nms_out_y),
    .out_score  (nms_out_score),
    .out_eof  (nms_out_eof),
    .out_ready  (pkt_ready)
  );

  // 3. AXI-Stream Packetizer State Machine
  typedef enum logic [1:0] {
    IDLE,
    SEND_KP,
    DONE_FRAME
  } state_t;

  state_t current_state, next_state;
  logic [3:0] word_counter;

  always_ff @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      current_state <= IDLE;
      word_counter  <= 4'd0;
    end else begin
      current_state <= next_state;
      if (current_state == SEND_KP && m_axis_tvalid && m_axis_tready) begin
        if (word_counter == 4'd10) word_counter <= 4'd0;
        else word_counter <= word_counter + 4'd1;
      end
    end
  end

  always_comb begin
    next_state = current_state;
    pkt_ready  = 1'b0;

    case (current_state)
      IDLE: begin
        pkt_ready = 1'b1;
        if (nms_out_valid) begin
          if (nms_out_eof) begin
            next_state = DONE_FRAME;
          end else begin
            next_state = SEND_KP;
          end
        end
      end
      SEND_KP: begin
        if (word_counter == 4'd10 && m_axis_tready) begin
          next_state = IDLE;
        end
      end
      DONE_FRAME: begin
        if (m_axis_tready) next_state = IDLE;
      end
    endcase
  end

  // 4. Output Assignments & Dummy Padding
  always_comb begin
    m_axis_tvalid = 1'b0;
    m_axis_tdata  = 32'd0;
    m_axis_tlast  = 1'b0;
    
    if (current_state == SEND_KP) begin
      m_axis_tvalid = 1'b1;
      case (word_counter)
        4'd0: m_axis_tdata = {nms_out_y, nms_out_x};    // Word 0: y, x
        4'd1: m_axis_tdata = {16'd0, 8'd0, nms_out_score};// Word 1: pad, oct, ang, score
        default: m_axis_tdata = 32'd0;          // Words 2-10: Zeros
      endcase
    end 
    else if (current_state == DONE_FRAME) begin
      m_axis_tvalid = 1'b1;
      m_axis_tdata  = 32'hFFFFFFFF; // EOF marker
      m_axis_tlast  = 1'b1;
    end
  end

  assign irq_done = (current_state == DONE_FRAME && m_axis_tready) ? 1'b1 : 1'b0;

endmodule