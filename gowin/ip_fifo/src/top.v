// Small project to try IP FIFO memory
/*
 Now with a FSM. Send null-terminated string.

 Main top-level module

    PIN
    35  clock 24Mhz
    14  btn_b
    15  btn_a

 Logic ann. config for debug:
    45  Ch0  debug[0]
    11  Ch1  debug[1]
    44  Ch2  debug[2]
    43  Ch4  debug[3]
    10  Ch5  debug[4]
    42  Ch6  debug[5]
    46  Ch7  debug[6]
*/
module top (
    input btn_a,
    input btn_b,
    input clk_i,
    output [6:0] debug
);

    wire clk_main;  // main clock
    wire restart;  // timer clock

//    assign clk_main = clk_i;
    clkdiv Clkdiv1(
        .clk_i(clk_i),
        .clk_o(clk_main)
    );

    wire full;
    wire [7:0] data;
    wire wren;
    wire serial;

    fifo_uart FUART1(
        .clk_i(clk_main),
        .byte_i(data),
        .wren_i(wren),
        .serial_o(serial),
        .full_o(full)
    );

    /* Fill FIFO */
    reg [7:0] byte = 0;
    assign data = byte[7:0];
    assign wren = ~|byte[7:4] & ~full;
 
    always @ (posedge clk_main)
        byte <= byte + 1'b1;




    assign debug[0] = clk_main;
    assign debug[1] = 0;
    assign debug[2] = 0;
    assign debug[3] = serial;
    assign debug[4] = full;
    assign debug[5] = wren;
    assign debug[6] = 0;

endmodule
