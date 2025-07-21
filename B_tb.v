// Code your testbench here
// or browse Examples
// Code your testbench here
// or browse Examples
module B_tb();
  
  //Inputs declared as regs
  
  reg [31:0] readData2;
  reg reset;
  reg clk;
 
  //Outputs declared as wires
  
  wire [31:0] dataB;
  
  B uut(
    .readData2(readData2),
    .reset(reset),
    .clk(clk),
 
    .dataB(dataB)
  );
  
	
  initial clk = 0;
  always #5 clk = ~clk;  // Toggle every 5 ns → 10 ns period = 100 MHz

  // Test sequence
  initial begin
    
    // Initialize inputs
	readData2 = 0; clk = 0; reset = 1; 
    
    #10 reset = 0;
    
    #10 readData2 = 32'd200000;
    
    
    #10 $display("data =%d", dataB);
    
    
    #10 reset = 1;
    
    
    #10 $display("data =%d", dataB);
    
    #10 $finish;
    
    
   
  end
endmodule