// Different clocks
module clocks(
    input  i_clk,
    output o_clk_main, // slow clock for logic ann
    output o_clk_uart, // bauds
    output o_clk_timer // restart timer
);

clkdiv Clkdiv1(
    .i_clk(i_clk),
    .o_clk(o_clk_main)
);

/* Automatic restart */
timer Timer1 (
   .i_clk(o_clk_main),
   .o_clk(o_clk_timer)
);


baudclock UARTClk(
    .i_clk(o_clk_main),
    .o_clk(o_clk_uart)
);

endmodule
