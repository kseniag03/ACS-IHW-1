#include <stdio.h>
#include <stdlib.h>

extern const int SIZEMAX;

extern int ARRAY_A[];

int command_line_input(int *n, char** argv) {
    int i;
    *n = atoi(argv[2]);
    if (*n <= 0 || *n > SIZEMAX) {
        printf("The num of elems in arr must be from 1 to %d\n", SIZEMAX);
        return 1;
    }
    for (i = 0; i < *n; ++i) {
        if (argv[i + 3] == NULL) {
            printf("Not enough elems in arr\n");
            return 1;
        }
        ARRAY_A[i] = atoi(argv[i + 3]);
    }
    return 0;
}
