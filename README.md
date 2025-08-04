This repository contains the Verilog code for the datapath and control for a 32-bit multicycle RISC-V processor, along with corresponding testbenches for verification.

- `datapath/`: Contains all datapath modules along with different instruction sequences and instructions on how to write your own instruction sequence.
- `control/`: Contains the FSM and ALU control modules.
- `testbenches/`: Contains testbenches for individual modules and full CPU simulation.

ModelSim can be used for full simulation, however Icarus Verilog can be used for testing individual modules with their corresponding testbenches.

The `top_tb.v` file is the file to be simulated, along with `top.v`, `full_control.v`, and `full_dp_instr_seq*.v` depending on which instruction sequence you wish to simulate.

Details on how to write your own instruction sequences can be found in `datapath/instruction_sequences`.

<img width="850" height="742" alt="image" src="https://github.com/user-attachments/assets/14a16767-7ccf-4a3f-a271-d985df8ae3e4" />

