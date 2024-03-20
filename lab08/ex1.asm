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

msg_color: .asciiz "Enter the color (as an integer): "
msg_thickness: .asciiz "Enter the thickness (as an integer): "

.text
main:
    # Print message to ask for color
    li a7, 4
    la a0, msg_color
    ecall

    # Read color from user
    li a7, 5
    ecall
    mv t0, a0  # Store color in t0

    # Print message to ask for thickness
    li a7, 4
    la a0, msg_thickness
    ecall

    # Read thickness from user
    li a7, 5
    ecall
    mv t1, a0  # Store thickness in t1

    # Calculate start point
    li t2, 128   # Bitmap size
    li t3, 64    # Square size
    sub t4, t2, t3  # 128 - 64
    srai t4, t4, 1  # (128 - 64) / 2 = 32, start point

    # Set up for drawing horizontal lines
    mv t5, t4  # y start
    add t6, t4, t3  # y end, t6 = t4 + 64
    mv t7, t4  # x start
    add t8, t4, t3  # x end, t8 = t4 + 64

draw_horizontal_lines:
    # Draw top horizontal line
    mv a1, t7  # x start
    mv a2, t5  # y start
    mv a3, t8  # x end
    mv a4, t5  # y end
    mv a5, t0  # color
    mv a6, t1  # thickness
    jal draw_line

    # Draw bottom horizontal line
    mv a1, t7  # x start
    addi a2, t6, -1  # y start, one less to draw inside square
    mv a3, t8  # x end
    addi a4, t6, -1  # y end, one less to draw inside square
    mv a5, t0  # color
    mv a6, t1  # thickness
    jal draw_line

    # Set up for drawing vertical lines
    mv t5, t4  # Reset y to start
    addi t5, t5, t1  # Adjust for thickness
    addi t6, t6, -1  # Adjust end for thickness
    subi t6, t6, t1

draw_vertical_lines:
    # Draw left vertical line
    mv a1, t7  # x start
    mv a2, t5  # y start
    mv a3, t7  # x end
    mv a4, t6  # y end
    mv a5, t0  # color
    mv a6, t1  # thickness
    jal draw_line

    # Draw right vertical line
    addi a1, t8, -1  # x start, one less to draw inside square
    mv a2, t5  # y start
    addi a3, t8, -1  # x end, one less to draw inside square
    mv a4, t6  # y end
    mv a5, t0  # color
    mv a6, t1  # thickness
    jal draw_line

    # Exit
    li a7, 10
    ecall

draw_line:  # a1 = x start, a2 = y start, a3 = x end, a4 = y end, a5 = color, a6 = thickness
    # Code to draw a line using system call or a loop with pixel drawing, depending on RARS capabilities
    # This pseudo-instruction represents the need for implementing line drawing, 
    # which may require iterative drawing of pixels or leveraging specific RARS syscalls.
    ret
    ecall
.end_macro

    .text
main:
    lui     s0, 0xffff0   # MMIO base
    mv      s1, zero      # counter
    mv      s2, zero      # previous value
    li      s3, 20        # counter limit
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

    mv      s2, zero  # reset previous value
    j       loop  # nothing is pressed (t1 == 0) - repeat
pressed:
    beq     t1, s2, loop # repeat if the same key value
    mv      s2, t1 # save current value

    # Prints the pressed key in format 0xXY, where X is column, Y is row.
    # Both X and Y are specified as bit flags (0x1, 0x2, 0x4, 0x8).
    # Bit position means the number of row/column (0x1 -> 1, 0x2 -> 2, 0x4 -> 3, x8 -> 4).
    print_hex(t1)
    newline

    addi    s1, s1, 1    # counter increment
    ble     s1, s3, loop # repeat if s1 <= s3
end:
    exit
.macro print_dec(%x)
    li      t4, '%'
    li      t5, 'x'
    mv      a0, t4
    li      a7, 4
    ecall
    mv      a0, t5
    li      a7, 4
    ecall
    mv      a0, %x
    li      a7, 1
    ecall
.end_macro

# Inside the pressed block
# Use the print_dec macro instead of the print_hex macro
# Converts the hexadecimal keypress value to decimal and displays


    beq     t1, s2, loop
    mv      s2, t1

    print_dec(t1)
    newline

    addi    s1, s1, 1
    ble     s1, s3, loop

    exit
