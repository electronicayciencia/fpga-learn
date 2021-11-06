module led (input i_clk, i_reset,
            output o_led_r);

reg count;

always @(posedge i_clk | i_reset) begin
    if (i_reset)
        count <= 0;
    else
        count <= count + 1'b1;
end



endmodule