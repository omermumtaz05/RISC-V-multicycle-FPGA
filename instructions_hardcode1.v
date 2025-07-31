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
	// addi x3, x0, 20
	data[0] = 8'h93;
	data[1] = 8'h01;
	data[2] = 8'h40;
	data[3] = 8'h01;
	    
	// lw x8, 120(x3)

	data[4] = 8'h03;
	data[5] = 8'hA4;
	data[6] = 8'h81;
	data[7] = 8'h07;

	// add x10, x3, x8
	data[8] = 8'h33;
	data[9] = 8'h05;
	data[10] = 8'h34;
	data[11] = 8'h00;

	// sub x11, x10, x8
	data[12] = 8'hb3;
	data[13] = 8'h05;
	data[14] = 8'h85;
	data[15] = 8'h40;

	//beq x3, x11, 8
	data[16] = 8'h63;
	data[17] = 8'h84;
	data[18] = 8'hb1;
	data[19] = 8'h00;
	    
	// garbage address
	data[20] = 8'hxx;
	data[21] = 8'hxx;
	data[22] = 8'hxx;
	data[23] = 8'hxx;
	    
	// garbage address
	data[24] = 8'hxx;
	data[25] = 8'hxx;
	data[26] = 8'hxx;
	data[27] = 8'hxx;
	
	// and x13, x8, x3
	data[28] = 8'hb3;
	data[29] = 8'h76;
	data[30] = 8'h34;
	data[31] = 8'h00;
	    
	// or x14, x8, x3
	data[32] = 8'h33;
	data[33] = 8'h67;
	data[34] = 8'h34;
	data[35] = 8'h00;
	    
	// sw x3, 150(x0)
	data[36] = 8'h23;
	data[37] = 8'h2b;
	data[38] = 8'h30;
	data[39] = 8'h08;
	    
	data[140] = 8'd82;
    end


    integer i;
    always @ (posedge clk)
    begin
       if(reset)
       begin
         	
         	for(i = 128; i < 256; i = i + 1)
                	data[i] <= 8'b0;
	        // reload hardcoded instructions and data

	       // addi x3, x0, 20
	       	data[0] <= 8'h93;
		data[1] <= 8'h01;
		data[2] <= 8'h40;
		data[3] <= 8'h01;
		
	        // lw x8, 120(x3)
		data[4] <= 8'h03;
		data[5] <= 8'hA4;
		data[6] <= 8'h81;
		data[7] <= 8'h07;

	        // add x10, x3, x8
	        data[8] <= 8'h33;
	        data[9] <= 8'h05;
	        data[10] <= 8'h34;
	        data[11] <= 8'h00;

	       // sub x11, x10, x8
	        data[12] <= 8'hb3;
	        data[13] <= 8'h05;
	        data[14] <= 8'h85;
	        data[15] <= 8'h40;
	       
		//beq x3, x11, 8
	       data[16] <= 8'h63;
	       data[17] <= 8'h84;
	       data[18] <= 8'hb1;
	       data[19] <= 8'h00;
	    
		// garbage address
	       data[20] <= 8'hxx;
	       data[21] <= 8'hxx;
	       data[22] <= 8'hxx;
	       data[23] <= 8'hxx;
	    
		// garbage address
	       data[24] <= 8'hxx;
	       data[25] <= 8'hxx;
	       data[26] <= 8'hxx;
	       data[27] <= 8'hxx;
	
		// and x13, x8, x3
	       data[28] <= 8'hb3;
	       data[29] <= 8'h76;
	       data[30] <= 8'h34;
	       data[31] <= 8'h00;
	    
		// or x14, x8, x3
	       data[32] <= 8'h33;
	       data[33] <= 8'h67;
	       data[34] <= 8'h34;
	       data[35] <= 8'h00;
	       
	       	// sw x3, 150(x0)
	       data[36] <= 8'h23;
	       data[37] <= 8'h2b;
	       data[38] <= 8'h30;
	       data[39] <= 8'h08;
	    
	    
	
		data[140] <= 8'd82;
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
