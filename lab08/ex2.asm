.macro exit
    li      a7, 10
    ecall
.end_macro

.macro print_hex(%x)
    mv      a0, %x
    li      a7, 34
    ecall
.end_macro

.macro newline
    li      a0, '\n'
    li      a7, 11
    ecall
.end_macro

.macro read_int
    li      a7, 5
    ecall
.end_macro

.text
main:
    lui     s0, 0xffff0   # MMIO base
    mv      s1, zero      # counter
    mv      s2, zero      # previous value
    li      s3, 20        # counter limit

    # Read X
    read_int
    mv      s4, a0        # Store X

loop:
    li      t0, 1         # check first row
    sb      t0, 0x12(s0)  # scan
    lb      t1, 0x14(s0)  # get result
    bnez    t1, pressed   # process key pressed

    li      t0, 2         # check second row
    sb      t0, 0x12(s0)
    lb      t1, 0x14(s0)
    bnez    t1, pressed

    li      t0, 4         # check third row
    sb      t0, 0x12(s0)
    lb      t1, 0x14(s0)
    bnez    t1, pressed

    li      t0, 8         # check fourth row
    sb      t0, 0x12(s0)
    lb      t1, 0x14(s0)
    bnez    t1, pressed

    mv      s2, zero      # reset previous value
    j       loop           # nothing is pressed (t1 == 0) - repeat

pressed:
    beq     t1, s2, loop  # repeat if the same key value
    mv      s2, t1        # save current value

    print_hex(t1)
    newline

    # Check if Y equals X
    beq     t1, s4, found

    # Check if Y equals 0
    beqz    t1, stopped

    addi    s1, s1, 1     # counter increment
    ble     s1, s3, loop  # repeat if s1 <= s3
    j       end

found:
    # Print "FOUND" and exit
    li      a0, 'F'
    li      a7, 11
    ecall
    li      a0, 'O'
    li      a7, 11
    ecall
    li      a0, 'U'
    li      a7, 11
    ecall
    li      a0, 'N'
    li      a7, 11
    ecall
    j       end

stopped:
    li      a0, 'S'
    li      a7, 11
    ecall
    li      a0, 'T'
    li      a7, 11
    ecall
    li      a0, 'O'
    li      a7, 11
    ecall
    li      a0, 'P'
    li      a7, 11
    ecall
    li      a0, 'P'
    li      a7, 11
    ecall
    li      a0, 'E'
    li      a7, 11
    ecall
    li      a0, 'D'
    li      a7, 11
    ecall
    j       end

end:
    exit
