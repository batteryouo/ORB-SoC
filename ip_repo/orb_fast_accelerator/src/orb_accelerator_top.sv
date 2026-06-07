// orb_accelerator_top.sv
// Top-level AXI-Stream Wrapper (Standalone FAST-9, No NMS)

module orb_accelerator_top (
  input  logic        clk,
  input  logic        resetn,

  input  logic [15:0] image_width,
  input  logic [7:0]  threshold,

  input  logic [7:0]  s_axis_tdata,
  input  logic        s_axis_tvalid,
  output logic        s_axis_tready,
  input  logic        s_axis_tlast,

  output logic [31:0] m_axis_tdata,
  output logic [3:0]  m_axis_tkeep, // <-- THIS WAS MISSING IN YOUR FILE!
  output logic        m_axis_tvalid,
  input  logic        m_axis_tready,
  output logic        m_axis_tlast,

  output logic        irq_done
);

  // Tie TKEEP to all 1s (all 4 bytes are valid in every 32-bit word)
  assign m_axis_tkeep = 4'hF;

  // FAST Detector Signals
  logic        fast_is_corner;
  logic [15:0] fast_x;
  logic [15:0] fast_y;
  logic [7:0]  fast_score;
  logic        fast_valid;

  // Pipeline Flush Signals
  logic        flush_active;
  logic [15:0] flush_counter;
  logic        fast_eof;
  logic        int_tvalid;
  logic [7:0]  int_tdata;

  // State Machine Ready Signal
  logic        pkt_ready;

  always_ff @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      flush_active  <= 1'b0;
      flush_counter <= 16'd0;
      fast_eof      <= 1'b0;
    end else begin
      fast_eof <= 1'b0;
      // Trigger flush when TLAST is received
      if (s_axis_tvalid && s_axis_tready && s_axis_tlast) begin
        flush_active  <= 1'b1;
        flush_counter <= (image_width * 16'd3) + 16'd10; 
      end 
      // Process flush only when packetizer is ready
      else if (flush_active && pkt_ready) begin
        if (flush_counter > 0) begin
          flush_counter <= flush_counter - 16'd1;
        end else begin
          fast_eof     <= 1'b1; 
          flush_active <= 1'b0;
        end
      end
    end
  end

  assign int_tvalid    = (s_axis_tvalid && !flush_active) || flush_active;
  assign int_tdata     = (s_axis_tvalid && !flush_active) ? s_axis_tdata : 8'd0;
  assign s_axis_tready = pkt_ready && !flush_active; 

  fast_detector_top inst_fast (
    .clk           (clk),
    .resetn        (resetn),
    .image_width   (image_width),
    .threshold     (threshold),
    .s_axis_tdata  (int_tdata),
    .s_axis_tvalid (int_tvalid & pkt_ready), 
    .out_is_corner (fast_is_corner),
    .out_x         (fast_x),
    .out_y         (fast_y),
    .out_score     (fast_score),
    .out_valid     (fast_valid)
  );

  typedef enum logic [1:0] {
    IDLE,
    SEND_KP,
    DONE_FRAME
  } state_t;

  state_t current_state, next_state;
  logic [3:0]  word_counter;
  
  logic [15:0] hold_x, hold_y;
  logic [7:0]  hold_score;

  always_ff @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      current_state <= IDLE;
      word_counter  <= 4'd0;
      hold_x        <= 16'd0;
      hold_y        <= 16'd0;
      hold_score    <= 8'd0;
    end else begin
      current_state <= next_state;
      
      if (current_state == IDLE && fast_valid) begin
        hold_x     <= fast_x;
        hold_y     <= fast_y;
        hold_score <= fast_score;
      end

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
        if (fast_eof) begin
          next_state = DONE_FRAME;
        end else if (fast_valid) begin
          next_state = SEND_KP;
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

  always_comb begin
    m_axis_tvalid = 1'b0;
    m_axis_tdata  = 32'd0;
    m_axis_tlast  = 1'b0;
    
    if (current_state == SEND_KP) begin
      m_axis_tvalid = 1'b1;
      case (word_counter)
        4'd0: m_axis_tdata = {hold_y, hold_x};
        4'd1: m_axis_tdata = 32'd0;                   // angle/octave/padding = 0
        4'd2: m_axis_tdata = {24'd0, hold_score};      // response = score
        default: m_axis_tdata = 32'd0;
      endcase
    end 
    else if (current_state == DONE_FRAME) begin
      m_axis_tvalid = 1'b1;
      m_axis_tdata  = 32'hFFFFFFFF; 
      m_axis_tlast  = 1'b1;
    end
  end

  assign irq_done = (current_state == DONE_FRAME && m_axis_tready) ? 1'b1 : 1'b0;

endmodule