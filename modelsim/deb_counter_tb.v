// Debounce - counter
`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module debounce_counter_tb;

reg btn1_line = 0;        // button1 input line
reg clk = 0;              // clock
wire [31:0] ctr_filtered; // pulse count (filtered)
wire [31:0] ctr_raw;      // pulse count (unfiltred)

wire btn1_line_debounced; // filtered pulse line


debounce btn1_debouncer (
	.clk(clk),
	.i(btn1_line),
	.st_o(),
	.up_o(btn1_line_debounced), 
	.dn_o()
);

counter counter_filtered (
	.clk(btn1_line_debounced), 
	.zero(), 
	.out(ctr_filtered)
);

counter counter_raw (
	.clk(btn1_line),
	.zero(),
	.out(ctr_raw)
);

initial begin
	forever #10 clk = ~clk;
end


always begin
	btn1_line = 0;

	#100;

	btn1_line = 1;

	#015 btn1_line = 0;
	#005 btn1_line = 1;
	#010 btn1_line = 0;
	#006 btn1_line = 1;
	#012 btn1_line = 0;
	#007 btn1_line = 1;

	#015 btn1_line = 0;
	#005 btn1_line = 1;
	#010 btn1_line = 0;
	#036 btn1_line = 1;
	#002 btn1_line = 0;
	#007 btn1_line = 1;
	#025 btn1_line = 0;
	#005 btn1_line = 1;
	#020 btn1_line = 0;
	#026 btn1_line = 1;
	#002 btn1_line = 0;
	#007 btn1_line = 1;
	#015 btn1_line = 0;
	#005 btn1_line = 1;
	#020 btn1_line = 0;
	#016 btn1_line = 1;
	#002 btn1_line = 0;
	#007 btn1_line = 1;

	#500;

	btn1_line = 0;

	#005 btn1_line = 1;
	#020 btn1_line = 0;
	#016 btn1_line = 1;
	#002 btn1_line = 0;
	#022 btn1_line = 1;
	#007 btn1_line = 0;


	#500 btn1_line = 1;
	#500 btn1_line = 0;

end




endmodule