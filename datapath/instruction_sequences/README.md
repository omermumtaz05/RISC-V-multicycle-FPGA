Welcome!
This directory contains three ```memory_instr_seq*.v``` modules containing different hardcoded instruction sequences into a standard memory module. 

The sequences were used to fully test and verify:
 - Branch if equal (`beq`) with equal and unequal cases
 - Add immediate instruction (`addi`)
 - Memory instructions (`lw` and `sw`) and checking memory consistency
 - R-type instructions (`add`, `sub`, `and`, `or`)
 - Negative immediate values
 - x0 consistently storing 32'b0

Addresses `0`-`127` are allocated for instruction memory and the remaining addresses `128`-`255` are allocated for data memory, allowing us to have a maximum of 32 instructions in one sequence as memory is byte addressable.

## Instruction Sequences Used for Testing:
 ### All R-type, branching when equal, lw, and sw:
``` assembly
  addi x3, x0, 20
  lw x8, 120(x3)
  add x10, x3, x8
  sub x11, x10, x8
  beq x3, x11, 8
  //Unused address ignored during branching
  //Unused address ignored during branching
  and x13, x8, x3
  or x14, x8, x3
  sw x3, 150(x0)
 ```
  - Decimal value `82` was hardcoded into address `140`
  
### Branching with not equal case and loop:
``` assembly
  addi x5, x0, 4
  addi x5, x0, -1
  beq x5, x0, 4
  beq x0, x0, -8
```
### Attempting to store value into register x0, lw and sw with negative immediate and lw/sw memory consistency check:
``` assembly
  addi x0, x0, 5
  addi x1, x0, 200
  lw x2, -50(x1)
  addi x3, x0, 99
  sw x3, -20(x1)
  lw x4, -20(x1)
  lw x5, 0(x1)
```
  - Hex value `87` was hardcoded into address `150`
  - Hex value `0x12345678` was hardcoded into addresses 200 - 203

## Writing your own instruction sequence

Instruction encoding was done with the help of https://luplab.gitlab.io/rvcodecjs/

If you would like to input your own instruction sequence for testing:
1. Go to the website https://luplab.gitlab.io/rvcodecjs.
2. Enter desired instruction.
3. Copy hex or binary machine code.
4. In a new memory module, ```memory_instr_seq*.v```, copy and paste the standard memory module and write the instruction machine code in the ```initial begin ... end``` block.
 - Use little endian byte order and only use addresses `0` - `127`.
 - For example, encoding hex 0x00528333 into the first four addresses would look like:
     ``` verilog
     initial begin
     
      data[0] = 8'h33; //lsb
      data[1] = 8'h83;
      data[2] = 8'h52;
      data[3] = 8'h00; //msb
     
     end
     ```
5. If a lw instruction is being executed, you must set the necessary data memory values in addresses `128` - `255`.
 - For example, setting address `200` to decimal `100` would look like:
    ``` verilog
     initial begin
       //Instructions
    
       data[200] = 8'd100;
   
     end
    ```
 - If you are hardcoding data that is greater than one byte, you can set up to four data memory addresses to contain all of the bits in little endian order as memory is byte addressable.
  - For example, writing `0x12345678` into data memory starting from address `216` would look like:
      ``` verilog
      initial begin
       //instruction encoding and possible other data

       data[216] = 8'h78;
       data[217] = 8'h56;
       data[218] = 8'h34;
       data[219] = 8'h12;
      
      end
     ```
   - The memory module will then concatenate all 4 addresses into one full word if called.

6. Repeat the same memory initialization in the `reset` block using non-blocking ` <= ` assignments after the `for` loop.
 - For example, encoding the instructions and data above into the `reset` block would look like:
   ``` verilog
    if(reset)
    begin
     //for loop

      data[0] <= 8'h33; 
      data[1] <= 8'h83;
      data[2] <= 8'h52;
      data[3] <= 8'h00;
   
      data[200] <= 8'd100;

      data[216] <= 8'h78;
      data[217] <= 8'h56;
      data[218] <= 8'h34;
      data[219] <= 8'h12;
    end
   
   ```
     
7. Copy and paste this into a new `full_dp_instr_seq*.v` file replacing the previous memory module.
8. Simulate the full_dp file on ModelSIM along with:
 -  `full_control.v`
 -  `top.v`
 -  `top_tb.v`


More instructions on full simulation can be found in the `testbenches/` directory. 
