module IR(
    input [31:0] MemData,
    input IRWrite,
    input clk,
	input reset,
  
    output reg [31:0] inst

);

    always @ (posedge clk)
      if(reset)
        inst <= 32'b0;
        
      else if(IRWrite)
        inst <= MemData;


endmodule 
