module lfsr (input clk,
             input [3:0] seed,
             input load,
             output q);

reg [3:0] status = 1;
reg feedback_bit;
reg out_bit;

assign feedback_bit = status[3] ^ status[2] ^ status[0];
assign q = out_bit;

always @ (posedge clk) begin
  if (load) begin
    status <= seed;
    out_bit <= status[0];
  end
  else begin
    out_bit <= status[0];
    status <= {feedback_bit, status[3:1]};
  end
end


endmodule
