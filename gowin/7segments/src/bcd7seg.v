// Translates BCD 4 bit input into 7 segment 8 bits vector

module bcd7seg (
    input [3:0] bcd,
    output reg [7:0] segs
);

    always @(bcd) begin
        case (bcd)
                           // pgfedcba
            4'h00: segs <= 8'b00111111;
            4'h01: segs <= 8'b00000110;
            4'h02: segs <= 8'b01011011;
            4'h03: segs <= 8'b01001111;
            4'h04: segs <= 8'b01100110;
            4'h05: segs <= 8'b01101101;
            4'h06: segs <= 8'b01111101;
            4'h07: segs <= 8'b00000111;
            4'h08: segs <= 8'b01111111;
            4'h09: segs <= 8'b01101111;
            4'h0A: segs <= 8'b01110111;
            4'h0B: segs <= 8'b01111100;
            4'h0C: segs <= 8'b00111001;
            4'h0D: segs <= 8'b01011110;
            4'h0E: segs <= 8'b01111001;
            4'h0F: segs <= 8'b01110001;
        endcase
    end

endmodule
