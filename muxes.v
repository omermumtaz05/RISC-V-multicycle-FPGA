module mem_mux (IorD,PC,OpB,M1); //2 to 1 mux
    input  wire IorD;
    input  wire [7:0]  PC;     
    input  wire [7:0]  ALUOut;    
    output wire [7:0]  M1;       

    assign M1 = (IorD) ? ALUOut : PC;
endmodule

module A_mux (ALUSrcA,A,PC,M2);
       input wire ALUSrcA;
       input wire [7:0] A;
       input wire [7:0] PC;
       output wire [7:0] M2;

       assign M2 = (ALUSrcA) ? A  : PC;
endmodule       

module MDR_mux (MemtoReg,MDR,ALUOut,M3);
       input wire MemtoReg;
       input wire  [7:0]  MDR;
       input wire  [7:0] ALUOut;
       output wire [7:0] M3;

       assign M3 = (MemtoReg) ? MDR : ALUOut;

endmodule

module PC_mux(PCSource,ALUOut,ALUResult,M4);
       input wire PCSource;
       input wire [7:0] ALUOut;
       input wire [7:0] ALUResult;
       output wire [7:0] M4;

        assign M4 = (PCSource) ? ALUOut : ALUResult;
endmodule       
// 3 to 1 mux    
module  B_mux(ALUSrcB,B,Imm3,M5);
        input  wire  [1:0] ALUSrcB;
        input  wire [7:0]  B;
        input  wire [7:0]  Imm;
        output reg [7:0]  M5;

        always @(*) begin
        case (ALUSrcB)
            2'b00: M5 = B;
            2'b01: M5 = 8'd4;
            2'b10: M5 = Imm;
            default: M5 = 8'bxxxxxxxx;
        endcase
    end
endmodule
         
