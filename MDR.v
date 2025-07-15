module MDR(
    input [31:0] MemData,
    input clk,

    output [31:0] data
);

    always @ (posedge clk)
        data <= MemData;

endmodule