.intel_syntax noprefix			# intel-синтаксис
.globl command_line_output		# точка запуска command_line_output
.type command_line_output, @function	# объявление command_line_output как функции

.section .data				# секция объявления переменных
	bracket:	.string		"[ "
	frmtnum:	.string		"%d "

.text					# секция кода

command_line_output:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	DWORD PTR -20[rbp], edi
	mov	QWORD PTR -32[rbp], rsi
	lea	rax, bracket[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	DWORD PTR -4[rbp], 0
	jmp	.L2
.L3:
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -32[rbp]
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	mov	esi, eax
	lea	rax, frmtnum[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	add	DWORD PTR -4[rbp], 1
.L2:
	mov	eax, DWORD PTR -4[rbp]
	cmp	eax, DWORD PTR -20[rbp]
	jl	.L3
	mov	edi, 93
	call	putchar@PLT
	mov	edi, 10
	call	putchar@PLT
	leave
	ret
