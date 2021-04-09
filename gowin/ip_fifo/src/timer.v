// Generate timer pulses
// Register output because comb. wire causes erratic behaviour
module timer (
    input clk_i,
    output reg clk_o
);


    localparam semiperiod = 24'd600000;    // 5 Hz 

    reg [23:0] counter = 0;

    always @(posedge clk_i) begin
        if (counter == semiperiod) begin
            clk_o <= 1;
            counter <= 0;
        end
        else begin 
            clk_o <= 0;
            counter <= counter + 1'b1;
        end
    end


endmodule
