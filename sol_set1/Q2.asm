
.data  #here we declare variables  

char_arr: .space 20
upper: .asciiz "\n num of upper is " 
lower: .asciiz "\n num of lower is " 

.text
.globl main
main:
# t3=char  t2 =location of char  t0 =check less than  t1=i
   la   $t2 , char_arr
   li   $t1 , 0
   li   $t4,0
   li   $t5,0
   for:
       slti $t0 ,$t1 , 5
       beq  $t0 , 0 , exitfor
       
       # reads a character
       li $v0, 12
       syscall
       
       addi $t3 , $v0 ,0
       sw   $t3 , ($t2)
       
       slti $t0 , $t3 , 65 
       beq  $t0 , 1 , exit1
            slti $t0 , $t3, 90 
            beq  $t0 , 0 , exit1
                 addi $t4 , $t4 ,1
       exit1:
       
       slti $t0  , $t3 , 97
       beq  $t0 , 1 , exit2
            slti $t0 , $t3, 122
            beq  $t0 , 0 , exit2
                 addi $t5 , $t5 ,1
       exit2:
                   
       addi $t2 , $t2 , 4
       addi $t1 , $t1 , 1
       j for
   exitfor:
  
   li $v0, 4
  la $a0, upper
  syscall

    li $v0 ,1
   addi $a0 , $t4 , 0
   syscall
   
   li $v0, 4
  la $a0, lower
  syscall
   
   li $v0,1
   addi $a0 , $t5,0
   syscall
   
   
    li $v0, 10
       syscall
   
