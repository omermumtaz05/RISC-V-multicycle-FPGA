
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
  
  #10
  //STATE 0 reset = 0 to set cycle running
  reset = 0;
  $display("Memread is %d, ALUSrcA is %d, IorD is %d, IRWrite is %d, ALUSrcB is %d, ALUOp is %d, PCWrite is %d, PCSource is %d", MemRead, ALUSrcA, IorD, IRWrite, ALUSrcB, ALUOp, PCWrite, PCSource); 

	

  #10
  //STATE 1 (only outputs are ALUSrcA, ALUSrcB and ALUOp
  
  $display("ALUSrcA is %d, ALUSrcB is %d, ALUOp is %d", ALUSrcA, ALUSrcB, ALUOp); 
  
  //#10
  //STATE 6 (taking R-type path)

  opcode = 7'b0110011; 
    
  #10 //check state 6 outputs
   
  $display("ALUSrcA is %d, ALUSrcB is %d, ALUOp is %d", ALUSrcA,     	ALUSrcB, ALUOp); 

  #10 
  // continute cycle for r-type -> checking state 7 outputs
  $display("RegWrite is %d, MemtoReg is %d", RegWrite, MemtoReg); 
  


  #10
  $display("Memread is %d, ALUSrcA is %d, IorD is %d, IRWrite is %d, ALUSrcB is %d, ALUOp is %d, PCWrite is %d, PCSource is %d", MemRead, ALUSrcA, IorD, IRWrite, ALUSrcB, ALUOp, PCWrite, PCSource); 
           
           
   #10 $stop;      

end


    
   
 
endmodule
