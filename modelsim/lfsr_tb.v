`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module lfsr_tb;

localparam seed = 4'b1110;

reg load;
wire q;

reg clk = 0;

lfsr UUT (clk,seed,load,q);

initial begin
	forever #10 clk = ~clk;
end

/*
initial begin
	load = 1;
	#20
	load = 0;
end
*/


endmodule
