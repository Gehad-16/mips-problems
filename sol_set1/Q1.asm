.text

li $s3 ,1
li $v0 , 5
   syscall
   addi $s0 , $v0 ,0

li $v0 , 5
   syscall
   addi $s1, $v0 ,0
   
   slt $t0 , $s1 , $s0
   bne $t0,1,else1
   
     add $s0, $s0 ,$s1
     j exit1
   else1: bne   $s0, $s1,else2
   
     mul $s0, $s0 ,$s1
     j exit1
   else2: sub $s0, $s0 ,$s1    
    
   exit1:
   
   li $v0 , 10
syscall 


