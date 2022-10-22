extern int ARRAY_A[];
extern int ARRAY_B[];

void fill_ARRAY_B(int n, int size, int element) {
    for (int i = 0, j = 0; i < n && j < size; ++i) {
        if (ARRAY_A[i] == element) {
            continue;
        }
        ARRAY_B[j] = ARRAY_A[i];
        ++j;
    }
}
