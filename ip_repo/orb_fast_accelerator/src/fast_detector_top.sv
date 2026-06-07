// fast_detector_top.sv
// FIXED: X coordinate pipeline offset corrected (+4 ? 0)
// FIXED: Score now uses actual FAST response instead of center pixel value

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

  // =========================================================================
  // Coordinate Tracking
  //
  // Total pipeline latency from input pixel to core output = 4 cycles:
  //   +1  window_7x7 registered shift
  //   +1  window_valid <= s_axis_tvalid (1-cycle delay)
  //   +1  fast9_core stage 1
  //   +1  fast9_core stage 2
  //
  // Additionally, the Xilinx line_buffer_dynamic IP has an internal output
  // register, adding +1 CE-cycle per line buffer. From input row [6] to
  // center row [3] there are 3 line buffers, so the center column is shifted
  // 3 extra columns behind the expected position.
  //
  // Window center column offset:        -3  (col [3] in a 7-wide window)
  // Line buffer register latency:       -3  (3 LBs × 1 cycle each)
  // Pipeline-vs-tracking mismatch:      -1  (4 pipeline stages, 2 tracking)
  //
  // Total X compensation = 3 + 3 + 1 = 7
  //
  // Tracking pipeline: 2 stages matching the 2-stage fast9_core,
  // with the remaining offset absorbed into center_x.
  // =========================================================================

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

  // FIXED: compensation increased from -3 to -7
  logic [15:0] center_x, center_y;
  assign center_x = current_x - 16'd7;
  assign center_y = current_y - 16'd3;

  logic [15:0] tracked_x_stg1, tracked_y_stg1;
  logic [15:0] tracked_x_stg2, tracked_y_stg2;

  always_ff @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      tracked_x_stg1 <= 16'd0;
      tracked_y_stg1 <= 16'd0;
      tracked_x_stg2 <= 16'd0;
      tracked_y_stg2 <= 16'd0;
    end else if (s_axis_tvalid) begin
      tracked_x_stg1 <= center_x;
      tracked_y_stg1 <= center_y;
      tracked_x_stg2 <= tracked_x_stg1;
      tracked_y_stg2 <= tracked_y_stg1;
    end
  end

  // Border mask: only output corners within valid image region
  // Adjusted to account for the larger compensation
  logic border_mask;
  assign border_mask = (tracked_x_stg2 >= 16'd3 && tracked_y_stg2 >= 16'd3 && 
                        tracked_x_stg2 < (image_width - 16'd3));

  assign out_is_corner = core_is_corner & border_mask;
  assign out_score     = core_score;
  assign out_x         = tracked_x_stg2;
  assign out_y         = tracked_y_stg2;
  assign out_valid     = core_valid & border_mask & core_is_corner;

endmodule