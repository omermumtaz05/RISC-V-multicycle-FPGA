module register(
    input [4:0] readReg1,
    input [4:0] readReg2,
    input [4:0] writeReg,
    input [31:0] writeData,
    input regWrite,
    input clk,

    output reg [31:0] readData1,
    output reg [31:0] readData2
);

    reg [31:0] RF [31:0]; // 32 registers each carrying 32 bits of data each

    always @ (*)
        begin
            readData1 = RF[readReg1];
            readData2 = RF[readReg2];
        end
    always @ (posedge clk)
        if(regWrite & writeReg != 0)
            RF[writeReg] <= writeData;




endmodule

//VERIFY