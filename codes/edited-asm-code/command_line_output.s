.intel_syntax noprefix			# intel-синтаксис
.globl command_line_output		# точка запуска command_line_output
.type command_line_output, @function	# объявление command_line_output как функции

.section .data				# секция объявления переменных
	bracket:	.string		"[ "
	frmtnum:	.string		"%d "

.text					# секция кода

command_line_output:
	push	rbp				# сохраняем rbp на стек
	mov	rbp, rsp			# присваиваем rbp = rsp
	sub	rsp, 32				# rsp -= 32 (выделение памяти на стеке)
	mov	DWORD PTR -20[rbp], edi		# 1-й аргумент command_line_output — int n (в стеке на -20)
	mov	QWORD PTR -32[rbp], rsi		# 2-й аргумент command_line_output — int arr[] (в стеке на -32)
	
	lea	rdi, bracket[rip]		# rdi := "[ " (1-й аргумент функции)
	call	printf@PLT			# printf("[ ")
	mov	r12d, 0				# i = 0
	jmp	.LOOP				# переход к LOOP
	
.PRINTELEM:
	mov	eax, r12d			# eax := i
	lea	rdx, 0[0 + rax * 4]		# rdx := rax * 4
	mov	rax, QWORD PTR -32[rbp]		# rax := n	
	add	rax, rdx			# rax := arr[i]
	
	lea	rdi, frmtnum[rip]		# rdi := "%d " (1-й аргумент функции)
	mov	esi, DWORD PTR [rax]		# esi := arr[i] (2-й аргумент функции)
	call	printf@PLT			# printf("%d ", arr[i])
	add	r12d, 1				# ++i
	
.LOOP:
	cmp	r12d, DWORD PTR -20[rbp]	# сравнение i и n
	jl	.PRINTELEM			# если i < n, переход в PRINTELEM
	
	mov	edi, 93				# передача 1-го аргумента в функцию
	call	putchar@PLT			# выводит символ ']' (номер 93), т.е. printf("]")
	mov	edi, 10				# передача 1-го аргумента в функцию		
	call	putchar@PLT			# выводит символ перевода строки (номер 10), т.е. printf("\n")
	
	leave					# освобождает стек на выходе из функции main
	ret					# выполняется выход из программы
