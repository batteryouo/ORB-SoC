// nms_grid_5x5.sv
// Non-overlapping 5x5 Grid NMS for Uniform Feature Distribution

module nms_grid_5x5 (
  input  logic        clk,
  input  logic        resetn,
  input  logic        enable,

  input  logic [15:0] image_width,
  input  logic [15:0] image_height,

  // Input from FAST detector
  input  logic        in_is_corner,
  input  logic [7:0]  in_score,
  input  logic [15:0] in_x,
  input  logic [15:0] in_y,

  // Final Output to AXI-Stream Packer
  output logic        out_valid,
  output logic [15:0] out_x,
  output logic [15:0] out_y,
  output logic [7:0]  out_score
);

  // -------------------------------------------------------------------------
  // 1. Grid Counters & Border Detection
  // -------------------------------------------------------------------------
  logic [15:0] grid_x;
  logic [2:0]  cnt_x;
  logic [2:0]  cnt_y;

  logic is_last_x, is_last_y;
  assign is_last_x = (in_x == image_width - 16'd1);
  assign is_last_y = (in_y == image_height - 16'd1);

  always_ff @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      cnt_x  <= '0;
      cnt_y  <= '0;
      grid_x <= '0;
    end else if (enable) begin
      if (is_last_x) begin
        cnt_x  <= '0;
        grid_x <= '0;
        if (is_last_y) cnt_y <= '0;
        else if (cnt_y == 3'd4) cnt_y <= '0;
        else cnt_y <= cnt_y + 3'd1;
      end else begin
        if (cnt_x == 3'd4) begin
          cnt_x  <= '0;
          grid_x <= grid_x + 16'd1;
        end else begin
          cnt_x <= cnt_x + 3'd1;
        end
      end
    end
  end

  // -------------------------------------------------------------------------
  // 2. Stage 1 -> Stage 2 Pipeline
  // -------------------------------------------------------------------------
  logic        stg2_valid;
  logic [15:0] stg2_grid_x;
  logic [2:0]  stg2_cnt_x;
  logic [2:0]  stg2_cnt_y;
  logic        stg2_is_last_x;
  logic        stg2_is_last_y;

  logic        stg2_in_is_corner;
  logic [7:0]  stg2_in_score;
  logic [15:0] stg2_in_x;
  logic [15:0] stg2_in_y;

  always_ff @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      stg2_valid        <= 1'b0;
      stg2_grid_x       <= '0;
      stg2_cnt_x        <= '0;
      stg2_cnt_y        <= '0;
      stg2_is_last_x    <= 1'b0;
      stg2_is_last_y    <= 1'b0;
      stg2_in_is_corner <= 1'b0;
      stg2_in_score     <= '0;
      stg2_in_x         <= '0;
      stg2_in_y         <= '0;
    end else begin
      stg2_valid <= enable;
      if (enable) begin
        stg2_grid_x       <= grid_x;
        stg2_cnt_x        <= cnt_x;
        stg2_cnt_y        <= cnt_y;
        stg2_is_last_x    <= is_last_x;
        stg2_is_last_y    <= is_last_y;
        stg2_in_is_corner <= in_is_corner;
        stg2_in_score     <= in_score;
        stg2_in_x         <= in_x;
        stg2_in_y         <= in_y;
      end
    end
  end

  // -------------------------------------------------------------------------
  // 3. Grid History BRAM
  // -------------------------------------------------------------------------
  logic [39:0] ram [0:1023];
  logic [39:0] ram_rdata;

  always_ff @(posedge clk) begin
    if (enable) begin
      ram_rdata <= ram[grid_x];
    end
  end

  // -------------------------------------------------------------------------
  // 4. Stage 2: Compare & Write/Output Logic
  // -------------------------------------------------------------------------
  logic [7:0]  run_score;
  logic [15:0] run_x;
  logic [15:0] run_y;

  logic [7:0]  comp_score1, comp_score2;
  logic [15:0] comp_x1, comp_x2;
  logic [15:0] comp_y1, comp_y2;

  logic [7:0]  next_run_score;
  logic [15:0] next_run_x;
  logic [15:0] next_run_y;

  always_comb begin
    comp_score1 = stg2_in_is_corner ? stg2_in_score : 8'd0;
    comp_x1     = stg2_in_x;
    comp_y1     = stg2_in_y;

    if (stg2_cnt_x == 3'd0) begin
      if (stg2_cnt_y == 3'd0) begin
        comp_score2 = 8'd0;
        comp_x2     = 16'd0;
        comp_y2     = 16'd0;
      end else begin
        comp_score2 = ram_rdata[39:32];
        comp_x2     = ram_rdata[31:16];
        comp_y2     = ram_rdata[15:0];
      end
    end else begin
      comp_score2 = run_score;
      comp_x2     = run_x;
      comp_y2     = run_y;
    end

    if (comp_score1 > comp_score2) begin
      next_run_score = comp_score1;
      next_run_x     = comp_x1;
      next_run_y     = comp_y1;
    end else begin
      next_run_score = comp_score2;
      next_run_x     = comp_x2;
      next_run_y     = comp_y2;
    end
  end

  logic grid_col_done;
  logic grid_row_done;

  assign grid_col_done = (stg2_cnt_x == 3'd4) || stg2_is_last_x;
  assign grid_row_done = (stg2_cnt_y == 3'd4) || stg2_is_last_y;

  always_ff @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      run_score <= 8'd0;
      run_x     <= 16'd0;
      run_y     <= 16'd0;
      out_valid <= 1'b0;
      out_x     <= 16'd0;
      out_y     <= 16'd0;
      out_score <= 8'd0;
    end else if (stg2_valid) begin
      run_score <= next_run_score;
      run_x     <= next_run_x;
      run_y     <= next_run_y;

      if (grid_col_done) begin
        ram[stg2_grid_x] <= {next_run_score, next_run_x, next_run_y};
      end

      if (grid_col_done && grid_row_done) begin
        out_valid <= (next_run_score > 8'd0);
        out_x     <= next_run_x;
        out_y     <= next_run_y;
        out_score <= next_run_score;
      end else begin
        out_valid <= 1'b0;
      end
    end else begin
      out_valid <= 1'b0;
    end
  end

endmodule