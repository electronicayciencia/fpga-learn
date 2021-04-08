// Different clocks
module clocks(
    input clk_i,
    output clk_main,   // slow clock for logic ann
    output clk_uart_o, // bauds
    output clk_timer_o // restart timer
);


/* Automatic restart */
timer Timer1 (
   .clk_i(clk_main),
   .clk_o(clk_timer_o)
);


endmodule
