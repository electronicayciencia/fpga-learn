// Convert a level change into a positive pulse < 1 clock wide
module high2pulse (
    input clk_i,
    input lvl_i,
    output pulse_o
);

    reg status = 0;

    assign pulse_o = (status != lvl_i);

    always @(posedge clk_i) status <= lvl_i;

endmodule
