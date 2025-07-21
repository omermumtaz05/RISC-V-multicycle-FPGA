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
