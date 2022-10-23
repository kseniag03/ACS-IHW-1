	.file	"fill_ARRAY_B.c"
	.intel_syntax noprefix
	.text
	.globl	fill_ARRAY_B
	.type	fill_ARRAY_B, @function
fill_ARRAY_B:
	endbr64
	push	rbp
	mov	rbp, rsp
	mov	DWORD PTR -20[rbp], edi
	mov	DWORD PTR -24[rbp], esi
	mov	DWORD PTR -28[rbp], edx
	mov	DWORD PTR -4[rbp], 0
	mov	DWORD PTR -8[rbp], 0
	jmp	.L2
.L6:
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	lea	rax, ARRAY_A[rip]
	mov	eax, DWORD PTR [rdx+rax]
	cmp	DWORD PTR -28[rbp], eax
	je	.L7
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	lea	rax, ARRAY_A[rip]
	mov	eax, DWORD PTR [rdx+rax]
	mov	edx, DWORD PTR -8[rbp]
	movsx	rdx, edx
	lea	rcx, 0[0+rdx*4]
	lea	rdx, ARRAY_B[rip]
	mov	DWORD PTR [rcx+rdx], eax
	add	DWORD PTR -8[rbp], 1
	jmp	.L4
.L7:
	nop
.L4:
	add	DWORD PTR -4[rbp], 1
.L2:
	mov	eax, DWORD PTR -4[rbp]
	cmp	eax, DWORD PTR -20[rbp]
	jge	.L8
	mov	eax, DWORD PTR -8[rbp]
	cmp	eax, DWORD PTR -24[rbp]
	jl	.L6
.L8:
	nop
	pop	rbp
	ret
	.size	fill_ARRAY_B, .-fill_ARRAY_B
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
