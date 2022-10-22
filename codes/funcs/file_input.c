#include <stdio.h>

extern const int SIZEMAX;

extern int ARRAY_A[];

int file_input(int *n,  char *filename) {
    int i;
    FILE *file;
    if ((file = fopen(filename, "r")) == NULL) {
        printf("Unable to open file '%s'\n", filename);
        return 1;
    }
    if (fscanf(file, "%d", n) < 1) {
        printf ("Reading file '%s' error\n", filename);
        fclose(file);
        return 1;
    }
    if (*n <= 0 || *n > SIZEMAX) {
        printf("The num of elems in arr must be from 1 to %d\n", SIZEMAX);
        fclose(file);
        return 1;
    }
    for (i = 0; i < *n; ++i) {
        if (fscanf(file, "%d", &ARRAY_A[i]) < 1) {
            printf("Reading file '%s' error\n", filename);
            fclose(file);
            return 1;
        }
    }
    fclose(file);
    return 0;
}
