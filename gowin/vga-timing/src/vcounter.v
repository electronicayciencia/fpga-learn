module vcounter (
    input hsync_i,          // horizontal counter reset
    output vactive_o,       // vertical signal in active zone
    output reg vsync_o,     // vertical sync pulse
    output reg [8:0] lin_o  // line number (0 ~ vactive-1)
);

localparam vactive      = 272;
localparam vfront_porch = 4;
localparam vsync_len    = 10;
localparam vback_porch  = 2;

localparam maxcount = vactive + vfront_porch + vback_porch + vsync_len - 1;

assign vactive_o = lin_o < (vactive);

always @(negedge hsync_i) begin
    if (lin_o == maxcount)
        lin_o <= 0;
    else
        lin_o <= lin_o + 1'b1;

    // prevent glitches
    vsync_o <= ~(lin_o > (vactive + vfront_porch) & 
                 lin_o < (vactive + vfront_porch + vsync_len));

end

endmodule