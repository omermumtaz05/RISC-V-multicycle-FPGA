module ProgramCounter(
  input PCWrite,
  input [31:0] next_pc,
  input clk,
  input reset,
  output reg [31:0] pc);
  

  always @ (posedge clk)
    if(reset)
      pc <= 32'b0
    else if(PCWrite)
      pc <= next_pc;
    
  
      
endmodule
      
//VERIFY
