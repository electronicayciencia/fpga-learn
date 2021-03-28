/* Send multiple characters via diy-UART 

 Logic ann. config:
    FPGA PIN -> Channel -> Signal
    42  Ch6  serial
    43  Ch4  debug[0]
    44  Ch2  debug[1]
    45  Ch0  debug[2]
    11  Ch1  debug[3]
    10  Ch5  debug[4]
    46  Ch7  debug[5]

*/
module multiple (
    input clk_24MHz, // main clock
    output serial,   // serial output
    output [5:0] debug   // debug pin (test probe)
);


/* String initialization */
reg [7:0] string [3:0];  // string to send (array of 8 bytes)
reg [1:0] pointer;       // 3 bytes enougth to address 8 positions

initial begin
    pointer = 0;
    string[0] = 8'h41;
    string[1] = 8'h42;
    string[2] = 8'h43;
    string[3] = 8'h44;
end


/* Clocks */
wire clk_timer;
wire clk_uart;
timer clkTimer_mod(clk_24MHz, clk_timer);
baudclock clkUart_mod(clk_24MHz, clk_uart);


/* Diy SimpleUART */
wire [7:0] byte;
wire busy;
reg start = 0;  // start must remain On until busy, then Off.

assign byte = string[pointer[1:0]];

simpleUARTtx uart_mod(
    .data(byte),
    .start(start),
    .clk(clk_uart),
    .busy(busy),
    .line(serial)
);


/* Main loop */
wire last_byte = (pointer == 3);
wire txing_byte = start | busy;
wire txing_block = !last_byte | txing_byte;
reg restart = 0;

always @(posedge clk_24MHz or posedge clk_timer) begin
    // Async restart: just set restart flag and wait for next clock
    // But don't allow to restart while in a transmission
    if (clk_timer) restart <= !txing_block;

    else begin
        if (restart) begin
            restart <= 0;
            pointer <= 0;
            start <= 1;
        end

        // Clear start flag once busy is set
        if (start & busy) start <= 0;

        // When byte TX finish, increase counter
        if (!txing_byte & !last_byte) begin
            pointer <= pointer + 1'b1;
            start <= 1;
        end
    end

end




assign debug[0] = clk_timer;
assign debug[1] = clk_uart;
assign debug[2] = start;
assign debug[3] = busy;
assign debug[4] = txing_byte;
assign debug[5] = txing_block;

endmodule
