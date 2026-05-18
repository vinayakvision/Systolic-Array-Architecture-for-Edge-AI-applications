module block #(   
    parameter DATA_W       = 16,
    parameter ACC_W        = 32,
    parameter SIGNED_ARITH = 0
)(
    input  wire               clk,
    input  wire               rst,
    input  wire               en,
    input  wire  [ACC_W-1:0]  p_sum,
    input  wire  [DATA_W-1:0] w_b,
    input  wire  [DATA_W-1:0] inp_west,
    output reg   [DATA_W-1:0] outp_east,
    output reg   [ACC_W-1:0]  result
);

    wire [ACC_W-1:0] mult;

    generate
        if (SIGNED_ARITH == 1) begin : GEN_SIGNED
            assign mult = $signed({{(ACC_W-DATA_W){inp_west[DATA_W-1]}}, inp_west}) *
                          $signed({{(ACC_W-DATA_W){w_b[DATA_W-1]}}, w_b});
        end else begin : GEN_UNSIGNED
            assign mult = {{(ACC_W-DATA_W){1'b0}}, inp_west} *
                          {{(ACC_W-DATA_W){1'b0}}, w_b};
        end
    endgenerate

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            result    <= {ACC_W{1'b0}};
            outp_east <= {DATA_W{1'b0}};
        end else if (en) begin
            result    <= p_sum + mult;
            outp_east <= inp_west;
        end
    end

endmodule
