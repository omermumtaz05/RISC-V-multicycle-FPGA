module imm_gen(
    input [31:0] inst,
    output [11:0] imm
);


    always @ (*)
        case(inst[6:0])

            7'b0000011:
                imm = inst[31:20]; // lw

            7'b0100011:
                imm[11:5] = inst[31:25]; //sw
                imm[4:0] = inst[11:7];

            7'b0010011:
                imm[11:5] = inst[31:20]; // addi

            7'b1100011:
                imm[12] = inst[31]; // beq
                imm[11] = inst[7];
                imm[10:5] = inst[30:25];
                imm[4:1] = inst[11:8];

        endcase

endmodule

//VERIFY AND EDIT
//FINISH SIGN EXTENDING