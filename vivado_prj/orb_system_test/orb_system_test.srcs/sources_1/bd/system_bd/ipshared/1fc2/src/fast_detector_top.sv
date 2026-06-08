// fast_detector_top.sv
// Connects Window, Core, and NMS. 
// Passes raw counters to NMS for boundary alignment and applies offset at output.

module fast_detector_top (
  input  logic        clk,
  input  logic        resetn,
  
  input  logic [15:0] image_width,
  input  logic [15:0] image_height,
  input  logic [7:0]  threshold,

  input  logic [7:0]  s_axis_tdata,
  input  logic        s_axis_tvalid,

  output logic        out_is_corner,
  output logic [15:0] out_x,
  output logic [15:0] out_y,
  output logic [7:0]  out_score,
  output logic        out_valid
);

  logic [7:0] window_7x7 [0:6][0:6];
  logic       window_valid;
  logic       core_is_corner;
  logic [7:0] core_score;
  logic       core_valid;

  fast_window_dynamic inst_window (
    .clk           (clk),
    .resetn        (resetn),
    .image_width   (image_width),
    .s_axis_tdata  (s_axis_tdata),
    .s_axis_tvalid (s_axis_tvalid),
    .window_7x7    (window_7x7),
    .window_valid  (window_valid)
  );

  fast9_core inst_core (
    .clk          (clk),
    .resetn       (resetn),
    .enable       (s_axis_tvalid),
    .threshold    (threshold),
    .window_7x7   (window_7x7),
    .window_valid (window_valid),
    .is_corner    (core_is_corner),
    .corner_score (core_score),
    .out_valid    (core_valid)
  );

  // Raw Coordinate Generation
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

  // Pass RAW coordinates so NMS boundary logic (is_last_x/y) works perfectly
  logic [15:0] nms_raw_x, nms_raw_y;
  logic        nms_valid;

  nms_grid_5x5 inst_nms (
    .clk          (clk),
    .resetn       (resetn),
    .enable       (core_valid),
    .image_width  (image_width),
    .image_height (image_height),
    .in_is_corner (core_is_corner),
    .in_score     (core_score),
    .in_x         (current_x),       
    .in_y         (current_y),       
    .out_valid    (nms_valid),
    .out_x        (nms_raw_x),       
    .out_y        (nms_raw_y),       
    .out_score    (out_score)
  );

  // Apply the correct offset ONLY to the final valid NMS output
  assign out_x         = nms_raw_x - 16'd11;
  assign out_y         = nms_raw_y - 16'd3;
  assign out_valid     = nms_valid;
  assign out_is_corner = nms_valid;

endmodule