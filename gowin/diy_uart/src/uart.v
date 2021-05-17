module simpleUARTtx (input [7:0] i_data, // byte to transmit
                     input i_start,      // set to one to start TX
                     input i_clk,        // baud clock signal
                     output o_busy,      // 1: working 0: idle
                     output o_line       // serial data output
                     );

reg  [3:0] counter = 0;
reg [11:0] shiftreg = 12'b111111111111;
                     // main shiftreg: pP76543210si (12 bits)
                     // p: stop mark (always 1)
                     // P: parity
                     // 7-0 data bits
                     // s: start mark (always 0)
                     // i: idle mark (always 1)


assign o_line = shiftreg[0]; // line is always the lsb of register
assign o_busy = |counter;    // busy if counter is not empty

assign parity_even = ^i_data;     // parity of data byte
assign parity_odd  = ~parity_even;

assign idle_value  = 1'b1;
assign start_mark = 1'b0;
assign parity = parity_even;
assign stop_mark  = 1'b1;

always @ (posedge i_clk) begin
    if (o_busy) begin 
        shiftreg <= {1'b1, shiftreg[11:1]};
        counter <= counter - 1'b1;
    end
    else if (i_start) begin
        shiftreg <= {stop_mark, parity, i_data[7:0], start_mark, idle_value};
        counter <= 4'd12;
    end
end

endmodule
