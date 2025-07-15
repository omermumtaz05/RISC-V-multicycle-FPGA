module B(
    input [31:0] readData2,
    input clk,

    output [31:0] dataB
);



    always @ (posedge clk)
        dataB <= readData2;

endmodule