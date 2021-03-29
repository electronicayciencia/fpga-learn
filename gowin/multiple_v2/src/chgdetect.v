// Pulse 1 clock when input changes
// 4 bit input
module chgdetect (
    input clk_i,
    input [3:0] in,
    output o
);

    reg [3:0] last_in;
    assign o = (in != last_in);

    always @(posedge clk_i)
        last_in <= in;

endmodule
