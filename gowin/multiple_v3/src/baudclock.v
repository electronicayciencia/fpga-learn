// Generate clock signal for UART module from 3MHz input clock.
module baudclock (
    input i_clk,
    output reg o_clk = 0
);

    localparam semiperiod = 16'd156;      // 9600 Hz

    reg [15:0] counter = 0;

    always @(posedge i_clk) begin
        counter <= counter + 1'b1;

        if (counter == semiperiod) begin
            counter <= 0;
            o_clk <= ~o_clk;
        end
    end

endmodule
