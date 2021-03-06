module counter (input clk, zero,
                output [31:0] out);

reg [31:0] counter = 0;

always @ (posedge clk) begin
	if (zero)
		counter = 0;
	else
		counter = counter + 1;
end

assign out = counter;

endmodule
