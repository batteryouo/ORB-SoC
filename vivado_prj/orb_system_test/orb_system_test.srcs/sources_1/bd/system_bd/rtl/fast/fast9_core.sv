// fast9_core.sv
// Pure combinational/pipelined core for FAST-9 corner detection

module fast9_core (
  input  logic    clk,
  input  logic    resetn,
  
  // Configuration
  input  logic [7:0]  threshold,

  // Input Window from window_generator
  input  logic [7:0]  window_7x7 [0:6][0:6],
  input  logic    window_valid,

  // Output Results
  output logic    is_corner,
  output logic [7:0]  center_pixel_val,
  output logic    out_valid
);

  // =========================================================================
  // 1. Extract Center and Circle Pixels
  // =========================================================================
  logic [7:0] Ip;
  logic [7:0] p [0:15];

  always_comb begin
    Ip  = window_7x7[3][3];
    // Bresenham circle of radius 3
    p[0]  = window_7x7[0][3];
    p[1]  = window_7x7[0][4];
    p[2]  = window_7x7[1][5];
    p[3]  = window_7x7[2][6];
    p[4]  = window_7x7[3][6];
    p[5]  = window_7x7[4][6];
    p[6]  = window_7x7[5][5];
    p[7]  = window_7x7[6][4];
    p[8]  = window_7x7[6][3];
    p[9]  = window_7x7[6][2];
    p[10] = window_7x7[5][1];
    p[11] = window_7x7[4][0];
    p[12] = window_7x7[3][0];
    p[13] = window_7x7[2][0];
    p[14] = window_7x7[1][1];
    p[15] = window_7x7[0][2];
  end

  // =========================================================================
  // 2. Safe Threshold Calculation (Avoid 8-bit Overflow/Underflow)
  // =========================================================================
  logic [8:0] Ip_plus_t;
  logic [8:0] Ip_minus_t;

  always_comb begin
    Ip_plus_t  = {1'b0, Ip} + {1'b0, threshold};
    // If Ip < threshold, clip to 0 to prevent underflow
    Ip_minus_t = (Ip >= threshold) ? ({1'b0, Ip} - {1'b0, threshold}) : 9'd0;
  end

  // =========================================================================
  // 3. Generate 16-bit Masks
  // =========================================================================
  logic [15:0] brighter_mask;
  logic [15:0] darker_mask;

  always_comb begin
    for (int i = 0; i < 16; i++) begin
      brighter_mask[i] = ({1'b0, p[i]} > Ip_plus_t);
      darker_mask[i]   = ({1'b0, p[i]} < Ip_minus_t);
    end
  end

  // =========================================================================
  // 4. Ring Unrolling & 9-Consecutive Check
  // =========================================================================
  // We concatenate the 16-bit mask with its lower 15 bits to simulate a ring
  logic [30:0] b_ring;
  logic [30:0] d_ring;
  
  assign b_ring = {brighter_mask[14:0], brighter_mask};
  assign d_ring = {darker_mask[14:0], darker_mask};

  logic [15:0] b_match;
  logic [15:0] d_match;

  always_comb begin
    for (int i = 0; i < 16; i++) begin
      // Check if 9 consecutive bits starting from 'i' are all 1s (Bitwise AND reduction)
      b_match[i] = &b_ring[i +: 9];
      d_match[i] = &d_ring[i +: 9];
    end
  end

  // =========================================================================
  // 5. Output Stage (Registered for Timing)
  // =========================================================================
  always_ff @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      is_corner    <= 1'b0;
      center_pixel_val <= 8'd0;
      out_valid    <= 1'b0;
    end else begin
      // If any of the 16 possible 9-streaks is true, it's a corner! (Bitwise OR reduction)
      is_corner    <= (|b_match) | (|d_match);
      center_pixel_val <= Ip;
      out_valid    <= window_valid;
    end
  end

endmodule