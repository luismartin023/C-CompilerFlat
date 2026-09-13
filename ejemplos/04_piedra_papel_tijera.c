#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(void) {
    int jugador;
    int computadora;
    const char *nombres[] = {"piedra", "papel", "tijera"};

    srand((unsigned int)time(NULL));
    printf("JUEGO: PIEDRA, PAPEL O TIJERA\n");
    printf("0 = piedra, 1 = papel, 2 = tijera, -1 = salir\n");

    while (1) {
        printf("Tu jugada: ");
        if (scanf("%d", &jugador) != 1) {
            printf("Entrada no valida.\n");
            return 1;
        }
        if (jugador == -1) {
            printf("Hasta luego!\n");
            break;
        }
        if (jugador < 0 || jugador > 2) {
            printf("Elige 0, 1, 2 o -1.\n");
            continue;
        }

        computadora = rand() % 3;
        printf("Tu: %s | Computadora: %s\n", nombres[jugador], nombres[computadora]);
        if (jugador == computadora) printf("Empate.\n");
        else if ((jugador + 1) % 3 == computadora) printf("Gana la computadora.\n");
        else printf("Ganaste!\n");
    }

    return 0;
}