#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(void) {
    int secreto;
    int intento;
    int turnos = 0;

    srand((unsigned int)time(NULL));
    secreto = (rand() % 100) + 1;
    printf("JUEGO: ADIVINA EL NUMERO\n");
    printf("Estoy pensando en un numero del 1 al 100.\n\n");

    do {
        printf("Intento: ");
        if (scanf("%d", &intento) != 1) {
            int c;
            printf("Entrada no valida. Introduce un numero entero.\n");
            while ((c = getchar()) != '\n' && c != EOF) {}
            continue;
        }
        turnos++;
        if (intento < secreto) {
            printf("El numero es mayor.\n");
        } else if (intento > secreto) {
            printf("El numero es menor.\n");
        } else {
            printf("Ganaste en %d turnos!\n\n", turnos);
        }
    } while (intento != secreto);

    system("pause");
    return 0;
}