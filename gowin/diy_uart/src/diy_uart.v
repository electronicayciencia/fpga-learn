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

    clock c(clk24MHz, baudclk);

    simpleUARTtx u1(
        .data(data),
        .start(~btn_a),
        .clk(baudclk),
        .busy(busy),
        .line(serial)
    );

    always @(negedge busy) begin
        data <= data + 1'b1;
    end

endmodule
