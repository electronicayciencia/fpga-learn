module pulse_detection (input level, clk,
                        output o);

reg level_old = 0;
reg out = 0;

always @ (posedge clk) begin
	if (level == 1 && level_old == 0)
		out = 1;
	else
		out = 0;

	level_old = level;
end

assign o = out;

endmodule
