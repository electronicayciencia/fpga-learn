module hcounter (
    input pxclk_i,          // pixel clock
    output reg hsync_o,     // horizontal sync pulse
    output reg hactive_o ,  // horizontal signal in active zone
    output reg [8:0] col_o // column number
);

localparam hactive      = 480;
localparam hfront_porch = 2;
localparam hsync_len    = 41;
localparam hback_porch  = 2;

localparam maxcount = hactive + hfront_porch + hback_porch + hsync_len - 1;


always @(posedge pxclk_i) begin
    if (col_o == maxcount)
        col_o <= 0;
    else
        col_o <= col_o + 1'b1;

    hactive_o <= col_o <= hactive;
    hsync_o   <= ~(col_o > (hactive + hfront_porch) & 
                   col_o < (hactive + hfront_porch + hsync_len));

end

endmodule