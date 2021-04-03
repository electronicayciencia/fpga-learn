/* 

New design splitting next_state logic.

*/

module fsm (
    input clk_i,
    input restart_i,
    input [7:0] byte_i,
    input busy_i,
    output reg start_o,
    output reg [3:0] address_o = 0
);

localparam [2:0] // 7 states needed
    IDLE       = 3'd00,
    RESTART    = 3'd01,
    WAIT_BYTE  = 3'd02,
    CHECK_BYTE = 3'd03,
    START_TX   = 3'd04,
    TX         = 3'd05,
    NEXT_BYTE  = 3'd06;

reg [2:0] state = IDLE;
reg [2:0] state_next = IDLE;

always @(posedge clk_i or posedge restart_i) begin
    if (restart_i) begin
        if (state == IDLE) begin
            state <= RESTART;
        end
    end
    else state <= state_next;
end

always @* begin
    case (state)
        RESTART:
            state_next <= WAIT_BYTE;

        WAIT_BYTE:
            state_next <= CHECK_BYTE;

        CHECK_BYTE:
            state_next <= byte_i == 0 ? IDLE : START_TX;

        START_TX:
            state_next <= busy_i ? TX : START_TX;

        TX:
            state_next <= busy_i ? TX : NEXT_BYTE;

        NEXT_BYTE:
            state_next <= WAIT_BYTE;

        default:
            state_next <= IDLE;
    endcase
end

// Address Output
always @(posedge clk_i) begin
    if (state == RESTART)
        address_o <= 0;
    else if (state == NEXT_BYTE)
        address_o <= address_o + 1'b1;
    else
        address_o <= address_o;
end

// Start Output
always @*
    start_o <= state == START_TX;


endmodule
