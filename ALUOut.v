module ALUOut(
    input [31:0] ALUResult,
    input clk,

    output ALUout
);


    always @ (posedge clk)
        ALUout <= ALUResult;

        
endmodule