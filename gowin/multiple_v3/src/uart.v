module simpleUARTtx (input [7:0] i_data, // byte to transmit
					 input i_start,      // set to one to start TX
					 input i_clk,        // baud clock signal
					 output o_busy,      // is 1 while sending
					 output o_line       // serial data output
					 );

reg  [3:0] counter = 0;
reg [11:0] shiftreg = 12'b111111111111;
					 // Starting point: PE76543210SI (12 bits)
					 // P: stop mark (always 1)
					 // E: even parity
					 // 7-0 data bits
					 // S: start mark (always 0)
					 // I: idle mark (always 1)
					 
assign o_line = shiftreg[0]; // line is always the lsb of register
assign o_busy = |counter;    // busy unless counter = 0
assign o_even = ^i_data;       // even parity of data byte

always @ (posedge i_clk or posedge i_start) begin
    if (i_start) begin
        if (!o_busy) begin
            shiftreg <= {1'b1, o_even, i_data[7:0], 1'b0, 1'b1};
            counter <= 4'd12;
        end
    end

    else begin
        if (o_busy) begin 
            shiftreg <= {1'b1, shiftreg[11:1]};
            counter <= counter - 1'b1;
        end
    end
end

endmodule
