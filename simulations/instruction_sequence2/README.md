**This directory contains images from the simulation of Instruction Sequence 2**

## What is being observed for verification:
 - Register x5
 - PC value to ensure branching is correct

## This Instruction Sequence is used to Verify:
 - `addi` with a negative immediate value
 - `beq` with a negative immediate value
 - `beq` with unequal condition

## Rough C Equivalent of Instruction Sequence:
``` C
  int x = 4;

  while(x != 0){
    x--;
  }
```

## Instruction Sequence in Assembly:
``` assembly
  addi x5, x0, 4 #x5 = 4

  loop:
  addi x5, x5, -1 #x5 = x5 - 1
  beq x5, x0, 4  # if x5 == 0, jump to exit
  beq x0, x0, -8 # unconditional jump back to loop

  exit:
    # continue
```

## Description of Images:
Decrement images show the value of register x5 after each loop back and decrement.

Loop-back images show how PC branches back to beginning of decrement instruction to perform `addi x5, x5, -1`.

Condition check images show how PC changes after branch condition is fulfilled or not fulfilled:
  - During loop (when x5 ≠ 0), the branch is not taken.
  - At the end of the loop (x5 == x0), the branch is taken, skipping the loop-back beq instruction.
