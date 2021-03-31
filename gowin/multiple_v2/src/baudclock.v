// Generate clock signal for UART module from 3MHz input clock.
module baudclock (
    input clk_i,
    output reg clk_o = 0
);

    localparam semiperiod = 16'd156;      // 9600 Hz

    reg [15:0] counter = 0;

    always @(posedge clk_i) begin
        counter <= counter + 1'b1;

        if (counter == semiperiod) begin
            counter <= 0;
            clk_o <= ~clk_o;
        end
    end

endmodule
