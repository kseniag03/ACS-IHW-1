	.file	"random_generation.c"
	.text
	.globl	random_generation
	.type	random_generation, @function
random_generation:
.LFB11:
	.cfi_startproc
	endbr64
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	leaq	ARRAY_A(%rip), %r12
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rdi, %rbp
	xorl	%edi, %edi
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	call	time@PLT
	movl	%eax, %edi
	call	srand@PLT
	call	rand@PLT
	cltd
	idivl	SIZEMAX(%rip)
	testl	%edx, %edx
	leal	1(%rdx), %eax
	cmovle	%eax, %edx
	xorl	%ebx, %ebx
	movl	%edx, 0(%rbp)
.L4:
	cmpl	%ebx, 0(%rbp)
	jle	.L8
	call	rand@PLT
	cltd
	idivl	VALUEMAX(%rip)
	movl	%edx, (%r12,%rbx,4)
	incq	%rbx
	jmp	.L4
.L8:
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE11:
	.size	random_generation, .-random_generation
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
