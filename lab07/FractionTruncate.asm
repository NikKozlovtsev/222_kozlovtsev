.global Fraction
Fraction:
.data 
skip: .asciz "\n"
.text
addi a3, zero, 10
fcvt.d.w fa3, a3
    # 1
    addi a7, zero, 5
    ecall
    add t1, zero, a0

    # 2
    addi a7, zero, 5
    ecall
    add t2, zero, a0

    # 3
    addi a7, zero, 5
    ecall
    add t0, zero, a0
    
add a5, zero, t0
fcvt.d.w fa0, t1
fcvt.d.w fa1, t2
fdiv.d fa0, fa0, fa1
whileLoop:
beq t0, x1, cont
addi t0, t0, -1
fmul.d fa0, fa0, fa3
j whileLoop
cont:
fcvt.w.d a2, fa0
fcvt.d.w fa0, a2
j whDiv
whDiv:
beq a5, x1, final
addi a5, a5, -1
fdiv.d fa0, fa0, fa3
j whDiv

final:
li a7, 3         
fmv.d fa2, fa0
ecall           
li a7, 11
li a0, '\n'
ecall