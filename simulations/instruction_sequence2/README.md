**This directory contains images from the simulation of Instruction Sequence 2**

What is being observed for verification:
 - Register x5
 - PC value to ensure branching is correct

This instruction sequence is used to verify `addi` with negative immediates, branching with negative immediates, and branching when the equal condition is not met.

Additionally, this sequence performs a loop which roughly looks like the following:

``` C
  int x = 4;

  while(x != 0){
    x--;
  }
```

The instruction sequence is as follows:
``` assembly
  addi x5, x0, 4 #x5 = 4

  loop:
  addi x5, x5, -1 #x5 = x5 - 1
  beq x5, x0, 4  # if x5 == 0, jump to exit
  beq x0, x0, -8 # unconditional jump back to loop

  exit:
    # continue
```

Decrement images show the value of register x5 after each loop back and decrement.

Loop-back images show how PC branches back to beginning of decrement instruction to perform `addi x5, x5, -1`.

Condition check images show how PC changes after branch condition is fulfilled or not fulfilled:
  - During loop (when x5 ≠ 0), branch not taken.
  - At the end of the loop (x5 == x0), branch taken, skipping the loop-back beq instruction.
