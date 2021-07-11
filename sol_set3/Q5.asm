.data
str: .space 20
a: .asciiz "it is not palindrom!"
b: .asciiz "it is palindrom!"

.text
.globl main
main:

add $t0, $zero, $zero   #t0 = i counter for the loops
add $t1, $zero, $zero   #t1 = j counter for length of the string

li  $v0, 8          #gets(str)
la  $a0, str
la  $a1, 20
syscall

li  $t5 ,0

length:
    lb  $s0, str($t0)  #load each character to s0

    beq $s0, '\n', NEXTCHECK 

    add $t0, $t0, 1 #i++ to scan all the characters of the string

    add $t1, $t1, 1 #j++ for the total length of the string

j length

NEXTCHECK :

add $t0, $zero, $zero   #clean the t0 register from the length loop


div $s2 , $t1 , 2

addi $t4 , $t1 , -1

  div $t1 , $t1 ,2
for: 

    slt $t3, $t0, $t1       #for(i=0; i<length; i++)
    beq $t3,0, EXIT 

    lb  $s0, str($t0)   #str[i]
    lb  $s1, str($t4)   #str[length-i-1]

    addi $t4, $t4, -1
    
    addi $t0, $t0, 1         #i++

    bne $s0, $s1, A      #if (str[i] == str[length-i-1])
    addi $t5 , $t5 ,1 
    A: 
  j for  
       
EXIT:
 
 beq $s2 , $t5 , B
    li  $v0, 4              #rintf("It is not palindromic");
    la  $a0, a
    syscall
    j EXITi
    B:li  $v0, 4          #printf("It is palindromic");
      la  $a0, b
      syscall
      EXITi:
li $v0 , 10
syscall 
