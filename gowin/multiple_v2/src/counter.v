// 4 bit modular counter with sync reset and end signal.
module counter (
    input clk_i,
    input reset_i,  // sync back to 0, active high
    output [3:0] out_o,
    output end_o
);

    localparam MAXVALUE = 7;

    reg [3:0] counter;

    assign end_o = (counter == MAXVALUE);
    assign out_o = counter;

    always @(posedge clk_i) begin
        if (reset_i) counter <= 0;

        else if (!end_o)
            counter <= counter + 1'b1;
    end

endmodule
