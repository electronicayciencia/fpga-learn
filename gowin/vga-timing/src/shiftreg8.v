// 8bit shift register abstraction
module shiftreg8 (
    input  [7:0] data_i, // data input
    input  load_i,       // load data (sync)
    input  dir_i,        // shift direction h: right, l: left
    input  cen,          // clock enabled (shift)
    input  clk_i,        // clock 
    output [7:0] data_o  // data output
);

reg [7:0] data = 0;
assign data_o = data;

always @(posedge clk_i) begin
    if load_i
        data <= data_i;
    else begin
        if dir_i // right
            data <= {data[6:0], 0}
        else     // left
            data <= {0, data[7:1]}
    end
end


endmodule