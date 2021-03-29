/*
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
    input sys_clk,
    output [6:0] debug
);

    wire restart;
    wire [3:0] address;
    wire endflag;
    wire [7:0] byte;
    wire newbyte;
    wire serial;
    wire busy;

    assign next_byte = sys_clk & ~busy;
    assign restart = restart_signal & endflag;
    
    /* Manual restart */
    /*
    high2pulse H2p(
        .clk_i(sys_clk),
        .lvl_i(btn_a),
        .pulse_o(restart_signal)
    );
    */

    /* Automatic restart */
    timer Timer1 (
        .clki(sys_clk),
        .clko(restart_signal)
    );

    counter Counter(
        .clk_i(next_byte),
        .reset_i(restart),
        .out_o(address),
        .end_o(endflag)
    );

    memory Mem(
        .addr_i(address),
        .data_o(byte)
    );

    chgdetect ChgDetect (
        .clk_i(sys_clk),
        .in(address),
        .o(newbyte)
    );

    baudclock UARTClk(
        .clki(sys_clk),
        .clko(uart_clk)
    );

    simpleUARTtx UART1 (
        .data(byte),
        .start(newbyte),
        .clk(uart_clk),
        .busy(busy),
        .line(serial)
    );



    assign debug[0] = restart;
    assign debug[1] = 0;
    assign debug[2] = 0;
    assign debug[3] = 0;
    assign debug[4] = serial;
    assign debug[5] = 0;
    assign debug[6] = 0;

endmodule
