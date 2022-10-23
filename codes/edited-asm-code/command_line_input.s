.intel_syntax noprefix			# intel-синтаксис
.globl command_line_input		# точка запуска command_line_input
.type command_line_input, @function	# объявление command_line_input как функции

.section .data				# секция объявления переменных
	wrongElemsNum:	.string		"The num of elems in arr must be from 1 to %d\n"
	notEnough:	.string		"Not enough elems in arr\n"

.text					# секция кода

command_line_input:			# тело command_line_input
	push	rbp					# сохраняем rbp на стек
	mov	rbp, rsp				# присваиваем rbp = rsp
	sub	rsp, 32					# rsp -= 32 (выделение памяти на стеке)

	mov	QWORD PTR -24[rbp], rdi			# 1-й аргумент command_line_input — int *n (в стеке на -24)
	mov	QWORD PTR -32[rbp], rsi			# 2-й аргумент command_line_input — char** argv (в стеке на -32)

	mov	rax, QWORD PTR -32[rbp]			# rax := argv
	mov	rdi, QWORD PTR [rax + 16]		# rdi := argv[2] (1-й аргумент функции)
	call	atoi@PLT				# вызов функции atoi для перевода в аргумент типа int, т.е. atoi(argv[2])

	mov	rdx, QWORD PTR -24[rbp]			# rdx := *n
	mov	DWORD PTR [rdx], eax			# n := результат вызова функции atoi
	mov	eax, DWORD PTR [rdx]			# eax := n
	cmp	eax, 0					# сравнение n и 0
	jle	.WRONGN					# если n <= 0, переходим к метке WRONGN
	cmp	eax, SIZEMAX[rip]			# иначе сравниваем n и SIZEMAX
	jle	.BEFORELOOP				# если n <= SIZEMAX, переходим к метке BEFORELOOP

.WRONGN:				# введен неверный размер массива
	lea	rdi, wrongElemsNum[rip]			# 1-й аргумент функции — строка "The num of elems in arr must be from 1 to %d\n"
	mov	esi, SIZEMAX[rip]			# 2-й аргумент функции — константа SIZEMAX 
	call	printf@PLT				# вызов функции печати для вывода сообщения об ошибке, т.е. printf("The num of elems in arr must be from 1 to %d\n", SIZEMAX)		

	mov	eax, 1					# return 1
	jmp	.EXIT					# переход к метке EXIT

.BEFORELOOP:				# объявляем индекс перед циклом
	mov	r12d, 0					# i := 0 (в свободном регистре r12)
	jmp	.LOOPFOR				# переход к метке LOOPFOR

.CHECKINPUTELEMS:
	mov	eax, r12d				# eax := i
	add	rax, 3					# rax += 3
	lea	rdx, 0[0 + rax * 8]			# rdx := (rax + 3) * 8

	mov	rax, QWORD PTR -32[rbp]			# rax := argv
	add	rax, rdx				# rax += rdx
	mov	rax, QWORD PTR [rax]			# rax := argv[i + 3]

	test	rax, rax				# логическое сравнене — проверка, является ли элемент NULL
	jne	.ARRAYELEMS				# если не NULL, переход к метке ARRAYELEMS

	lea	rdi, notEnough[rip]			# 1-й аргумент функции — строка "Not enough elems in arr\n"
	call	printf@PLT				# вызов функции печати для вывода сообщения об ошибке, т.е. printf("Not enough elems in arr\n")

	mov	eax, 1 					# return 1;
	jmp	.EXIT					# переход к метке EXIT

.ARRAYELEMS:
	mov	eax, r12d				# eax := i
	add	rax, 3					# rax += 3
	lea	rdx, 0[0 + rax * 8]			# rdx := (rax + 3) * 8

	mov	rax, QWORD PTR -32[rbp]			# rax := argv
	add	rax, rdx				# rax += rdx
	mov	rdi, QWORD PTR [rax]			# rdi := argv[i + 3] (1-й аргумент функции)
	call	atoi@PLT				# вызов функции atoi для перевода в аргумент типа int, т.е. atoi(argv[i + 3])

	movsx	rdx, r12d				# в rdx копируется r12d
	lea	rcx, 0[0 + rdx * 4]			# rcx := rdx * 4
	lea	rdx, ARRAY_A[rip]			# rdx := &ARRAY_A[rip]
	mov	DWORD PTR [rcx + rdx], eax		# *(rcx + rdx) = eax
	add	r12d, 1					# ++i

.LOOPFOR:				# цикл for по i
	mov	rax, QWORD PTR -24[rbp]			# rax := *n
	mov	eax, DWORD PTR [rax]			# eax := n
	cmp	r12d, eax				# сравниваем i c n
	jl	.CHECKINPUTELEMS			# если i < n, переход к метке CHECKINPUTELEMS
	mov	eax, 0					# return 0

.EXIT:					# выход из программы
	leave					# освобождает стек на выходе из функции main
	ret					# выполняется выход из программы
