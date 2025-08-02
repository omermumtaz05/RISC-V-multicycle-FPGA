Hello! This directory contains memory modules with different instruction sequences hardcoded.

Each of the three 'memory_instr_seq*.v' file contains different hardcoded instruction sequences to be executed in simulation.

## The different instruction sequences are:
 ### 1.
  # addi x3, x0, 20
  # lw x8, 120(x3)
  # add x10, x3, x8
  # sub x11, x10, x8
  # beq x3, x11, 8
  # *garbage address to be ignored during  branching*
  # *garbage address to be ignored during branching*
  # and x13, x8, x3
  # or x14, x8, x3
  # sw x3, 150(x0)

  # With decimal 82 hardcoded into address 140,

- 2:
  #addi x5, x0, 4
  #addi x5, x0, -1
  #beq x5, x0, 4
  #beq x0, x0, -8

- 3:
  #addi x0, x0, 5
  #addi x1, x0, 200
  #lw x2, -50(x1)
  #addi x3, x0, 99
  #sw x3, -20(x1)
  #lw x4, -20(x1)

  With hex 87 hardcoded into address 150

Instruction decoding was done with the help of https://luplab.gitlab.io/rvcodecjs/

If you would like to input your own instruction sequence for testing, please:
- Go to the website https://luplab.gitlab.io/rvcodecjs)=
- Write in the desired instruction
- Set the desired instruction decoded in hex or binary into 4 addresses in memory (as memory is byte accessible) in little endian order starting from address 0
- Set necessary data memory addresses to values if lw is being used.
- Write the same address encoding in the reset block as well with non-blocking assignments
- Copy and paste this into a new full_dp_instr_seq*.v file with only changing the memory module
- Simulate the full_dp file on ModelSIM along with full_control.v, top.v, and top_tb.v

