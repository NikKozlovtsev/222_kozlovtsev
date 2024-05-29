.text
    .globl hw4.2
hw4.2:

.macro print(%x)
li a7, 1
mv a0, %x
ecall 
.end_macro
	#x input
    addi a7, zero, 5
    ecall
    add x10, zero, a0
	#y input
    addi a7, zero, 5
    ecall
    add x11, zero, a0
    
    mul x12, x10, x11
    mv x10, x12
    
    print(x10)
    