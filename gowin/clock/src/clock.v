/* Clock test
   17/03/2021

   BTN_A   => IOB6B   (pin 15) (active low)
   BTN_B   => IOB3B   (pin 14) (active low)

   XTAL_IN => GCLKT_2 (pin 35) ( 24MHz )

   LED_R   => IOB10B  (pin 18) (active low)
   LED_G   => IOB7A   (pin 16) (active low)
   LED_B   => IOB10A  (pin 17) (active low)

*/

module clock (
    input XTAL_IN, BTN_A, BTN_B,
    output LED_R, LED_G, LED_B);

    reg [31:0] counter = 0;
    assign LED_R = ~counter[24];
    assign LED_G = ~counter[25];
    assign LED_B = ~counter[26];


    always @(posedge XTAL_IN) begin
        counter <= counter + 1;
    end

endmodule
