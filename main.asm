.data
    mensaje_menu: .asciiz "\n--- Menu ---\n1. Decimal a Binario\n2. Binario a Decimal\n3. Generar Numero Aleatorio Y Transformarlo A Binario\n4. Salir\nIngrese una opcion: "
    mensaje_decimal: .asciiz "\nIngrese un numero decimal (0-255): "
    mensaje_binario_resultado: .asciiz "\nEl numero binario es: "
    mensaje_binario: .asciiz "\nIngrese un numero binario (8 bits): "
    mensaje_decimal_resultado: .asciiz "\nEl numero decimal es: "
    mensaje_aleatorio: .asciiz "\nGenerando numero aleatorio..."
    mensaje_salida: .asciiz "\nSaliendo del programa...\n"
    mensaje_error: .asciiz "\nOpcion no valida. Intente nuevamente.\n"
    mensaje_aleatorio_resultado: .asciiz "\nNumero aleatorio generado: "

    buffer: .space 9
    binario_buffer: .space 8

.text
.globl main

main:
menu:
    li $v0, 4
    la $a0, mensaje_menu
    syscall

    li $v0, 5
    syscall
    move $t0, $v0

    li $t1, 1
    li $t2, 2
    li $t3, 3
    li $t4, 4
    beq $t0, $t1, opcion_1
    beq $t0, $t2, opcion_2
    beq $t0, $t3, opcion_3
    beq $t0, $t4, opcion_4
    j opcion_error

opcion_1:
    li $v0, 4
    la $a0, mensaje_decimal
    syscall

    li $v0, 5
    syscall
    move $a0, $v0

    la $a1, binario_buffer
    jal decimalABinario
    j menu

opcion_2:
    li $v0, 4
    la $a0, mensaje_binario
    syscall

    li $v0, 8
    la $a0, buffer
    li $a1, 9
    syscall

    jal binarioADecimal
    j menu

opcion_3:
    li $v0, 4
    la $a0, mensaje_aleatorio
    syscall

    jal generarNumeroAleatorio
    j menu

opcion_4:
    li $v0, 4
    la $a0, mensaje_salida
    syscall
    li $v0, 10
    syscall

opcion_error:
    li $v0, 4
    la $a0, mensaje_error
    syscall
    j menu

# --- Generar Número Aleatorio ---
.globl generarNumeroAleatorio

generarNumeroAleatorio:
    li $v0, 30
    syscall
    li $v0, 43
    move $a0, $a0
    syscall
    li $v0, 42
    syscall
    li $t0, 41
    rem $t1, $a0, $t0
    addi $t1, $t1, 10

    li $v0, 4
    la $a0, mensaje_aleatorio_resultado
    syscall

    li $v0, 1
    move $a0, $t1
    syscall
    
    move $a0, $t1
    jal decimalABinario
    j menu
    
    jr $ra

# --- Binario a Decimal ---
.globl binarioADecimal

binarioADecimal:
    la $t0, buffer
    li $t1, 0
    li $t2, 7

transformacion:
    lb $t3, 0($t0)
    subi $t3, $t3, 48
    li $t4, 1
    sllv $t4, $t4, $t2
    mul $t3, $t3, $t4
    add $t1, $t1, $t3
    addi $t0, $t0, 1
    addi $t2, $t2, -1
    bge $t2, $zero, transformacion
    
impresion:
    # Mostrar mensaje "El número decimal es: "
    li $v0, 4
    la $a0, mensaje_decimal_resultado
    syscall

    # Imprimir el número decimal
    move $a0, $t1
    li $v0, 1
    syscall

    jr $ra
# --- Decimal a Binario ---
.globl decimalABinario

decimalABinario:
    la $s0, binario_buffer
    li $t1, 8

reset_buffer:
    beqz $t1, start
    li $t3, 48
    sb $t3, 0($s0)
    addi $s0, $s0, 1
    addi $t1, $t1, -1
    j reset_buffer

start:
    move $t0, $a0
    la $s0, binario_buffer
    addi $s0, $s0, 7
    li $t1, 7
    li $t2, 2

while:
    blez $t0, imprimir
    bltz $t1, imprimir
    div $t0, $t2
    mfhi $t3
    addi $t3, $t3, 48
    sb $t3, 0($s0)
    addi $s0, $s0, -1
    mflo $t0
    addi $t1, $t1, -1
    j while

imprimir:
    li $v0, 4
    la $a0, mensaje_binario_resultado
    syscall

    la $s0, binario_buffer
    li $t1, 8

for:
    beqz $t1, end
    lb $t3, 0($s0)
    move $a0, $t3
    li $v0, 11
    syscall
    addi $s0, $s0, 1
    addi $t1, $t1, -1
    j for

end:
    jr $ra
