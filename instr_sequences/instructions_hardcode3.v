
// Code your design here
module memory(
    input [31:0]address,
    input [31:0]writeData,
    input memRead,
    input memWrite,
    input clk,
    input reset,
    output reg [31:0] memData
);

    reg [7:0] data [255:0];

    initial begin
	//addi x0, x0, 5
	data[0] = 8'h13;
	data[1] = 8'h00;
	data[2] = 8'h50;
  	data[3] = 8'h00;
	    
	//addi x5, x5, -1
	data[4] = 8'h93;
	data[5] = 8'h82;
	data[6] = 8'hF2;
	data[7] = 8'hFF;

	// beq x5, x0, 4
	data[8] = 8'h63;
	data[9] = 8'h82;
	data[10] = 8'h02;
	data[11] = 8'h00;

	// beq x0, x0, -12
	data[12] = 8'he3;
	data[13] = 8'h0a;
	data[14] = 8'h00;
	data[15] = 8'hfe;

    end


    integer i;
    always @ (posedge clk)
    begin
       if(reset)
       begin
         	
         	for(i = 128; i < 256; i = i + 1)
                	data[i] <= 8'b0;
	        // reload hardcoded instructions and data

		//addi x0, x0, 5
	       data[0] <= 8'h13;
	       data[1] <= 8'h00;
	       data[2] <= 8'h50;
	       data[3] <= 8'h00;
	       
		//addi x5, x5, -1
	       data[4] <= 8'h93;
	       data[5] <= 8'h82;
	       data[6] <= 8'hF2;
	       data[7] <= 8'hFF;

		// beq x5, x0, 4
	       data[8] <= 8'h63;
	       data[9] <= 8'h82;
	       data[10] <= 8'h02;
	       data[11] <= 8'h00;

		// beq x0, x0, -12
	       data[12] <= 8'he3;
	       data[13] <= 8'h0a;
	       data[14] <= 8'h00;
	       data[15] <= 8'hfe;
	       

       end

       else if(memWrite)
       begin
            data[address] <= writeData[7:0];
            data[address + 1] <= writeData[15:8];
            data[address + 2] <= writeData[23:16];
            data[address + 3] <= writeData[31:24];
       end
    end

    always @ (*)
        if(memRead)
            memData = {data[address + 3], data[address + 2], data[address + 1], data[address]};
        else
            memData = 32'b0;


endmodule
