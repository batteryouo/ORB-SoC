module fast9_core (
  input  logic       clk,
  input  logic       resetn,
  input  logic       enable,

  input  logic [7:0] threshold,
  input  logic [7:0] window_7x7 [0:6][0:6],
  input  logic       window_valid,

  output logic       is_corner,
  output logic [7:0] corner_score,
  output logic       out_valid
);

  logic [7:0] Ip;
  logic [7:0] p [0:15];

  function automatic [7:0] min8(
    input [7:0] a,
    input [7:0] b
  );
    begin
      min8 = (a < b) ? a : b;
    end
  endfunction

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
  logic [7:0] stg1_p [0:15];
  logic [7:0] stg1_abs_diff [0:15];
  logic       stg1_valid;

  always_ff @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      stg1_Ip_plus_t <= '0;
      stg1_Ip_minus_t <= '0;
      stg1_valid <= 1'b0;
      for (int i=0;i<16;i++) begin
        stg1_p[i] <= '0;
        stg1_abs_diff[i] <= '0;
      end
    end else if (enable) begin
      stg1_Ip_plus_t <= {1'b0,Ip}+{1'b0,threshold};
      stg1_Ip_minus_t <= (Ip>=threshold)?({1'b0,Ip}-{1'b0,threshold}):9'd0;
      stg1_valid <= window_valid;
      for (int i=0;i<16;i++) begin
        stg1_p[i] <= p[i];
        stg1_abs_diff[i] <= (p[i] >= Ip) ? (p[i]-Ip) : (Ip-p[i]);
      end
    end
  end

  logic [15:0] brighter_mask, darker_mask;
  logic [30:0] b_ring, d_ring;
  logic [15:0] b_match, d_match;

  always_comb begin
    for (int i=0;i<16;i++) begin
      brighter_mask[i] = ({1'b0,stg1_p[i]} > stg1_Ip_plus_t);
      darker_mask[i]   = ({1'b0,stg1_p[i]} < stg1_Ip_minus_t);
    end

    b_ring = {brighter_mask[14:0], brighter_mask};
    d_ring = {darker_mask[14:0], darker_mask};

    for (int i=0;i<16;i++) begin
      b_match[i] = &b_ring[i +: 9];
      d_match[i] = &d_ring[i +: 9];
    end
  end

  logic       stg2_corner;
  logic [7:0] stg2_score;
  logic       stg2_valid;

  logic [7:0] brighter_min_diff;
  logic [7:0] darker_min_diff;
  logic [7:0] computed_score;

  logic [7:0] bright_val [0:15];
  logic [7:0] dark_val   [0:15];
  always_comb begin
    for (int i=0;i<16;i++) begin
      bright_val[i] = brighter_mask[i] ? stg1_abs_diff[i] : 8'hFF;
      dark_val[i]   = darker_mask[i]   ? stg1_abs_diff[i] : 8'hFF;
    end
  end

  logic [7:0] b_l1 [0:7];
  logic [7:0] d_l1 [0:7];
  always_comb begin
    for (int i=0;i<8;i++) begin
      b_l1[i] = min8(bright_val[2*i], bright_val[2*i+1]);
      d_l1[i] = min8(dark_val[2*i], dark_val[2*i+1]);
    end
  end

  logic [7:0] b_l2 [0:3];
  logic [7:0] d_l2 [0:3];
  always_comb begin
    for (int i=0;i<4;i++) begin
      b_l2[i] = min8(b_l1[2*i], b_l1[2*i+1]);
      d_l2[i] = min8(d_l1[2*i], d_l1[2*i+1]);
    end
  end

  logic [7:0] b_l3 [0:1];
  logic [7:0] d_l3 [0:1];
  always_comb begin
    b_l3[0] = min8(b_l2[0], b_l2[1]);
    b_l3[1] = min8(b_l2[2], b_l2[3]);

    d_l3[0] = min8(d_l2[0], d_l2[1]);
    d_l3[1] = min8(d_l2[2], d_l2[3]);
  end

  always_comb begin
    brighter_min_diff = min8(b_l3[0], b_l3[1]);
    darker_min_diff   = min8(d_l3[0], d_l3[1]);
  end

  // score
  always_comb begin
    if (|b_match)
      computed_score = brighter_min_diff;
    else if (|d_match)
      computed_score = darker_min_diff;
    else
      computed_score = 8'd0;
  end

  always_ff @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      stg2_corner <= 1'b0;
      stg2_score  <= 8'd0;
      stg2_valid  <= 1'b0;
    end else if (enable) begin
      stg2_corner <= (|b_match) | (|d_match);
      stg2_score  <= computed_score;
      stg2_valid  <= stg1_valid;
    end
  end

  always_ff @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      is_corner    <= 1'b0;
      corner_score <= 8'd0;
      out_valid    <= 1'b0;
    end else if (enable) begin
      is_corner    <= stg2_corner;
      corner_score <= stg2_score;
      out_valid    <= stg2_valid;
    end
  end

endmodule

