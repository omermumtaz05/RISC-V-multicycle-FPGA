
// Code your testbench here
// or browse Examples

// Code your testbench here
// or browse Examples
module FSM_tb();
  
  //Inputs declared as regs
    reg clk;
    reg reset;
  	reg [6:0] opcode;
  
  //Outputs declared as wires
    wire RegWrite;
    wire ALUSrcA;
    wire MemRead;
    wire MemWrite;
    wire MemtoReg;
    wire IorD;
    wire IRWrite; 
    wire PCWrite;
    wire PCWriteCond;
    wire PCSource;

  	wire [1:0] ALUOp;
  	wire [1:0] ALUSrcB;

  
  FSM uut(
    .clk(clk),
    .reset(reset),
    .opcode(opcode),
    
    .RegWrite(RegWrite),
    .ALUSrcA(ALUSrcA),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .MemtoReg(MemtoReg),
    .IorD(IorD),
    .IRWrite(IRWrite),
    .PCWrite(PCWrite),
    .PCWriteCond(PCWriteCond),
    .PCSource(PCSource),
    
    .ALUOp(ALUOp),
    .ALUSrcB(ALUSrcB)
    
  );
  
  initial clk = 0;
  always #5 clk = ~clk;  // Toggle every 5 ns → 10 ns period = 100 MHz


  // Test sequence
initial begin

  reset = 1;
  
  #5
  //STATE 0 reset = 0 to set cycle running
  reset = 0;
  //$display("Memread is %d, ALUSrcA is %d, IorD is %d, IRWrite is %d, ALUSrcB is %d, ALUOp is %d, PCWrite is %d, PCSource is %d", MemRead, ALUSrcA, IorD, IRWrite, ALUSrcB, ALUOp, PCWrite, PCSource); 

	

  #10
  //STATE 1 (only outputs are ALUSrcA, ALUSrcB and ALUOp
  
  
  
  #10
  //STATE 2 (taking LW path)
  
  opcode = 7'b0000011; //lw opcode
    
  #10 //check state 2 outputs
   
  

  #10 opcode = 7'b0000011; 
  // continute cycle for lw -> checking state 3 outputs
 
  #10 
  //state 4

  #10
       //state 5      
           
   #10 $stop;         
  //$finish;
end


    
   
 
endmodule
