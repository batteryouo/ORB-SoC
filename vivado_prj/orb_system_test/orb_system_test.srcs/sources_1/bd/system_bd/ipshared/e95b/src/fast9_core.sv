// fast9_core.sv(test)
// FIXED: Added enable input to stall pipeline correctly

module fast9_core (
  input  logic       clk,
  input  logic       resetn,
  input  logic       enable,   // Stalls pipeline if downstream is busy
  
  input  logic [7:0] threshold,
  input  logic [7:0] window_7x7 [0:6][0:6],
  input  logic       window_valid,

  output logic       is_corner,
  output logic [7:0] center_pixel_val,
  output logic       out_valid
);

  logic [7:0] Ip;
  logic [7:0] p [0:15];

  always_comb begin
    Ip    = window_7x7[3][3];
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

  logic [8:0] stg1_Ip_plus_t;
  logic [8:0] stg1_Ip_minus_t;
  logic [7:0] stg1_p  [0:15];
  logic [7:0] stg1_Ip;
  logic       stg1_valid;

  always_ff @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      stg1_Ip_plus_t  <= 9'd0;
      stg1_Ip_minus_t <= 9'd0;
      stg1_Ip         <= 8'd0;
      stg1_valid      <= 1'b0;
      for (int i = 0; i < 16; i++) stg1_p[i] <= 8'd0;
    end else if (enable) begin // CRITICAL: Stall protection
      stg1_Ip_plus_t  <= {1'b0, Ip} + {1'b0, threshold};
      stg1_Ip_minus_t <= (Ip >= threshold) ? ({1'b0, Ip} - {1'b0, threshold}) : 9'd0;
      stg1_Ip         <= Ip;
      stg1_valid      <= window_valid;
      stg1_p          <= p;
    end
  end

  logic [15:0] brighter_mask;
  logic [15:0] darker_mask;
  logic [30:0] b_ring;
  logic [30:0] d_ring;
  logic [15:0] b_match;
  logic [15:0] d_match;

  always_comb begin
    for (int i = 0; i < 16; i++) begin
      brighter_mask[i] = ({1'b0, stg1_p[i]} > stg1_Ip_plus_t);
      darker_mask[i]   = ({1'b0, stg1_p[i]} < stg1_Ip_minus_t);
    end
    
    b_ring = {brighter_mask[14:0], brighter_mask};
    d_ring = {darker_mask[14:0], darker_mask};

    for (int i = 0; i < 16; i++) begin
      b_match[i] = &b_ring[i +: 9];
      d_match[i] = &d_ring[i +: 9];
    end
  end

  always_ff @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      is_corner        <= 1'b0;
      center_pixel_val <= 8'd0;
      out_valid        <= 1'b0;
    end else if (enable) begin // CRITICAL: Stall protection
      is_corner        <= (|b_match) | (|d_match);
      center_pixel_val <= stg1_Ip;
      out_valid        <= stg1_valid;
    end
  end

endmodule