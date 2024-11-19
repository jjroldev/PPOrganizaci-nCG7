.data
	mensaje1: .asciiz "Ingrese una opcion: \n"
	mensaje2: .asciiz "Opcion 1:\n"
	mensaje3: .asciiz "Opçion 2: \n"
	mensaje4: .asciiz "Opcion 3: \n"
	mensaje5: .asciiz "Opcion 4: \n:"
	mensaje6: .asciiz "\nIngrese una opcion nuevamente: "
	mensaje7: .asciiz "Ingrese un numero: \n"
	mensaje8: .asciiz "El numero binario es: "
	mensaje9: .asciiz "Ingrese una cadena: \n"
	mensaje10: .asciiz "Su cadena fue: "
	mensaje11: .asciiz "Esto es una prueba \n"
	mensaje12: .asciiz "adios"
	buffer: .space 9
	array: .space 8
.text
	li $v0, 4
	la $a0, mensaje1
	syscall
	li $v0, 5
	syscall
	move $t0,$v0
	li $t1, 4
	li $t2, 1
	li $t3, 2
	li $t4, 3


ingreso: 
	blt $t0,1,validacion
	bgt $t0,4 validacion
	j while
loop: 
	beq $t0,$t1, exit
	beq $t0,$t2,first
	beq $t0,$t3,second
	beq $t0,$t4,third
	
first:
	li $v0,4
	la $a0, mensaje2
	syscall
	li $v0, 4
	la $a0, mensaje7
	syscall
	li $v0,5
	syscall
	move $a0,$v0
	jal decimalABinario
	move $s2,$v0
	li $v0,4
	la $a0, mensaje8
	syscall
	li $v0, 1
	move $a0,$s2
	syscall
	li $v0,4
	la $a0, mensaje6
	syscall
	li $v0, 5
	syscall
	move $t0,$v0
	j ingreso
	
salida: 
	li $v0, 4
	la $a0, mensaje5
	syscall
	li $v0, 4
	la $a0, mensaje12
	syscall
	li $v0,10
	syscall
	
second:
	li $v0,4
	la $a0, mensaje3
	syscall
	li $v0, 4
	la $a0, mensaje9
	syscall
	li $v0, 8
	la $a0, buffer
	li $a1, 9
	syscall
	li $v0, 4
	la $a0, mensaje10
	syscall
	li $v0,4
	la $a0,buffer
	syscall
	li $v0,4
	la  $a0, mensaje6
	syscall
	li $v0, 5
	syscall
	move $t0,$v0
	j ingreso
	
third: 
	li $v0, 4
	la $a0, mensaje4
	syscall
	li $v0, 4
	la $a0, mensaje11
	syscall
	li $v0, 4
	la $a0, mensaje6
	syscall
	li $v0,5
	syscall
	move $t0, $v0
	j ingreso
	
validacion:
	li $v0, 4
	la $a0, mensaje6
	syscall
	li $v0, 5
	syscall
	move $t0, $v0
	j ingreso
	
	
	
decimalABinario:
	 addi $sp, $sp, -8    
   	 sw $ra, 4($sp)        
    	 sw $s0, 0($sp) 
	la $s0,array
	addi $s0,$s0,7
	li $t1, 7
	li $t2, 2
	

while: 
	blez $a0, imprimir
	bltz $t1, imprimir
	div $a0,$t2
	mfhi $t3
	sb $t3,0($s0)
	addi $s0, $s0, -1
	mflo $a0
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
	 lw $ra, 4($sp)        
   	 lw $s0, 0($sp)        
   	 addi $sp, $sp, 8
	jr $ra

		