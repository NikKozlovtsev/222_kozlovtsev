
.data
regs_save:
    .word 0 #  t0
    .word 0 #  t1
    .word 0 #  t2
    .word 0 #  t3
    .word 0 #  t4
    .word 0 #  t5
    .word 0 #  t6
    .word 0 #  t7

table:
    .word 0, 0, 0, 0
    .word 0, 0, 0, 0
    .word 0, 0, 0, 0
    .word 0, 0, 0, 0

handler:
    csrr a0, mcause
    li t0, 13
    bne a0, t0, end_handler

    csrr a1, mtval
    li t1, 0
    li t2, 0
    li t3, 0

    la t4, regs_save
    sw t0, 0(t4)
    sw t1, 4(t4)
    sw t2, 8(t4)
    sw t3, 12(t4)
    sw t5, 16(t4)
    sw t6, 20(t4)
    sw t7, 24(t4)

    lw t5, 0(a1) # Check if address is divisible by 4
    li t6, 4
    rem t7, t5, t6
    bnez t7, invalid_address

    srl t5, t5, 2 # Dividing by 4 to get array index
    slli t6, t5, 2

    lw t0, table(t6)
    retu_lw:

    sw t0, 0(a1) # Writing to the memory
    li t0, 0
    lw t5, 0(a1)
    bnez t5, end_handler

    li t5, 16
    li t6, 0
find_empty_space:
    beq t0, t5, end_handler
    lw t0, table(t6)
    beqz t0, empty_space_found
    addi t6, t6, 4
    addi t0, t0, 1
    j find_empty_space
    empty_space_found:
    sw a1, table(t6)
    j end_handler

invalid_address:
    li t0, 0
    j end_handler

end_handler:
    lw t0, 0(t4)
    lw t1, 4(t4)
    lw t2, 8(t4)
    lw t3, 12(t4)
    lw t5, 16(t4)
    lw t6, 20(t4)
    lw t7, 24(t4)

    ret
