# registers 
# $s0 = front of array
# $s1 = size of array 
# $s2 = max value 
# $s3 = sum value 
# $s4 used as counter 
# $s5 used to load int at index 


.data 

max_msg: .asciiz "The maximum is "
sum_msg: .asciiz "The summation is " 
newline: .asciiz "\n"
list: .word 11, 12, -10, 13, 9, 12, 14, 15, -20, 0
size: .word 10


.text

.globl main 

main:
    lw $s1, size    #store array size
    la $s0, list    #store array address 
    li $s4, 0   #loop counter

    # maximum value, prints message then jumps to max and then prints found integer
    li	$v0,  4		#print string code
    la	$a0, max_msg    #what I want to print 
    syscall     #print in console 
    jal max     #jumps to function to find max
    li $v0, 1   #print int code 
    move  $a0, $s2  #store the found value in correct register 
    syscall 

    #prints new line 
    li	$v0,  4		#print string code
    la	$a0, newline    #what I want to print 
    syscall     #print in console 

    # summation, prints message then prints the sum
    li	$v0,  4		#print string code
    la	$a0, sum_msg    #what I want to print 
    syscall     #print in console 
    jal sum     #jumps to function to find summation 
    li $v0, 1   #print int code 
    move  $a0,  $s3  #store the found value in correct register 
    syscall 

    # ends program 
    j end



# finds and stores maximum value 
max:
    beq $s4, $s1, max_end #check for array end 
    lw $s5, ($s0) #load value at index 
    bgt $s5, $s2, max_set # check if current pointer is greater than current max 
    addi $s4, $s4, 1    #incriments counter 
    addi $s0, $s0, 4    #moves pointer to next index
    j max

#sets the max value when a new one is found 
max_set:
    addi $s2, $s5, 0 # sets new max value 
    addi $s4, $s4, 1    #incriments counter 
    addi $s0, $s0, 4    #moves pointer to next index
    j max

#works with max to return 
max_end:
    la $s0, list #reset pointer 
    li $s4, 0   #loop counter reset 
    jr $ra


# finds and stores summation 
sum:
    beq $s4, $s1, max_end   #checks to see if counter is equal to size
    lw $s5, ($s0) #load value at index 
    add $s3, $s3, $s5   #adds new to current sum 
    addi $s4, $s4, 1    #incriments counter 
    addi $s0, $s0, 4    #moves pointer to next index 
    j sum


# works with sum to return 
sum_end:
    la $s0, list #reset pointer 
    li $s4, 0   #loop counter reset 
    jr $ra



# ends the program 
end:
    li $v0, 10  #exit code 
    syscall 

