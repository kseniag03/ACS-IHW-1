	.file	"main.c"
	.intel_syntax noprefix
	.text
	.globl	SIZEMAX
	.section	.rodata
	.align 4
	.type	SIZEMAX, @object
	.size	SIZEMAX, 4
SIZEMAX:
	.long	100000
	.globl	VALUEMAX
	.align 4
	.type	VALUEMAX, @object
	.size	VALUEMAX, 4
VALUEMAX:
	.long	100000
	.globl	ARRAY_A
	.bss
	.align 32
	.type	ARRAY_A, @object
	.size	ARRAY_A, 400000
ARRAY_A:
	.zero	400000
	.globl	ARRAY_B
	.align 32
	.type	ARRAY_B, @object
	.size	ARRAY_B, 400000
ARRAY_B:
	.zero	400000
	.section	.rodata
.LC0:
	.string	"arg = %s"
.LC1:
	.string	"input.txt"
.LC2:
	.string	"No arguments"
.LC3:
	.string	"Elapsed: %ld ns\n"
.LC4:
	.string	"output.txt"
	.text
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 96
	mov	DWORD PTR -84[rbp], edi
	mov	QWORD PTR -96[rbp], rsi
	cmp	DWORD PTR -84[rbp], 1
	jle	.L2
	mov	rax, QWORD PTR -96[rbp]
	mov	rax, QWORD PTR 8[rax]
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -8[rbp]
	mov	rsi, rax
	lea	rax, .LC0[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	edi, 10
	call	putchar@PLT
	mov	rax, QWORD PTR -8[rbp]
	mov	rdi, rax
	call	atoi@PLT
	mov	DWORD PTR -12[rbp], eax
	cmp	DWORD PTR -12[rbp], 1
	jne	.L3
	mov	rdx, QWORD PTR -96[rbp]
	lea	rax, -36[rbp]
	mov	rsi, rdx
	mov	rdi, rax
	call	command_line_input@PLT
	test	eax, eax
	je	.L4
	mov	eax, 1
	jmp	.L7
.L3:
	cmp	DWORD PTR -12[rbp], 2
	jne	.L6
	lea	rax, -36[rbp]
	lea	rdx, .LC1[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	file_input@PLT
	test	eax, eax
	je	.L4
	mov	eax, 1
	jmp	.L7
.L6:
	lea	rax, -36[rbp]
	mov	rdi, rax
	call	random_generation@PLT
	mov	eax, DWORD PTR -36[rbp]
	lea	rdx, ARRAY_A[rip]
	mov	rsi, rdx
	mov	edi, eax
	call	command_line_output@PLT
	jmp	.L4
.L2:
	lea	rax, .LC2[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	eax, 0
	jmp	.L7
.L4:
	lea	rax, -64[rbp]
	mov	rsi, rax
	mov	edi, 1
	call	clock_gettime@PLT
	mov	eax, DWORD PTR -36[rbp]
	lea	rdx, ARRAY_A[rip]
	mov	rsi, rdx
	mov	edi, eax
	call	get_min_from_array@PLT
	mov	DWORD PTR -16[rbp], eax
	mov	eax, DWORD PTR -36[rbp]
	mov	edx, DWORD PTR -16[rbp]
	lea	rcx, ARRAY_A[rip]
	mov	rsi, rcx
	mov	edi, eax
	call	count_if_equals_element@PLT
	mov	DWORD PTR -20[rbp], eax
	mov	eax, DWORD PTR -36[rbp]
	sub	eax, DWORD PTR -20[rbp]
	mov	DWORD PTR -20[rbp], eax
	mov	eax, DWORD PTR -36[rbp]
	mov	edx, DWORD PTR -16[rbp]
	mov	ecx, DWORD PTR -20[rbp]
	mov	esi, ecx
	mov	edi, eax
	call	fill_ARRAY_B@PLT
	lea	rax, -80[rbp]
	mov	rsi, rax
	mov	edi, 1
	call	clock_gettime@PLT
	mov	rax, QWORD PTR -64[rbp]
	mov	rdx, QWORD PTR -56[rbp]
	mov	rdi, QWORD PTR -80[rbp]
	mov	rsi, QWORD PTR -72[rbp]
	mov	rcx, rdx
	mov	rdx, rax
	call	timespec_difference@PLT
	mov	QWORD PTR -32[rbp], rax
	mov	eax, DWORD PTR -20[rbp]
	lea	rdx, ARRAY_B[rip]
	mov	rsi, rdx
	mov	edi, eax
	call	command_line_output@PLT
	mov	eax, DWORD PTR -20[rbp]
	lea	rdx, .LC4[rip]
	mov	rsi, rdx
	mov	edi, eax
	call	file_output@PLT
	mov	rax, QWORD PTR -32[rbp]
	mov	rsi, rax
	lea	rax, .LC3[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	eax, 0
.L7:
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
