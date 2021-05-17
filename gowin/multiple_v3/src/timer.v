// Generate timer pulses
// Register output because comb. wire causes erratic behaviour
module timer (
    input i_clk,
    output reg o_clk
);


    localparam semiperiod = 16'd60000;    // 40 Hz 

    reg [15:0] counter = 0;

    always @(posedge i_clk) begin
        if (counter == semiperiod) begin
            o_clk <= 1;
            counter <= 0;
        end
        else begin 
            o_clk <= 0;
            counter <= counter + 1'b1;
        end
    end


endmodule
