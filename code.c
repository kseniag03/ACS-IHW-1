#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdint.h>

extern const int SIZEMAX;
extern const int VALUEMAX;

extern int ARRAY_A[];
extern int ARRAY_B[];

// in main.c
extern int64_t timespec_difference(struct timespec a, struct timespec b);
extern int get_min_from_array(int n, const int arr[]);
extern int count_if_equals_element(int n, const int arr[], int element);
extern void fill_ARRAY_B(int n, int size, int element);
extern int command_line_input(int *n, char** argv);
extern void command_line_output(int n, int arr[]);
extern int file_input(int *n,  char *filename);
extern void file_output(int n,  char *filename);
extern void random_generation(int *n);

const int SIZEMAX = 100000;
const int VALUEMAX = 1000;

int ARRAY_A[100000];
int ARRAY_B[100000];

int64_t timespec_difference(struct timespec a, struct timespec b) {
    int64_t timeA, timeB;
    timeA = a.tv_sec;
    timeA *= 1000000000;
    timeA += a.tv_nsec;
    timeB = b.tv_sec;
    timeB *= 1000000000;
    timeB += b.tv_nsec;
    return timeA - timeB;
}

int get_min_from_array(int n, const int arr[]) {
    int min = arr[0];
    for (int i = 1; i < n; ++i) {
        if (arr[i] < min) {
            min = arr[i];
        }
    }
    return min;
}

int count_if_equals_element(int n, const int arr[], int element) {
    int cnt = 0;
    for (int i = 0; i < n; ++i) {
        if (arr[i] == element) {
            ++cnt;
        }
    }
    return cnt;
}

void fill_ARRAY_B(int n, int size, int element) {
    for (int i = 0, j = 0; i < n && j < size; ++i) {
        if (ARRAY_A[i] == element) {
            continue;
        }
        ARRAY_B[j] = ARRAY_A[i];
        ++j;
    }
}

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

void command_line_output(int n, int arr[]) {
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

int main (int argc, char** argv) {
    char *arg;
    int option, n, size, min;
    struct timespec start, end;
    int64_t elapsed_ns;
    // input
    if (argc > 1) {
        arg = argv[1];
        printf("arg = %s", arg);
        printf("\n");
        option = atoi(arg);
        if (option == 1) {
            if (command_line_input(&n, argv)) {
                return 1;
            }
        } else if (option == 2) {
            if (file_input(&n, "input.txt")) {
                return 1;
            }
        } else {
            random_generation(&n);
            command_line_output(n, ARRAY_A);
        }
    } else {
        printf("No arguments");
        return 0;
    }
    // timeStart
    clock_gettime(CLOCK_MONOTONIC, &start);
    // fill arrayB
    min = get_min_from_array(n, ARRAY_A);
    size = count_if_equals_element(n, ARRAY_A, min);
    size = n - size;
    fill_ARRAY_B(n, size, min);
    // timeEnd
    clock_gettime(CLOCK_MONOTONIC, &end);
    elapsed_ns = timespec_difference(end, start);
    printf("Elapsed: %ld ns", elapsed_ns);
    // output
    command_line_output(size, ARRAY_B);
    file_output(size, "output.txt");
    return 0;
}
