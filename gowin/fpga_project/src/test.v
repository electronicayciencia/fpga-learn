module led (input i_btn_a, i_btn_b,
            output o_led_r);

assign o_led_r = i_btn_a & i_btn_b;

endmodule