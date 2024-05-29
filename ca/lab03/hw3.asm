    .global hw3
    
    .data
skip: .asciz "\n"

    .text
hw3:
    # x
    addi a7, zero, 5
    ecall
    add t0, zero, a0

    # y
    addi a7, zero, 5
    ecall
    add t1, zero, a0

    # 1
    addi t2, t0, 5
    addi t3, t1, -7
    sub t4, t2, t3

      
    add a0, zero, t4
    addi a7, zero, 1
    ecall
    
    li a7, 4
    la a0, skip
    ecall
    
    # 2
    mv t2, zero
    mv t3, zero
    srli t2, t0, 2
    addi t3, t1, -1
    slli t3, t3, 3
    add t4, t2, t3
    
    
    add a0, zero, t4
    addi a7, zero, 1
    ecall
    
    li a7, 4
    la a0, skip
    ecall
    
    # 3
    mv t2, zero
    mv t3, zero
    sll t2, t0, t1
    addi t3, t2, -10
    
    
    add a0, zero, t3
    addi a7, zero, 1
    ecall
    
    li a7, 4
    la a0, skip
    ecall
    
    # 4
    mv t2, zero
    mv t3, zero
    sra t2, t0, t1
    addi t3, t2, 10
    
       
    add a0, zero, t3
    addi a7, zero, 1
    ecall
    
    li a7, 4
    la a0, skip
    ecall
    
    # 5
    mv t2, zero
    mv t3, zero
    slli t2, t0, 2
    sub t3, t2, t1
    addi t3, t3, 5
    srai t3, t3, 1
    
       
    add a0, zero, t3
    addi a7, zero, 1
    ecall
    
    li a7, 4
    la a0, skip
    ecall
    
    # 6
    mv t2, zero
    mv t3, zero
    addi t4, zero, 6
    mul t2, t0, t4
    mv t4, zero
    addi t4, zero, 3
    mul t3, t1, t4
    sub t3, t2, t3
    
        
    add a0, zero, t3
    addi a7, zero, 1
    ecall
    
    li a7, 4
    la a0, skip
    ecall
    
    # 7
    mv t2, zero
    mv t3, zero
    addi t4, zero, 2
    mul t2, t0, t4
    mul t2, t2, t0
    mv t4, zero
    addi t4, zero, 3
    mul t3, t1, t4
    sub t3, t2, t3
    addi t3, t3, 4
    
        
    add a0, zero, t3
    addi a7, zero, 1
    ecall
    
    li a7, 4
    la a0, skip
    ecall
    
    # 8
    mv t2, zero
    mv t3, zero
    addi t2, t0, 5
    div t2, t2, t1
    mv t4, zero
    addi t4, zero, 10
    addi t3, t3, -1
    div t3, t4, t3
    add t3, t3, t2
    
        
    add a0, zero, t3
    addi a7, zero, 1
    ecall
    
    li a7, 4
    la a0, skip
    ecall
    
    # 9
    mv t2, zero
    mv t3, zero
    div t2, t0, t1
    mul t2, t2, t1
    rem t3, t0, t1
    add t3, t3, t2
    
         
    add a0, zero, t3
    addi a7, zero, 1
    ecall
    
    li a7, 4
    la a0, skip
    ecall
    
    # 10
    mv t2, zero
    mv t3, zero
    addi t2, zero, -1
    srli t2, t2, 5
    and t3, t0, t2
    
        
    add a0, zero, t3
    addi a7, zero, 1
    ecall
    
    li a7, 4
    la a0, skip
    ecall
    
    # 11
    mv t2, zero
    mv t3, zero
    addi t2, zero, -1
    srai t2, t2, 27
    or t3, t0, t2
    

    add a0, zero, t3
    addi a7, zero, 1
    ecall
    
    li a7, 4
    la a0, skip
    ecall
    
    # 12
    mv t2, zero
    mv t3, zero
    addi t2, zero, 1
    sll t2, t2, t1
    or t3, t0, t2
    
        
    add a0, zero, t3
    addi a7, zero, 1
    ecall
    
    li a7, 4
    la a0, skip
    ecall
