`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module adder_tb;

reg [3:0] a,b;

wire [3:0] out;
wire carry;

localparam period = 20;

adder UUT (a,b,carry,out);

initial begin
	a = 4'd0;
	b = 4'd0;
	#period;
	//assert(out == 4'd0 && carry == 0);

	a = 4'd5;
	b = 4'd5;
	#period;
	//assert(out == 4'd10 && carry == 0);

	a = 4'd15;
	b = 4'd15;
	#period;
	//assert(out == 4'd0 && carry == 1);

end

endmodule

