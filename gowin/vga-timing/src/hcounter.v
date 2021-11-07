module hcounter (
    input pxclk_i,          // pixel clock
    output hactive_o ,      // horizontal signal in active zone
    output reg hsync_o,     // horizontal sync pulse
    output reg [8:0] col_o  // column number (0 ~ hactive-1)
);

localparam hactive      = 480;
localparam hfront_porch = 2;
localparam hsync_len    = 41;
localparam hback_porch  = 2;

localparam maxcount = hactive + hfront_porch + hback_porch + hsync_len - 1;

// must be blocking assignment, otherwise the column number starts by 1 not 0.
assign hactive_o = col_o < hactive;

always @(negedge pxclk_i) begin
    if (col_o == maxcount)
        col_o <= 0;
    else
        col_o <= col_o + 1'b1;

    // prevent glitches
    hsync_o <= ~(col_o > (hactive + hfront_porch) & 
                 col_o < (hactive + hfront_porch + hsync_len));

end

endmodule