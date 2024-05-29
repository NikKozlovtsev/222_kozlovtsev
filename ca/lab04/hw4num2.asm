#0x00500893  3
addi x17, x0, 5 
#0x00000073  4 
ecall
#0x00a00333  5  # store "a"
add x6, x0, x10
#0x01f55293  6  # store sign of "a"
srli x5, x10, 31
#0x00000073  8 
ecall
#0x00a00eb3  9  # store "b"
add x29, x0, x10
#0x01f55e13  10 # store sign of "b"
srli x28, x10, 31
#0x06030263  12
beq x6, x0, label1
#0x060e8063  13
beq x29, x0, label1
#0x00028663  15 # if "a" < 0 then inverse it
beq x5, x0, label2
#0xfff34313  16
xori x6, x6, -1
#0x00130313  17
addi x6, x6, 1
label2:
#0x000e0663  19 # if "b" < 0 then inverse it
beq x28, x0, label3
#0xfffece93  20
xori x29, x29, -1
#0x001e8e93  21
addi x29, x29, 1
label3:
#0x01d35863  24 # if "a" < "b" swap them
bge x6, x29, label4
#0x006eceb3  25
xor x29, x29, x6
#0x006ec333  26
xor x6, x29, x6
#0x006eceb3  27
xor x29, x29, x6
label4:
#0x000003b3  29
add x7, x0, x0
label5:
#0x006383b3  31
add x7, x7, x6
#0xfffe8e93  32
addi x29, x29, -1
#0xffd04ce3  33
blt x0, x29, label5
#0x01c2cfb3  36
xor x31, x5, x28
#0x000f8663  37
beq x31, x0, label6
#0xfff3c393  38
xori x7, x7, -1
#0x00138393  39 # t2 - result accumulator
addi x7, x7, 1
label6:
#0x00100893  41
addi x17, x0, 1
#0x00700533  42
add x10, x0, x7
#0x00000073  43
ecall
#0x00a00893  45
addi x17, x0, 10
#0x00000073  46
ecall
label1:
#0x00100893  49 # if sign of "a" and "b" is different then negate the result
addi x17, x0, 1
#0x00000533  50
add x10, x0, x0
#0x00000073  51
ecall
#0x00a00893  52
addi x17, x0, 10
#0x00000073  53
ecall