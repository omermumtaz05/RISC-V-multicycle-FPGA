module A(
    input [31:0] readData1,
    input clk,
    input reset, 

    output reg [31:0] dataA

);


    always @ (posedge clk)
        if(reset)
            dataA <= 32'b0;
        else
            dataA <= readData1;
        
endmodule
