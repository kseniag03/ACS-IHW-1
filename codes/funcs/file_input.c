#include <stdio.h>

extern const int SIZEMAX;

extern int ARRAY_A[];

int file_input(int *n,  char *filename) {
    int i;
    FILE *file;
    if ((file = fopen(filename, "r")) == NULL) {
        printf("Невозможно открыть файл '%s'\n", filename);
        return 1;
    }
    if (fscanf(file, "%d", n) < 1) {
        printf ("Ошибка чтения из файла '%s'\n", filename);
        fclose(file);
        return 1;
    }
    if (*n <= 0 || *n > SIZEMAX) {
        printf("Кол-во эл-в массива должно быть от 1 до %d\n", SIZEMAX);
        fclose(file);
        return 1;
    }
    for (i = 0; i < *n; ++i) {
        if (fscanf(file, "%d", &ARRAY_A[i]) < 1) {
            printf("Ошибка чтения из файла '%s'\n", filename);
            fclose(file);
            return 1;
        }
    }
    fclose(file);
    return 0;
}
