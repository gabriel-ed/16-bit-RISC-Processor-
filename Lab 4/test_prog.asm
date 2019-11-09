.text
.globl main

main:	li $v0,4 
	la $a0, MSG1
	syscall
	

# --TEST CODE --
	
	addi $t1, $t1, 4	#store 4 in t1
	addi $t2, $t2, 3	#store 3 in t2
	add $t3, $t1, $t2	#add t1 and t2 / store result in t3
	
	sub $t4, $t1, $t2	#subtract t1 from t2 / store result in t4
	
	li $v0, 1
	la $a0, 0($t3)
	syscall
	
	li $v0, 1
	la $a0, 0($t4)
	syscall
	li $v0, 10
	syscall
	
	
	
	
	
	
	
	
	
	
	
	
	
	
.data

MSG1: .asciiz	"Test program for 16-bit RISC Processor"
	
	
	
	
	
	
	
	
	
	
	
	
	
