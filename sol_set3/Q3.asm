.data
arr: .space 16
.text
main:
   la $t0 , arr
   li $t5 , 1
   sw $t5 , ($t0)
   sw $t5 , 4($t0)
   sw $t5 , 8($t0)
   sw $t5 , 12($t0)
   
   li $t1 , 0
   
   
   for1:slti  $t3 , $t1 , 4
        beq $t3 , 0 , exit1
        addi $t2 ,$t1, 0
        for2:slti  $t6, $t2 , 0
             beq $t6, 1 , exit2
             lw  $t7 , ($t0)
             mul $t7 , $t7 , $t2
             subi $t2 , $t2 , 1
             j for2
        exit2:
        addi $t1 , $t1, 1
        sw  $t7 , ($t0) 
        addi $t0 , $t0, 4
        
              j for1  
               
   exit1:
.end main
