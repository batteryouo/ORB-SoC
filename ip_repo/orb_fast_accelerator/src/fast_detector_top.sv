// fast_detector_top.sv(test)
// FIXED: Added enable control to pipeline registers to prevent corner drops

module fast_detector_top (
  input  logic        clk,
  input  logic        resetn,
  
  input  logic [15:0] image_width,
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
  logic [7:0] core_center_val;
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
    .clk              (clk),
    .resetn           (resetn),
    .enable           (s_axis_tvalid), // Pass enable to freeze core when needed
    .threshold        (threshold),
    .window_7x7       (window_7x7),
    .window_valid     (window_valid),
    .is_corner        (core_is_corner),
    .center_pixel_val (core_center_val),
    .out_valid        (core_valid)
  );

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

  logic [15:0] tracked_x_stg1, tracked_y_stg1;
  logic [15:0] tracked_x_stg2, tracked_y_stg2;

  always_ff @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      tracked_x_stg1 <= 16'd0;
      tracked_y_stg1 <= 16'd0;
      tracked_x_stg2 <= 16'd0;
      tracked_y_stg2 <= 16'd0;
    end else if (s_axis_tvalid) begin // CRITICAL: Only shift when pipeline is enabled
      tracked_x_stg1 <= center_x;
      tracked_y_stg1 <= center_y;
      tracked_x_stg2 <= tracked_x_stg1;
      tracked_y_stg2 <= tracked_y_stg1;
    end
  end

  logic border_mask;
  assign border_mask = (tracked_x_stg2 >= 16'd3 && tracked_y_stg2 >= 16'd3 && 
                        tracked_x_stg2 < (image_width - 16'd3));

  assign out_is_corner = core_is_corner & border_mask;
  assign out_score     = core_center_val;
  assign out_x         = tracked_x_stg2;
  assign out_y         = tracked_y_stg2;
  assign out_valid     = core_valid & border_mask & core_is_corner;

endmodule