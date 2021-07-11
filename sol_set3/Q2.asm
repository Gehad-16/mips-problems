.data
str: .space 20
str2: .space 20
.text
.globl main
main:

add $t0, $zero, $zero   #t0 = i counter for the loops
add $t1, $zero, $zero   #t1 = j counter for length of the string

li  $v0, 8              #gets(str)
la  $a0, str
la  $a1, 20
syscall



length:
    lb  $s0, str($t0)  #load each character to s0

    beq $s0, '\n', NEXTCHECK 

    add $t0, $t0, 1    #i++ to scan all the characters of the string

    add $t1, $t1, 1    #j++ for the total length of the string

j length

NEXTCHECK :

add $t0, $zero, $zero   #clean the t0 register from the length loop


addi $t4 , $t1 , -1

for: 

    slt $t3, $t0, $t1       #for(i=0; i<length; i++)
    beq $t3,0, EXIT 

    lb  $s1, str($t0)     #str[i]
    sb  $s1, str2($t4)   #str[length-i-1]
    
    addi $t4, $t4, -1
    addi $t0, $t0, 1         #i++

  j for  
       
EXIT:

 li $v0, 4        #function to print string
   la $a0, str2    #load address of message into register $a0
   syscall
 
li $v0 , 10
syscall 
