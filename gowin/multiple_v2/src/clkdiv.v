// Simple clock divider block
module clkdiv (
    input clk_i,
    output clk_o
);

    reg [3:0] n;

    //assign clk_o = n[0]; // :2   -> 12 MHz
    //assign clk_o = n[1]; // :4   ->  6 MHz
    assign clk_o = n[2]; // :8   ->  3 MHz
    //assign clk_o = n[3]; // :16  ->  1.5 MHz

    always @(posedge clk_i) n <= n + 1'b1;

endmodule