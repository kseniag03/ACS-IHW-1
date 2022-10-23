	.file	"fill_ARRAY_B.c"
	.text
	.globl	fill_ARRAY_B
	.type	fill_ARRAY_B, @function
fill_ARRAY_B:
.LFB0:
	.cfi_startproc
	endbr64
	xorl	%ecx, %ecx
	xorl	%eax, %eax
	leaq	ARRAY_A(%rip), %r9
	leaq	ARRAY_B(%rip), %r10
.L2:
	cmpl	%ecx, %edi
	jle	.L1
	cmpl	%esi, %eax
	jge	.L1
	movl	(%r9,%rcx,4), %r8d
	cmpl	%edx, %r8d
	je	.L3
	movslq	%eax, %r11
	incl	%eax
	movl	%r8d, (%r10,%r11,4)
.L3:
	incq	%rcx
	jmp	.L2
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
