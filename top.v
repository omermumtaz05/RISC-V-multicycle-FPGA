module top_module( clock,reset);
      input wire clock;
      input wire reset;

        wire [31:0] PC, ALUOut, MDR, ALUResult, A, B, Imm3;
        wire IorD, ALUSrcA, MemtoReg, PCSource;
        wire [1:0] ALUSrcB;
        wire [31:0] M1, M2, M3, M4, M5;

        // Instantiation the muxes
        mem_mux MEM_INST (IorD, PC, ALUOut, M1);
        A_mux A_mux_INST (ALUSrcA, A, PC, M2);
        MDR_mux MDR_mux_INST (MemtoReg, MDR, ALUOut, M3);
        PC_mux pc_mux_inst (PCSource, ALUOut, ALUResult, M4);
        B_mux b_mux_inst (ALUSrcB, B, Imm3, M5);
 
 


