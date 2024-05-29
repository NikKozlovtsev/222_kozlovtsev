#include <stdio.h>
#include <stdlib.h>

int main() {
    int N;
    scanf("%d", &N);

    int *array = (int *)malloc(N * sizeof(int));
    if (array == NULL) {
        return 1;
    }

    for (int i = 0; i < N; i++) {
        scanf("%d", &array[i]);
    }

    for (int i = 0; i < N / 2; i++) {
        int temp = array[i];
        array[i] = array[N - 1 - i];
        array[N - 1 - i] = temp;
    }

    for (int i = 0; i < N; i++) {
        printf("%d ", array[i]);
    }
    printf("\n");

    free(array);

    return 0;
}