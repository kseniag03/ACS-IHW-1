.intel_syntax noprefix			# intel-синтаксис
.globl file_input			# точка запуска file_input
.type file_input, @function		# объявление file_input как функции

.section .data				# секция объявления переменных
	readFile:	.string		"r"
	notOpenFile:	.string		"Unable to open file '%s'\n"
	frmtnum:	.string		"%d"
	readFileError:	.string		"Reading file '%s' error\n"
	wrongElemsNum:	.string		"The num of elems in arr must be from 1 to %d\n"

.text					# секция кода

file_input:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi
	mov	QWORD PTR -32[rbp], rsi
	mov	rax, QWORD PTR -32[rbp]
	lea	rdx, readFile[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -16[rbp], rax
	cmp	QWORD PTR -16[rbp], 0
	jne	.L2
	mov	rax, QWORD PTR -32[rbp]
	mov	rsi, rax
	lea	rax, notOpenFile[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	eax, 1
	jmp	.L3
.L2:
	mov	rdx, QWORD PTR -24[rbp]
	mov	rax, QWORD PTR -16[rbp]
	lea	rcx, frmtnum[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	test	eax, eax
	jg	.L4
	mov	rax, QWORD PTR -32[rbp]
	mov	rsi, rax
	lea	rax, readFileError[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	rax, QWORD PTR -16[rbp]
	mov	rdi, rax
	call	fclose@PLT
	mov	eax, 1
	jmp	.L3
.L4:
	mov	rax, QWORD PTR -24[rbp]
	mov	eax, DWORD PTR [rax]
	test	eax, eax
	jle	.L5
	mov	rax, QWORD PTR -24[rbp]
	mov	edx, DWORD PTR [rax]
	mov	eax, DWORD PTR SIZEMAX[rip]
	cmp	edx, eax
	jle	.L6
.L5:
	mov	eax, DWORD PTR SIZEMAX[rip]
	mov	esi, eax
	lea	rax, wrongElemsNum[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	rax, QWORD PTR -16[rbp]
	mov	rdi, rax
	call	fclose@PLT
	mov	eax, 1
	jmp	.L3
.L6:
	mov	DWORD PTR -4[rbp], 0
	jmp	.L7
.L9:
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	lea	rax, ARRAY_A[rip]
	add	rdx, rax
	mov	rax, QWORD PTR -16[rbp]
	lea	rcx, frmtnum[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	test	eax, eax
	jg	.L8
	mov	rax, QWORD PTR -32[rbp]
	mov	rsi, rax
	lea	rax, readFileError[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	rax, QWORD PTR -16[rbp]
	mov	rdi, rax
	call	fclose@PLT
	mov	eax, 1
	jmp	.L3
.L8:
	add	DWORD PTR -4[rbp], 1
.L7:
	mov	rax, QWORD PTR -24[rbp]
	mov	eax, DWORD PTR [rax]
	cmp	DWORD PTR -4[rbp], eax
	jl	.L9
	mov	rax, QWORD PTR -16[rbp]
	mov	rdi, rax
	call	fclose@PLT
	mov	eax, 0
.L3:
	leave
	ret
