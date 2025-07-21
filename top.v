module top_module( clock,reset);
      input wire clock;
      input wire reset;

        wire [31:0] PC, ALUOut, MDR, ALUResult, A, B, Imm3;
        wire IorD, ALUSrcA, MemtoReg, PCSource;
        wire [1:0] ALUSrcB;
        wire [31:0] M1, M2, M3, M4, M5;
        wire [31:0] ALUResult;
        wire [31:0] ALUOut;
        wire [31:0] MDR;
        wire [31:0] A, B;
        wire [31:0] Imm3;
        wire [31:0] result;

        // Instantiation the muxes
        mem_mux MEM_INST (IorD, PC, ALUOut, M1);
        A_mux A_mux_INST (ALUSrcA, A, PC, M2);
        MDR_mux MDR_mux_INST (MemtoReg, MDR, ALUOut, M3);
        PC_mux pc_mux_inst (PCSource, ALUOut, ALUResult, M4);
        B_mux b_mux_inst (ALUSrcB, B, Imm3, M5);
        wire [3:0] control;
        wire zero;
        wire [31:0] result;
        
        ALU ALU_INST (A, M5, ALUResult, ALUSrcA, ALUSrcB);
        registers registers_INST (clock, reset, M1, M2, MDR, ALU
        Out, A, B, Imm3, PC, ALUResult);
        memory memory_INST (clock, reset, M1, ALUOut, MDR);
        PC PC_INST (clock, reset, M4, PC);
        control_unit control_unit_INST (clock, reset, PC, ALUResult, MDR,
            IorD, ALUSrcA, MemtoReg, PCSource, ALUSrcB);
        instruction_memory instruction_memory_INST (PC, M1);  
        data_memory data_memory_INST (clock, reset, ALUOut, MDR, M1);
        instruction_decoder instruction_decoder_INST (M1, A, B, Imm3);

        ALU_control ALU_control_INST (ALUResult, ALUSrcA, ALUSrcB);

        
endmodule
 
 

