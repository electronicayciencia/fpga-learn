module debounce (clk,i,st_o,up_o,dn_o);

	input  clk;  // clock
	input  i;	 // input line (unfiltered)
	output st_o; // status filtered
	output up_o; // line went up pulse
	output dn_o; // line went down pulse

	localparam stable = 16'h3;

	reg [15:0] counter = 0;
	reg st	 = 0;   // actual switch status
	reg st_old = 0;   // former switch status
	
	assign up_o = (st != st_old) & i;
	assign dn_o = (st != st_old) & ~i;
	assign st_o = st;

	always @(i) counter = 0;

	always @(posedge clk) begin
		st_old = st;
		if (i != st) counter = counter + 1;
		if (counter == stable) begin
			st = i;
		end
	end

endmodule
