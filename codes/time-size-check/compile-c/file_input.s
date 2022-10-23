	.file	"file_input.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
.LC0:
	.string	"r"
.LC1:
	.string	"Unable to open file '%s'\n"
.LC2:
	.string	"%d"
.LC3:
	.string	"Reading file '%s' error\n"
	.align 8
.LC4:
	.string	"The num of elems in arr must be from 1 to %d\n"
	.text
	.globl	file_input
	.type	file_input, @function
file_input:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi
	mov	QWORD PTR -32[rbp], rsi
	mov	rax, QWORD PTR -32[rbp]
	lea	rdx, .LC0[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -16[rbp], rax
	cmp	QWORD PTR -16[rbp], 0
	jne	.L2
	mov	rax, QWORD PTR -32[rbp]
	mov	rsi, rax
	lea	rax, .LC1[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	eax, 1
	jmp	.L3
.L2:
	mov	rdx, QWORD PTR -24[rbp]
	mov	rax, QWORD PTR -16[rbp]
	lea	rcx, .LC2[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	test	eax, eax
	jg	.L4
	mov	rax, QWORD PTR -32[rbp]
	mov	rsi, rax
	lea	rax, .LC3[rip]
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
	lea	rax, .LC4[rip]
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
	lea	rcx, .LC2[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	test	eax, eax
	jg	.L8
	mov	rax, QWORD PTR -32[rbp]
	mov	rsi, rax
	lea	rax, .LC3[rip]
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
	.size	file_input, .-file_input
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
