`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module half_adder_tb;

reg a,b;
wire c,o;

localparam period = 20;

half_adder UUT (a,b,c,o);

initial begin
	
	a = 0;
	b = 0;
	#period;

	a = 1;
	b = 0;
	#period;

	a = 0;
	b = 1;
	#period;

	a = 1;
	b = 1;
	#period;


end

endmodule
