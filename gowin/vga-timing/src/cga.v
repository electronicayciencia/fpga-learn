// Converts 4bit RGBI color scheme to RGB565
module cga (
    input  [3:0] color_i,
    output [4:0] red_o,
    output [5:0] green_o,
    output [4:0] blue_o
);

assign blue  = color_i[0]; // blue color line
assign green = color_i[1]; // green color line
assign red   = color_i[2]; // red color line
assign i     = color_i[3]; // intensifier line

// 00h => 00000000b
// 55h => 01010101b  (intensifier bit)
// AAh => 10101010b  (color bit)
// FFh => 11111111b

assign red_o   = { red,   i, red,   i, red };
assign green_o = { green, i, green, i, green, i };
assign blue_o  = { blue,  i, blue,  i, blue };

endmodule
