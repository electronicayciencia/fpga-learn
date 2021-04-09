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
    wire restart;   // timer clock

//    assign clk_main = clk_i;   // fast clock for simulation
    clkdiv Clkdiv1(            // slow clock for logic analyzer
        .clk_i(clk_i),
        .clk_o(clk_main)
    );


    /* Automatic restart */
    timer Timer1 (
        .clk_i(clk_main),
        .clk_o(restart)
    );


    /* UART plus FIFO */
    wire uart_full;
    wire [7:0] uart_din;
    wire uart_wren;
    wire uart_serial;

    fifo_uart FUART1(
        .clk_i(clk_main),
        .byte_i(uart_din),
        .wren_i(uart_wren),
        .serial_o(uart_serial),
        .full_o(uart_full)
    );

    /* Simple Syncronous Memory */
    wire [3:0] mem_address;
    wire [7:0] mem_dout;

    memory Mem(
        .clk_i(clk_main),
        .addr_i(mem_address),
        .data_o(mem_dout)
    );

    assign uart_din = mem_dout;


    /* Fill FIFO */
    localparam STRLEN = 4'd11;

    reg [4:0] counter = 0;
    reg rden = 0;
    reg wren = 0;
    assign mem_address = STRLEN+1'd1 - counter[3:0]; // counter counts backwards
    assign uart_wren = wren;

    always @(posedge clk_main) begin
        rden <= counter != 0;   // no read on last cycle
        wren <= rden;           // 1 clock delay
    end

    always @(posedge clk_main or posedge restart) begin
        if (restart)
            counter <= STRLEN+5'd1;
        else begin
            if (counter != 0)  // TODO: and fifo is not full
                counter <= counter - 5'd1;
        end
    end


    assign debug[0] = restart;
    assign debug[1] = clk_main;
    assign debug[2] = 0;
    assign debug[3] = uart_serial;
    assign debug[4] = uart_full;
    assign debug[5] = wren;
    assign debug[6] = rden;

endmodule
