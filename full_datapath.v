
module ALU(
    input [31:0] A,
    input [31:0] B,
    input [3:0] control,
    output zero, 
    output reg [31:0] result
);

    always @ (*)
        begin
            case(control)
                4'b0000: result = A & B;
                4'b0001: result = A | B;
                4'b0010: result = A + B;
                4'b0110: result = A - B;
                default: result = 32'b0;
            endcase
        end

    
    assign zero = (result == 0);
    


endmodule

module ProgramCounter(
  input PCWrite,
  input [31:0] next_pc,
  input clk,
  input reset,
  output reg [31:0] pc);
  

  always @ (posedge clk)
    if(reset)
      pc <= 32'b0;
    else if(PCWrite)
      pc <= next_pc;
    
  
      
endmodule
      
//VERIFY

// Code your design here
module memory(
    input [31:0]address,
    input [31:0]writeData,
    input memRead,
    input memWrite,
    input clk,
    input reset,
    output reg [31:0] memData
);

    reg [7:0] data [255:0];

    initial begin
	data[0] = 8'h93;
	data[1] = 8'h01;
	data[2] = 8'h40;
	data[3] = 8'h01;
    end


    integer i;
    always @ (posedge clk)
    begin
       if(reset)
       begin
         	
         	for(i = 128; i < 256; i = i + 1)
                data[i] <= 8'b0;
       end

       else if(memWrite)
       begin
            data[address] <= writeData[7:0];
            data[address + 1] <= writeData[15:8];
            data[address + 2] <= writeData[23:16];
            data[address + 3] <= writeData[31:24];
       end
    end

    always @ (*)
        if(memRead)
            memData = {data[address + 3], data[address + 2], data[address + 1], data[address]};
        else
            memData = 32'b0;


endmodule

//VERIFY AGAIN

module register(
    input [4:0] readReg1,
    input [4:0] readReg2,
    input [4:0] writeReg,
    input [31:0] writeData,
    input regWrite,
    input clk,
  	input reset,

    output reg [31:0] readData1,
    output reg [31:0] readData2
);

    reg [31:0] RF [31:0]; // 32 registers each carrying 32 bits of data each

    integer i;
    always @ (posedge clk)
      if(reset)
        begin
  		
        for (i = 0; i < 32;  i = i + 1)
          RF[i] = 32'b0;
  
        end
        	
       else if(regWrite & writeReg != 0)
            RF[writeReg] <= writeData;

    always @ (*)
        begin
            readData1 = RF[readReg1];
            readData2 = RF[readReg2];
        end
  




endmodule

//VERIFY

module A(
    input [31:0] readData1,
    input clk,
    input reset, 

    output reg [31:0] dataA

);


    always @ (posedge clk)
        if(reset)
            dataA <= 32'b0;
        else
            dataA <= readData1;
        
endmodule

module ALUOut(
    input [31:0] ALUResult,
    input clk,
    input reset,

  	output reg [31:0] ALUOut_result
);


    always @ (posedge clk)
        if(reset)
            ALUOut_result <= 32'b0;
        else
            ALUOut_result <= ALUResult;

        
endmodule

module B(
    input [31:0] readData2,
    input clk,
  	input reset,
	
    output reg [31:0] dataB
);



    always @ (posedge clk)
      if(reset)
        dataB <= 32'b0;
  
      else
        dataB <= readData2;

endmodule

module imm_gen(
    input [31:0] inst,
  	output reg [31:0] imm
);


    always @ (*)
        case(inst[6:0])

            7'b0000011,
          	7'b0010011:
              imm = {{20{inst[31]}}, inst[31:20]}; // lw and addi

            7'b0100011:

          		imm = {{20{inst[31]}}, inst[31:25], inst[11:7]};
          		

            7'b1100011:
      
  		 		    imm = {{19{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1'b0};

            default:
            
                imm = 32'b0;

        endcase

endmodule

module IR(
    input [31:0] MemData,
    input IRWrite,
    input clk,
	input reset,
  
    output reg [31:0] inst

);

    always @ (posedge clk)
      if(reset)
        inst <= 32'b0;
        
      else if(IRWrite)
        inst <= MemData;


endmodule 

module MDR(
    input [31:0] memData,
    input reset,
    input clk,
    

  	output reg [31:0] data_out
);

    always @ (posedge clk)
      if(reset)
        data_out <= 32'b0;
  
  	  else
        data_out <= memData;

endmodule

module mem_mux (IorD, PC, ALUOut, M1); // 2 to 1 mux
    input  wire  IorD;
    input  wire [31:0] PC;     
    input  wire [31:0] ALUOut;    
    output wire [31:0] M1;       

    assign M1 = (IorD) ? ALUOut : PC;
endmodule

module A_mux (ALUSrcA, A, PC, M2);
    input wire  ALUSrcA;
    input wire [31:0] A;
    input wire [31:0] PC;
    output wire [31:0] M2;

    assign M2 = (ALUSrcA) ? A : PC;
endmodule       

module MDR_mux (MemtoReg, MDR, ALUOut, M3);
    input wire MemtoReg;
    input wire [31:0] MDR;
    input wire [31:0] ALUOut;
    output wire [31:0] M3;

    assign M3 = (MemtoReg) ? MDR : ALUOut;
endmodule

module PC_mux (PCSource, ALUOut, ALUResult, M4);
    input wire  PCSource;
    input wire [31:0] ALUOut;
    input wire [31:0] ALUResult;
    output wire [31:0] M4;

    assign M4 = (PCSource) ? ALUOut : ALUResult;
endmodule       

// 3 to 1 mux    
module B_mux (ALUSrcB, B, Imm3, M5);
    input  wire [1:0]  ALUSrcB;
    input  wire [31:0] B;
    input  wire [31:0] Imm3;
    output reg  [31:0] M5;

    always @(*) begin
        case (ALUSrcB)
            2'b00: M5 = B;
            2'b01: M5 = 32'd4;
            2'b10: M5 = Imm3;
            default: M5 = 32'hxxxxxxxx;
        endcase
    end
endmodule
