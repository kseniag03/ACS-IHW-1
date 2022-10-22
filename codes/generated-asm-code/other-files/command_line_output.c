#include <stdio.h>

void command_line_output(int n, int arr[]) {
    int i;
    printf("[ ");
    for (i = 0; i < n; ++i) {
        printf("%d ", arr[i]);
    }
    printf("]");
    printf("\n");
}
