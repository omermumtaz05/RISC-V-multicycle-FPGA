
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
      wire [3:0] ALUControlLine, state_out;

        //OUTPUTS OF DATAPATH:

        //functional units
      wire [31:0] PC, ALUResult, memData, regReadData1, regReadData2; // outputs
      wire zero; // ALU zero
        
        // temp registers outputs
      wire [31:0] ALUOut_out, MDR_out, A_out, B_out, Imm3, IR_out;

        //mux outputs
      wire [31:0] M1, M2, M3, M4, M5;
      wire [31:0] next_pc;

      assign PCcontrol = PCWrite | (PCWriteCond & zero);
      

        // Instantiation the muxes
      mem_mux MEM_INST (IorD, PC, ALUOut_out, M1);
      A_mux A_mux_INST (ALUSrcA, A_out, PC, M2);
      MDR_mux MDR_mux_INST (MemtoReg, MDR_out, ALUOut_out, M3);
      PC_mux pc_mux_inst (PCSource, ALUOut_out, ALUResult, M4);
      B_mux b_mux_inst (ALUSrcB, B_out, Imm3, M5);

      // control instances
      FSM fsm_inst (
          clock, reset, IR_out[6:0]
          ,regWrite, ALUSrcA, memRead, memWrite,MemtoReg, IorD, IRWrite, PCWrite, PCWriteCond,PCSource,
          ALUOp,ALUSrcB, state_out
      );
       
      ALUControl ALU_control_INST (IR_out[31:25], IR_out[14:12], ALUOp, reset, ALUControlLine);


        //functional units 

  	ProgramCounter PC_INST (PCcontrol, M4, clock, reset, PC);  

      memory memory_INST (M1, B_out, memRead, memWrite, clock, reset, memData); // done

      ALU ALU_INST (M2, M5, ALUControlLine, zero, ALUResult);

      register registers_INST (IR_out[19:15], IR_out[24:20], IR_out[11:7], M3, regWrite, clock, reset, 			regReadData1, regReadData2);

      // All temp register instantiations

      IR IR_INST(memData, IRWrite, clock, reset, IR_out);

      MDR MDR_INST(memData, reset, clock, MDR_out);

      A A_INST(regReadData1, clock, reset, A_out);
      B B_INST(regReadData2, clock, reset, B_out);

      ALUOut ALUOut_INST(ALUResult, clock, reset, ALUOut_out);

      imm_gen imm_gen_INST(IR_out, Imm3);

        
endmodule
