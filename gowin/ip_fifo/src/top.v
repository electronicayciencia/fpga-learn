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

    wire sys_clk;  // main clock
    wire restart;  // timer clock
    wire uart_clk; // uart speed clock

    wire gnd = 1'b0;
    wire vdd = 1'b1;


    //assign uart_clk = clk_i;
    
    clocks Clocks1(
    .clk_i(clk_i),
    .clk_main(sys_clk),
    .clk_uart_o(uart_clk),
    .clk_timer_o(restart)
    );
    

    wire fifo_clk;
    wire fifo_wren; 
    wire fifo_rden;
    wire fifo_empty; 
    wire fifo_full;

    wire [7:0] fifo_din, 
               fifo_dout;

	fifo_sc Fifo1(
		.Data(fifo_din),
		.Clk(fifo_clk),
		.WrEn(fifo_wren),
		.RdEn(fifo_rden),
		.Q(fifo_dout),
        .Reset(1'b0),
		.Empty(fifo_empty),
		.Full(fifo_full)
	);


    reg  uart_start = 0;
    wire uart_busy;
    wire uart_out;

    wire [7:0] uart_din;

    simpleUARTtx UART1 (
        .data(uart_din),
        .start(uart_start),
        .clk(uart_clk),
        .busy(uart_busy),
        .line(uart_out)
    );

    assign fifo_clk   = uart_clk;
    assign uart_din   = fifo_dout;

    reg pre_start = 0;  
    assign fifo_rden = ~fifo_empty & ~uart_busy & ~pre_start;

    always @(posedge uart_clk) begin
        // wait 1 clock for FIFO data
        pre_start <= fifo_rden;
        uart_start <= pre_start;
    end
       



 
    /* Fill FIFO */

    reg [7:0] counter = 0;
    assign fifo_din = counter[7:0];
    assign fifo_wren = ~|counter[7:4] & ~fifo_full;

    always @ (posedge uart_clk)
        counter <= counter + 1'b1;




    assign debug[0] = uart_clk;
    assign debug[1] = pre_start;
    assign debug[2] = uart_start;
    assign debug[3] = uart_out;
    assign debug[4] = uart_busy;
    assign debug[5] = fifo_rden;
    assign debug[6] = 0;

endmodule
