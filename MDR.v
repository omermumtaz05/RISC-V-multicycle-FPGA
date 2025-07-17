module MDR(
    input [31:0] memData,
    input reset,
    input clk,
    

  	output reg [31:0] data_out
);

    always @ (posedge clk)
      if(reset)
        data_out <= 32'b0;
  
  	  else
        data_out <= memData;

endmodule
