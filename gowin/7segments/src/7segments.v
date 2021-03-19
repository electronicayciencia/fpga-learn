/* Module to play with a single 7 segment display 
   18/03/2021

   clk -> XTAL_IN -> 35
   clk -> btn_b -> 14

   reset -> btn_a -> 15

   a -> G4 -> 39
   b -> G3 -> 38
   c -> R1 -> 28
   d -> R2 -> 29
   e -> R3 -> 30
   f -> G5 -> 40
   g -> B0 -> 41
   dp-> R0 -> 27

*/

module display (
    input clk,reset,
    output a,b,c,d,e,f,g,dp);

    wire clk1s;
    wire [7:0] leds;
    reg [3:0] counter = 0;

    assign a = ~leds[0]; // active low (common anode)
    assign b = ~leds[1];
    assign c = ~leds[2];
    assign d = ~leds[3];
    assign e = ~leds[4];
    assign f = ~leds[5];
    assign g = ~leds[6];
    assign dp = ~leds[7];

    reduceclock rc (clk, clk1s);
    bcd7seg     b7 (counter, leds);

    always @(posedge clk1s or negedge reset) begin
        if (!reset)
            counter <= 0;
        else
            counter <= counter + 4'd1;
    end

endmodule
