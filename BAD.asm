.data
	mensaje1: .asciiz "Ingrese un numero binario: \n"
	mensaje2: .asciiz "\nEl numero decimal es: "
	buffer: .space 9
.text
	li $v0, 4
	la $a0,mensaje1
	syscall
	li $v0,8
	la $a0,buffer
	li $a1, 9
	syscall
	la $t0,buffer
	li $t1,0
	li $t2,7
	
	

transformacion:
		lb $t3,0($t0)
		subi $t3,$t3,48
		li $t4,1
		sllv $t4,$t4,$t2
		mul $t3,$t3,$t4
		add $t1,$t1,$t3
		addi $t0,$t0,1
		addi $t2,$t2,-1
		bge $t2,$zero,transformacion
		
impresion: 
	li $v0, 4
	la $a0, mensaje2
	syscall
	li $v0,1
	move $a0,$t1
	syscall
	li $v0,10
	syscall
		
	