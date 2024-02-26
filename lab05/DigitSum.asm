.global DigitSum

.text
    
DigitSum:
.macro print_int(%x)
li a7, 1
mv a0, %x
ecall
.end_macro

    # x
    addi a7, zero, 5
    ecall
    add t0, zero, a0      

    bltz t0, makePositive
    
    li t1, 0          

extrDigits:
    
    beqz t0, print

    li t2, 10         
    rem t3, t0, t2    
    div t0, t0, t2   

  
    add t1, t1, t3   


    j extrDigits

makePositive:
    neg t0, t0       
    j extrDigits  

print:
 
print_int(t1)
li a7, 11
li a0, '\n'
ecall
