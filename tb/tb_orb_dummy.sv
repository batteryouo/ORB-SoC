`timescale 1ns / 1ps

module tb_orb_dummy();

    // =========================================================================
    // System Signals
    // =========================================================================
    logic        clk;
    logic        resetn;

    // AXI-Lite (Trigger)
    logic        axi_lite_start;

    // AXI-Stream Image Input (From DMA #1)
    logic [7:0]  s_axis_image_tdata;
    logic        s_axis_image_tvalid;
    logic        s_axis_image_tready;
    logic        s_axis_image_tlast;

    // AXI-Stream Result Output (To DMA #2)
    logic [31:0] m_axis_result_tdata;
    logic        m_axis_result_tvalid;
    logic        m_axis_result_tready;
    logic        m_axis_result_tlast;

    // Interrupt
    logic        irq_done;

    // =========================================================================
    // Device Under Test (DUT) Instantiation
    // =========================================================================
    orb_dummy_ip dut (
        .clk                 (clk),
        .resetn               (resetn),
        .axi_lite_start      (axi_lite_start),
        .s_axis_image_tdata  (s_axis_image_tdata),
        .s_axis_image_tvalid (s_axis_image_tvalid),
        .s_axis_image_tready (s_axis_image_tready),
        .s_axis_image_tlast  (s_axis_image_tlast),
        .m_axis_result_tdata (m_axis_result_tdata),
        .m_axis_result_tvalid(m_axis_result_tvalid),
        .m_axis_result_tready(m_axis_result_tready),
        .m_axis_result_tlast (m_axis_result_tlast),
        .irq_done            (irq_done)
    );

    // =========================================================================
    // Clock Generation (100 MHz)
    // =========================================================================
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk; 
    end

    // =========================================================================
    // Main Test Sequence
    // =========================================================================
    initial begin
        // 1. Initialize all inputs
        resetn                = 1'b0;
        axi_lite_start       = 1'b0;
        s_axis_image_tdata   = 8'd0;
        s_axis_image_tvalid  = 1'b0;
        s_axis_image_tlast   = 1'b0;
        m_axis_result_tready = 1'b0;

        // 2. Apply Reset
        #20;
        resetn = 1'b1;
        #20;

        // 3. Trigger the IP (Simulate PS writing to AXI-Lite register)
        @(posedge clk);
        axi_lite_start = 1'b1;
        @(posedge clk);
        axi_lite_start = 1'b0;

        // 4. Send Dummy Image Stream (Simulate MM2S DMA)
        // We simulate a very small image (e.g., 10 pixels) just to test the logic
        for (int i = 0; i < 10; i++) begin
            @(posedge clk);
            s_axis_image_tvalid = 1'b1;
            s_axis_image_tdata  = 8'hA0 + i; // Fake pixel value
            
            if (i == 9) begin
                s_axis_image_tlast = 1'b1;
            end

            // Handshake wait: ensure DUT is ready before proceeding
            wait(s_axis_image_tready == 1'b1);
        end

        // End of image stream
        @(posedge clk);
        s_axis_image_tvalid = 1'b0;
        s_axis_image_tlast  = 1'b0;

        // 5. Receive Result Stream (Simulate S2MM DMA)
        #50;
        m_axis_result_tready = 1'b1; // Tell DUT we are ready to receive data

        // Wait until DUT finishes sending and triggers interrupt
        wait(irq_done == 1'b1);

        // 6. Finish Simulation
        #100;
        $display("Simulation Finished Successfully.");
        $finish;
    end

endmodule