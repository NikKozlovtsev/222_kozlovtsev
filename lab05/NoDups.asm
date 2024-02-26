.global noDups


.data
sk: .ascii "'\n'"

.text
noDups:


li a7, 5
ecall
mv t0, a0
mv t2, sp
li t1, 0 
li t3, 0 

rs:
mv t5, sp
beqz t0, printRes
mv t3, t1
mv t5, t2 
ecall
addi t0, t0, -1
j checkingSt
checkingSt:
beqz t3, addE
lw t4, 0(t5)
beq a0, t4, rs
addi t5, t5, -4
addi t3, t3, -1
j checkingSt
addE:
addi t2, t2, 4
addi t1, t1, 1
sw a0, 0(t2)
j rs
printRes:
beq t5, t2, resFin
addi t1, t1, -1
addi t5, t5, 4
lw a0, 0(t5)
addi a7, zero, 1
ecall

li a7, 11
li a0, '\n'
ecall
j printRes

resFin:
li a7, 11
li a0, '\n'
ecall