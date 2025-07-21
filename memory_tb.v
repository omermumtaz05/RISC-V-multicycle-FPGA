// Code your testbench here
// or browse Examples
// Code your testbench here
// or browse Examples
module memory_tb();
  
  //Inputs declared as regs
  
  reg [31:0] address;
  reg [31:0] writeData;

  reg memRead;
  reg memWrite;
  
  reg reset;
  reg clk;
 
  //Outputs declared as wires
  
  wire [31:0] memData;
  
  memory uut(
    .address(address),
    .writeData(writeData),
    .memRead(memRead),
    .memWrite(memWrite),
    .reset(reset),
    .clk(clk),
    
    .memData(memData)
  );
  
	
  initial clk = 0;
  always #5 clk = ~clk;  // Toggle every 5 ns → 10 ns period = 100 MHz

  // Test sequence
  initial begin
    
    // Initialize inputs
	address = 0; writeData = 0; memRead = 0; memWrite = 0; 
    reset = 1; clk = 0; 
    
    #10 reset = 0;
    
    #10 writeData = 32'd200; address = 32'd3; memWrite = 1;
    	memRead = 0;
    
    	// store decimal 200 into register 2
    
    #10 memRead = 1; address = 32'd3;
    	//store decimal 10 into register 5
    
    #10 $display("memData=%d", memData);
    
    
    #10 writeData = 32'd10; address = 32'd5; memWrite = 1;
    	memRead = 0;
    
    #10 memRead = 1; address = 32'd5;
    	//store decimal 10 into register 5
    
    #10 $display("memData=%d", memData);
    
    #10 $finish;
    
    
   
  end
endmodule