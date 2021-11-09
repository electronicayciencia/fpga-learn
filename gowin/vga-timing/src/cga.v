// Receive the color attribute and "pixel on" signal 
// and pretend to drive a IRGB electron gun.
// LCD input is R(5)G(6)B(5) actually.
module cga (
    input  [7:0] color_i,   // irgb irgb (background, foreground) (sync)
    input        on_i,      // pixel on (async)
    input        clk_i,
    output [4:0] red_o,
    output [5:0] green_o,
    output [4:0] blue_o
);

reg [7:0] color_attr = 0;
wire back_i = color_attr[7];
wire back_r = color_attr[6];
wire back_g = color_attr[5];
wire back_b = color_attr[4];
wire fore_i = color_attr[3];
wire fore_r = color_attr[2];
wire fore_g = color_attr[1];
wire fore_b = color_attr[0];

always @(posedge clk_i)
    color_attr <= color_i;


wire blue  = fore_b & on_i | back_b & ~on_i; // blue color line
wire green = fore_g & on_i | back_g & ~on_i; // green color line
wire red   = fore_r & on_i | back_r & ~on_i; // red color line
wire i     = fore_i & on_i | back_i & ~on_i; // intensifier color line

// 00h => 00000000b
// 55h => 01010101b  (intensifier bit)
// AAh => 10101010b  (color bit)
// FFh => 11111111b

assign red_o   = { red,   i, red,   i, red };
assign green_o = { green, i, green, i, green, i };
assign blue_o  = { blue,  i, blue,  i, blue };

endmodule
