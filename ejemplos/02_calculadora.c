#include <stdio.h>
#include <stdlib.h>

int main(void) {
    double numero1;
    double numero2;
    char operador;

    printf("Escribe una operacion, por ejemplo 8 * 4: ");
    if (scanf("%lf %c %lf", &numero1, &operador, &numero2) != 3) {
        printf("Entrada no valida.\n\n");
        system("pause");
        return 1;
    }

    switch (operador) {
        case '+':
            printf("Resultado: %.2f\n\n", numero1 + numero2);
            break;
        case '-':
            printf("Resultado: %.2f\n\n", numero1 - numero2);
            break;
        case '*':
            printf("Resultado: %.2f\n\n", numero1 * numero2);
            break;
        case '/':
            if (numero2 == 0.0) {
                printf("No se puede dividir entre cero.\n\n");
                system("pause");
                return 1;
            }
            printf("Resultado: %.2f\n\n", numero1 / numero2);
            break;
        default:
            printf("Usa +, -, * o /.\n\n");
            system("pause");
            return 1;
    }

    system("pause");
    return 0;
}