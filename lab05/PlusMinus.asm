.global plusMinus
.data
.macro print(%x)
li a7, 1
mv a0, %x
ecall 
.end_macro
.text
plusMinus:
    addi a7, zero, 5
    ecall
    add t0, zero, a0
addi t1, zero, 1
addi t2, zero, 0
while:
beqz t0, whileLoop
    addi a7, zero, 5
    ecall
    add a3, zero, a0
addi t0, t0, -1
addi a7, zero, 1
beq t1, a7, pls
j min
min:
sub  t2, t2, a3
addi t1, zero, 1
addi a3, a3, 0
j while
pls:
add t2, t2, a3
addi t1, zero, 0
addi a3, zero, 0
j while
whileLoop:
print(t2)

li a7, 11
li a0, '\n'
ecall