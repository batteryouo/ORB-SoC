// fast_detector_top.sv
// Top-level wrapper for FAST-9 detector with pipelined coordinate tracking and border masking

module fast_detector_top (
  input  logic    clk,
  input  logic    resetn,
  
  input  logic [15:0] image_width,
  input  logic [7:0]  threshold,

  input  logic [7:0]  s_axis_tdata,
  input  logic    s_axis_tvalid,

  output logic    out_is_corner,
  output logic [15:0] out_x,
  output logic [15:0] out_y,
  output logic [7:0]  out_score,
  output logic    out_valid
);

  logic [7:0] window_7x7 [0:6][0:6];
  logic     window_valid;
  
  logic     core_is_corner;
  logic [7:0] core_center_val;
  logic     core_valid;

  // 1. Window Generator
  fast_window_dynamic inst_window (
    .clk       (clk),
    .resetn    (resetn),
    .image_width   (image_width),
    .s_axis_tdata  (s_axis_tdata),
    .s_axis_tvalid (s_axis_tvalid),
    .window_7x7  (window_7x7),
    .window_valid  (window_valid)
  );

  // 2. FAST-9 Core
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

  // 3. Coordinate Tracking & Border Masking
  logic [15:0] current_x, current_y;

  always_ff @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      current_x <= 16'd0;
      current_y <= 16'd0;
    end else if (s_axis_tvalid) begin
      if (current_x == image_width - 16'd1) begin
        current_x <= 16'd0;
        current_y <= current_y + 16'd1;
      end else begin
        current_x <= current_x + 16'd1;
      end
    end
  end

  logic [15:0] center_x, center_y;
  assign center_x = current_x - 16'd3;
  assign center_y = current_y - 16'd3;

  // Pipeline delay to match FAST core's 1-cycle latency
  logic [15:0] tracked_x, tracked_y;
  always_ff @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      tracked_x <= 16'd0;
      tracked_y <= 16'd0;
    end else begin
      tracked_x <= center_x;
      tracked_y <= center_y;
    end
  end

  // Border mask: Ignore coordinates too close to the edge
  logic border_mask;
  assign border_mask = (tracked_x >= 16'd3 && tracked_y >= 16'd3 && 
              tracked_x < (image_width - 16'd3));

  // 4. Output Assignments (Pipeline Alignment)
  logic     reg_is_corner;
  logic [7:0] reg_score;

  always_ff @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      reg_is_corner <= 1'b0;
      reg_score   <= 8'd0;
    end else begin
      reg_is_corner <= core_is_corner;
      reg_score   <= core_center_val;
    end
  end

  assign out_is_corner = reg_is_corner & border_mask;
  assign out_score   = reg_score;
  assign out_x     = tracked_x;
  assign out_y     = tracked_y;
  assign out_valid   = core_valid & border_mask & reg_is_corner;

endmodule