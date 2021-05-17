// Simple DIY TX uart
// Sends sequential characters 0-255 while A is pressed.

module diy_uart (
    input clk24MHz,
    input btn_a,
    output serial
);

    wire baudclk;
    wire busy;
    reg [7:0] data = 0;

    clock c(
        .i_clk(clk24MHz), 
        .o_clk(baudclk)
    );

    simpleUARTtx u1(
        .i_data(data),
        .i_start(~btn_a),
        .i_clk(baudclk),
        .o_busy(busy),
        .o_line(serial)
    );

    always @(negedge busy) begin
        data <= data + 1'b1;
    end

endmodule
