// fast_nms_filter.sv
// Grid-based Non-Maximum Suppression with hold register for row crossing

module fast_nms_filter #(
  parameter GRID_SIZE_LOG2 = 4, 
  parameter MAX_GRIDS_X  = 40 
)(
  input  logic    clk,
  input  logic    resetn,

  input  logic    in_valid,
  input  logic [15:0] in_x,
  input  logic [15:0] in_y,
  input  logic [7:0]  in_score,
  input  logic    in_eof,   
  output logic    in_ready,   

  output logic    out_valid,
  output logic [15:0] out_x,
  output logic [15:0] out_y,
  output logic [7:0]  out_score,
  output logic    out_eof,  
  input  logic    out_ready
);

  logic [15:0] grid_x, grid_y;
  assign grid_x = in_x >> GRID_SIZE_LOG2;
  assign grid_y = in_y >> GRID_SIZE_LOG2;

  logic [7:0]  grid_max_score [0:MAX_GRIDS_X-1];
  logic [15:0] grid_max_x   [0:MAX_GRIDS_X-1];
  logic [15:0] grid_max_y   [0:MAX_GRIDS_X-1];

  logic [15:0] active_grid_y;
  logic [15:0] pending_grid_y;

  // Holding registers for the corner that triggers a row flush
  logic    hold_valid;
  logic [15:0] hold_x;
  logic [15:0] hold_y;
  logic [7:0]  hold_score;

  typedef enum logic [1:0] {
    IDLE_ACCUM, 
    FLUSH_ROW,  
    SEND_EOF  
  } state_t;

  state_t current_state;
  logic [7:0] flush_idx;
  logic     is_eof_flush;

  always_ff @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      current_state  <= IDLE_ACCUM;
      active_grid_y  <= 16'd0;
      flush_idx    <= 8'd0;
      out_valid    <= 1'b0;
      out_eof    <= 1'b0;
      is_eof_flush   <= 1'b0;
      hold_valid   <= 1'b0;
      
      for (int i = 0; i < MAX_GRIDS_X; i++) begin
        grid_max_score[i] <= 8'd0;
      end
    end else begin
      out_valid <= 1'b0;
      out_eof   <= 1'b0;

      case (current_state)
        IDLE_ACCUM: begin
          if (in_eof) begin
            current_state  <= FLUSH_ROW;
            flush_idx    <= 8'd0;
            pending_grid_y <= 16'd0;
            is_eof_flush   <= 1'b1;
          end 
          else if (in_valid && in_ready) begin
            if (grid_y > active_grid_y) begin
              current_state  <= FLUSH_ROW;
              flush_idx    <= 8'd0;
              pending_grid_y <= grid_y;
              is_eof_flush   <= 1'b0;
              
              // Save the corner that crossed the boundary
              hold_valid <= 1'b1;
              hold_x   <= in_x;
              hold_y   <= in_y;
              hold_score <= in_score;
            end 
            else if (grid_y == active_grid_y) begin
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
              out_valid <= 1'b1;
              out_x   <= grid_max_x[flush_idx];
              out_y   <= grid_max_y[flush_idx];
              out_score <= grid_max_score[flush_idx];
              
              if (out_ready && out_valid) begin 
                grid_max_score[flush_idx] <= 8'd0; 
                flush_idx <= flush_idx + 8'd1;
              end
            end else begin
              flush_idx <= flush_idx + 8'd1;
            end
          end else begin
            if (is_eof_flush) begin 
              current_state <= SEND_EOF;
            end else begin
              current_state <= IDLE_ACCUM;
              active_grid_y <= pending_grid_y;
              
              // Inject the held corner into the fresh row
              if (hold_valid) begin
                grid_max_score[hold_x >> GRID_SIZE_LOG2] <= hold_score;
                grid_max_x[hold_x >> GRID_SIZE_LOG2]   <= hold_x;
                grid_max_y[hold_x >> GRID_SIZE_LOG2]   <= hold_y;
                hold_valid <= 1'b0;
              end
            end
          end
        end

        SEND_EOF: begin
          out_valid <= 1'b1;
          out_eof   <= 1'b1;
          if (out_ready) begin
            current_state <= IDLE_ACCUM;
            active_grid_y <= 16'd0;
            is_eof_flush  <= 1'b0;
          end
        end
      endcase
    end
  end

  assign in_ready = (current_state == IDLE_ACCUM && !(in_valid && grid_y > active_grid_y));

endmodule