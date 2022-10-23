Markdown report <br>

1. Ганина Ксения Андреевна <br>
2. БПИ212 <br>
3. В-13 <br>
![image](https://user-images.githubusercontent.com/114473740/197335272-b4a5eef8-d401-4dce-ad53-26b7bfa52687.png) <br>

должна быть прога на си, скомпелированная gcc с флагами и без них + вылизанная скомпиленная прога <br>

05 <br>
Аргументы в функцию передаются через регистры в следующем порядке: ... <br>
Возвращаемое из функции значение лежит в регистре rax (считываем результат выполнения функции из rax) <br>
при вызове функции перекладываются агрументы на стек (первый аргумент argc) <br>

06 <br>
рефакторинг -- gcc всё кидает на стек, а это не нужно, заменяем регистры, где надо (и указываем), <br>
проверяем, что всё работает так же верно, как и раньше <br>
находить эквиваленты между строками кода на си и на асме <br>

07 <br>
пишем все функции по отдельным файлам (получается несколько единиц компиляции) <br>

08 <br>
ввод данных либо из командной строки, либо из файла, либо с использованием генератора <br>
вывести время работы проги ●●

09 <br>
скомпилить с O2 (+ флагами на оптимизацию и флагами на размер), <br>
сравнить по размерам исполняемых файлов, размеру асм кода и производительности (время работы, скорость исполнения) <br>
//можно табличку: моя, без оптима, с оптимом по размеру <br>
//можно не анализировать код после полученного оптимизатора! <br>


________________________

4. Тесты, демонстрирующие проверку программ. <br>

Формат ввода данных <br>
argc -- число аргументов в функции (если > 1, значит, передали аргументы) <br>
argv -- массив с аргументами, где: <br>
argv[0] -- имя исполняемого файла <br>
argv[1] -- формат ввода (1 -- console, 2 -- file, else -- random generation) <br>
выводится в консоль и в файл "output.txt" <br>

...  <br>

5. Результаты тестовых прогонов для различных исходных данных. <br>

...  <br>

6. Исходные тексты программы на языке C. <br>


main.c -- основная функция
```c
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
```
<br>

command_line_input.c -- ввод из командной строки
```c
#include <stdio.h>
#include <stdlib.h>

extern const int SIZEMAX;

extern int ARRAY_A[];

int command_line_input(int *n, char** argv) {
    int i;
    *n = atoi(argv[2]);
    if (*n <= 0 || *n > SIZEMAX) {
        printf("The num of elems in arr must be from 1 to %d\n", SIZEMAX);
        return 1;
    }
    for (i = 0; i < *n; ++i) {
        if (argv[i + 3] == NULL) {
            printf("Not enough elems in arr\n");
            return 1;
        }
        ARRAY_A[i] = atoi(argv[i + 3]);
    }
    return 0;
}
```
<br>

command_line_output.c -- вывод в командную строку/консоль
```c
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
```
<br>

count_if_equals_element.c -- подсчёт числа эл-в массива, равных данному
```c
int count_if_equals_element(int n, const int arr[], int element) {
    int cnt = 0;
    for (int i = 0; i < n; ++i) {
        if (arr[i] == element) {
            ++cnt;
        }
    }
    return cnt;
}
```
<br>

file_input.c -- ввод данных из входного файла "input.txt"
```c
#include <stdio.h>

extern const int SIZEMAX;

extern int ARRAY_A[];

int file_input(int *n,  char *filename) {
    int i;
    FILE *file;
    if ((file = fopen(filename, "r")) == NULL) {
        printf("Unable to open file '%s'\n", filename);
        return 1;
    }
    if (fscanf(file, "%d", n) < 1) {
        printf ("Reading file '%s' error\n", filename);
        fclose(file);
        return 1;
    }
    if (*n <= 0 || *n > SIZEMAX) {
        printf("The num of elems in arr must be from 1 to %d\n", SIZEMAX);
        fclose(file);
        return 1;
    }
    for (i = 0; i < *n; ++i) {
        if (fscanf(file, "%d", &ARRAY_A[i]) < 1) {
            printf("Reading file '%s' error\n", filename);
            fclose(file);
            return 1;
        }
    }
    fclose(file);
    return 0;
}
```
<br>

file_output.c -- вывод данных в выходной файл "output.txt"
```c
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
```
<br>

fill_ARRAY_B.c -- заполнение массива B согласно условию задачи
```c
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
```
<br>

get_min_from_array.c -- получение минимума массива
```c
int get_min_from_array(int n, const int arr[]) {
    int min = arr[0];
    for (int i = 1; i < n; ++i) {
        if (arr[i] < min) {
            min = arr[i];
        }
    }
    return min;
}
```
<br>

random_generation.c -- псевдослучайная генерация исходного массива
```c
#include <stdlib.h>
#include <time.h>

extern const int SIZEMAX;
extern const int VALUEMAX;

extern int ARRAY_A[];

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
```
<br>

timespec_difference.c -- вычисление разницы по времени работы
```c
#include <time.h>
#include <stdint.h>

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
```
<br>

7. Тексты программы на языке ассемблера, разработанной вручную или полученной после компиляции и расширенной комментариями. <br>

<br>

8. Текст на ассемблере программы, полученный после компиляции программы на C. <br>

Смотреть: ACS-IHW-1/codes/generated-asm-code/ <br>

9. Информацию, подтверждающую выполнение задания в соответствие требованиям на предполагаемую оценку. <br>
<br>




Компиляция частей кода и линковка: <br>

`gcc -masm=intel \`
    `-fno-asynchronous-unwind-tables \`
    `-fno-jump-tables \`
    `-fno-stack-protector \`
    `-fno-exceptions \`
    `./main.c \`
    `-S -o ./main.s`
`gcc ./main.s -c -o ./main.o`

Аналогичные команды выполнить для всех файлов-функций: <br>
command_line_input.c <br>
command_line_output.c <br>
count_if_equals_element.c <br>
file_input.c <br>
file_output.c <br>
fill_ARRAY_B.c <br>
get_min_from_array.c <br>
random_generation.c <br>
timespec_difference.c <br>

Для линковки:
`gcc -lc main.o command_line_input.o command_line_output.o count_if_equals_element.o file_input.o file_output.o fill_ARRAY_B.o get_min_from_array.o random_generation.o timespec_difference.o -o foo.exe`

Убираем макросы: <br>
endbr64, cdqe, cdq <br>

Переписываем .section.data и названия меток (LC0, L1, etc.) для наглядности <br>


Убираем лишние присваивания: вместо  <br>
`mov	rax, QWORD PTR -8[rbp]` <br>
`mov	rdi, rax` <br>
сразу пишем <br>
`mov	rdi, QWORD PTR -8[rbp]` <br>

Изменения main: <br>
Добавилось небольшое отличие от программы на Си — вывод `elapsed_ns` после выводов массива (чтобы при генерации массивов время было видно при выводе) <br>


Переменную цикла i записываем в один из свободных регистров: <br>
DWORD PTR -4[rbp] -> r12d
