module A(
    input [31:0] readData1,
    input clk,

    output [31:0] dataA

);


    always @ (posedge clk)
        dataA <= readData1;
        
endmodule