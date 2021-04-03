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
module main (
    input btn_a,
    input btn_b,
    input clk_i,
    output [6:0] debug
);

    wire sys_clk;  // main clock
    wire restart;  // timer clock
    wire uart_clk; // uart speed clock

    wire gnd = 1'b0;
    wire vdd = 1'b1;

    clocks Clocks1(
    .clk_i(clk_i),
    .clk_main(sys_clk),
    .clk_uart_o(uart_clk),
    .clk_timer_o(restart)
    );

    wire busy;
    wire start;
    wire [3:0] address;
    wire [7:0] byte;


    memory Mem(
        .clk_i(sys_clk),
        .addr_i(address),
        .data_o(byte)
    );


//    Gowin_pROM Mem(
//        .dout(byte),   // [7:0] dout
//        .clk(sys_clk), // clk
//        .oce(vdd),     // output enable
//        .ce(vdd),      // chip enable
//        .reset(gnd),   // reset
//        .ad(address)   // [3:0] address
//    );

    simpleUARTtx UART1 (
        .data(byte),
        .start(start),
        .clk(uart_clk),
        .busy(busy),
        .line(serial)
    );

    fsm FSM1 (
        .clk_i(sys_clk),
        .restart_i(restart),
        .byte_i(byte),
        .busy_i(busy),
        .start_o(start),
        .address_o(address)
    );

   
    assign debug[0] = restart;
    assign debug[1] = sys_clk;
    assign debug[2] = uart_clk;
    assign debug[3] = serial;
    assign debug[6:4] = address[2:0];
    //assign debug[4] = 0;
    //assign debug[5] = 0;
    //assign debug[6] = 0;

endmodule
