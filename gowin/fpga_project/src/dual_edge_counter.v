module dual_edge_counter (
    input i_clk, 
    output [16:0] o_count
);

    wire [16:0] next = o_count + 1'b1;

    reg [16:0] poscnt;
    reg [16:0] negcnt;

    //assign next = o_count + 1'b1;

    always @(posedge i_clk) poscnt <= next;
    always @(negedge i_clk) negcnt <= next;

    assign o_count = i_clk ? poscnt : negcnt;

endmodule