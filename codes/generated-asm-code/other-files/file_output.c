#include <stdio.h>

extern int ARRAY_B[];

void file_output(int n,  char *filename) {
    int i;
    FILE *file;
    if ((file = fopen(filename, "w")) != NULL) {
        for (i = 0; i < n; ++i) {
            fprintf(file, "%d ", ARRAY_B[i]);
        }
        fclose(file);
    }
}
