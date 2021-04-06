`timescale 1 ns/1 ns

module fifo_tb;

reg clk = 0;
always #10 clk=~clk;


reg [7:0] counter = 0;
reg wen_i = 0;
reg ren_i = 0; 

wire [7:0] data_o;
wire empty_o;
wire full_o;

/*
	fifo Fifo1(
		.Data(counter),
		.WrClk(clk),
		.RdClk(clk),
		.WrEn(wen_i),
		.RdEn(ren_i),
		.Q(data_o),
		.Empty(empty_o),
		.Full(full_o)
	);
*/



	fifo_sc your_instance_name(
		.Data(counter), //input [7:0] Data
		.Clk(clk), //input Clk
		.WrEn(wen_i), //input WrEn
		.RdEn(ren_i), //input RdEn
		.Reset(1'b0), //input Reset
		.Q(data_o), //output [7:0] Q
		.Empty(empty_o), //output Empty
		.Full(full_o) //output Full
	);


always @(posedge clk)
	counter <= counter + 1;



initial begin
	#10 // coincidence with raising edge
    #100 
    wen_i <= 1;
    #500 
    wen_i <= 0;
    #100
    ren_i <= 1;
    #500
    ren_i <= 0;
end

endmodule
