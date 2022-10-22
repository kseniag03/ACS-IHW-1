#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdint.h>

const int NMAX = 1048576;
const int ELEMENTMAX = 100;
const int THRESHOLD = RAND_MAX - 10;

//static int ARRAY[1048576];
// copy in all separate files
//extern int ARRAY[];
//in main
int ARRAY_A[1048576];
int ARRAY_B[1048576];
//in main
//extern func

int64_t timespecDifference(struct timespec a, struct timespec b) {
    int64_t timeA, timeB;
    timeA = a.tv_sec;
    timeA *= 1000000000;
    timeA += a.tv_nsec;
    timeB = b.tv_sec;
    timeB *= 1000000000;
    timeB += b.tv_nsec;
    return timeA - timeB;
}

int getMinFromArrayA(int n) {
    int min = ARRAY_A[0];
    for (int i = 1; i < n; ++i) {
        if (ARRAY_A[i] < min) {
            min = ARRAY_A[i];
        }
    }
    return min;
}

int countIfEqualsElement(int n, int element) {
    int cnt = 0;
    for (int i = 0; i < n; ++i) {
        if (ARRAY_A[i] == element) {
            ++cnt;
        }
    }
    return cnt;
}

void fillArrayB(int n, int size, int element) {
    for (int i = 0, j = 0; i < n && j < size; ++i) {
        if (ARRAY_A[i] == element) {
            continue;
        }
        ARRAY_B[j] = ARRAY_A[i];
        ++j;
    }
}

int console_input(int *n, char** argv) {
    int i;
    *n = atoi(argv[2]);
    if (*n <= 0) {
        printf("Кол-во эл-в массива должно быть от 1 до %d\n", NMAX);
        return 1;
    }
    for (i = 0; i < *n; ++i) {
        ARRAY_A[i] = atoi(argv[i + 3]);
    }
}

void console_output(int n, int arr[]) {
    int i;
    printf("[ ");
    for (i = 0; i < n; ++i) {
        printf("%d ", arr[i]);
    }
    printf("]");
    printf("\n");
}

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

    if (*n < 0 || *n > NMAX) {
        printf("Кол-во эл-в массива должно быть от 1 до %d\n", NMAX);
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
}

void file_output(int n,  char *filename) {
    int i;
    FILE *file;

    if ((file = fopen(filename, "w")) != NULL) {
        for (i = 0; i < n; i++) {
            fprintf(file, "%d ", ARRAY_B[i]);
        }
        fclose(file);
    }
}

void random_generation(int n) {
    srand(time(NULL));
    int i;
    for (i = 0; i < n; ++i) {
        ARRAY_A[i] = rand() % ELEMENTMAX;
    }
    printf("\n");
}

int main (int argc, char** argv) {
    char *arg;
    int option, seed;
    int n, size, min;

    struct timespec start, end;
    int64_t elapsed_ns;

    // input
    if (argc > 1) {
        arg = argv[1];
        printf("arg = %s", arg);
        printf("\n");
        option = atoi(arg);
        if (option == 1) {
            console_input(&n, argv);
        } else if (option == 2) {
            file_input(&n, "input.txt");
        } else {
            srand(time(NULL));
            n = 1 + rand() % NMAX;
            random_generation(n);
            console_output(n, ARRAY_A);
        }
    } else {
        printf("No arguments");
        return 0;
    }
    // timeStart
    clock_gettime(CLOCK_MONOTONIC, &start);
    // fill arrayB
    min = getMinFromArrayA(n);
    size = countIfEqualsElement(n, min);
    size = n - size;
    fillArrayB(n, size, min);
    // timeEnd
    clock_gettime(CLOCK_MONOTONIC, &end);
    elapsed_ns = timespecDifference(end, start);
    printf("Elapsed: %ld ns", elapsed_ns);
    // output
    console_output(size, ARRAY_B);
    file_output(size, "output.txt");
    return 0;
}
