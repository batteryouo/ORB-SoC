// fast_window_dynamic.sv
// Converts 1D AXI-Stream to 2D 7x7 sliding window with dynamic resolution

module fast_window_dynamic (
  input  logic        clk,
  input  logic        resetn,

  input  logic [15:0] image_width,
  input  logic [7:0]  s_axis_tdata,
  input  logic        s_axis_tvalid,

  output logic [7:0]  window_7x7 [0:6][0:6],
  output logic        window_valid
);

  logic [7:0]  row_pixels [0:6];
  logic [9:0]  delay_value;

  assign row_pixels[6] = s_axis_tdata;
  assign delay_value = image_width[9:0] - 10'd1;

  genvar i;
  generate
    for (i = 0; i < 6; i++) begin : gen_line_buffers
      line_buffer_dynamic inst_lb (
        .D   (row_pixels[i+1]),
        .CLK (clk),
        .CE  (s_axis_tvalid),
        .A   (delay_value),
        .Q   (row_pixels[i])
      );
    end
  endgenerate

  integer r, c;
  always_ff @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      for (r = 0; r < 7; r++) begin
        for (c = 0; c < 7; c++) begin
          window_7x7[r][c] <= 8'd0;
        end
      end
      window_valid <= 1'b0;
    end else begin
      if (s_axis_tvalid) begin
        for (r = 0; r < 7; r++) begin
          for (c = 0; c < 6; c++) begin
            window_7x7[r][c] <= window_7x7[r][c+1];
          end
          window_7x7[r][6] <= row_pixels[r];
        end
      end
      window_valid <= s_axis_tvalid;
    end
  end

endmodule