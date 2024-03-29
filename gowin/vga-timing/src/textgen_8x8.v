// Generate character based on 8x8 ROM and inner-block line/column
module textgen_8x8 (
    input clk_i,
    input [7:0] chr_ord_i,   // character number (8bit, 0~256)
    input [2:0] cell_col_i,  // cell column (0~7)
    input [2:0] cell_lin_i,  // cell line (0~7)
    output px_o              // pixel is on or off
);

wire vcc = 1'b1;
wire gnd = 1'b0;

reg  [7:0] chrline = 0;
wire [7:0] rom_output;
wire [10:0] chrrom_addr; // 7bit + 3bit
assign chrrom_addr = {chr_ord_i, cell_lin_i};

// 8x8 fixed font character generator
chr_rom chr_rom(
    .oce       (vcc),          //
    .ce        (vcc),          //
    .reset     (gnd),          // reset
    .dout      (rom_output),   // data output [7:0]
    .clk       (clk_i),        // clock
    .ad        (chrrom_addr)   // address line [9:0]
);


// Cycle:
// 0: text position updated
//    text position -> vram address
// 1: vram address -> vram output
//    vram output -> character
//    character + cell line -> rom address
// 2: rom address -> rom output
// 3: rom output -> character line
always @(posedge clk_i) begin
    if (cell_col_i == 3'd3)
        chrline <= rom_output;
    else
        chrline <= {chrline[6:0], gnd};
end

// left pixel is most significant bit but columns start by 0
// Cannot use a shift register because one clock is not one cell pixel
assign px_o = chrline[7];

endmodule
