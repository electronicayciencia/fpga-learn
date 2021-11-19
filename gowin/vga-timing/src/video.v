// Video Card abstraction for R5G6B5 480x272 LCD
// 30x17 text 8x8 cells 128 characters.
// 9.2MHz clock
// 1k VRAM
//
// Memory scheme
//
// Character+attr:
//      Blink  Background color  Foreground color   Character code
// bit# 15     14 13 12          11 10 9 8          7 6 5 4 3 2 1 0
//
// Color (4 bits):
//      Intensisty  R G B
// bit# 3           2 1 0
//----------------
module video (
    input lcd_clk_i,      // clock for LCD 9.2MHz
    input vram_clk_i,     // clock for VRAM A port
    input vram_cea_i,     // CEA for VRAM
    input [10:0] vram_ada_i,    // VRAM address for write
    input  [7:0] vram_din_i,   // VRAM data for write
    output [4:0] lcd_r_o,
    output [5:0] lcd_g_o,
    output [4:0] lcd_b_o,
    output lcd_hsync_o,
    output lcd_vsync_o,
    output lcd_den_o
);

wire vcc = 1'b1;
wire gnd = 1'b0;



// Graphic mode
wire [9:0] col; // X position in the screen (only 8 bits used)
wire [8:0] lin; // Y position in the screen

// Text mode cells. 
// Need to reduce text resolution to 30*17 to save memory
// To reduce text resolution:
// a) ignore last bytes of screen position (divide coordinates / 2)
wire [4:0] text_row = lin[8:4]; // vertical cell number (text row)
wire [4:0] text_pos = col[8:4]; // horizontal cell number (text position)
wire [2:0] cell_lin = lin[3:1]; // Y position inside the text cell
wire [2:0] cell_col = col[3:1]; // X position inside the text cell

// b) Divide clock for VRAM, and character ROM access.
clkdiv clkdiv(
    .clk_i  (lcd_clk_i),
    .clk_o  (reduced_clock)
);


// Semi-Dual port RAM
// Port A supports write operation and port B support read operation
wire [10:0] vram_addr;// = 0; // row5, col5, (attr:1 | chr:0)
wire [7:0] vram_output;
text_ram text_ram(
    .oce       (vcc),
    .ceb       (vcc),
    .resetb    (gnd),
    .cea       (vram_cea_i),
    .reseta    (gnd),
    .clka      (vram_clk_i),
    .clkb      (lcd_clk_i),
    .ada       (vram_ada_i),   // port A address [9:0]
    .din       (vram_din_i),   // port A data input [15:0]
    .adb       (vram_addr),    // port B address [9:0]
    .dout      (vram_output)   // data output port B irgb(4)+IRGB(4), chr(8)
);

// Hardware LCD signals
wire vactive;
wire hactive;
assign lcd_den = vactive & hactive;

delay delay_h(
    .clk  (lcd_clk_i),
    .in   (lcd_hsync),
    .out  (lcd_hsync_o)
);

delay delay_v(
    .clk  (lcd_clk_i),
    .in   (lcd_vsync),
    .out  (lcd_vsync_o)
);

delay delay_en(
    .clk  (lcd_clk_i),
    .in   (lcd_den),
    .out  (lcd_den_o)
);

hcounter hcounter(
    .pxclk_i   (lcd_clk_i),    // pixel clock
    .hsync_o   (lcd_hsync),  // horizontal sync pulse
    .hactive_o (hactive),      // horizontal signal in active zone
    .x_o       (col)           // x pixel position
);

vcounter vcounter(
    .hsync_i   (lcd_hsync),  // horizontal sync pulse
    .clk_i     (lcd_clk_i),    // main clock
    .vsync_o   (lcd_vsync),  // vertical sync pulse
    .vactive_o (vactive),      // vertical signal in active zone
    .y_o       (lin)           // y pixel position
);


// read character one clock early because character ROM is sync
// read attributes (next mem position) on the next cycle
wire [7:0] chr_ord; // character number
reg [7:0] textattr  = 8'h17;

assign vram_addr = {text_row, text_pos, 1'b0};
assign chr_ord   = vram_output;




// Draw the text in the screen
wire light; // pixel is on

// 8x8 character generator
textgen_8x8 textgen_8x8 (
    .clk_i      (lcd_clk_i),
    .chr_ord_i  (chr_ord),     // character number (8bit, 0~256)
    .cell_col_i (cell_col),    // cell column (0~7)
    .cell_lin_i (cell_lin),    // cell line (0~7)
    .px_o       (light)        // pixel mask, is on or off
);

// CGA color generator
cga cga(
    .color_i   (textattr),     // irgb irgb (background, foreground) (async)
    .on_i      (light),        // pixel on (async)
    .red_o     (lcd_r_o),
    .green_o   (lcd_g_o),
    .blue_o    (lcd_b_o)
);

endmodule
