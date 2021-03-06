`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module counter_tb;

localparam N = 32;

reg zero = 0;
reg clk = 0;
wire [N-1:0] out;

counter UUT (clk,zero,out);

initial begin
	forever #10 clk = ~clk;
end

endmodule
