.data
m_limit: .word 10           
t_interval: .word 1000      

.text
.global _start

_start:

    li x10, 0   # Counter 
    la x11, m_limit
    lw x12, 0(x11)   # Load m_limit 
    la x13, t_interval
    lw x14, 0(x13)   # Load t_interval 
    
 
    li x15, 0x8000
    csrs mie, x15  

    la x31, thread1_start  
    li x16, 0               
    
    #  thread 2
    la x30, thread2_start    
    li x17, 0                
    
wait_loop:

    wfi
    addi x10, x10, 1

    bge x10, x12, exit_program


    jalr zero, x31, 0
    

    csrw mtime, zero
    

    j wait_loop

exit_program:

thread1_start:
    li x31, 0      
    
thread1_loop:

    addi x16, x16, 1
    
    # Check if thread 1 reached  limit
    bge x16, x12, thread1_exit
    
    # Jump to loop
    j thread1_loop
    
thread1_exit:

    jalr zero, ra, 0

thread2_start:
    li x30, 0      
    
thread2_loop:


    addi x17, x17, 1
    
    bge x17, x12, thread2_exit
    
    j thread2_loop
    
thread2_exit:

    jalr zero, ra, 0