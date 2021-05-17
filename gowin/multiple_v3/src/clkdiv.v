// Simple clock divider block
module clkdiv (
    input i_clk,
    output o_clk
);

    reg [3:0] n;

    //assign o_clk = n[0]; // :2   -> 12 MHz
    //assign o_clk = n[1]; // :4   ->  6 MHz
    assign o_clk = n[2]; // :8   ->  3 MHz
    //assign o_clk = n[3]; // :16  ->  1.5 MHz

    always @(posedge i_clk) n <= n + 1'b1;

endmodule