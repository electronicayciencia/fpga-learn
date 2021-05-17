/* 

New design splitting next_state logic.

*/

module fsm (
    input i_clk,
    input i_restart,
    input [7:0] i_byte,
    input i_busy,
    output reg o_start,
    output reg [3:0] o_address = 0
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

always @(posedge i_clk or posedge i_restart) begin
    if (i_restart) begin
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
            state_next <= i_byte == 0 ? IDLE : START_TX;

        START_TX:
            state_next <= i_busy ? TX : START_TX;

        TX:
            state_next <= i_busy ? TX : NEXT_BYTE;

        NEXT_BYTE:
            state_next <= WAIT_BYTE;

        default:
            state_next <= IDLE;
    endcase
end

// Address Output
always @(posedge i_clk) begin
    if (state == RESTART)
        o_address <= 0;
    else if (state == NEXT_BYTE)
        o_address <= o_address + 1'b1;
    else
        o_address <= o_address;
end

// Start Output
always @*
    o_start <= state == START_TX;


endmodule
