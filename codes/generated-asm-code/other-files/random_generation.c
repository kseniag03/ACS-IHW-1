#include <stdlib.h>
#include <time.h>

extern const int SIZEMAX;
extern const int VALUEMAX;

extern int ARRAY_A[];

void random_generation(int *n) {
    srand(time(NULL));
    *n = rand() % SIZEMAX;
    if (*n < 1) {
        ++*n;
    }
    int i;
    for (i = 0; i < *n; ++i) {
        ARRAY_A[i] = rand() % VALUEMAX;
    }
}
