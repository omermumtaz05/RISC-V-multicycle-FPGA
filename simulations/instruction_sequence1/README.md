**This directory contains images of the ModelSim simulation of Instruction Sequence 1.**

## What is Being Observed for Verification:
 - Register `x3`
 - Register `x8`
 - Register `x10`
 - Register `x11`
 - Register `x13`
 - Register `x14`
 - Data memory address `140`
 - Data memory address `150`
 - `PC` value to check instruction memory address and ensure correct branching

## What is Being Verified:
 - `addi` with a positive immediate valye
 - `lw` with a positive immediate value
 - `sw` with a positive immediate value
 - `add`
 - `sub`
 - `and`
 - `or`
 - `beq` with a positive immediate value

## Instruction Sequence Used for Testing:
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
  
