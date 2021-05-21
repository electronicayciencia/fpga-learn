module blink_1s (
    input i_clk, 
    output reg o_led = 0
);

    reg [31:0] counter = 0;

    always @(posedge i_clk) begin
        counter <= counter + 1;

        if (counter == 12e3-1) begin
            o_led <= ~o_led;
            counter <= 0;
        end 
    end

endmodule
