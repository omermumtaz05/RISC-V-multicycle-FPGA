module ALUOut(
    input [31:0] ALUResult,
    input clk,
    input reset,

  	output reg [31:0] ALUOut_result
);


    always @ (posedge clk)
        if(reset)
            ALUOut_result <= 32'b0;
        else
            ALUOut_result <= ALUResult;

        
endmodule
