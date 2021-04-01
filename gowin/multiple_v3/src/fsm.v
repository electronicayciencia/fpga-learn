/* 

State        Actions               Until clock and...
------------------------------------------------------
IDLE         idle               -> restart signal -> set memory = 0
WAIT_BYTE    wait for ROM       -> (only clock)
READ_BYTE    check byte is null -> (only clock)
 - if byte == 0 => IDLE
 - else => START_TX
START_TX     set uart start     -> busy signal
TX           clear uart start   -> not busy signal
NEXT_BYTE    set memory address -> (only clock)

*/

module fsm (
    input clk_i,
    input restart_i,
    input [7:0] byte_i,
    input busy_i,
    output reg start_o,
    output reg [3:0] address_o
);

localparam [2:0] // 6 states needed
    IDLE       = 3'd01,
    WAIT_BYTE  = 3'd02,
    READ_BYTE  = 3'd03,
    START_TX   = 3'd04,
    TX         = 3'd05,
    NEXT_BYTE  = 3'd06;

reg [2:0] state = IDLE;

always @(posedge clk_i or posedge restart_i) begin
    if (restart_i) begin
        if (state == IDLE) begin
            address_o <= 0;
            state <= WAIT_BYTE;
        end
    end

    else begin
        case (state)
            IDLE:
                state <= IDLE;

            WAIT_BYTE:
                state <= READ_BYTE;

            READ_BYTE:
                begin
                    if (|byte_i) 
                        state <= START_TX;
                    else 
                        state <= IDLE;
                end

            START_TX:
                begin
                    if (~busy_i)
                        start_o <= 1'b1;
                    else begin
                        start_o <= 0;
                        state <= TX;
                    end
                end

            TX:
                if (~busy_i)
                    state <= NEXT_BYTE;

            NEXT_BYTE:
                begin
                    address_o <= address_o + 1'b1;
                    state <= WAIT_BYTE;
                end

            default:
                state <= IDLE;

        endcase
    end
end


endmodule
