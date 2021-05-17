module dual_edge_counter (
    input i_clk, 
    output [3:0] o_count
);

    wire [3:0] next = o_count + 1'b1;

    reg [3:0] poscnt;
    reg [3:0] negcnt;

    always @(posedge i_clk) poscnt <= next;
    always @(negedge i_clk) negcnt <= next;

    assign o_count = i_clk ? poscnt : negcnt;

endmodule