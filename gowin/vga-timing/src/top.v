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
    Attributes: 16 color foreground + 16 color background: 8bit
    Text: 128 characters: 7 bit (8 bit for the future)
    



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

// Go to text mode cells
// need to reduce text resolution 30*17 because using two BSRAM banks has a problem:
//  attributes are retrieved correctly but not text character.
wire [4:0] text_row = lin[8:4]; // vertical cell number (text row)
wire [4:0] text_pos = col[8:4]; // horizontal cell number (text position)

// Get character, foreground and background of this cell from RAM

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


assign vcc = 1'b1;
assign gnd = 1'b0;

wire [15:0] cell_content;// = 16'h4262;
reg [6:0] chr_ord   = 0; // only 128 characters (7bit)
reg [7:0] textattr  = 0;
reg [3:0] rgbifront = 0;
reg [3:0] rgbiback  = 0;

// Semi-Dual port RAM: 
//  Port A supports write operation 
//  and port B support read operation

// pre-fetch next character while in last clock of the current one because rom generator is clocked 
// but not text attrs because color output is direct logic
wire [9:0] vram_addr = {text_row, text_pos+1'b1};
always @(posedge LCD_CLK) begin
    if (col[3:1] == 3'b111) begin
        chr_ord   <= cell_content[6:0];
        textattr  <= cell_content[15:8];
    end
    else if (col[3:1] == 3'b000) begin
        rgbifront <= textattr[3:0];
        rgbiback  <= textattr[7:4];
    end
end

text_ram text_ram(
    .oce(vcc),
    .ceb(vcc),
    .resetb(gnd),
    .cea(gnd),                 // dont write
    .reseta(vcc),              // dont write
    .clka(LCD_CLK),
    .clkb(LCD_CLK),
    .ada(10'b0),               // port A address [9:0]
    .din(16'h0000),             // port A data input [15:0]
    .adb(vram_addr),  // port B address [9:0]
    .dout(cell_content)        // data output port B irgb(4) IRGB(4) chr(8)
);


//----------------



// Draw the text in the screen
wire [2:0] cell_col = col[3:1]; // position inside the text cell
wire [2:0] cell_lin = lin[3:1]; 

wire light; // pixel is on

// 8x8 character tenerator
textgen_8x8 textgen_8x8 (
    .clk_i      (LCD_CLK),
    .chr_ord_i  (chr_ord),     // character number (7bit, 0~128)
    .cell_col_i (cell_col),    // cell column (0~7)
    .cell_lin_i (cell_lin),    // cell line (0~7)
    .px_o       (light)        // pixel mask, is on or off
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
