// According to LCD manual, it is falling-edge triggered.
module hcounter (
    input pxclk_i,          // pixel clock
    output reg hactive_o ,  // horizontal signal in active zone
    output reg hsync_o,     // horizontal sync pulse
    output reg [9:0] x_o = 0 // pixel column (0 ~ hactive-1)
);

localparam hactive      = 480;
localparam hfront_porch = 2;
localparam hsync_len    = 41;
localparam hback_porch  = 2;

localparam maxcount  = hactive + hfront_porch + hback_porch + hsync_len;
localparam syncstart = hactive + hback_porch;
localparam syncend   = syncstart + hsync_len;

reg [9:0] counter = 0;

always @(posedge pxclk_i) begin
    if (counter == maxcount - 1)
        counter <= 0;
    else
        counter <= counter + 1'b1;

    x_o       <= counter;
    hactive_o <= (counter < hactive);
    hsync_o   <= ~(counter >= syncstart & counter < syncend);
end


endmodule
