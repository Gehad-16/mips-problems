.text
.globl main
main:
li $a3 , 10

   jal sumodd
   
   li $v0 ,1
   addi $a0 , $s1 , 0
   syscall
    
    li $v0,10
    syscall 
   
   sumodd:
   
   add $t0 , $zero ,$zero
   #li $v1 , 0 
   add $t1 , $zero ,$zero 
   addi $t2 , $zero ,1
   
   div $a3 , $a3 , 2
   
   while: 
         slt $t3 , $t0 , $a3
         beq $t3 , 0 , exitwhile
         add $t1 , $t1 , $t2
         add $s1 , $t1, $zero
         addi $t2 , $t2 , 2
         addi $t0 , $t0 ,1
         j while
         
   exitwhile:
         jr $ra
         
    .end main     
   li $v0 , 10
syscall 
