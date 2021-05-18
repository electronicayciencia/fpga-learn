//Copyright (C)2014-2021 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Post-PnR Simulation Model file
//GOWIN Version: V1.9.7.03Beta
//Created Time: Tue May 18 16:14:53 2021

module and_gate(
	a,
	b,
	o
);
input a;
input b;
output o;
wire GND;
wire VCC;
wire a;
wire b;
wire o;
VCC VCC_cZ (
  .V(VCC)
);
GND GND_cZ (
  .G(GND)
);
GSR GSR (
	.GSRI(VCC)
);
LUT2 o_d_s (
	.I0(a),
	.I1(b),
	.F(o)
);
defparam o_d_s.INIT=4'h8;
endmodule
