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

assign vcc = 1'b1;
assign gnd = 1'b0;

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

wire [3:0] rgbicolor = 7;
wire [6:0] chr_ord = 4;

// CGA color generator
cga cga(
    .red_o     (LCD_R),
    .green_o   (LCD_G),
    .blue_o    (LCD_B),
    .color_i   ({ rgbicolor[3] & light, 
                  rgbicolor[2] & light, 
                  rgbicolor[1] & light, 
                  rgbicolor[0] & light })
);



wire [7:0] rom_output;
reg [8:0] chrline = 0;

wire [6:0] text_col = col[8:3];  // text mode block (line / col)
wire [6:0] text_lin = lin[8:3];
wire [2:0] text_sub_col = col[2:0]; // inner block position (sub line / sub col)
wire [2:0] text_sub_lin = lin[2:0]; 

wire [9:0] chrrom_addr = {chr_ord, text_sub_lin}; // 7bit + 3bit

// 8x8 fixed font character generator
chr_rom chr_rom(
    .oce       (vcc),          //
    .ce        (vcc),          //
    .reset     (gnd),          // reset
    .dout      (rom_output),   // data output [7:0]
    .clk       (LCD_CLK),      // clock
    .ad        (chrrom_addr)   // address line [9:0]
);

always @(posedge LCD_CLK) begin
    if (text_sub_col == 0)
        chrline <= rom_output;
    else
        // left pixel it the most significat bit 
        chrline <= {chrline[6:0], 1'b0};
end

assign light = chrline[7];




endmodule
