module B(
    input [31:0] readData2,
    input clk,
  	input reset,
	
    output reg [31:0] dataB
);



    always @ (posedge clk)
      if(reset)
        dataB <= 32'b0;
  
      else
        dataB <= readData2;

endmodule
