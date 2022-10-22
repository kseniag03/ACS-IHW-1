int count_if_equals_element(int n, const int arr[], int element) {
    int cnt = 0;
    for (int i = 0; i < n; ++i) {
        if (arr[i] == element) {
            ++cnt;
        }
    }
    return cnt;
}
