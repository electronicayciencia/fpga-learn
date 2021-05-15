module led (input i_btn_a, i_btn_b,
            output o_led_r, o_led_g, o_led_b);

    assign btn_a = ~i_btn_a;
    assign btn_b = ~i_btn_b;


    assign led_r = btn_a & ~btn_b;
    assign led_g = ~btn_a & btn_b;
    assign led_b = btn_a & btn_b;


    assign o_led_r = ~led_r;
    assign o_led_g = ~led_g;
    assign o_led_b = ~led_b;

endmodule
