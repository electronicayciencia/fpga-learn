// Translates BCD 4 bit input into 7 segment 8 bits vector

module bcd7seg (
    input [3:0] i_bcd,
    output reg [7:0] o_segs
);

    always @* begin
        case (i_bcd)
                             // pgfedcba
            4'h00: o_segs <= 8'b00111111;
            4'h01: o_segs <= 8'b00000110;
            4'h02: o_segs <= 8'b01011011;
            4'h03: o_segs <= 8'b01001111;
            4'h04: o_segs <= 8'b01100110;
            4'h05: o_segs <= 8'b01101101;
            4'h06: o_segs <= 8'b01111101;
            4'h07: o_segs <= 8'b00000111;
            4'h08: o_segs <= 8'b01111111;
            4'h09: o_segs <= 8'b01101111;
            4'h0A: o_segs <= 8'b01110111;
            4'h0B: o_segs <= 8'b01111100;
            4'h0C: o_segs <= 8'b00111001;
            4'h0D: o_segs <= 8'b01011110;
            4'h0E: o_segs <= 8'b01111001;
            4'h0F: o_segs <= 8'b01110001;
        endcase
    end

endmodule
