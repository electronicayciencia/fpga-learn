// Blink 1.0Hz @24MHz
module blink (
    input i_clk, 
    output reg o_led
);

    reg [31:0] counter = 0;

    always @(posedge i_clk) begin
        counter <= counter + 1'b1;

        if (counter == 12e6) begin
            o_led <= ~o_led;
            counter <= 0;
        end 
    end

endmodule
