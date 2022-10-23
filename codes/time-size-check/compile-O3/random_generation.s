	.file	"random_generation.c"
	.text
	.p2align 4
	.globl	random_generation
	.type	random_generation, @function
random_generation:
.LFB16:
	.cfi_startproc
	endbr64
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movq	%rdi, %r12
	xorl	%edi, %edi
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$8, %rsp
	.cfi_def_cfa_offset 48
	call	time@PLT
	movl	%eax, %edi
	call	srand@PLT
	call	rand@PLT
	cltd
	idivl	SIZEMAX(%rip)
	testl	%edx, %edx
	jle	.L2
	movl	%edx, (%r12)
.L4:
	movl	VALUEMAX(%rip), %ebp
	xorl	%ebx, %ebx
	leaq	ARRAY_A(%rip), %r13
	.p2align 4,,10
	.p2align 3
.L3:
	call	rand@PLT
	cltd
	idivl	%ebp
	movl	%edx, 0(%r13,%rbx,4)
	addq	$1, %rbx
	cmpl	%ebx, (%r12)
	jg	.L3
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L2:
	.cfi_restore_state
	addl	$1, %edx
	movl	%edx, (%r12)
	cmpl	$1, %edx
	je	.L4
	addq	$8, %rsp
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE16:
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
