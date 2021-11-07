// Generate character based on 8x8 ROM and inner-block line/column
module textgen_8x8 (
    input clk_i,
    input [6:0] chr_ord_i,   // character number (7bit, 0~128)
    input [2:0] block_col_i, // block column (0~7)
    input [2:0] block_lin_i, // block line (0~7)
    output px_o              // pixel is on or off
);

assign vcc = 1'b1;
assign gnd = 1'b0;

reg  [7:0] chrline = 0;
wire [7:0] rom_output;
wire [9:0] chrrom_addr = {chr_ord_i, block_lin_i}; // 7bit + 3bit

// 8x8 fixed font character generator
chr_rom chr_rom(
    .oce       (vcc),          //
    .ce        (vcc),          //
    .reset     (gnd),          // reset
    .dout      (rom_output),   // data output [7:0]
    .clk       (clk_i),        // clock
    .ad        (chrrom_addr)   // address line [9:0]
);

always @(posedge clk_i) begin
    if (block_col_i == 0)
        chrline <= rom_output[7:0];
end

// left pixel is most significant bit
// by column start by 0
assign px_o = chrline[3'd7-block_col_i+:1];

endmodule
