module fast_detector_top (
  input  logic        clk,
  input  logic        resetn,
  
  input  logic [15:0] image_width,
  input  logic [15:0] image_height, // ADDED: Required for NMS boundary check
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

  // -------------------------------------------------------------------------
  // Base Coordinate Tracking (No compensation needed!)
  // -------------------------------------------------------------------------
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

  // -------------------------------------------------------------------------
  // Grid 5x5 NMS Instantiation
  // -------------------------------------------------------------------------
  nms_grid_5x5 inst_nms (
    .clk          (clk),
    .resetn       (resetn),
    .enable       (core_valid),      // Trigger NMS only when core output is valid
    .image_width  (image_width),
    .image_height (image_height),
    
    .in_is_corner (core_is_corner),
    .in_score     (core_score),
    .in_x         (current_x),       // Pass raw coordinates directly
    .in_y         (current_y),

    .out_valid    (out_valid),
    .out_x        (out_x),
    .out_y        (out_y),
    .out_score    (out_score)
  );

  // The NMS module handles validity and corners internally
  assign out_is_corner = out_valid;

endmodule