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
    printf("Estoy pensando en un numero del 1 al 100.\n");

    do {
        printf("Intento: ");
        if (scanf("%d", &intento) != 1) {
            printf("Entrada no valida.\n");
            return 1;
        }
        turnos++;
        if (intento < secreto) printf("El numero es mayor.\n");
        else if (intento > secreto) printf("El numero es menor.\n");
        else printf("Ganaste en %d turnos!\n", turnos);
    } while (intento != secreto);

    return 0;
}