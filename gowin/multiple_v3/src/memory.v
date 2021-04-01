// DIY Read Only Syncronous Memory
// 4 bits addr bus
// 8 bits data bus
// string is null-terminated
module memory (
    input clk_i,
    input [3:0] addr_i,
    output reg [7:0] data_o
);

    reg [7:0] mem [15:0];

    initial begin
        mem[0]  = 8'h41;
        mem[1]  = 8'h42;
        mem[2]  = 8'h43;
        mem[3]  = 8'h00;
        mem[4]  = 8'h45;
        mem[5]  = 8'h46;
        mem[6]  = 8'h47;
        mem[7]  = 8'h48;
        mem[8]  = 8'h49;
        mem[9]  = 8'h50; // <- NULL
        mem[10] = 8'h51;
        mem[11] = 8'h52;
        mem[12] = 8'h53;
        mem[13] = 8'h54;
        mem[14] = 8'h55;
        mem[15] = 8'h00;
    end

    always @(posedge clk_i)
        data_o <= mem[addr_i[3:0]];

endmodule
