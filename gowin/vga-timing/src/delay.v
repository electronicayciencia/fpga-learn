module delay (
    input clk,
    input in,
    output out
);

reg [5:0] S;
assign out = S[2]; // how many cycles?

always @(posedge clk) 
    S <= {S[4:0], in};

endmodule
