//------------------------------------------------------------------------------
// Module      : tb_systolic_array
// Description : Testbench for 16-bit systolic_array.
//------------------------------------------------------------------------------

module tb_systolic_array();

    //--------------------------------------------------------------------------
    // DUT signal declarations (16-bit version)
    //--------------------------------------------------------------------------
    reg         clk;
    reg         rst;

    // Load handshake
    reg         load_valid;
    wire        load_ready;

    // Separate SRAM write ports (16-bit data)
    reg         w_we,  a_we;
    reg  [3:0]  w_addr, a_addr;
    reg  [15:0] weight_din, act_din;

    // Results (32-bit accumulator outputs)
    wire        result_valid;
    wire [31:0] Re1, Re2, Re3, Re4;

    //--------------------------------------------------------------------------
    // Test data arrays (16-bit values)
    //--------------------------------------------------------------------------
    reg [15:0] W [0:15];
    reg [15:0] A [0:15];

    integer i;

    //--------------------------------------------------------------------------
    // DUT instantiation (16-bit parameters)
    //--------------------------------------------------------------------------
    systolic_array #(
        .DATA_W(16),
        .ACC_W(32),
        .SIGNED_ARITH(0)
    ) uut (
        .clk          (clk),
        .rst          (rst),
        .load_valid   (load_valid),
        .load_ready   (load_ready),
        .w_we         (w_we),
        .w_addr       (w_addr),
        .weight_din   (weight_din),
        .a_we         (a_we),
        .a_addr       (a_addr),
        .act_din      (act_din),
        .result_valid (result_valid),
        .Re1          (Re1),
        .Re2          (Re2),
        .Re3          (Re3),
        .Re4          (Re4)
    );

    //--------------------------------------------------------------------------
    // Clock: 10 ns period (100 MHz)
    //--------------------------------------------------------------------------
    initial clk = 0;
    always  #5 clk = ~clk;

    //--------------------------------------------------------------------------
    // Main stimulus
    //--------------------------------------------------------------------------
    initial begin
        // Initialise all inputs
        rst        = 1;
        load_valid = 0;
        w_we       = 0;  a_we   = 0;
        w_addr     = 0;  a_addr = 0;
        weight_din = 0;  act_din = 0;

        // Hold reset for 4 cycles
        repeat(4) @(posedge clk);
        @(negedge clk);
        rst = 0;

        //----------------------------------------------------------------------
        // Load test vectors (16-bit values, range 1-16)
        //----------------------------------------------------------------------
        W[0]=1;   W[1]=2;   W[2]=3;   W[3]=4;
        W[4]=5;   W[5]=6;   W[6]=7;   W[7]=8;
        W[8]=9;   W[9]=10;  W[10]=11; W[11]=12;
        W[12]=13; W[13]=14; W[14]=15; W[15]=16;

        A[0]=1;   A[1]=0;   A[2]=0;   A[3]=0;
        A[4]=0;   A[5]=1;   A[6]=0;   A[7]=0;
        A[8]=0;   A[9]=0;  A[10]=1; A[11]=0;
        A[12]=0; A[13]=0; A[14]=0; A[15]=1;

        //----------------------------------------------------------------------
        // SRAM preload
        //----------------------------------------------------------------------
        for (i = 0; i < 16; i = i + 1) begin
            @(negedge clk);
            w_we       = 1;       a_we   = 1;
            w_addr     = i[3:0];  a_addr = i[3:0];
            weight_din = W[i];
            act_din    = A[i];
        end
        @(negedge clk);
        w_we       = 0;  a_we   = 0;
        w_addr     = 0;  a_addr = 0;
        weight_din = 0;  act_din = 0;

        @(posedge clk);

        // Wait for DUT to be ready
        @(negedge clk);
        wait(load_ready);

        // Start computation
        @(negedge clk);
        load_valid = 1;

        @(negedge clk);
        load_valid = 0;

        // Wait for results
        wait(result_valid);

        repeat(10) @(posedge clk);

        $display("\nSimulation Finished\n");
        $stop;
    end

    //--------------------------------------------------------------------------
    // Output monitor
    //--------------------------------------------------------------------------
    initial begin
        $display("------------------------------------------------------------------");
        $display(" Time    RValid  Ready    Re1        Re2        Re3        Re4");
        $display("------------------------------------------------------------------");
        forever begin
            @(posedge clk);
            #1;
            if (uut.state >= 3'd2) begin
                $display("%6t     %b       %b     %6d     %6d     %6d     %6d",
                         $time,
                         result_valid,
                         load_ready,
                         Re1, Re2, Re3, Re4);
            end
        end
    end

    //--------------------------------------------------------------------------
    // Expected results for 16-bit 4x4 systolic array
    // With weights and activations both 1..16 row-major:
    // Re1 = 13*1 + 14*2 + 15*3 + 16*4 = 13 + 28 + 45 + 64 = 150
    // Re2 = 13*5 + 14*6 + 15*7 + 16*8 = 65 + 84 + 105 + 128 = 382
    // Re3 = 13*9 + 14*10 + 15*11 + 16*12 = 117 + 140 + 165 + 192 = 614
    // Re4 = 13*13 + 14*14 + 15*15 + 16*16 = 169 + 196 + 225 + 256 = 846
    //--------------------------------------------------------------------------
    localparam EXPECTED_Re1 = 32'd150;
    localparam EXPECTED_Re2 = 32'd382;
    localparam EXPECTED_Re3 = 32'd614;
    localparam EXPECTED_Re4 = 32'd846;

    initial begin
        wait(result_valid);
        @(posedge clk); #1;

        $display("\n--- RESULT CHECK ---");
        if (Re1 === EXPECTED_Re1 &&
            Re2 === EXPECTED_Re2 &&
            Re3 === EXPECTED_Re3 &&
            Re4 === EXPECTED_Re4) begin
            $display("? PASS:");
            $display("  Re1 = %0d  (expected %0d)", Re1, EXPECTED_Re1);
            $display("  Re2 = %0d  (expected %0d)", Re2, EXPECTED_Re2);
            $display("  Re3 = %0d  (expected %0d)", Re3, EXPECTED_Re3);
            $display("  Re4 = %0d  (expected %0d)", Re4, EXPECTED_Re4);
        end else begin
            $display("? FAIL:");
            $display("  Re1 = %0d  (expected %0d)", Re1, EXPECTED_Re1);
            $display("  Re2 = %0d  (expected %0d)", Re2, EXPECTED_Re2);
            $display("  Re3 = %0d  (expected %0d)", Re3, EXPECTED_Re3);
            $display("  Re4 = %0d  (expected %0d)", Re4, EXPECTED_Re4);
        end
        $display("--------------------\n");
    end

    //--------------------------------------------------------------------------
    // Waveform dump
    //--------------------------------------------------------------------------
    initial begin
        $shm_open("wave.shm");
        $shm_probe("ACTMF");
    end

endmodule
