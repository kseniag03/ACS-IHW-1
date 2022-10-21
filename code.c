#include <stdio.h>
#include <stdlib.h>

void inputArray(int n, int* array) {
    for (int i = 0; i < n; ++i) {
        scanf("%d", &array[i]);
    }
}

void outputArray(int n, int* array) {
    for (int i = 0; i < n; ++i) {
        printf("%d ", array[i]);
    }
    printf("\n");
}

int getMinFromArray(int n, int* array) {
    int min = array[0];
    for (int i = 1; i < n; ++i) {
        if (array[i] < min) {
            min = array[i];
        }
    }
    return min;
}

int countIfEqualsElement(int n, int* array, int element) {
    int cnt = 0;
    for (int i = 0; i < n; ++i) {
        if (array[i] == element) {
            ++cnt;
        }
    }
    return cnt;
}

int* getNewArray(int n, int* array, int size, int element) {
    int* newArray = (int*)malloc(size * sizeof(int));
    for (int i = 0, j = 0; i < n && j < size; ++i) {
        if (array[i] == element) {
            continue;
        }
        newArray[j] = array[i];
        ++j;
    }
    return newArray;
}

int main() {
    int n;
    scanf("%d", &n);
    int* a = (int*)malloc(n * sizeof(int));
    inputArray(n, &a[0]);
    outputArray(n, &a[0]);
    int min = getMinFromArray(n, &a[0]);
    int size = n - countIfEqualsElement(n, &a[0], min);
    printf("%d\n", min);
    printf("%d\n", size);
    int* b = getNewArray(n, &a[0], size, min);
    outputArray(size, &b[0]);
    return 0;
}

// 13.
// Сформировать массив B из элементов массива A, за исключением элементов,
// значения которых совпадают с минимальным элементом массива A.
