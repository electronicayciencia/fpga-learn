`timescale 1ns/1ns 

module test;

parameter PERIOD = 41.6; // 24MHz (41ns)

reg clk = 0;
always #PERIOD clk=~clk;

multiple UUT (.clk_24MHz(clk), .serial(), .debug() );

endmodule
