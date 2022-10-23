.intel_syntax noprefix			# intel-синтаксис
.globl main				# точка запуска main
.type main, @function			# объявление main как функции

.globl	SIZEMAX				# объявление глобальной константы
.globl	VALUEMAX			# объявление глобальной константы

.global ARRAY_A				# объявление глобального массива (входные данные)
.global ARRAY_B				# объявление глобальной массива (выходные данные)

.section .data				# секция объявления переменных 
	SIZEMAX:	.long		100000
	VALUEMAX:	.long		100000
	ARRAY_A:	.zero		400000
	ARRAY_B:	.zero		400000
	showArg:	.string		"arg = %s"
	inputFileName:	.string		"input.txt"
	outputFileName:	.string		"output.txt"
	noArg:		.string		"No arguments\n"
	elapsed:	.string		"Elapsed: %ld ns\n"

.text					# секция кода

main:					# тело main
	push	rbp				# сохраняем rbp на стек
	mov	rbp, rsp			# присваиваем rbp = rsp
	sub	rsp, 96				# rsp -= 96 (выделение памяти на стеке)

	mov	DWORD PTR -84[rbp], edi		# 1-й аргумент main — argc (в стеке на -84)
	mov	QWORD PTR -96[rbp], rsi		# 2-й аргумент main — argv (в стеке на -96)
	cmp	DWORD PTR -84[rbp], 1		# сравниваем число аргументов командной строки (argc) с 1
	jle	.NOARGS				# если argc <= 1, переходим к метке NOARGS

	lea	rdi, showArg[rip]		# 1-й аргумент для вывода варианта ввода — строка "arg = %s" (формат)
	mov	rax, QWORD PTR -96[rbp]		# rax := argv
	mov	rax, QWORD PTR 8[rax]		# rax := argv[1]
	mov	QWORD PTR -8[rbp], rax		# arg := rax
	mov	rsi, QWORD PTR -8[rbp]		# 2-й аргумент для вывода варианта ввода — arg
	call	printf@PLT			# вызов функции печати для вывода ответа, т.е. printf("arg = %s", arg)
	mov	edi, 10				# 1-й аргумент для функции печати символа — перевод строки (код 10)
	call	putchar@PLT			# вызов функции печати символа перевода строки, т.е. printf("\n")

	mov	rdi, QWORD PTR -8[rbp]		# 1-й аргумент для функции перевода в int — arg
	call	atoi@PLT			# вызов функции atoi для перевода в аргумент типа int, т.е. atoi(argv[1])
	mov	DWORD PTR -12[rbp], eax		# option := eax (результат выполнения функции atoi(argv[1]))

	cmp	DWORD PTR -12[rbp], 1		# сравниваем option с 1
	jne	.FILEINPUT			# если option не равен 1, переходим к метке FILEINPUT

	lea	rdi, -36[rbp]			# rdi := -36 на стеке, т.е. 1-й аргумент для ввода из командной строки — &n
	mov	rsi, QWORD PTR -96[rbp]		# 2-й аргумент для ввода из командной строки — argv
	call	command_line_input@PLT		# вызов функции ввода данных из командной строки, т.е. command_line_input(&n, argv)

	test	eax, eax			# проверяется код возврата (логическое сравнение)
	je	.FILLARRAYB			# если равны, переход к метке FILLARRAYB (если command_line_input не завершился с ошибкой и вернул 0)
	mov	eax, 1				# иначе return 1

	jmp	.EXIT				# переход к метке EXIT

.FILEINPUT:				# ввод из файла
	cmp	DWORD PTR -12[rbp], 2		# сравниваем option с 2
	jne	.RANDOM				# если option не равен 2, переходим к метке RANDOM

	lea	rdi, -36[rbp]			# 1-й аргумент для ввода из файла — &n
	lea	rsi, inputFileName[rip]		# 2-й аргумент для ввода из файла — "input.txt"
	call	file_input@PLT			# вызов функции ввода данных из файла, т.е. file_input(&n, "input.txt")

	test	eax, eax			# проверяется код возврата (логическое сравнение)
	je	.FILLARRAYB			# если равны, переход к метке FILLARRAYB (если file_input не завершился с ошибкой и вернул 0)
	mov	eax, 1				# иначе return 1

	jmp	.EXIT				# переход к метке EXIT

.RANDOM:				# псевдослучайная генерация массива
	lea	rdi, -36[rbp]			# 1-й аргумент для генерации — &n
	call	random_generation@PLT		# вызов функции случайной генерации массива, т.е. random_generation(&n);

	mov	edi, DWORD PTR -36[rbp]		# 1-й аргумент для вывода — &n
	lea	rsi, ARRAY_A[rip]		# 2-й аргумент для вывода — сгенерированный исходный массив 
	call	command_line_output@PLT		# вызов функции вывода исходного сгенерированного массива, т.е. command_line_output(n, ARRAY_A)

	jmp	.FILLARRAYB			# переход к метке FILLARRAYB

.NOARGS:				# недостаточно аргументов в командной строке для работы программы
	lea	rdi, noArg[rip]			# 1-й аргумент для вывода сообщения — строка "No arguments"
	call	printf@PLT			# вызов функции печати для вывода ответа, т.е. printf("No arguments\n")
	mov	eax, 0				# return 0

	jmp	.EXIT				# переход к метке EXIT

.FILLARRAYB:
	mov	edi, 1				# 1-й аргумент для запуска счётчика — 1 (CLOCK_MONOTONIC)
	lea	rsi, -64[rbp]			# 2-й аргумент для запуска счётчика — &start
	call	clock_gettime@PLT		# вызов функции подсчёта времени до заполнения массива B, т.е. clock_gettime(CLOCK_MONOTONIC, &start)

	mov	edi, DWORD PTR -36[rbp]		# 1-й аргумент для поиска минимума — n
	lea	rsi, ARRAY_A[rip]		# 2-й аргумент для поиска минимума — ARRAY_A
	call	get_min_from_array@PLT		# вызов функции поиска минимума, т.е. get_min_from_array(n, ARRAY_A);
	mov	DWORD PTR -16[rbp], eax		# min := результат функции get_min_from_array (в стеке на -16)

	mov	edi, DWORD PTR -36[rbp]		# 1-й аргумент для подсчёта — n
	lea	rsi, ARRAY_A[rip]		# 2-й аргумент для подсчёта — ARRAY_A
	mov	edx, DWORD PTR -16[rbp]		# 3-й аргумент для поиска минимума — min
	call	count_if_equals_element@PLT	# вызов функции ..., т.е. count_if_equals_element(n, ARRAY_A, min);
	mov	DWORD PTR -20[rbp], eax		# size := результат функции count_if_equals_element (в стеке на -20)

	mov	eax, DWORD PTR -36[rbp]		# eax := n
	sub	eax, DWORD PTR -20[rbp]		# eax := n - size
	mov	DWORD PTR -20[rbp], eax		# size := eax

	mov	edi, DWORD PTR -36[rbp]		# 1-й аргумент для заполнения — n
	mov	esi, DWORD PTR -20[rbp]		# 2-й аргумент для заполнения — size
	mov	edx, DWORD PTR -16[rbp]		# 3-й аргумент для заполнения — min
	call	fill_ARRAY_B@PLT		# вызов функции заполнения массива B, т.е. fill_ARRAY_B(n, size, min)

	mov	edi, 1				# 1-й аргумент для запуска счётчика — 1 (CLOCK_MONOTONIC)
	lea	rsi, -80[rbp]			# 2-й аргумент для запуска счётчика — &end
	call	clock_gettime@PLT		# вызов функции подсчёта времени до вывода, т.е. clock_gettime(CLOCK_MONOTONIC, &end)

	mov	rdi, QWORD PTR -80[rbp]		# 1-й аргумент для подсчёта времени — ///
	mov	rsi, QWORD PTR -72[rbp]		# 2-й аргумент для подсчёта времени — ///
	mov	rdx, QWORD PTR -64[rbp]		# 3-й аргумент для подсчёта времени — ///
	mov	rcx, QWORD PTR -56[rbp]		# 4-й аргумент для подсчёта времени — ///
	call	timespec_difference@PLT		# вызов функции для вычисления времени заполнения массива B, т.е. timespec_difference(end, start) (4 аргумента, т.к. передаются структуры с 2-мя полями)
	mov	QWORD PTR -32[rbp], rax		# elapsed_ns := rax (результат выполнения функции timespec_difference)

	mov	edi, DWORD PTR -20[rbp]		# 1-й аргумент для вывода — size
	lea	rsi, ARRAY_B[rip]		# 2-й аргумент для вывода — ARRAY_B
	call	command_line_output@PLT		# вызов функции вывода полученного массива, т.е. command_line_output(size, ARRAY_B)

	mov	edi, DWORD PTR -20[rbp]		# 1-й аргумент для вывода — size
	lea	rsi, outputFileName[rip]	# 2-й аргумент для вывода — "output.txt"
	call	file_output@PLT			# вызов функции вывода полученного массива в выходной файл, т.е. file_output(size, "output.txt")

	lea	rdi, elapsed[rip]		# 1-й аргумент для вывода времени — строка "Elapsed: %ld ns\n"
	mov	rsi, QWORD PTR -32[rbp]		# 2-й аргумент для вывода времени — elapsed_ns
	call	printf@PLT			# вызов функции печати для вывода ответа, т.е. printf("Elapsed: %ld ns\n", elapsed_ns)

	mov	eax, 0				# return 0

.EXIT:					# выход из программы
	leave					# освобождает стек на выходе из функции main
	ret					# выполняется выход из программы
