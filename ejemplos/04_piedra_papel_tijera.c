#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(void) {
    int jugador;
    int computadora;
    const char *nombres[] = {"piedra", "papel", "tijera"};

    srand((unsigned int)time(NULL));
    printf("JUEGO: PIEDRA, PAPEL O TIJERA\n");
    printf("0 = piedra, 1 = papel, 2 = tijera, -1 = salir\n\n");

    while (1) {
        printf("Tu jugada: ");
        if (scanf("%d", &jugador) != 1) {
            int c;
            printf("Entrada no valida. Elige 0, 1, 2 o -1 para salir.\n\n");
            while ((c = getchar()) != '\n' && c != EOF) {}
            continue;
        }
        if (jugador == -1) {
            printf("\nHasta luego!\n\n");
            break;
        }
        if (jugador < 0 || jugador > 2) {
            printf("Opcion invalida. Elige 0, 1, 2 o -1 para salir.\n\n");
            continue;
        }

        computadora = rand() % 3;
        printf("Tu: %s | Computadora: %s\n", nombres[jugador], nombres[computadora]);
        if (jugador == computadora) {
            printf("Resultado: Empate.\n\n");
        } else if ((jugador + 1) % 3 == computadora) {
            printf("Resultado: Gana la computadora.\n\n");
        } else {
            printf("Resultado: Ganaste!\n\n");
        }
    }

    system("pause");
    return 0;
}