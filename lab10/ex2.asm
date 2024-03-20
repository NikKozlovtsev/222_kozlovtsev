.data
Thread1_PC: .word 0
Thread1_counter: .word 0
Thread2_PC: .word 0
Thread2_counter: .word 0

.text
.global _start

_start:
    lui t0, %hi(Thread1)
    lw t1, %lo(Thread1)(t0)
    lui t2, %hi(Thread2)
    lw t3, %lo(Thread2)(t2)
    addi t4, x0, 1

    li a1, 10 # Set loop limit

    thread1_loop:
        lw a0, %lo(Thread1_counter)(t1)
        add a0, a0, t4
        lw a1, %lo(Thread1_PC)(t1)
        add a1, a1, t4
        jal ra, printThread1Msg

        lw t1, %lo(Thread1)(t0)
        addi t5, x0, 1


        beq a0, a1, thread1_exit
        j thread1_loop

    thread1_exit:
        lui t6, %hi(Thread2)

        lw t1, %lo(Thread2)(t6)


    thread2_loop:
        lw a0, %lo(Thread2_counter)(t1)
        add a0, a0, t4
        lw a1, %lo(Thread2_PC)(t1)
        add a1, a1, t4
        jal ra, printThread2Msg

        lw t1, %lo(Thread2)(t2)
        addi t5, x0, 1


        beq a0, a1, thread2_exit
        j thread2_loop

    thread2_exit:
        j thread1_loop

printThread1Msg:

    ret

printThread2Msg:

    ret

.timer_interrupt_handler:

    ret

# Memory initialization
.data
Thread1:
    .word Thread1_PC
    .word Thread1_counter

Thread2:
    .word Thread2_PC
    .word Thread2_counter