`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module debounce_tb;

reg i = 0;
reg clk = 0;

debounce UUT (clk,i,st_o,up_o,dn_o);


initial begin
	forever #10 clk = ~clk;
end


initial begin
	i = 0;

	#100;

	i = 1;

	#015 i = 0;
	#005 i = 1;
	#010 i = 0;
	#006 i = 1;
	#012 i = 0;
	#007 i = 1;

	#015 i = 0;
	#005 i = 1;
	#010 i = 0;
	#036 i = 1;
	#002 i = 0;
	#007 i = 1;
	#025 i = 0;
	#005 i = 1;
	#020 i = 0;
	#026 i = 1;
	#002 i = 0;
	#007 i = 1;
	#015 i = 0;
	#005 i = 1;
	#020 i = 0;
	#016 i = 1;
	#002 i = 0;
	#007 i = 1;

	#500;

	i = 0;

	#005 i = 1;
	#020 i = 0;
	#016 i = 1;
	#002 i = 0;
	#022 i = 1;
	#007 i = 0;


	#500 i = 1;
	#500 i = 0;

end




endmodule
