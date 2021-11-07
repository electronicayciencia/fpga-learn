/* 
VGA 480x272 using FPGA

Electronica y ciencia   06/11/2021

References:
 https://www.improwis.com/tables/video.webt
 https://www.kernel.org/doc/Documentation/devicetree/bindings/display/panel/panel-dpi.txt
 https://www.waveshare.com/w/upload/4/44/4.3inch-480x272-Touch-LCD-B-UserManual.pdf
 https://en.wikipedia.org/wiki/Color_Graphics_Adapter

8x8 bit font from:
 https://github.com/dhepper/font8x8

Full graphic mode:
  RGB565 = 16bit
  480*272*16 = 2088960 = 255kB ram
  GW1N SRAM Capacity(bits): 72 K

Text mode with 8x8 font and CGA color
  Address lines:
    480/8 = 60 horizontal blocks (6 bit)
    272/8 = 34 vertical blocks (6 bit)

  Output width
    16 color foreground: 4bit
    16 color background: 4bit
    128 characters: 7 bit (8 bit for the future)
    Total: 16bits



*/


module top (
    input XTAL_IN,       // 24 MHz
    output [4:0] LCD_R,
    output [5:0] LCD_G,
    output [4:0] LCD_B,
    output LCD_HSYNC,
    output LCD_VSYNC,
    output LCD_CLK,
    output LCD_DEN
);



wire [8:0] col;
wire [8:0] lin;

assign LCD_DEN = vactive & hactive;


// VGA timing generator
Gowin_rPLL pll(
    .clkin     (XTAL_IN),      // input clkin 24MHz
    .clkout    (),             // output clkout (not used)
    .clkoutd   (LCD_CLK)       // pixel clock 9.2MHz
);

hcounter hcounter(
    .pxclk_i   (LCD_CLK),      // pixel clock
    .hsync_o   (LCD_HSYNC),    // horizontal sync pulse
    .hactive_o (hactive),      // horizontal signal in active zone
    .col_o     (col)           // column number
);

vcounter vcounter(
    .hsync_i   (LCD_HSYNC),    // horizontal clock
    .vsync_o   (LCD_VSYNC),    // vertical sync pulse
    .vactive_o (vactive),      // vertical signal in active zone
    .lin_o     (lin)           // line number
);

// Go to text mode
wire [6:0] text_col = col[8:4];  // text mode block (line / col)
wire [6:0] text_lin = lin[8:4];

// Get character, foreground and background of this block from RAM


wire [6:0] chr_ord = 7'h61;
wire [3:0] rgbifront = 2;
wire [3:0] rgbiback  = 4;

// Draw the text in the screen
wire [2:0] block_col = col[3:1]; // inner block position (sub line / sub col)
wire [2:0] block_lin = lin[3:1]; 

wire light; // pixel is on

// 8x8 character tenerator
textgen_8x8 textgen_8x8 (
    .clk_i       (LCD_CLK),
    .chr_ord_i   (chr_ord),    // character number (7bit, 0~128)
    .block_col_i (block_col),  // block column (0~7)
    .block_lin_i (block_lin),  // block line (0~7)
    .px_o        (light)       // pixel mask, is on or off
);

// CGA color generator
cga cga(
    .red_o     (LCD_R),
    .green_o   (LCD_G),
    .blue_o    (LCD_B),
    .color_i   ({ rgbifront[3] & light | rgbiback[3] & ~light, 
                  rgbifront[2] & light | rgbiback[2] & ~light, 
                  rgbifront[1] & light | rgbiback[1] & ~light, 
                  rgbifront[0] & light | rgbiback[0] & ~light })
);

endmodule
