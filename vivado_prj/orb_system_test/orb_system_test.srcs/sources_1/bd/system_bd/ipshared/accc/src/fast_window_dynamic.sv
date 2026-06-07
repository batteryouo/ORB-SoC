// fast_window_dynamic.sv
// Converts 1D AXI-Stream to 2D 7x7 sliding window with dynamic resolution

module fast_window_dynamic (
  input  logic        clk,
  input  logic        resetn,

  // Configuration from AXI-Lite register (Driven by ARM processor)
  input  logic [15:0] image_width,

  // AXI-Stream Input
  input  logic [7:0]  s_axis_tdata,
  input  logic        s_axis_tvalid,

  // Output 2D Window
  // window_7x7[row][col]: [0][0] is top-left, [6][6] is bottom-right
  output logic [7:0]  window_7x7 [0:6][0:6],
  output logic        window_valid
);

  // =========================================================================
  // 1. Dynamic Line Buffers
  // =========================================================================
  logic [7:0]  row_pixels [0:6];
  logic [9:0]  delay_value;

  // The incoming pixel is always the bottom-rightmost pixel of the column
  assign row_pixels[6] = s_axis_tdata;

  // In Xilinx Shift RAM IP, a variable delay input of 'A' produces a delay of 'A+1'.
  // Therefore, to delay by 'image_width', we must input 'image_width - 1'.
  assign delay_value = image_width[9:0] - 10'd1;

  genvar i;
  generate
    for (i = 0; i < 6; i++) begin : gen_line_buffers
      // IP Name: line_buffer_dynamic
      // Must be configured as "Variable Length" with Clock Enable (CE)
      line_buffer_dynamic inst_lb (
        .D   (row_pixels[i+1]), // Data input from the row below
        .CLK (clk),
        .CE  (s_axis_tvalid),   // Shift ONLY when stream data is valid
        .A   (delay_value),     // Dynamic address/length control
        .Q   (row_pixels[i])    // Data output to the current row
      );
    end
  endgenerate

  // =========================================================================
  // 2. 7x7 Sliding Window (Shift Registers)
  // =========================================================================
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
        // Shift existing pixels to the left (older data)
        for (r = 0; r < 7; r++) begin
          for (c = 0; c < 6; c++) begin
            window_7x7[r][c] <= window_7x7[r][c+1];
          end
          // Load the newest column from line buffers into the right edge
          window_7x7[r][6] <= row_pixels[r];
        end
      end
      // Pipeline the valid signal
      window_valid <= s_axis_tvalid;
    end
  end

endmodule