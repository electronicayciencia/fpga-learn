// Divide a clock by 2
module clkdiv(
    input clk_i,
    output reg clk_o = 0
);

always @(posedge clk_i)
    clk_o <= ~clk_o;

endmodule
