// reset on two simultaneous conditions
module dualreset (input i_reset_1, i_reset_2, i_clk, 
             output o_out);

    reg [2:0] count = 0;
    assign o_out = count[0];

    assign reset = i_reset_1 & i_reset_2;

    always @(posedge i_clk or posedge reset) begin
        if (reset)
            count <= 0;
        else
            count <= count + 1'b1;
    end

endmodule