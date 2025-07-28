// Code your testbench here
// or browse Examples
// Code your testbench here
// or browse Examples
module ALUOut_tb();
  
  //Inputs declared as regs
  
  reg [31:0] ALUResult;
  reg reset;
  reg clk;
 
  //Outputs declared as wires
  
  wire [31:0] ALUOut_result;
  
  ALUOut uut(
    .ALUResult(ALUResult),
    .clk(clk),
    .reset(reset),
 
    .ALUOut_result(ALUOut_result)
  );
  
	
  initial clk = 0;
  always #5 clk = ~clk;  // Toggle every 5 ns → 10 ns period = 100 MHz

  // Test sequence
  initial begin
    
    // Initialize inputs
	ALUResult = 0; clk = 0; reset = 1; 
    
    #10 reset = 0;
    
    #10 ALUResult = 32'd200000;
    
    
    #10 $display("data =%d", ALUOut_result);
    
    
    #10 reset = 1;
    
    
    #10 $display("data =%d", ALUOut_result);
    
    #10 $finish;
    
    
   
  end
endmodule
