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
        mem[0]  = "S";
        mem[1]  = "i";
        mem[2]  = "m";
        mem[3]  = "p";
        mem[4]  = "l";
        mem[5]  = "e";
        mem[6]  = " ";
        mem[7]  = "U";
        mem[8]  = "A";
        mem[9]  = "R";
        mem[10] = "T";
        mem[11] = " ";
        mem[12] = "E";
        mem[13] = "y";
        mem[14] = "C";
        mem[15] = 0;
    end

    always @(posedge clk_i)
        data_o <= mem[addr_i[3:0]];

endmodule
