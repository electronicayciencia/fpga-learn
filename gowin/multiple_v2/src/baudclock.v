// Generate clock signal for UART module from 24MHz input clock.
module baudclock (
    input clki,
    output reg clko = 0
);

    //localparam semiperiod = 32'd10000;    // 1200 Hz
    //localparam semiperiod = 16'd1250;     // 9600 Hz
    //localparam semiperiod = 16'd208;      // 57600 Hz
    localparam semiperiod = 16'd104;      // 115200 Hz

    reg [15:0] counter = 0;

    always @(posedge clki) begin
        counter <= counter + 1'b1;

        if (counter == semiperiod) begin
            counter <= 0;
            clko <= ~clko;
        end
    end

endmodule
