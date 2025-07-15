module ProgramCounter(
  input PCWrite,
  input [31:0] next_pc,
  input clk,
  output reg [31:0] pc);
  

  always @ (posedge clk)
    if(PCWrite)
      pc <= next_pc;
    
  
      
endmodule
      
//VERIFY