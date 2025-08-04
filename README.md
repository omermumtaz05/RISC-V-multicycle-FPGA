This repository contains the Verilog code for the datapath and control for a 32-bit multicycle RISC-V processor, along with corresponding testbenches for verification.

- `datapath/`: Contains three `full_dp_instr_seq*.v` files with all datapath modules, different instruction sequences and instructions on how to write your own instruction sequence.
- `control/`: Contains the FSM and ALU control modules.
- `testbenches/`: Contains testbenches for individual modules and full CPU simulation.

For simulation, you will need a simulator like Icarus Verilog or ModelSim.

The `top_tb.v` file is the file to be simulated, along with `top.v`, `full_control.v`, and `full_dp_instr_seq*.v` depending on which instruction sequence you wish to simulate.

Details on how to write your own instruction sequences can be found in `datapath/instruction_sequences`.

<img width="850" height="742" alt="image" src="https://github.com/user-attachments/assets/14a16767-7ccf-4a3f-a271-d985df8ae3e4" />

