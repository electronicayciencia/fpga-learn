/* Electronicayciencia 17/03/2021
 *
 * Make some logic functions using the two push buttons:
 * BTN_A => IOB6B  (pin 15) (active low)
 * BTN_B => IOB3B  (pin 14) (active low)
 * LED_R => IOB10B (pin 18) (active low)
 * LED_G => IOB7A  (pin 16) (active low)
 * LED_B => IOB10A (pin 17) (active low)
 */

module gate (
    input btn_a, btn_b,
    output led_r, led_g, led_b
);

/*
    // Direct assignment for testing
    assign led_r = btn_b;
    assign led_g = btn_a;
    assign led_b = 1; // off
*/


    // Login gate (red led light when q is true)
    assign a = ~btn_a;
    assign b = ~btn_b;

    assign q = a ^ b;

    assign led_r = ~q;
    assign led_g = 1;
    assign led_b = 1; // off




endmodule
