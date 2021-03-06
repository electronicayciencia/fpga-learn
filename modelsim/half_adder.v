module half_adder (input a,b,
                   output c,o);

	assign o = a^b;
	assign c = a & b;

endmodule
