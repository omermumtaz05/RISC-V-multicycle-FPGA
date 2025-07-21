module top_module(clock, reset);

      input wire clock;
      input wire reset;

        // ALL CONTROL SIGNALS:

        //control signals (1-bit)
        wire IorD, ALUSrcA, MemtoReg, PCSource, PCWriteCond, PCWrite, 
            PCcontrol, memRead, memWrite, IRWrite, regWrite;

        //control signals (2-bit)
        wire [1:0] ALUSrcB, ALUOp;

        // alu control
        wire [3:0] ALUControlLine;

        //OUTPUTS OF DATAPATH:

        //functional units
        wire [31:0] PC, ALUResult, memData, regReadData1, regReadData2; // outputs
        wire zero; // ALU zero
        
        // temp registers
        wire [31:0] ALUOut, MDR, ALUResult, A, B, Imm3, IR_out;

        //mux outputs
        wire [31:0] M1, M2, M3, M4, M5;
    

        assign PCcontol = PCWrite | (PCWriteCond & zero);

        // Instantiation the muxes
        mem_mux MEM_INST (IorD, PC, ALUOut, M1);
        A_mux A_mux_INST (ALUSrcA, A, PC, M2);
        MDR_mux MDR_mux_INST (MemtoReg, MDR, ALUOut, M3);
        PC_mux pc_mux_inst (PCSource, ALUOut, ALUResult, M4);
        B_mux b_mux_inst (ALUSrcB, B, Imm3, M5);

        
        //functional units and temp regs datapath

        ProgramCounter PC_INST (PCcontrol, M4, clock, reset, PC);  

       /*  ProgramCounter(
  input PCWrite,
  input [31:0] next_pc,
  input clk,
  input reset,
  output reg [31:0] pc)*/


      /* module memory(
    input [31:0]address,
    input [31:0]writeData,
    input memRead,
    input memWrite,
    input clk,
    input reset,
    output reg [31:0] memData
);*/

        memory memory_INST (M1, B, memRead, memWrite, clock, reset, memData); // done



      /*  module IR(
    input [31:0] MemData,
    input IRWrite,
    input clk,
	input reset,
  
    output reg [31:0] inst

);*/


        IR IR_INST(memData, IRWrite, clock, reset, IR_out);


    /*    module register(
    input [4:0] readReg1,
    input [4:0] readReg2,
    input [4:0] writeReg,
    input [31:0] writeData,
    input regWrite,
    input clk,
  	input reset,

    output reg [31:0] readData1,
    output reg [31:0] readData2
);*/

        register registers_INST (IR_out[19:15], IR_out[24:20], IR_out[11:7], M3, regWrite, clock, reset, regReadData1, regReadData2);

        ALU ALU_INST (M2, M5, ALUContrlLine, zero, ALUResult);




        PC PC_INST (clock, reset, M4, PC);

        control_unit control_unit_INST (clock, reset, PC, ALUResult, MDR,
            IorD, ALUSrcA, MemtoReg, PCSource, ALUSrcB);

      //  instruction_memory instruction_memory_INST (PC, M1);  

       // data_memory data_memory_INST (clock, reset, ALUOut, MDR, M1);

        instruction_decoder instruction_decoder_INST (M1, A, B, Imm3);

        ALUControl ALU_control_INST (ALUResult, ALUSrcA, ALUSrcB);

        
endmodule
 
 
