.data
newline: .asciiz "\n"
space: .asciiz " "
.text
.globl main
main:
#0x3fc00000
#0x4050000

#li $v0, 5 # service 5 (read integer)
#add $s4, $zero, $v0 
#syscall

#li $v0, 5 # service 5 (read integer)
#add $s5, $zero, $v0 
#syscall
#li $s4 ,2192048128  #1 00000101 01010000000000000000000
#li $s5 ,53477376    #0 00000110 01100000000000000000000 
                    #0 00000000 11111111111111111111111
           


li $s4 ,0x81B00000  #1 00000011 01100000000000000000000
li $s5 ,0x2B80000   #0 00000101 01110000000000000000000
#sign
srl $t1, $s4 , 31   #1
srl $t2, $s5 , 31   #0

xor $s0 , $t1 , $t2  #1

sll $s0 , $s0 , 31   #1 00000000 00000000000000000000000
 
#-----------------------------exponet----------------------------
srl $t4 , $s4 , 23   # 00000011
srl $t5 , $s5 , 23   # 00000101

 
andi $t4 , $t4 , 255  #00000011 and 011111111  == 11 == 3                  
andi $t5 , $t5 , 255  #00000101 and 011111111  == 101 == 5

addi  $t4 , $t4 , -127
addi  $t5 , $t5 , -127

add $s1 , $t4 , $t5

add $s1 , $s1 , 127   #110001001

sll $s1 , $s1 , 23   #110001001 00000000000000000000000


 
#-----------------------------------mantessa-------------------------------
andi $t6 , $s4 ,8388607  #0 00000000 11111111111111111111111
andi $t7 , $s5 , 8388607 

ori $s6 , $t6 ,0x00800000 #1 00000000000000000000000 add1 in last bit
ori $s7 , $t7 ,0x00800000 #1 00000000000000000000000 add1 in last bit
 
mult  $s6 , $s7 
mfhi $t2                  #11111010000000000000000

#-------------------normalization------------------
sll $t2 , $t2 ,16

norm:

li $s6, 31 #counter
li $t8 , 1 

srlv $t9 , $t2 ,$s6


ori  $t9 , $t9 ,1

li $v0 , 1
add $a0 , $t9 , $0
syscall

subi $s6 , $s6 , 1


addi $t8 , $t8 ,1
beqz $t9 , norm



beqz $s6 , res 



res:
sllv $t2 , $t2 , $t8
srl $t2 , $t2 , 9

or $s3 , $s0 , $s1
or $s3 , $s3 ,$t2 

li $v0 , 10
syscall 
