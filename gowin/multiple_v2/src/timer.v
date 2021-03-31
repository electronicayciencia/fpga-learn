// Generate timer pulses
module timer (
    input clki,
    output clko
);


    localparam semiperiod = 32'd60000;    // 50 Hz 


    reg [32:0] counter = 0;

    assign clko = (counter == semiperiod);

    always @(posedge clki) begin
        if   (counter == semiperiod) counter <= 0;
        else counter <= counter + 1;
    end


endmodule
