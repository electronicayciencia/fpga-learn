// Takes the input clock @24MHz and divides it in a counter
module reduceclock (
    input clk,
    output slowclk);

    reg [24:0] counter;

    assign slowclk = counter[23]; // approx 0.5s

    always @(posedge clk) begin
        counter <= counter + 25'd1;
    end

endmodule
