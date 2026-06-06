// fast_detector_top.sv
// Top-level wrapper for FAST-9 detector with X, Y coordinate tracking

module fast_detector_top (
  input  logic    clk,
  input  logic    resetn,
  
  // Configuration
  input  logic [15:0] image_width,
  input  logic [7:0]  threshold,

  // AXI-Stream Input (Image)
  input  logic [7:0]  s_axis_tdata,
  input  logic    s_axis_tvalid,

  // FAST Detection Output
  output logic    out_is_corner,
  output logic [15:0] out_x,
  output logic [15:0] out_y,
  output logic [7:0]  out_score, // Using center pixel as temporary score
  output logic    out_valid
);

  // Internal wires connecting Window Generator and FAST Core
  logic [7:0] window_7x7 [0:6][0:6];
  logic     window_valid;
  
  logic     core_is_corner;
  logic [7:0] core_center_val;
  logic     core_valid;

  // =========================================================================
  // 1. Instantiate Window Generator
  // =========================================================================
  fast_window_dynamic inst_window (
    .clk       (clk),
    .resetn    (resetn),
    .image_width   (image_width),
    .s_axis_tdata  (s_axis_tdata),
    .s_axis_tvalid (s_axis_tvalid),
    .window_7x7  (window_7x7),
    .window_valid  (window_valid)
  );

  // =========================================================================
  // 2. Instantiate FAST-9 Core
  // =========================================================================
  fast9_core inst_core (
    .clk        (clk),
    .resetn       (resetn),
    .threshold    (threshold),
    .window_7x7     (window_7x7),
    .window_valid   (window_valid),
    .is_corner    (core_is_corner),
    .center_pixel_val (core_center_val),
    .out_valid    (core_valid)
  );

  // =========================================================================
  // 3. Coordinate Tracking Logic
  // =========================================================================
  // The center pixel of the 7x7 window is delayed by 3 rows and 3 columns 
  // relative to the incoming pixel stream.
  
  logic [15:0] current_x, current_y;

  always_ff @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      current_x <= 16'd0;
      current_y <= 16'd0;
    end else begin
      if (s_axis_tvalid) begin
        if (current_x == image_width - 16'd1) begin
          current_x <= 16'd0;
          current_y <= current_y + 16'd1;
        end else begin
          current_x <= current_x + 16'd1;
        end
      end
    end
  end

  // Pipeline delay for coordinates to match the 1-cycle delay of FAST core
  logic [15:0] tracked_x, tracked_y;
  always_ff @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      tracked_x <= 16'd0;
      tracked_y <= 16'd0;
    end else if (s_axis_tvalid) begin
      // The center of the 7x7 window is (x-3, y-3) relative to incoming data
      tracked_x <= current_x - 16'd3;
      tracked_y <= current_y - 16'd3;
    end
  end

  // =========================================================================
  // 4. Output Assignments
  // =========================================================================
  assign out_is_corner = core_is_corner;
  assign out_x     = tracked_x;
  assign out_y     = tracked_y;
  assign out_score   = core_center_val; 
  assign out_valid   = core_valid;

endmodule