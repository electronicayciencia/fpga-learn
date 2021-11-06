module vcounter (
    input hsync_i,          // horizontal counter reset
    output reg vsync_o,     // vertical sync pulse
    output reg vactive_o,   // vertical signal in active zone
    output reg [8:0] lin_o  // line number
);

localparam vactive      = 272;
localparam vback_porch  = 2;
localparam vsync_len    = 10;
localparam vfront_porch = 4;

localparam maxcount = vactive + vfront_porch + vback_porch + vsync_len - 1;

always @(posedge hsync_i) begin
    if (lin_o == maxcount)
        lin_o <= 0;
    else
        lin_o <= lin_o + 1'b1;

    vactive_o <= lin_o <= vactive;
    vsync_o   <= ~(lin_o > (vactive + vfront_porch) & 
                   lin_o < (vactive + vfront_porch + vsync_len));

end


endmodule