.data
arr: .space 16
.text
main:
   la $t0 , arr
   li $t5 , 0
   sw $t5 , ($t0)
   sw $t5 , 4($t0)
   sw $t5 , 8($t0)
   sw $t5 , 12($t0)
   
   li $t1 , 0
   
   
   for1:slti  $t3 , $t1 , 4
        beq $t3 , 0 , exit1
        li $t2 , 0
        for2:slti  $t6, $t2 , 4
             beq $t6, 0 , exit2
             sub $t7 , $t1 , $t2
             addi $t2 , $t2 , 1
             j for2 
        exit2:addi $t1 , $t1, 1
        sw  $t7 , ($t0) 
        addi $t0 , $t0, 8 
        
              j for1  
               
   exit1:
.end main
li $v0 , 10
syscall 