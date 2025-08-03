This directory contains the complete datapath modules including all individual modules for full CPU simulation.

Each of the three different `full_dp_instr_seq*.v` files have different instruction sequence hardcoded into the memory module. 
More details can be found in the `instruction_sequences/` directory.

For full testing with any one of these datapaths, the desired `full_dp_instr_seq*.v` file can be copied into a new project in ModelSIM, 
along with:
  - `full_control.v`
  - `top.v`
  - `top_tb.v`
  - 
More instructions on simulating can be found in the 'testbenches/' directory.
