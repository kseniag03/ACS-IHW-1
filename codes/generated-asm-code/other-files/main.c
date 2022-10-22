#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdint.h>

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
const int VALUEMAX = 100000;

int ARRAY_A[100000];
int ARRAY_B[100000];

int main (int argc, char** argv) {
    char *arg;
    int option, n, size, min;
    struct timespec start, end;
    int64_t elapsed_ns;
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
        printf("No arguments\n");
        return 0;
    }
    clock_gettime(CLOCK_MONOTONIC, &start);
    min = get_min_from_array(n, ARRAY_A);
    size = count_if_equals_element(n, ARRAY_A, min);
    size = n - size;
    fill_ARRAY_B(n, size, min);
    clock_gettime(CLOCK_MONOTONIC, &end);
    elapsed_ns = timespec_difference(end, start);
    printf("Elapsed: %ld ns\n", elapsed_ns);
    command_line_output(size, ARRAY_B);
    file_output(size, "output.txt");
    return 0;
}
