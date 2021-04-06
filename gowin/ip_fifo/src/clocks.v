// Different clocks
module clocks(
    input clk_i,
    output clk_main,   // slow clock for logic ann
    output clk_uart_o, // bauds
    output clk_timer_o // restart timer
);

clkdiv Clkdiv1(
    .clk_i(clk_i),
    .clk_o(clk_main)
);

/* Automatic restart */
timer Timer1 (
   .clk_i(clk_main),
   .clk_o(clk_timer_o)
);


baudclock UARTClk(
    .clk_i(clk_main),
    .clk_o(clk_uart_o)
);

endmodule
