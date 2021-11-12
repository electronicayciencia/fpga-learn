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
  GW1N SRAM Capacity(bits): 72 K BSRAM+pROM

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


// VGA timing generator
Gowin_rPLL pll(
    .clkin     (XTAL_IN),      // input clkin 24MHz
    .clkout    (SYS_CLK),             // output clkout 92MHz
    .clkoutd   (LCD_CLK)       // pixel clock 9.2MHz
);


reg [7:0] clkcounter;
assign REDUCED_LCD_CLK = clkcounter[0];

always @(posedge LCD_CLK)
    clkcounter <= clkcounter + 1'b1;




wire write_ram = 1'b0;
reg [10:0] video_addr = 0;
reg [7:0] video_data = 0;

video video(
    .lcd_clk_i   (LCD_CLK),    // clock for LCD 9.2MHz
    .vram_clk_i  (LCD_CLK),    // clock for VRAM A port
    .vram_cea_i  (write_ram),  // Chip enable for VRAM
    .vram_ada_i  (video_addr), // VRAM address for write [10:0]
    .vram_din_i  (video_data), // VRAM data for write [15:0]
    .lcd_r_o     (LCD_R),
    .lcd_g_o     (LCD_G),
    .lcd_b_o     (LCD_B),
    .lcd_hsync_o (LCD_HSYNC),
    .lcd_vsync_o (LCD_VSYNC),
    .lcd_den_o   (LCD_DEN)
);

reg [31:0] counter = 0;

reg [15:0] l = 16'h1; // Galois LFSR

// fill video memory
always @(posedge LCD_CLK) begin
    counter <= counter + 1'b1;

    if (counter[9]) begin
        video_addr <= video_addr + 2'd2;
        video_data <= l[7:0];
        counter <= 0;
    end

    if (video_addr > 32*17*2) begin
        video_addr <= 0;
    end

    l <= {l[14:0], l[15] ^ l[13] ^ l[12] ^ l[10]};

end


endmodule
