module systolic_array #(
    parameter ROWS         = 4,
    parameter COLS         = 4,
    parameter DATA_W       = 16,
    parameter ACC_W        = 32,
    parameter SIGNED_ARITH = 0
)(
    input  wire        clk,
    input  wire        rst,
    input  wire        load_valid,
    output reg         load_ready,
    input  wire        w_we,
    input  wire [3:0]  w_addr,
    input  wire [15:0] weight_din,
    input  wire        a_we,
    input  wire [3:0]  a_addr,
    input  wire [15:0] act_din,
    output reg         result_valid,
    output wire [31:0] Re1, Re2, Re3, Re4
);

    localparam DEPTH         = 1 << 4;
    localparam FETCH_CYCLES  = DEPTH + 2;
    localparam WAVE_CYCLES   = ROWS + COLS;
    localparam FETCH_MAX     = 5'd17;
    localparam WAVE_MAX      = 4'd7;
    localparam DRAIN_MAX     = 3'd3;

    localparam S_IDLE      = 3'd0;
    localparam S_FETCH     = 3'd1;
    localparam S_WAVEFRONT = 3'd2;
    localparam S_DRAIN     = 3'd3;
    localparam S_DONE      = 3'd4;

    wire [15:0] sram_w_out, sram_a_out;
    reg  [3:0]  internal_addr;

    wire [3:0] w_final_addr = w_we ? w_addr : internal_addr;
    wire [3:0] a_final_addr = a_we ? a_addr : internal_addr;

    asic_sram_macro #(.DATA_W(16), .ADDR_W(4)) W_SRAM (
        .clk  (clk),
        .cs   (1'b1),
        .we   (w_we),
        .oe   (1'b1),
        .addr (w_final_addr),
        .din  (weight_din),
        .dout (sram_w_out)
    );

    asic_sram_macro #(.DATA_W(16), .ADDR_W(4)) A_SRAM (
        .clk  (clk),
        .cs   (1'b1),
        .we   (a_we),
        .oe   (1'b1),
        .addr (a_final_addr),
        .din  (act_din),
        .dout (sram_a_out)
    );

    reg [15:0] weight_reg [0:DEPTH-1];
    reg [15:0] act_reg    [0:DEPTH-1];

    reg [2:0]  state;
    reg [4:0]  fetch_cnt;
    reg [3:0]  wave_cnt;
    reg [2:0]  drain_cnt;
    reg        pe_en;

    reg [15:0] inP1, inP5, inP9, inP13;

    wire [DATA_W-1:0] E_0_0, E_0_1, E_0_2;
    wire [DATA_W-1:0] E_1_0, E_1_1, E_1_2;
    wire [DATA_W-1:0] E_2_0, E_2_1, E_2_2;
    wire [DATA_W-1:0] E_3_0, E_3_1, E_3_2;

    (* keep = "true" *) wire [DATA_W-1:0] E_0_3;
    (* keep = "true" *) wire [DATA_W-1:0] E_1_3;
    (* keep = "true" *) wire [DATA_W-1:0] E_2_3;
    (* keep = "true" *) wire [DATA_W-1:0] E_3_3;

    wire [ACC_W-1:0] C_0_0, C_0_1, C_0_2, C_0_3;
    wire [ACC_W-1:0] C_1_0, C_1_1, C_1_2, C_1_3;
    wire [ACC_W-1:0] C_2_0, C_2_1, C_2_2, C_2_3;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state         <= S_IDLE;
            fetch_cnt     <= 5'd0;
            wave_cnt      <= 4'd0;
            internal_addr <= 4'd0;
            load_ready    <= 1'b1;
            result_valid  <= 1'b0;
            pe_en         <= 1'b0;
            drain_cnt     <= 3'd0;
            inP1  <= 16'd0; inP5  <= 16'd0;
            inP9  <= 16'd0; inP13 <= 16'd0;

            weight_reg[0]  <= 16'd0; weight_reg[1]  <= 16'd0;
            weight_reg[2]  <= 16'd0; weight_reg[3]  <= 16'd0;
            weight_reg[4]  <= 16'd0; weight_reg[5]  <= 16'd0;
            weight_reg[6]  <= 16'd0; weight_reg[7]  <= 16'd0;
            weight_reg[8]  <= 16'd0; weight_reg[9]  <= 16'd0;
            weight_reg[10] <= 16'd0; weight_reg[11] <= 16'd0;
            weight_reg[12] <= 16'd0; weight_reg[13] <= 16'd0;
            weight_reg[14] <= 16'd0; weight_reg[15] <= 16'd0;

            act_reg[0]  <= 16'd0; act_reg[1]  <= 16'd0;
            act_reg[2]  <= 16'd0; act_reg[3]  <= 16'd0;
            act_reg[4]  <= 16'd0; act_reg[5]  <= 16'd0;
            act_reg[6]  <= 16'd0; act_reg[7]  <= 16'd0;
            act_reg[8]  <= 16'd0; act_reg[9]  <= 16'd0;
            act_reg[10] <= 16'd0; act_reg[11] <= 16'd0;
            act_reg[12] <= 16'd0; act_reg[13] <= 16'd0;
            act_reg[14] <= 16'd0; act_reg[15] <= 16'd0;
        end else begin
            result_valid <= 1'b0;

            case (state)
                S_IDLE: begin
                    load_ready <= 1'b1;
                    pe_en <= 1'b0;
                    if (load_valid) begin
                        load_ready    <= 1'b0;
                        internal_addr <= 4'd0;
                        fetch_cnt     <= 5'd0;
                        state         <= S_FETCH;
                    end
                end

                S_FETCH: begin
                    fetch_cnt <= fetch_cnt + 1;

                    if (fetch_cnt < 5'd15)
                        internal_addr <= fetch_cnt[3:0] + 4'd1;

                    if (fetch_cnt >= 5'd1 && fetch_cnt <= 5'd16) begin
                        weight_reg[fetch_cnt - 1] <= sram_w_out;
                        act_reg   [fetch_cnt - 1] <= sram_a_out;
                    end

                    if (fetch_cnt == FETCH_MAX) begin
                        wave_cnt <= 4'd0;
                        pe_en    <= 1'b1;
                        state    <= S_WAVEFRONT;
                    end
                end

                S_WAVEFRONT: begin
                    wave_cnt <= wave_cnt + 1;
                    case (wave_cnt)
                        4'd0: begin
                            inP1  <= act_reg[0];
                            inP5  <= 16'd0;
                            inP9  <= 16'd0;
                            inP13 <= 16'd0;
                        end
                        4'd1: begin
                            inP1  <= act_reg[4];
                            inP5  <= act_reg[1];
                            inP9  <= 16'd0;
                            inP13 <= 16'd0;
                        end
                        4'd2: begin
                            inP1  <= act_reg[8];
                            inP5  <= act_reg[5];
                            inP9  <= act_reg[2];
                            inP13 <= 16'd0;
                        end
                        4'd3: begin
                            inP1  <= act_reg[12];
                            inP5  <= act_reg[9];
                            inP9  <= act_reg[6];
                            inP13 <= act_reg[3];
                        end
                        4'd4: begin
                            inP1  <= 16'd0;
                            inP5  <= act_reg[13];
                            inP9  <= act_reg[10];
                            inP13 <= act_reg[7];
                        end
                        4'd5: begin
                            inP1  <= 16'd0;
                            inP5  <= 16'd0;
                            inP9  <= act_reg[14];
                            inP13 <= act_reg[11];
                        end
                        4'd6: begin
                            inP1  <= 16'd0;
                            inP5  <= 16'd0;
                            inP9  <= 16'd0;
                            inP13 <= act_reg[15];
                        end
                        4'd7: begin
                            inP1  <= 16'd0;
                            inP5  <= 16'd0;
                            inP9  <= 16'd0;
                            inP13 <= 16'd0;
                            drain_cnt <= 3'd0;
                            state <= S_DRAIN;
                        end
                        default: state <= S_DRAIN;
                    endcase
                end

                S_DRAIN: begin
                    drain_cnt <= drain_cnt + 1;
                    if (drain_cnt == DRAIN_MAX) begin
                        pe_en <= 1'b0;
                        state <= S_DONE;
                    end
                end

                S_DONE: begin
                    result_valid <= 1'b1;
                    load_ready   <= 1'b1;
                    if (load_valid) begin
                        result_valid  <= 1'b0;
                        load_ready    <= 1'b0;
                        internal_addr <= 4'd0;
                        fetch_cnt     <= 5'd0;
                        pe_en         <= 1'b0;
                        state         <= S_FETCH;
                    end
                end

                default: begin
                    state      <= S_IDLE;
                    load_ready <= 1'b1;
                    pe_en      <= 1'b0;
                end
            endcase
        end
    end

    block #(.DATA_W(DATA_W), .ACC_W(ACC_W), .SIGNED_ARITH(SIGNED_ARITH)) P1
        (.clk(clk), .rst(rst), .en(pe_en), .p_sum(32'd0),   .w_b(weight_reg[0]),  .inp_west(inP1),  .outp_east(E_0_0), .result(C_0_0));
    block #(.DATA_W(DATA_W), .ACC_W(ACC_W), .SIGNED_ARITH(SIGNED_ARITH)) P2
        (.clk(clk), .rst(rst), .en(pe_en), .p_sum(32'd0),   .w_b(weight_reg[1]),  .inp_west(E_0_0), .outp_east(E_0_1), .result(C_0_1));
    block #(.DATA_W(DATA_W), .ACC_W(ACC_W), .SIGNED_ARITH(SIGNED_ARITH)) P3
        (.clk(clk), .rst(rst), .en(pe_en), .p_sum(32'd0),   .w_b(weight_reg[2]),  .inp_west(E_0_1), .outp_east(E_0_2), .result(C_0_2));
    block #(.DATA_W(DATA_W), .ACC_W(ACC_W), .SIGNED_ARITH(SIGNED_ARITH)) P4
        (.clk(clk), .rst(rst), .en(pe_en), .p_sum(32'd0),   .w_b(weight_reg[3]),  .inp_west(E_0_2), .outp_east(E_0_3), .result(C_0_3));

    block #(.DATA_W(DATA_W), .ACC_W(ACC_W), .SIGNED_ARITH(SIGNED_ARITH)) P5
        (.clk(clk), .rst(rst), .en(pe_en), .p_sum(C_0_0),   .w_b(weight_reg[4]),  .inp_west(inP5),  .outp_east(E_1_0), .result(C_1_0));
    block #(.DATA_W(DATA_W), .ACC_W(ACC_W), .SIGNED_ARITH(SIGNED_ARITH)) P6
        (.clk(clk), .rst(rst), .en(pe_en), .p_sum(C_0_1),   .w_b(weight_reg[5]),  .inp_west(E_1_0), .outp_east(E_1_1), .result(C_1_1));
    block #(.DATA_W(DATA_W), .ACC_W(ACC_W), .SIGNED_ARITH(SIGNED_ARITH)) P7
        (.clk(clk), .rst(rst), .en(pe_en), .p_sum(C_0_2),   .w_b(weight_reg[6]),  .inp_west(E_1_1), .outp_east(E_1_2), .result(C_1_2));
    block #(.DATA_W(DATA_W), .ACC_W(ACC_W), .SIGNED_ARITH(SIGNED_ARITH)) P8
        (.clk(clk), .rst(rst), .en(pe_en), .p_sum(C_0_3),   .w_b(weight_reg[7]),  .inp_west(E_1_2), .outp_east(E_1_3), .result(C_1_3));

    block #(.DATA_W(DATA_W), .ACC_W(ACC_W), .SIGNED_ARITH(SIGNED_ARITH)) P9
        (.clk(clk), .rst(rst), .en(pe_en), .p_sum(C_1_0),   .w_b(weight_reg[8]),  .inp_west(inP9),  .outp_east(E_2_0), .result(C_2_0));
    block #(.DATA_W(DATA_W), .ACC_W(ACC_W), .SIGNED_ARITH(SIGNED_ARITH)) P10
        (.clk(clk), .rst(rst), .en(pe_en), .p_sum(C_1_1),   .w_b(weight_reg[9]),  .inp_west(E_2_0), .outp_east(E_2_1), .result(C_2_1));
    block #(.DATA_W(DATA_W), .ACC_W(ACC_W), .SIGNED_ARITH(SIGNED_ARITH)) P11
        (.clk(clk), .rst(rst), .en(pe_en), .p_sum(C_1_2),   .w_b(weight_reg[10]), .inp_west(E_2_1), .outp_east(E_2_2), .result(C_2_2));
    block #(.DATA_W(DATA_W), .ACC_W(ACC_W), .SIGNED_ARITH(SIGNED_ARITH)) P12
        (.clk(clk), .rst(rst), .en(pe_en), .p_sum(C_1_3),   .w_b(weight_reg[11]), .inp_west(E_2_2), .outp_east(E_2_3), .result(C_2_3));

    block #(.DATA_W(DATA_W), .ACC_W(ACC_W), .SIGNED_ARITH(SIGNED_ARITH)) P13
        (.clk(clk), .rst(rst), .en(pe_en), .p_sum(C_2_0),   .w_b(weight_reg[12]), .inp_west(inP13), .outp_east(E_3_0), .result(Re1));
    block #(.DATA_W(DATA_W), .ACC_W(ACC_W), .SIGNED_ARITH(SIGNED_ARITH)) P14
        (.clk(clk), .rst(rst), .en(pe_en), .p_sum(C_2_1),   .w_b(weight_reg[13]), .inp_west(E_3_0), .outp_east(E_3_1), .result(Re2));
    block #(.DATA_W(DATA_W), .ACC_W(ACC_W), .SIGNED_ARITH(SIGNED_ARITH)) P15
        (.clk(clk), .rst(rst), .en(pe_en), .p_sum(C_2_2),   .w_b(weight_reg[14]), .inp_west(E_3_1), .outp_east(E_3_2), .result(Re3));
    block #(.DATA_W(DATA_W), .ACC_W(ACC_W), .SIGNED_ARITH(SIGNED_ARITH)) P16
        (.clk(clk), .rst(rst), .en(pe_en), .p_sum(C_2_3),   .w_b(weight_reg[15]), .inp_west(E_3_2), .outp_east(E_3_3), .result(Re4));

endmodule
