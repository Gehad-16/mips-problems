.data
a: .float 1.123
b: .float 1.5
.text
main :
lwc1 $f2 , a
lwc1 $f4 , b

add.s $f12,$f2 , $f4

#li $v0 , 3
#syscall 

li $t1 , 5
div $t0 ,$t1 ,2

li $v0 , 1
addi $a0 , $t0 , 0
syscall


li $v0 , 10
syscall 