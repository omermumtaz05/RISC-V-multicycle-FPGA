This repository contains the Verilog code for the datapath and control for a 32-bit multicycle RISC-V processor, along with testbenches for verification.

# Directories: #
- `datapath/`: Contains three datapath files with different instruction sequences and instructions on how to write your own instruction sequence.
- `control/`: Contains the FSM and ALU control modules.
- `testbenches/`: Contains testbenches for individual modules and full CPU simulation.


The processor has been fully verified for all instruction types (R-type, lw, sw, beq, and addi), along with negative immediate values, attempting to store values into x0 and lw/sw memory consistency. More details on instruction sequences can be found in the directory datapath/instruction_sequences.

<img width="850" height="742" alt="image" src="https://github.com/user-attachments/assets/14a16767-7ccf-4a3f-a271-d985df8ae3e4" />

