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
    input vram_clk_i,     // clock for VRAM
    input vram_cea_i,     // CEA for VRAM
    input  [9:0] vram_ada_i,     // VRAM address for write
    input  [15:0] vram_din_i,   // VRAM data for write
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
wire [8:0] col; // X position in the screen
wire [8:0] lin; // Y position in the screen

// Text mode cells. Need to reduce text resolution to 30*17 to save memory
wire [4:0] text_row = lin[8:4]; // vertical cell number (text row)
wire [4:0] text_pos = col[8:4]; // horizontal cell number (text position)
wire [2:0] cell_lin = lin[3:1]; // Y position inside the text cell
wire [2:0] cell_col = col[3:1]; // X position inside the text cell

// LCD signals
wire vactive;
wire hactive;
assign lcd_den_o = vactive & hactive;

// Character, foreground and background of the cell from RAM
wire [9:0] vram_addr = {text_row, text_pos+1'b1};
wire [15:0] vram_output;



// Semi-Dual port RAM: 
// Port A supports write operation and port B support read operation
text_ram text_ram(
    .oce       (vcc),
    .ceb       (vcc),
    .resetb    (gnd),
    .cea       (vram_cea_i),
    .reseta    (vcc),
    .clka      (vram_clk_i),
    .clkb      (lcd_clk_i),
    .ada       (vram_ada_i),   // port A address [9:0]
    .din       (vram_din_i),   // port A data input [15:0]
    .adb       (vram_addr),    // port B address [9:0]
    .dout      (vram_output)   // data output port B irgb(4) IRGB(4) chr(8)
);

hcounter hcounter(
    .pxclk_i   (lcd_clk_i),      // pixel clock
    .hsync_o   (lcd_hsync_o),    // horizontal sync pulse
    .hactive_o (hactive),      // horizontal signal in active zone
    .col_o     (col)           // column number
);

vcounter vcounter(
    .hsync_i   (lcd_hsync_o),    // horizontal clock
    .vsync_o   (lcd_vsync_o),    // vertical sync pulse
    .vactive_o (vactive),      // vertical signal in active zone
    .lin_o     (lin)           // line number
);


// pre-fetch next character while in last clock of the current one
reg [6:0] chr_ord   = 0; // only 128 characters (7bit)
reg [7:0] textattr  = 0;
reg [7:0] textattr_delay = 0; // character generator needs one more cycle than attrib
always @(posedge lcd_clk_i) begin
    if (col[3:1] == 3'b111) begin
        chr_ord         <= vram_output[6:0];
        textattr_delay  <= vram_output[15:8];
        textattr        <= textattr_delay;
    end
end



// Draw the text in the screen
wire light; // pixel is on

// 8x8 character tenerator
textgen_8x8 textgen_8x8 (
    .clk_i      (lcd_clk_i),
    .chr_ord_i  (chr_ord),     // character number (7bit, 0~128)
    .cell_col_i (cell_col),    // cell column (0~7)
    .cell_lin_i (cell_lin),    // cell line (0~7)
    .px_o       (light)        // pixel mask, is on or off
);

// CGA color generator
cga cga(
    .color_i   (textattr),     // irgb irgb (background, foreground) (sync)
    .clk_i     (lcd_clk_i),
    .on_i      (light),        // pixel on (async)
    .red_o     (lcd_r_o),
    .green_o   (lcd_g_o),
    .blue_o    (lcd_b_o)
);

endmodule