module counter (
    input i_clk, 
    output [6:0] o_debug
);

    reg [32:0] i = 0;
    assign o_debug = i[7:1];

    always @(posedge i_clk)
        i <= i + 1;

endmodule

