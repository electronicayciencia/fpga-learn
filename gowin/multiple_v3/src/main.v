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
    input i_btn_a,
    input i_btn_b,
    input i_clk,
    output [6:0] o_debug
);

    wire sys_clk;  // main clock
    wire restart;  // timer clock
    wire uart_clk; // uart speed clock

    wire gnd = 1'b0;
    wire vdd = 1'b1;

    clocks Clocks1(
        .i_clk(i_clk),
        .o_clk_main(sys_clk),
        .o_clk_uart(uart_clk),
        .o_clk_timer(restart)
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
        .i_data(byte),
        .i_start(start),
        .i_clk(uart_clk),
        .o_busy(busy),
        .o_line(serial)
    );

    fsm FSM1 (
        .i_clk(sys_clk),
        .i_restart(restart),
        .i_byte(byte),
        .i_busy(busy),
        .o_start(start),
        .o_address(address)
    );

   
    assign o_debug[0] = restart;
    assign o_debug[1] = sys_clk;
    assign o_debug[2] = uart_clk;
    assign o_debug[3] = serial;
    assign o_debug[6:4] = address[2:0];
    //assign debug[4] = 0;
    //assign debug[5] = 0;
    //assign debug[6] = 0;

endmodule
