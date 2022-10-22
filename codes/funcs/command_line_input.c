#include <stdio.h>
#include <stdlib.h>

extern const int SIZEMAX;

extern int ARRAY_A[];

int command_line_input(int *n, char** argv) {
    int i;
    *n = atoi(argv[2]);
    if (*n <= 0 || *n > SIZEMAX) {
        printf("Кол-во эл-в массива должно быть от 1 до %d\n", SIZEMAX);
        return 1;
    }
    for (i = 0; i < *n; ++i) {
        ARRAY_A[i] = atoi(argv[i + 3]);
    }
    return 0;
}
