module vcounter (
    input hsync_i,          // horizontal counter reset
    input clk_i,            // main clock
    output reg vactive_o,   // vertical signal in active zone
    output reg vsync_o,     // vertical sync pulse
    output reg [8:0] y_o = 0   // y position
);

localparam vactive      = 272;
localparam vfront_porch = 4;
localparam vsync_len    = 10;
localparam vback_porch  = 4;

localparam maxcount  = vactive + vfront_porch + vback_porch + vsync_len;
localparam syncstart = vactive + vback_porch;
localparam syncend   = syncstart + vsync_len;

reg [8:0] counter = 0;

always @(posedge hsync_i) begin
    if (counter == maxcount - 1)
        counter <= 0;
    else
        counter <= counter + 1'b1;

    y_o       <= counter;
    vactive_o <= (counter < vactive);
    vsync_o   <= ~(counter >= syncstart & counter < syncend);
end

endmodule
