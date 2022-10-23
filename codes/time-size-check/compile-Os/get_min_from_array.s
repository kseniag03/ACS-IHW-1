	.file	"get_min_from_array.c"
	.text
	.globl	get_min_from_array
	.type	get_min_from_array, @function
get_min_from_array:
.LFB0:
	.cfi_startproc
	endbr64
	movl	(%rsi), %eax
	xorl	%edx, %edx
.L2:
	incq	%rdx
	cmpl	%edx, %edi
	jle	.L5
	movl	(%rsi,%rdx,4), %ecx
	cmpl	%ecx, %eax
	cmovg	%ecx, %eax
	jmp	.L2
.L5:
	ret
	.cfi_endproc
.LFE0:
	.size	get_min_from_array, .-get_min_from_array
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
