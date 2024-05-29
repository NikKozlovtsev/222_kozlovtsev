    .global hw4
    
    .data
msg: .asciz "Hello, Acos"

    .text
hw4:
    li a7, 4                   
    la a0, msg            
    ecall                      
