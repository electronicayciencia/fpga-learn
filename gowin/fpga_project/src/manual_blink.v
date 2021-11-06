module led (input i_btn,
            output o_led);

    reg led = 0;
    assign o_led = led;

    always @(negedge i_btn)
        led <= ~led;

endmodule