// Takes the input clock @24MHz and divides it in a counter
module reduceclock (
    input i_clk,
    output o_clk);

    reg [24:0] counter;

    assign o_clk = counter[23]; // approx 0.5s

    always @(posedge i_clk) begin
        counter <= counter + 25'd1;
    end

endmodule
