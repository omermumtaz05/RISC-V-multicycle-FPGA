**This directory contains the ModelSim simulation results of Instruction Sequence 3**

## What is Being Observed for Verification:
- Register `x0`
- Register `x1`
- Register `x2`
- Register `x3`
- Register `x4`
- Register `x5`
- Address `150`
- Address `180`
- Addresses `200`-`203`
- `PC` value to check instruction memory address

## What is Being Verified:
- `x0` always storing `0` regardless of values being added into it.
- `lw` and `sw` with negative immediate values.
- `sw` and `lw` memory consistency (does `lw` load the data in the address that was just stored by `sw`).
- `lw` loading a full concatenated word from four data memory addresses into a register.

## Instruction Sequence Used for Testing:
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
  - Hex value `0x87654321` was hardcoded into addresses `200`-`203`

