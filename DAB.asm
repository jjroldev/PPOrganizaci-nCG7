.data
	mensaje1: .asciiz "Ingrese un numero: \n"
	mensaje2: .asciiz "El numero binario es: "
	array: .space 8
	

.text
	li $v0,4
	la $a0,mensaje1
	syscall
	li $v0, 5
	syscall
	move $t0,$v0
	la $s0,array
	addi $s0,$s0,7
	li $t1, 7
	li $t2, 2
	

while: 
	blez $t0, imprimir
	bltz $t1, imprimir
	div $t0,$t2
	mfhi $t3
	sb $t3,0($s0)
	addi $s0, $s0, -1
	mflo $t0
	addi $t1, $t1, -1
	j while
	
imprimir:
	li $v0, 4
	la $a0, mensaje2
	syscall
	la $s0, array
	li $t1, 8
for:
	beqz $t1,exit
	lb $t3, 0($s0)
	move $a0, $t3
	li $v0,1
	syscall
	addi $s0,$s0,1
	addi $t1,$t1,-1
	j for
	
exit: 
	
	jr $ra
