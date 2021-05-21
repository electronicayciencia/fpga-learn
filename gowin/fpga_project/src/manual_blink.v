module led (input i_btn,
            output o_led);

    reg o_led = 0;

    always @(negedge i_btn)
        o_led <= ~o_led;


endmodule