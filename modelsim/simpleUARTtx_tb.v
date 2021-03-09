// simpleUARTtx
`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module simpleUARTtx_tb;

reg clk = 0;   // clock
reg start = 0;  // start transmission
reg [7:0] data = 0;  // data byte

wire busy;     // tx in progress
wire line;     // serial output

simpleUARTtx UUT (data, start, clk, busy, line);

initial begin
	forever #10 clk = ~clk;
end


initial begin
	data = 8'b00000001;
	#25;

	start = 1;
	#10;
	start = 0;
end



endmodule