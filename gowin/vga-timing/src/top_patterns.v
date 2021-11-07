/* 
VGA 480x272 using FPGA

Electronica y ciencia   06/11/2021

Basic TOP module to try patterns.

References:
 https://www.improwis.com/tables/video.webt
 https://www.kernel.org/doc/Documentation/devicetree/bindings/display/panel/panel-dpi.txt
 https://www.waveshare.com/w/upload/4/44/4.3inch-480x272-Touch-LCD-B-UserManual.pdf
 https://en.wikipedia.org/wiki/Color_Graphics_Adapter


Full graphic mode:
  RGB565 = 16bit
  480*272*16 = 2088960 = 255kB ram
  GW1N SRAM Capacity(bits): 72 K

Text mode with 8x8 font and CGA color
  480/8 = 60
  272/8 = 34
  16 colors: 4bit

  60*34*4 =~ 8kbit



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

/* 
// CGA bars
cga cga(
    .color_i   ({ col[8], lin[7], lin[6], lin[5] }),
    .red_o     (LCD_R),
    .green_o   (LCD_G),
    .blue_o    (LCD_B)
);
*/



// Checkboard 16x16 (30x17)
assign light = ~(col[4]^lin[4]);

cga cga(
    .color_i   ({ 1'b0, light, light, light }),
    .red_o     (LCD_R),
    .green_o   (LCD_G),
    .blue_o    (LCD_B)
);


endmodule
