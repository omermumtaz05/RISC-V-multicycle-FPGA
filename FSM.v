module FSM(
    input clk,
    input reset,
    input [6:0] opcode,

    output reg RegWrite,
    output reg ALUSrcA,
    output reg MemRead,
    output reg MemWrite,
    output reg MemtoReg,
    output reg IorD,
    output reg IRWrite, 
    output reg PCWrite,
    output reg PCWriteCond,
    output reg PCSource,

    output reg [1:0] ALUOp,
    output reg [1:0] ALUSrcB,

);

parameter state0 = 4'b0000, state1 = 4'b0001, state2 = 4'b0010, state3 = 4'b0011,
            state4 = 4'b0100, state5 = 4'b0101, state6 = 4'b0110, state7 = 4'b0111,
            state8 = 4'b1000;

reg [3:0] state, next_state;

parameter LW = 7'b0000011,
          SW = 7'b0100011,
          R_type = 7'b0110011,
          BEQ = 7'b1100111;

    // State transition logic
always @ (*)
    case(state)
            state0:
                next_state = state1;


            state1:
                begin
                    if(opcode == LW || opcode == SW)
                        next_state = state2;

                    else if(opcode == R_type)
                        next_state = state6;
                        
                    else if(opcode == BEQ)
                        next_state = state8;

                end
            state2:
                begin
                    if(opcode == LW)
                        next_state = state3;
                    else if(opcode == SW)
                        next_state = state5;
                end

            state3:
                next_state = state4;

            state4:
                next_state = state0;

            state5:
                next_state = state0;

            state6:
                next_state = state7;

            state7:
                next_state = state0;

            state8:
                next_state = state0;
            
  	endcase
                    

always @ (posedge clk)
    if(reset)
        state <= state0;
    else
        state <= next_state;

//1-bit control signals
assign MemRead = (state == state0 || state == state3);
assign MemWrite = (state == state5);

assign ALUSrcA = (state != state0 || state != state1 || state == state2 || state == state6 || state == state8);
assign IorD = (state != state0 || state == state3 || state == state5);

assign IRWrite = (state == state0);

assign PCWrite = (state == state0);

assign PCWriteCond = (state == state8);

assign RegWrite = (state == state4 || state == state7);

assign MemToReg = (state == state4 || state != state7);

assign PCSource = (state != state0 || state == state8);

//2-bit control signals
assign ALUOp = (state == state0 || state == state1 || state == state2) ? 2'b00:
               (state == state6) ? 2'b10:
               (state == state8) ? 2'b01;

assign ALUSrcB = (state == state0) ? 2'b01:
                 (state == state1 || state == state2) ? 2'b10:
                 (state == state6 || state == state8) ? 2'b00;





endmodule