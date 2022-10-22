	.file	"command_line_input.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
	.align 8
.LC0:
	.string	"The num of elems in arr must be from 1 to %d\n"
.LC1:
	.string	"Not enough elems in arr"
	.text
	.globl	command_line_input
	.type	command_line_input, @function
command_line_input:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi
	mov	QWORD PTR -32[rbp], rsi
	mov	rax, QWORD PTR -32[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	mov	rdx, QWORD PTR -24[rbp]
	mov	DWORD PTR [rdx], eax
	mov	rax, QWORD PTR -24[rbp]
	mov	eax, DWORD PTR [rax]
	test	eax, eax
	jle	.L2
	mov	rax, QWORD PTR -24[rbp]
	mov	edx, DWORD PTR [rax]
	mov	eax, DWORD PTR SIZEMAX[rip]
	cmp	edx, eax
	jle	.L3
.L2:
	mov	eax, DWORD PTR SIZEMAX[rip]
	mov	esi, eax
	lea	rax, .LC0[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	eax, 1
	jmp	.L4
.L3:
	mov	DWORD PTR -4[rbp], 0
	jmp	.L5
.L7:
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	add	rax, 3
	lea	rdx, 0[0+rax*8]
	mov	rax, QWORD PTR -32[rbp]
	add	rax, rdx
	mov	rax, QWORD PTR [rax]
	test	rax, rax
	jne	.L6
	lea	rax, .LC1[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	eax, 1
	jmp	.L4
.L6:
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	add	rax, 3
	lea	rdx, 0[0+rax*8]
	mov	rax, QWORD PTR -32[rbp]
	add	rax, rdx
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	mov	edx, DWORD PTR -4[rbp]
	movsx	rdx, edx
	lea	rcx, 0[0+rdx*4]
	lea	rdx, ARRAY_A[rip]
	mov	DWORD PTR [rcx+rdx], eax
	add	DWORD PTR -4[rbp], 1
.L5:
	mov	rax, QWORD PTR -24[rbp]
	mov	eax, DWORD PTR [rax]
	cmp	DWORD PTR -4[rbp], eax
	jl	.L7
	mov	eax, 0
.L4:
	leave
	ret
	.size	command_line_input, .-command_line_input
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
