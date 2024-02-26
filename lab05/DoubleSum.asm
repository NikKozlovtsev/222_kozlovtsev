    .global  DoubleSum
    .data
skip: .asciz "\n"

DoubleSum:
.macro print_int(%x)
li a7, 1
mv a0, %x
ecall 
.end_macro
.text
    # 1
    addi a7, zero, 5
    ecall
    add t0, zero, a0

    # 2
    addi a7, zero, 5
    ecall
    add t1, zero, a0
        #3
    addi a7, zero, 5
    ecall
    add x11, zero, a0

    #4
    addi a7, zero, 5
    ecall
    add x12, zero, a0

add x3, t0, x11
print_int(x3)

li a7, 11
li a0, '\n'
ecall

add x4, t1, x12
print_int(x4)

li a7, 11
li a0, '\n'
ecall