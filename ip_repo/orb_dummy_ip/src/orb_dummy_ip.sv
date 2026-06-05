// orb_dummy_ip.sv
// Dummy IP for ORB Accelerator System Integration Test

module orb_dummy_ip (
    input  logic        clk,
    input  logic        resetn,

    // AXI-Lite Slave (Simplified for testing: just a start trigger)
    input  logic        axi_lite_start,

    // AXI-Stream Slave (Image Input from DMA)
    input  logic [7:0]  s_axis_image_tdata,
    input  logic        s_axis_image_tvalid,
    output logic        s_axis_image_tready,
    input  logic        s_axis_image_tlast,

    // AXI-Stream Master (Result Output to DMA)
    output logic [31:0] m_axis_result_tdata,
    output logic        m_axis_result_tvalid,
    input  logic        m_axis_result_tready,
    output logic        m_axis_result_tlast,

    // Interrupt output
    output logic        irq_done
);

    // =========================================================================
    // State Machine Definitions
    // =========================================================================
    typedef enum logic [1:0] {
        IDLE        = 2'b00,
        DRAIN_IMAGE = 2'b01,
        SEND_RESULT = 2'b10,
        DONE        = 2'b11
    } state_t;

    state_t current_state, next_state;

    // Counters
    logic [15:0] result_word_count;
    localparam logic [15:0] TOTAL_RESULT_WORDS = 16'd44; // Send 4 dummy keypoints (4 * 11 words = 44)

    // =========================================================================
    // FSM Sequential Logic
    // =========================================================================
    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            current_state     <= IDLE;
            result_word_count <= 16'd0;
        end else begin
            current_state <= next_state;
            
            // Counter logic for result output
            if (current_state == SEND_RESULT && m_axis_result_tvalid && m_axis_result_tready) begin
                result_word_count <= result_word_count + 16'd1;
            end else if (current_state == IDLE) begin
                result_word_count <= 16'd0;
            end
        end
    end

    // =========================================================================
    // FSM Combinational Logic
    // =========================================================================
    always_comb begin
        next_state = current_state;

        case (current_state)
            IDLE: begin
                if (axi_lite_start) begin
                    next_state = DRAIN_IMAGE;
                end
            end
            
            DRAIN_IMAGE: begin
                // Transition when the last pixel of the image arrives
                if (s_axis_image_tvalid && s_axis_image_tready && s_axis_image_tlast) begin
                    next_state = SEND_RESULT;
                end
            end
            
            SEND_RESULT: begin
                // Transition when the last dummy result word is sent
                if (m_axis_result_tvalid && m_axis_result_tready && m_axis_result_tlast) begin
                    next_state = DONE;
                end
            end
            
            DONE: begin
                next_state = IDLE;
            end
            
            default: next_state = IDLE;
        endcase
    end

    // =========================================================================
    // Output Logic Assignments
    // =========================================================================
    
    // Always ready to accept image data in DRAIN_IMAGE state
    assign s_axis_image_tready = (current_state == DRAIN_IMAGE) ? 1'b1 : 1'b0;

    // Generate dummy result data
    always_comb begin
        m_axis_result_tvalid = 1'b0;
        m_axis_result_tdata  = 32'h0000_0000;
        m_axis_result_tlast  = 1'b0;

        if (current_state == SEND_RESULT) begin
            m_axis_result_tvalid = 1'b1;
            m_axis_result_tdata  = {16'hDEAD, result_word_count}; // Dummy pattern
            
            if (result_word_count == (TOTAL_RESULT_WORDS - 16'd1)) begin
                m_axis_result_tlast = 1'b1;
            end
        end
    end

    // Interrupt logic: pulse high for one cycle when done
    assign irq_done = (current_state == DONE) ? 1'b1 : 1'b0;

endmodule