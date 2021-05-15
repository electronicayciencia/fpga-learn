// Blink 1.4Hz @24MHz
module blink (input i_clk, output o_led);
    reg [31:0] counter = 0;

    assign o_led = counter[24];

    always @(posedge i_clk) begin
        counter <= counter + 1'b1;
    end
endmodule
