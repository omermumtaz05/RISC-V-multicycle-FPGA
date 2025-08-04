## Instruction Sequences Used for Testing:
 ### All R-type, branching when equal, lw, and sw:
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
  
