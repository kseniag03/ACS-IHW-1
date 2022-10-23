	.file	"count_if_equals_element.c"
	.text
	.globl	count_if_equals_element
	.type	count_if_equals_element, @function
count_if_equals_element:
.LFB0:
	.cfi_startproc
	endbr64
	xorl	%eax, %eax
	xorl	%r8d, %r8d
.L2:
	cmpl	%eax, %edi
	jle	.L6
	cmpl	%edx, (%rsi,%rax,4)
	jne	.L3
	incl	%r8d
.L3:
	incq	%rax
	jmp	.L2
.L6:
	movl	%r8d, %eax
	ret
	.cfi_endproc
.LFE0:
	.size	count_if_equals_element, .-count_if_equals_element
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
