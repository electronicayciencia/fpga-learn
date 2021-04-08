module fifo_uart (
    input clk_i,
    input [7:0] byte_i,
    input wren_i,
    output serial_o,
    output full_o
);

    wire uart_clk;

    baudclock UARTClk(
        .clk_i(clk_i),
        .clk_o(uart_clk)
    );

    wire fifo_rden;
    wire fifo_empty; 
    wire [7:0] fifo_dout;

    fifo Fifo1(
        .Data(byte_i),
        .WrClk(clk_i),
        .RdClk(uart_clk),
        .WrEn(wren_i),
        .RdEn(fifo_rden),
        .Q(fifo_dout),
        .Empty(fifo_empty),
        .Full(full_o)
    );

    reg  uart_start = 0;
    wire uart_busy;

    simpleUARTtx UART1 (
        .data(fifo_dout),
        .start(uart_start),
        .clk(uart_clk),
        .busy(uart_busy),
        .line(serial_o)
    );


    // FIFO - UART interface logic
    reg pre_start = 0;  
    assign fifo_rden = ~fifo_empty & ~uart_busy & ~pre_start; // TODO: glitchy

    always @(posedge uart_clk) begin
        // delay 1 clock for FIFO data
        pre_start <= fifo_rden;
        uart_start <= pre_start;
    end


endmodule