// fast_tb.sv
// Simple testbench to verify FAST-9 corner detection logic

`timescale 1ns / 1ps

module fast_tb;

  // Testbench signals
  logic    clk;
  logic    resetn;
  logic [15:0] image_width;
  logic [7:0]  threshold;
  logic [7:0]  s_axis_tdata;
  logic    s_axis_tvalid;

  logic    out_is_corner;
  logic [15:0] out_x;
  logic [15:0] out_y;
  logic [7:0]  out_score;
  logic    out_valid;

  // Instantiate the Device Under Test (DUT)
  fast_detector_top dut (
    .clk       (clk),
    .resetn    (resetn),
    .image_width   (image_width),
    .threshold   (threshold),
    .s_axis_tdata  (s_axis_tdata),
    .s_axis_tvalid (s_axis_tvalid),
    .out_is_corner (out_is_corner),
    .out_x     (out_x),
    .out_y     (out_y),
    .out_score   (out_score),
    .out_valid   (out_valid)
  );

  // Clock generation (100MHz)
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Main Test Stimulus
  integer row, col;
  initial begin
    // Initialize inputs
    resetn    = 0;
    image_width   = 16'd16;  // Small 16x16 image for quick simulation
    threshold   = 8'd20;
    s_axis_tdata  = 8'd0;
    s_axis_tvalid = 0;

    // Apply reset
    #20;
    resetn = 1;
    #20;

    // Feed a 16x16 synthetic image
    for (row = 0; row < 16; row++) begin
      for (col = 0; col < 16; col++) begin
        @(posedge clk);
        s_axis_tvalid <= 1'b1;
        
        // Draw a white square (value 200) from (4,4) to (11,11) on black bg (value 10)
        if (row >= 4 && row <= 11 && col >= 4 && col <= 11) begin
          s_axis_tdata <= 8'd200;
        end else begin
          s_axis_tdata <= 8'd10;
        end
      end
    end

    // Stop feeding data
    @(posedge clk);
    s_axis_tvalid <= 1'b0;
    
    // Wait for pipeline to drain
    #200;
    
    $display("Simulation Finished!");
    $finish;
  end

  // Monitor corners
  always_ff @(posedge clk) begin
    if (out_valid && out_is_corner) begin
      $display("CORNER DETECTED at X: %0d, Y: %0d (Val: %0d)", out_x, out_y, out_score);
    end
  end

endmodule