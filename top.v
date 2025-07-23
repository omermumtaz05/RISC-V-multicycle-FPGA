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
      wire [31:0] ALUOut, MDR, A, B, Imm3, IR_out;

        //mux outputs
      wire [31:0] M1, M2, M3, M4, M5;
    

      assign PCcontrol = PCWrite | (PCWriteCond & zero);

        // Instantiation the muxes
      mem_mux MEM_INST (IorD, PC, ALUOut, M1);
      A_mux A_mux_INST (ALUSrcA, A, PC, M2);
      MDR_mux MDR_mux_INST (MemtoReg, MDR, ALUOut, M3);
      PC_mux pc_mux_inst (PCSource, ALUOut, ALUResult, M4);
      B_mux b_mux_inst (ALUSrcB, B, Imm3, M5);

      FSM fsm_inst (
          clock, reset, IR_out[6:0]
          ,regWrite, ALUSrcA, memRead, memWrite,MemtoReg, IorD, IRWrite, PCWrite, PCWriteCond,PCSource,
          ALUOp,ALUSrcB
      );
  
        //functional units and temp regs datapath

  		ProgramCounter PC_INST (PCcontrol, M4, clock, reset, PC);  

      memory memory_INST (M1, B, memRead, memWrite, clock, reset, memData); // done


      IR IR_INST(memData, IRWrite, clock, reset, IR_out);


      register registers_INST (IR_out[19:15], IR_out[24:20], IR_out[11:7], M3, regWrite, clock, reset, 			regReadData1, regReadData2);

  		ALU ALU_INST (M2, M5, ALUControlLine, zero, ALUResult);




  	   ALUControl ALU_control_INST (IR_out[31:25], IR_out[14:12], ALUOp, reset, ALUControlLine);

        
endmodule
