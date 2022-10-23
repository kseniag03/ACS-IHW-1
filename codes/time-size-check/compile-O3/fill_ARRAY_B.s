	.file	"fill_ARRAY_B.c"
	.text
	.p2align 4
	.globl	fill_ARRAY_B
	.type	fill_ARRAY_B, @function
fill_ARRAY_B:
.LFB0:
	.cfi_startproc
	endbr64
	testl	%edi, %edi
	jle	.L1
	testl	%esi, %esi
	jle	.L1
	movl	$1, %eax
	xorl	%ecx, %ecx
	leaq	-4+ARRAY_A(%rip), %r10
	leaq	ARRAY_B(%rip), %r11
	.p2align 4,,10
	.p2align 3
.L4:
	movl	(%r10,%rax,4), %r8d
	cmpl	%edx, %r8d
	je	.L3
	movslq	%ecx, %r9
	addl	$1, %ecx
	movl	%r8d, (%r11,%r9,4)
.L3:
	cmpl	%eax, %edi
	setg	%r9b
	cmpl	%esi, %ecx
	setl	%r8b
	addq	$1, %rax
	testb	%r8b, %r9b
	jne	.L4
.L1:
	ret
	.cfi_endproc
.LFE0:
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
