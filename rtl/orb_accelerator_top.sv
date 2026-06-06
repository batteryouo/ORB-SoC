// orb_accelerator_top.sv
// Top-level AXI-Stream Wrapper for FAST-9 IP

module orb_accelerator_top (
  input  logic    clk,
  input  logic    resetn,

  // Configuration (Can be connected to AXI-Lite later)
  input  logic [15:0] image_width,
  input  logic [7:0]  threshold,

  // AXI-Stream Slave (Image In from DMA)
  input  logic [7:0]  s_axis_tdata,
  input  logic    s_axis_tvalid,
  output logic    s_axis_tready,
  input  logic    s_axis_tlast,

  // AXI-Stream Master (Keypoint Out to DMA)
  output logic [31:0] m_axis_tdata,
  output logic    m_axis_tvalid,
  input  logic    m_axis_tready,
  output logic    m_axis_tlast,

  // Interrupt
  output logic    irq_done
);

  // =========================================================================
  // 1. FAST Detector Instantiation
  // =========================================================================
  logic    fast_is_corner;
  logic [15:0] fast_x;
  logic [15:0] fast_y;
  logic [7:0]  fast_score;
  logic    fast_valid;

  fast_detector_top inst_fast (
    .clk       (clk),
    .resetn    (resetn),
    .image_width   (image_width),
    .threshold   (threshold),
    .s_axis_tdata  (s_axis_tdata),
    .s_axis_tvalid (s_axis_tvalid & s_axis_tready), // Only valid if we are ready
    .out_is_corner (fast_is_corner),
    .out_x     (fast_x),
    .out_y     (fast_y),
    .out_score   (fast_score),
    .out_valid   (fast_valid)
  );

  // =========================================================================
  // 2. AXI-Stream Packetizer State Machine
  // =========================================================================
  typedef enum logic [1:0] {
    IDLE,
    SEND_KP,
    DONE_FRAME
  } state_t;

  state_t current_state, next_state;
  logic [3:0] word_counter; // Counts from 0 to 10 (11 words total)

  // Sequential Logic
  always_ff @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      current_state <= IDLE;
      word_counter  <= 4'd0;
    end else begin
      current_state <= next_state;
      
      // Counter management
      if (current_state == SEND_KP && m_axis_tvalid && m_axis_tready) begin
        if (word_counter == 4'd10) begin
          word_counter <= 4'd0;
        end else begin
          word_counter <= word_counter + 4'd1;
        end
      end
    end
  end

  // Combinational Logic for Next State
  always_comb begin
    next_state = current_state;
    case (current_state)
      IDLE: begin
        if (fast_valid && fast_is_corner) begin
          next_state = SEND_KP;
        end else if (s_axis_tvalid && s_axis_tlast && s_axis_tready) begin
          // Image finished
          next_state = DONE_FRAME;
        end
      end
      
      SEND_KP: begin
        // Return to IDLE after sending the 11th word
        if (word_counter == 4'd10 && m_axis_tready) begin
          next_state = IDLE;
        end
      end
      
      DONE_FRAME: begin
        next_state = IDLE;
      end
    endcase
  end

  // =========================================================================
  // 3. Output Assignments
  // =========================================================================
  
  // We stall the incoming image stream if we are busy sending a keypoint packet
  // Note: In a fully pipelined design, a FIFO should be placed between FAST and this packetizer
  assign s_axis_tready = (current_state == IDLE) ? 1'b1 : 1'b0;

  // AXI-Stream Master outputs
  always_comb begin
    m_axis_tvalid = 1'b0;
    m_axis_tdata  = 32'd0;
    
    if (current_state == SEND_KP) begin
      m_axis_tvalid = 1'b1;
      case (word_counter)
        4'd0: m_axis_tdata = {fast_y, fast_x};          // Word 0: y, x
        4'd1: m_axis_tdata = {16'd0, 8'd0, fast_score};       // Word 1: angle(0), response(score)
        // Word 2 to 9 will default to 32'd0 (Descriptor zeros)
        // Word 10 will default to 32'd0 (Padding zeros)
        default: m_axis_tdata = 32'd0;
      endcase
    end
  end

  // Interrupt logic
  assign irq_done   = (current_state == DONE_FRAME) ? 1'b1 : 1'b0;
  // For TLAST, usually you assert it on the very last word of the very last keypoint. 
  // For simplicity in bare-metal, DMA might just rely on a fixed length or we tie it to 0.
  assign m_axis_tlast = 1'b0; 

endmodule