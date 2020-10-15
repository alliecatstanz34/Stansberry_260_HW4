.data
 
 input1_msg: .asciiz "Enter first number: "
 input2_msg: .asciiz "Enter second number: "
 op_msg: .asciiz "Enter the operation type (0, 1, 2 for +, -, x respectivly): "
 result_msg: .asciiz "The result is: "  
 err_msg: .asciiz "Invalid inputs!" 
 newline: .asciiz "\n"

 .text

.globl main

main:
#prints new line, added at the beginning so there would be a line between runs
    li	$v0,  4		#Print string code
    la	$a0, newline    #what I want to print 
    syscall     #print in console 

#first input 
    li	$v0,  4		#Print string code
    la	$a0, input1_msg    #what I want to print
    syscall     #print in console
    li  $v0,  5     #read int code
    syscall     #print in console
    move $s0, $v0   #moves user to saved temporary register   

#second input 
    li	$v0,  4		#Print string code
    la	$a0, input2_msg    #what I want to print
    syscall     #print in console
    li  $v0,  5     #read int code
    syscall     #print in console
    move $s1, $v0   #moves user to saved temporary register

#operation input 
    li	$v0,  4		#Print string code
    la	$a0, op_msg    #what I want to print
    syscall     #print in console
    li  $v0,  5     #read int code
    syscall     #print in console
    move $s2, $v0   #moves user to saved temporary register

# at this point: first input = $s0, second input = $s1, op code = $s2

#deciding which operation "function" to jump to 
    li $t0, 1   #setting $t0 to 1 for comparison 
    li $t1, 2   #setting $t1 to 2 for comparison 
    beq	$s2, $zero, add_     #if op code is 0, go to add
    beq	$s2, $t0, sub_     #if op code is 1, go to sub
    beq	$s2, $t1, mult_     #if op code is 2, go to mult
    j error_   #if op code is invalid go to error 

# addition function 
add_:
    #print result message 
    jal result_ 


    # add numbers and print 
    add $a0, $s0, $s1 # add input 1 and 2, put into syscall register
    li $v0, 1   # print int code 
    syscall 

    j main


# subtraction function 
sub_:
    #print result message 
    jal result_ 


    # subtract numbers and print 
    sub $a0, $s0, $s1 # subtract input 1 and 2, put into syscall register
    li $v0, 1   # print int code 
    syscall 

    j main


# multiplication function 
mult_:
    #print result message 
    jal result_ 


    # multiply numbers and print 
    mult $s0, $s1 # multiply input 1 and 2, put into syscall register
    mflo $a0    #lower 32 bits of multiplication 
    li $v0, 1   # print int code 
    syscall 

    j main


# will run if op code is invalid 
error_:
    li $v0, 4   #print string code
    la $a0, err_msg      #error message  
    syscall     #print in console
    j main 


# result message function 
result_:
    li $v0, 4   #print string code
    la $a0, result_msg      #result message  
    syscall     #print in console
    jr $ra

