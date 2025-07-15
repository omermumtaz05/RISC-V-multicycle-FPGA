module IR(
    input [31:0] MemData,
    input IRWrite,
    input clk,

    output [31:0] inst

);

    always @ (posedge clk)
        if(IRWrite)
            inst <= MemData;


endmodule 