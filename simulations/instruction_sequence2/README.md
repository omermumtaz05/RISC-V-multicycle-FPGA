**This directory contains images from the simulation of instruction seqeuence 2**

Each image shows the outputs of necessary registers after each instruction being executed.

This instruction sequence performs a loop which roughly looks like the following:

``` C
  int x = 5;

  while(x != 0){
    x--;
  }
```

The instruction sequence is as follows:
``` assembly
  addi x5, x0, 4 #x5 = 4

  loop:
  addi x5, x5, -1 #x5 = x5 - 1
  beq x5, x0, 4  # if x5 == x0, jump to exit
  beq x0, x0, -8 # unconditional jump back to loop

  exit:
    #continue
```

Decrement images show the value of register x5 after each loop back and decrement.

Loop back images show how PC branches back to beginning of decrement instruction to perform `addi x5, x5, -1`.

Condition check images show how PC changes after branch condition fulfilled or not fulfilled.
  - During loop (when x5 not equal to x0), branch not taken.
  - At the end of loop (x5 == x0), branch taken, skipping the loop back beq instruction.
