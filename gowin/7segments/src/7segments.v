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
    input i_clk,i_btn_a,i_btn_b,
    output a,b,c,d,e,f,g,dp);

    wire reset;
    wire tick;           // count goes up on tick's posedge
    wire [7:0] leds;

    wire [3:0] count;
    assign reset = ~i_btn_a;

    assign a = ~leds[0]; // active low (common anode)
    assign b = ~leds[1];
    assign c = ~leds[2];
    assign d = ~leds[3];
    assign e = ~leds[4];
    assign f = ~leds[5];
    assign g = ~leds[6];
    assign dp = ~leds[7];

    assign tick = ~i_btn_b;          // manual counting

//    reduceclock rc (                   // automatic counting
//        .i_clk(i_clk), 
//        .o_clk(tick)
//    );

    bcd7seg bcd7seg_1 (
        .i_bcd(count),
        .o_segs(leds)
    );

//    reg [3:0] counter = 0;
//    always @(posedge tick or posedge reset) begin
//        if (reset)
//            counter <= 0;
//        else
//            counter <= counter + 4'd1;
//    end

    dual_edge_counter dec_1 (
        .i_clk(tick),
        .o_count(count)
    );

endmodule
