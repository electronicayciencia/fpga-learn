`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module full_adder_tb;

reg a,b,ci;
wire co,o;

localparam period = 20;

full_adder UUT (a,b,ci,co,o);

initial begin
	
	a = 0;
	b = 0;
	ci = 0;
	#period;
	assert(co == 0 && o == 0);

	a = 1;
	b = 1;
	ci = 1;
	#period;
	assert(co == 1 && o == 1);

end

endmodule
