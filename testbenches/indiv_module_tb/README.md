This directory contains testbenches for all individual datapath and control module.

Each module's corresponding testbench file is named using the format `*_tb.v`.

To test any of the individual modules:
1. Open a simulator like Icarus Verilog or ModelSim
2. Copy the desired module and its corresponding testbench file
3. Simulate the testbench file

Each testbench sets input values to check the expected output control signals and data values. Output values are displayed at the necessary clock cycles for verification.
