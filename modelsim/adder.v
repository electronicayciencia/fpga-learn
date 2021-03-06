module adder (input reg [3:0] a,b,
              output carry,
              output [3:0] o);

wire c1, c2, c3;

half_adder ha0 (a[0], b[0], c1, o[0]);
full_adder ha1 (a[1], b[1], c1, c2, o[1]);
full_adder ha2 (a[2], b[2], c2, c3, o[2]);
full_adder ha3 (a[3], b[3], c3, carry, o[3]);

endmodule
