	.file	"file_output.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
.LC0:
	.string	"w"
.LC1:
	.string	"%d "
	.text
	.globl	file_output
	.type	file_output, @function
file_output:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	DWORD PTR -20[rbp], edi
	mov	QWORD PTR -32[rbp], rsi
	mov	rax, QWORD PTR -32[rbp]
	lea	rdx, .LC0[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -16[rbp], rax
	cmp	QWORD PTR -16[rbp], 0
	je	.L5
	mov	DWORD PTR -4[rbp], 0
	jmp	.L3
.L4:
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	lea	rax, ARRAY_B[rip]
	mov	edx, DWORD PTR [rdx+rax]
	mov	rax, QWORD PTR -16[rbp]
	lea	rcx, .LC1[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	fprintf@PLT
	add	DWORD PTR -4[rbp], 1
.L3:
	mov	eax, DWORD PTR -4[rbp]
	cmp	eax, DWORD PTR -20[rbp]
	jl	.L4
	mov	rax, QWORD PTR -16[rbp]
	mov	rdi, rax
	call	fclose@PLT
.L5:
	nop
	leave
	ret
	.size	file_output, .-file_output
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
