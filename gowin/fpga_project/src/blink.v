module counter (
    input i_clk, 
    output o_led
);

    assign o_led = counter[21];

    reg [32:0] counter = 0;

    always @(posedge i_clk)
        counter <= counter + 1;

endmodule