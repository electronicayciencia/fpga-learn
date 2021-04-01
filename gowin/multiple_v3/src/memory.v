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
        mem[0]  = "P";
        mem[1]  = "r";
        mem[2]  = "o";
        mem[3]  = "b";
        mem[4]  = "a";
        mem[5]  = "n";
        mem[6]  = "d";
        mem[7]  = "o";
        mem[8]  = " ";
        mem[9]  = "U"; // <- NULL
        mem[10] = "A";
        mem[11] = "R";
        mem[12] = "T";
        mem[13] = 0;
        mem[14] = 0;
        mem[15] = 0;
    end

    always @(posedge clk_i)
        data_o <= mem[addr_i[3:0]];

endmodule
