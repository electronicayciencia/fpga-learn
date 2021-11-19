/*
Run using:
vsim -L GowinIP work.video_tb
add wave -position end  sim:/video_tb/LCD_CLK
add wave -position end  sim:/video_tb/LCD_HSYNC
add wave -position end  sim:/video_tb/LCD_VSYNC
add wave -position end  sim:/video_tb/LCD_DEN

*/

`timescale 10 ps/1 ps  // time-unit = 1 ns, precision = 1 ns

module video_tb;

reg LCD_CLK;
wire write_ram;
wire [10:0] video_addr;
wire  [7:0] video_data;
wire [4:0] LCD_R;
wire [5:0] LCD_G;
wire [4:0] LCD_B;
wire LCD_HSYNC;
wire LCD_VSYNC;
wire LCD_DEN;

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

always 
begin
    LCD_CLK <= 1'b1; 
    #1; // high for 1 * timescale = 1 ns

    LCD_CLK <= 1'b0;
    #1; // low for 1 * timescale = 1 ns
end

endmodule
