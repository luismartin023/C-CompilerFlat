#include <stdio.h>

int main(void) {
    double numero1;
    double numero2;
    char operador;

    printf("Escribe una operacion, por ejemplo 8 * 4: ");
    if (scanf("%lf %c %lf", &numero1, &operador, &numero2) != 3) {
        printf("Entrada no valida.\n");
        return 1;
    }

    switch (operador) {
        case '+': printf("Resultado: %.2f\n", numero1 + numero2); break;
        case '-': printf("Resultado: %.2f\n", numero1 - numero2); break;
        case '*': printf("Resultado: %.2f\n", numero1 * numero2); break;
        case '/':
            if (numero2 == 0) {
                printf("No se puede dividir entre cero.\n");
                return 1;
            }
            printf("Resultado: %.2f\n", numero1 / numero2);
            break;
        default:
            printf("Usa +, -, * o /.\n");
            return 1;
    }
    return 0;
}