module simpleUARTtx (input [7:0] data, // byte to transmit
					 input start,      // set to one to start TX
					 input clk,        // baud clock signal
					 output busy,      // is 1 while sending
					 output line       // serial data output
					 );

reg  [3:0] counter = 0;
reg [11:0] shiftreg = 12'b111111111111;
					 // Starting point: PE76543210SI (12 bits)
					 // P: stop mark (always 1)
					 // E: even parity
					 // 7-0 data bits
					 // S: start mark (always 0)
					 // I: idle mark (always 1)
					 
assign line = shiftreg[0]; // line is always the lsb of register
assign busy = |counter;    // busy unless counter = 0
assign even = ^data;       // even parity of data byte

always @ (posedge clk or posedge start) begin
    if (start) begin
        if (!busy) begin
            shiftreg <= {1'b1, even, data[7:0], 1'b0, 1'b1};
            counter <= 4'd12;
        end
    end

    else begin
        if (busy) begin 
            shiftreg <= {1'b1, shiftreg[11:1]};
            counter <= counter - 1'b1;
        end
    end
end

endmodule
