module memory(
    input [31:0]address,
    input [31:0]writeData,
    input memRead,
    input memWrite,
    input clk,
    input reset,
    output reg [31:0] memData
);

    reg [31:0] data [63:0];

    always @ (posedge clk)
    begin
       if(reset)
       begin
         	integer i;
         	for(i = 0; i < 64; i = i + 1)
                data[i] <= 32'b0;
       end

       else if(memWrite)
            data[address] <= writeData;
    end

    always @ (*)
        if(memRead)
            memData = data[address];
        else
            memData = 32'b0;


endmodule

//VERIFY
