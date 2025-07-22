module top_module(clock, reset);

      input wire clock;
      input wire reset;

    // CONTROL SIGNALS:

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
    

        assign PCcontrol = PCWrite | (PCWriteCond & zero);
        FSM fsm_inst (
            clock, reset, IR_out[6:0]
            ,regWrite, ALUSrcA, memRead, memWrite,MemtoReg, IorD, IRWrite, PCWrite, PCWriteCond,PCSource,
            ALUOp,ALUSrcB
        );
        register registers_INST (IR_out[19:15], IR_out[24:20], IR_out[11:7], M3, regWrite, clock, regReadData1, regReadData2);
        A A_INST (regReadData1,clock, reset, A);
        B B_INST (regReadData2, clock, reset, B);
        MDR MDR_INST (MDR, clock, reset, M3); // M3 is the output of the mux for MemtoReg
        imm_gen imm_gen_INST (IR_out, Imm3); // Imm3 is the immediate value generated from the instruction
       ALUControl ALUControl_INST (
    IR_out[31:25], IR_out[14:12], ALUOp, reset, ALUControlLine);

         MDR MDR_INST (memData, reset, clock, MDR);
         ALUOut ALUOut_INST (ALUResult, clock, reset, ALUOut); 


        // Instantiation of muxes
        mem_mux MEM_INST (IorD, PC, ALUOut, M1);
        A_mux A_mux_INST (ALUSrcA, A, PC, M2);
        MDR_mux MDR_mux_INST (MemtoReg, MDR, ALUOut, M3);
        PC_mux pc_mux_inst (PCSource, ALUOut, ALUResult, M4);
        B_mux b_mux_inst (ALUSrcB, B, Imm3, M5);

        ALU ALU_INST ( M2, M5, ALUControlLine, zero, ALUResult);

        ProgramCounter PC_INST (PCcontrol, M4, clock, reset, PC);  
        memory memory_INST (M1, B, memRead, memWrite, clock, reset, memData); 

        IR IR_INST(memData, IRWrite, clock, reset, IR_out);
        
endmodule
 


