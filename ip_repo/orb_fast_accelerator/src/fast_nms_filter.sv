// fast_nms_filter.sv
// Grid-based Non-Maximum Suppression (NMS) for FAST corners

module fast_nms_filter #(
  parameter GRID_SIZE_LOG2 = 4, // 16x16 grid (2^4 = 16)
  parameter MAX_GRIDS_X  = 40 // Supports image width up to 640 (640/16 = 40)
)(
  input  logic    clk,
  input  logic    resetn,

  // Input from FAST Core
  input  logic    in_valid,
  input  logic [15:0] in_x,
  input  logic [15:0] in_y,
  input  logic [7:0]  in_score,
  input  logic    in_eof,   // End of Frame pulse
  output logic    in_ready,   // Backpressure to stall FAST

  // Output to AXI-Stream Packetizer
  output logic    out_valid,
  output logic [15:0] out_x,
  output logic [15:0] out_y,
  output logic [7:0]  out_score,
  output logic    out_eof,  // Pass End of Frame
  input  logic    out_ready
);

  // Grid coordinates for the incoming pixel
  logic [15:0] grid_x;
  logic [15:0] grid_y;
  assign grid_x = in_x >> GRID_SIZE_LOG2;
  assign grid_y = in_y >> GRID_SIZE_LOG2;

  // Registers to hold the max values for the current grid row
  logic [7:0]  grid_max_score [0:MAX_GRIDS_X-1];
  logic [15:0] grid_max_x   [0:MAX_GRIDS_X-1];
  logic [15:0] grid_max_y   [0:MAX_GRIDS_X-1];

  logic [15:0] active_grid_y;
  logic [15:0] pending_grid_y;

  // State Machine
  typedef enum logic [1:0] {
    IDLE_ACCUM, // Accumulating max scores for the current grid row
    FLUSH_ROW,  // Outputting the strongest corners of the finished row
    SEND_EOF  // Outputting the End of Frame signal
  } state_t;

  state_t current_state;
  logic [7:0] flush_idx;

  always_ff @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      current_state <= IDLE_ACCUM;
      active_grid_y <= 16'd0;
      flush_idx   <= 8'd0;
      out_valid   <= 1'b0;
      out_eof     <= 1'b0;
      
      for (int i = 0; i < MAX_GRIDS_X; i++) begin
        grid_max_score[i] <= 8'd0;
      end
    end else begin
      // Default assignments
      out_valid <= 1'b0;
      out_eof   <= 1'b0;

      case (current_state)
        IDLE_ACCUM: begin
          if (in_eof) begin
            // Frame ended, flush the last row
            current_state <= FLUSH_ROW;
            flush_idx   <= 8'd0;
            pending_grid_y <= 16'd0; // Reset for next frame
          end 
          else if (in_valid && in_ready) begin
            if (grid_y > active_grid_y) begin
              // Crossed into a new grid row! Start flushing.
              current_state  <= FLUSH_ROW;
              flush_idx    <= 8'd0;
              pending_grid_y <= grid_y; // Remember where we are
            end 
            else if (grid_y == active_grid_y) begin
              // Inside current row, update max if score is higher
              if (grid_x < MAX_GRIDS_X && in_score > grid_max_score[grid_x]) begin
                grid_max_score[grid_x] <= in_score;
                grid_max_x[grid_x]   <= in_x;
                grid_max_y[grid_x]   <= in_y;
              end
            end
          end
        end

        FLUSH_ROW: begin
          if (flush_idx < MAX_GRIDS_X) begin
            if (grid_max_score[flush_idx] > 0) begin
              // We have a valid corner in this grid, send it out!
              out_valid <= 1'b1;
              out_x   <= grid_max_x[flush_idx];
              out_y   <= grid_max_y[flush_idx];
              out_score <= grid_max_score[flush_idx];
              
              if (out_ready && out_valid) begin // Handshake complete
                grid_max_score[flush_idx] <= 8'd0; // Clear for next row
                flush_idx <= flush_idx + 8'd1;
              end
            end else begin
              // Empty grid, skip immediately
              flush_idx <= flush_idx + 8'd1;
            end
          end else begin
            // Flushing finished
            if (in_eof) begin // If we were flushing due to EOF
              current_state <= SEND_EOF;
            end else begin
              current_state <= IDLE_ACCUM;
              active_grid_y <= pending_grid_y; // Advance to the new row
            end
          end
        end

        SEND_EOF: begin
          out_valid <= 1'b1;
          out_eof   <= 1'b1;
          if (out_ready) begin
            current_state <= IDLE_ACCUM;
            active_grid_y <= 16'd0;
          end
        end
      endcase
    end
  end

  // We can only accept new pixels if we are idle and not crossing a row boundary
  assign in_ready = (current_state == IDLE_ACCUM && !(in_valid && grid_y > active_grid_y));

endmodule