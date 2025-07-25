
module FSM(
    input clk,
    input reset,
    input [6:0] opcode,

    output RegWrite,
    output ALUSrcA,
    output MemRead,
    output MemWrite,
    output MemtoReg,
    output IorD,
    output IRWrite, 
    output PCWrite,
    output PCWriteCond,
    output PCSource,

    output [1:0] ALUOp,
    output [1:0] ALUSrcB

);

parameter state0 = 4'b0000, state1 = 4'b0001, state2 = 4'b0010, state3 = 4'b0011,
            state4 = 4'b0100, state5 = 4'b0101, state6 = 4'b0110, state7 =4'b0111,
            state8 = 4'b1000;

reg [3:0] state, next_state;

parameter LW = 7'b0000011,
          SW = 7'b0100011,
          R_type = 7'b0110011,
          BEQ = 7'b1100011;

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
  assign MemRead = ((state == state0) || (state == state3));
assign MemWrite = (state == state5);

  assign ALUSrcA = (state == state0) || (state == state1) ? 1'b0:
    				(state == state2) || (state == state6) || (state == state8) ? 							1'b1:
    				1'b0;
  
  assign IorD = (state == state0) ? 1'b0:
		 (state == state3) || (state == state5) ? 1'b1:
		1'b0;


assign IRWrite = (state == state0);

assign PCWrite = (state == state0);

assign PCWriteCond = (state == state8);

  assign RegWrite = ((state == state4) || (state == state7));

  assign MemtoReg = (state == state7) ? 1'b0:
		(state == state4) ? 1'b1:
		1'b0;

  assign PCSource = (state == state0) ? 1'b0: 
					(state == state8) ? 1'b1:
					1'b0;

//2-bit control signals
  assign ALUOp = ((state == state0) || (state == state1) || (state == state2)) ? 2'b00:
               (state == state6) ? 2'b10:
    			(state == state8) ? 2'b01:
    			2'b00;

assign ALUSrcB = (state == state0) ? 2'b01:
                 (state == state1 || state == state2) ? 2'b10:
  				(state == state6 || state == state8) ? 2'b00:
  				2'b00;





endmodule

module ALUControl(
//input [6:0] funct7,
//input [2:0] funct3,
//input [31:0] inst,
input [6:0] funct7,
input [2:0] funct3,
input [1:0] ALUOp,
input reset, 

output reg [3:0] control

);

 // wire [6:0] funct7;
  //wire [2:0] funct3;

 // assign funct7 = inst[31:25];
  //assign funct3 = inst[15:12];
  
    always @ (*)
        begin
            if(reset)
                control = 0;

            else if(ALUOp == 2'b00)
                control = 4'b0010;
            else if(ALUOp == 2'b01)
                control = 4'b0110;
            else if(ALUOp == 2'b10)
                begin
                  if(funct7 == 7'b0 && funct3 == 3'b0)
                        control = 4'b0010; // add
                  else if(funct7 == 7'b0100000 && funct3 == 3'b0)
                        control = 4'b0110; // sub
                  else if(funct7 == 7'b0 && funct3 == 3'b111)
                        control = 4'b0000; // AND
                    else if(funct7 == 7'b0 && funct3 == 3'b110)
                        control = 4'b0001; // OR;
                end
        end

endmodule

//VERIFY 
