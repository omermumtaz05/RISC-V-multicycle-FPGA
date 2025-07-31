
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
	    
	//addi x1, x0, 200
	data[4] = 8'h93;
	data[5] = 8'h00;
	data[6] = 8'h80;
	data[7] = 8'h0c;

	// lw x2, -50(x1) -> load whatever is in address -50 + 200 (150)into reg x2
	data[8] = 8'h03;
	data[9] = 8'ha1;
	data[10] = 8'he0;
	data[11] = 8'hfc;

	// addi x3, x0, 99
	data[12] = 8'h93;
	data[13] = 8'h01;
	data[14] = 8'h30;
	data[15] = 8'h06;

	// sw x3, -20(x1) -> store whatever is in register x3 into address -20 + 200 (180)
	data[16] = 8'h23;
	data[17] = 8'ha6;
	data[18] = 8'h30;
	data[19] = 8'hfe;

	//lw x4, -20(x1)
	data[20] = 8'h03;
	data[21] = 8'ha2;
	data[22] = 8'hc0;
	data[23] = 8'hfe;

	data[150] = 8'h87;
	    
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
	       
		//addi x1, x0, 200
	       data[4] <= 8'h93;
	       data[5] <= 8'h00;
	       data[6] <= 8'h80;
	       data[7] <= 8'h0c;

		// lw x2, -50(x1) -> load whatever is in address -50 + 200 (150)into reg x2
	       data[8] <= 8'h03;
	       data[9] <= 8'ha1;
	       data[10] <= 8'he0;
	       data[11] <= 8'hfc;

		// addi x3, x0, 99
	       data[12] <= 8'h93;
	       data[13] <= 8'h01;
	       data[14] <= 8'h30;
	       data[15] <= 8'h06;

	       // sw x3, -20(x1) -> store whatever is in register x3 into address -20 + 200 (180)
	       data[16] <= 8'h23;
	       data[17] <= 8'ha6;
	       data[18] <= 8'h30;
	       data[19] <= 8'hfe;

	       //lw x4, -20(x1)
	       data[20] <= 8'h03;
	       data[21] <= 8'ha2;
	       data[22] <= 8'hc0;
	       data[23] <= 8'hfe;

	       data[150] <= 8'h87;
	       

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
