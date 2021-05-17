// Blink 1.0Hz @24MHz
module blink (input i_clk, output o_led);

    reg [31:0] counter = 0;
    reg o_led;

    assign got_max_count = (counter == 12e6);

    always @(posedge i_clk)
        counter <= got_max_count ? 0 : counter + 1'b1;

    always @(posedge i_clk)
        o_led <= got_max_count ? ~o_led : o_led;

endmodule
