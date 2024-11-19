.data
mensaje: .asciiz "Numero aleatorio entre 10 y 50: \n"

.text
main:
    # Obtener el tiempo actual como semilla
    li $v0, 30       # Syscall para obtener tiempo en segundos
    syscall          # El resultado estará en $a0 (tiempo actual)
    
    # Establecer la semilla
    li $v0, 43       # Syscall para inicializar la semilla
    move $a0, $a0    # Usar el tiempo como semilla
    syscall

    # Generar un número aleatorio
    li $v0, 42       # Syscall para generar número aleatorio
    syscall          # Resultado estará en $a0

    # Escalar al rango 10-50
    li $t0, 41       # Tamaño del rango (50 - 10 + 1)
    rem $t1, $a0, $t0  # $t1 = $a0 % 41 (número entre 0 y 40)
    addi $t1, $t1, 10  # Ajustar al rango (sumar 10)

    # Mostrar mensaje
    li $v0, 4
    la $a0, mensaje
    syscall

    # Mostrar número escalado
    li $v0, 1
    move $a0, $t1
    syscall

    # Salir del programa
    li $v0, 10
    syscall
