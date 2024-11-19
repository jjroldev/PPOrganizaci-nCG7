#include <stdio.h>
#include <stdlib.h>
#include <math.h>

// Función para convertir un número decimal a binario
void decimalABinario(int decimal) {
    int binario[8] = {0};
    int i = 7; // Índice para llenar el arreglo desde el final

    while (decimal > 0 && i >= 0) {
        binario[i] = decimal % 2;
        decimal /= 2;
        i--;
    }

    printf("Número en binario: ");
    for (int j = 0; j < 8; j++) {
        printf("%d", binario[j]);
    }
    printf("\n");
}

// Función para convertir un número binario a decimal (Se asume que es de 8 bits el que se ingresa)
int binarioADecimal(char *binario) {
    int decimal = 0;

    // Convertir binario a decimal recorriendo de derecha a izquierda.
    for (int i = 7; i >= 0; i--) {
        int bit = binario[i] - '0'; // Convertir el carácter a un número (0 o 1). ('0' - '0'= 0  '1' - '0' = 1)
	    decimal += bit * (int)pow(2, 7 - i);
    
}

    return decimal;
}


// Función para generar un número aleatorio entre 10 y 50
void generarNumeroAleatorio() {
    int aleatorio = 10 + rand() % 41; // Genera un número entre 10 y 50
    printf("Número aleatorio generado: %d\n", aleatorio);
    decimalABinario(aleatorio);
}

int main() {
    
    int opcion;
    char binario[9]; // Espacio para 8 bits y el carácter nulo
    int decimal;

    do {
        printf("\n--- Menú ---\n");
        printf("1. Convertir Decimal a Binario\n");
        printf("2. Convertir Binario a Decimal\n");
        printf("3. Generar un Número Aleatorio\n");
        printf("4. Salir\n");
        printf("Seleccione una opción: ");
        scanf("%d", &opcion);

        switch (opcion) {
            case 1:
                printf("Ingrese un número decimal: ");
                scanf("%d", &decimal);
                if (decimal < 0 || decimal > 255) {
                    printf("Error: El número debe estar entre 0 y 255.\n");
                } else {
                    decimalABinario(decimal);
                }
                break;
            case 2:
                printf("Ingrese un número binario de 8 bits: ");
                scanf("%s", binario);
                decimal = binarioADecimal(binario);
                if (decimal != -1) {
                    printf("Número en decimal: %d\n", decimal);
                }
                break;
            case 3:
                generarNumeroAleatorio();
                break;
            case 4:
                printf("Saliendo del programa...\n");
                break;
            default:
                printf("Opción no válida. Intente de nuevo.\n");
        }
    } while (opcion != 4);

    return 0;
}
