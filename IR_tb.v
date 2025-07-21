// Code your testbench here
// or browse Examples
// Code your testbench here
// or browse Examples
module IR_tb();
  
  //Inputs declared as regs
  
  reg [31:0] MemData;
  reg IRWrite;
  reg reset;
  reg clk;
 
  //Outputs declared as wires
  
  wire [31:0] inst;
  
  IR uut(
    .MemData(MemData),
    .clk(clk),
    .reset(reset),
    .IRWrite(IRWrite),
 
    .inst(inst)
  );
  
	
  initial clk = 0;
  always #5 clk = ~clk;  // Toggle every 5 ns → 10 ns period = 100 MHz

  // Test sequence
  initial begin
    
    // Initialize inputs
	MemData = 0; clk = 0; reset = 1; 
    IRWrite = 0;
    
    #10 reset = 0;
    
    #10 IRWrite = 1; MemData = 32'd200000; 
    
    
    #10 $display("data =%d", inst);
    
    
    #10 reset = 1;
    
    
    #10 $display("data =%d", inst);
    
    #10 $finish;
    
    
   
  end
endmodule