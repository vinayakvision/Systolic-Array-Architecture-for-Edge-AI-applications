module asic_sram_macro #(
    parameter DATA_W = 16,
    parameter ADDR_W = 4
)(
    input  wire               clk,
    input  wire               cs,
    input  wire               we,
    input  wire               oe,
    input  wire [ADDR_W-1:0]  addr,
    input  wire [DATA_W-1:0]  din,
    output wire [DATA_W-1:0]  dout
);

    wire CEN = ~cs;
    wire WEN = ~we;
    wire OEN = ~oe;

    wire [6:0] A = {{3{1'b0}}, addr};

    reg [DATA_W-1:0] mem [0:(1<<ADDR_W)-1];

    reg [DATA_W-1:0] dout_reg;

    always @(posedge clk) begin
        if (!CEN && !WEN) begin
            mem[A[ADDR_W-1:0]] <= din;
        end
    end

    always @(posedge clk) begin
        if (!CEN && WEN) begin
            dout_reg <= mem[A[ADDR_W-1:0]];
        end
    end

    assign dout = (!OEN) ? dout_reg : {DATA_W{1'bz}};

endmodule
