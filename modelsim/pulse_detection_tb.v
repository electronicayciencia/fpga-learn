`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module pulse_detection_tb;

reg level = 0;
reg clk = 0;
wire o;

pulse_detection UUT (level,clk,o);

always begin
	#0.5 level = 1;
	#10  level = 0;
	#10;
end


always begin
	#1 clk = ~clk;
end

endmodule
