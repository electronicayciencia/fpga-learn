module full_adder (input a,b,ci,
                   output co,o);

	assign o  = a^b^ci;
	assign co = (a & b) | (a & ci) | (b & ci);

endmodule
