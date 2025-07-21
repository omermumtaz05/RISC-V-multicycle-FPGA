// Code your testbench here
// or browse Examples

// Code your testbench here
// or browse Examples
module ALUControl_tb();
  
  //Inputs declared as regs
  reg [6:0] funct7;
  reg [2:0] funct3;
  reg [1:0] ALUOp;
  
  //Outputs declared as wires
  wire [3:0] control;
  
  ALUControl uut(
    .funct7(funct7),
    .funct3(funct3),
    .ALUOp(ALUOp),
    .control(control)
  );
  


  // Test sequence
  initial begin
    // Initialize inputs
    funct7 = 0; funct3 = 0; ALUOp = 0;
    
    #10 funct7 = 7'd20; funct3 = 3'b110; ALUOp = 2'b00;
    
    #1 $display("ALUControl is %d ", control);
    
    #10 funct7 = 7'd19; funct3 = 3'b111; ALUOp = 2'b01;
    #1 $display("ALUControl is %d ", control);
    
    #10 funct7 = 7'b0; funct3 = 3'b0; ALUOp = 2'b10;
    #1 $display("ALUControl is %d ", control);
    
    #10 funct7 = 7'b0100000; funct3 = 3'b0; ALUOp = 2'b10;
    #1 $display("ALUControl is %d ", control);
    
    #10 funct7 = 7'b0; funct3 = 3'b111; ALUOp = 2'b10;
    #1 $display("ALUControl is %d ", control);
    
    #10 funct7 = 7'b0; funct3 = 3'b110; ALUOp = 2'b10;
    #1 $display("ALUControl is %d ", control);
    
    
    #10 $finish;
    
    
   
  end
endmodule