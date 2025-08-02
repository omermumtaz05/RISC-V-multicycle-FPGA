Hello! This directory contains memory modules with different instruction sequences hardcoded.

Each of the three ```memory_instr_seq*.v``` file contains different hardcoded instruction sequences. For testing and simulation, the memory module in a full_datapath file should  be replaced with a memory module with desired instructions and data hardcoded.

## Instruction Sequences:
 ### 1.
``` assembly
  addi x3, x0, 20
  lw x8, 120(x3)
  add x10, x3, x8
  sub x11, x10, x8
  beq x3, x11, 8
  *Unused address to be ignored during  branching*
  *Unused address to be ignored during  branching*
  and x13, x8, x3
  or x14, x8, x3
  sw x3, 150(x0)
 ```
  With decimal value 82 hardcoded into address 140
  
### 2:
``` assembly
  addi x5, x0, 4
  addi x5, x0, -1
  beq x5, x0, 4
  beq x0, x0, -8
```
### 3:
``` assembly
  addi x0, x0, 5
  addi x1, x0, 200
  lw x2, -50(x1)
  addi x3, x0, 99
  sw x3, -20(x1)
  lw x4, -20(x1)
```
  With hex value 87 hardcoded into address 150

## Writing your own instruction sequence

Instruction encoding was done with the help of https://luplab.gitlab.io/rvcodecjs/

If you would like to input your own instruction sequence for testing:
1. Go to the website https://luplab.gitlab.io/rvcodecjs
2. Enter desired instruction
3. Copy hex or binary machine code
4. In a new memory module, ```memory_instr_seq*.v```, copy and paste the standard memory module and write the instruction machine code in the initial begin ... end block
5. Use little endian byte order and only use addresses 0 - 127.
 - For example, encoding hex 0x00528333 would look like
     ``` verilog
     initial begin
     
      data[0] = 8'h33; //lsb
      data[1] = 8'h83;
      data[2] = 8'h52;
      data[3] = 8'h00; //msb
     
     //...
     end
     ```
6. If a lw instruction is being executed, set necessary data memory values in addresses 128 - 255
 - For example, setting address 200 to decimal 100 would look like:
    ``` verilog
     initial begin
       //Instruction encoding from addresses 0 - 127 

       data[200] = 8'd100;
    
       // ...
    end
 - Because memory is byte addressable, setting addresses to any value greater than 1 byte would require you to set the remaining 4 addresses to contain remaining bits
  - For example, writing 0x12345678 into data memory starting from address 216 would look like:
      ``` verilog
      initial begin
       //instruction encoding and possible other data

       data[216] = 8'h78;
       data[217] = 8'h56;
       data[218] = 8'h34;
       data[219] = 8'h12;

       // ...
      end
   - Memory module will then concatenate all 4 addresses into one full word if called

7. Repeat the same memory initialization into the ```reset``` block using non-blocking ``` <= ``` assignments after the ```for```loop
8. Copy and paste this into a new ```full_dp_instr_seq*.v```file with only changing the memory module
9. Simulate the full_dp file on ModelSIM along with:
 - full_control.v
 - top.v
 - top_tb.v

