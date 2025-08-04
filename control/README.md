**This directory contains the control modules needed for testing and simulation.**

`full_control.v` contains the FSM and ALUControl modules.

For simulation, `full_control.v` should be added to a new project in ModelSim, along with:
- `full_dp_instr_seq*.v` depending on which instruction sequence to use
- `top.v`
- `top_tb.v`

More details on testing can be found in the testbenches directory.
