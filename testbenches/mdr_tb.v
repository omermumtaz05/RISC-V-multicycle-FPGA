// Code your testbench here
// or browse Examples
// Code your testbench here
// or browse Examples
module mdr_tb();
  
  //Inputs declared as regs
  
  reg [31:0] memData;
  reg reset;
  reg clk;
 
  //Outputs declared as wires
  
  wire [31:0] data_out;
  
  MDR uut(
    .memData(memData),
    .reset(reset),
    .clk(clk),
 
    .data_out(data_out)
  );
  
	
  initial clk = 0;
  always #5 clk = ~clk;  // Toggle every 5 ns → 10 ns period = 100 MHz

  // Test sequence
  initial begin
    
    // Initialize inputs
	memData = 0; clk = 0; reset = 1; 
    
    #10 reset = 0;
    
    #10 memData = 32'd200000;
    
    
    #10 $display("data =%d", data_out);
    
    
    #10 reset = 1;
    
    
    #10 $display("data =%d", data_out);
    
    #10 $finish;
    
    
   
  end
endmodule
