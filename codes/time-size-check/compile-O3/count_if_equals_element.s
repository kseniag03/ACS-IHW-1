	.file	"count_if_equals_element.c"
	.text
	.p2align 4
	.globl	count_if_equals_element
	.type	count_if_equals_element, @function
count_if_equals_element:
.LFB0:
	.cfi_startproc
	endbr64
	movl	%edi, %ecx
	testl	%edi, %edi
	jle	.L11
	leal	-1(%rdi), %eax
	cmpl	$2, %eax
	jbe	.L12
	shrl	$2, %edi
	movd	%edx, %xmm3
	pxor	%xmm0, %xmm0
	movq	%rsi, %rax
	subl	$1, %edi
	pshufd	$0, %xmm3, %xmm2
	salq	$4, %rdi
	leaq	16(%rsi,%rdi), %rdi
	.p2align 4,,10
	.p2align 3
.L4:
	movdqu	(%rax), %xmm1
	addq	$16, %rax
	pcmpeqd	%xmm2, %xmm1
	psubd	%xmm1, %xmm0
	cmpq	%rax, %rdi
	jne	.L4
	movdqa	%xmm0, %xmm1
	movl	%ecx, %edi
	psrldq	$8, %xmm1
	andl	$-4, %edi
	paddd	%xmm1, %xmm0
	movdqa	%xmm0, %xmm1
	psrldq	$4, %xmm1
	paddd	%xmm1, %xmm0
	movd	%xmm0, %eax
	testb	$3, %cl
	je	.L15
.L3:
	movslq	%edi, %r8
	leaq	0(,%r8,4), %r9
	cmpl	%edx, (%rsi,%r8,4)
	je	.L16
.L7:
	leal	1(%rdi), %r8d
	cmpl	%ecx, %r8d
	jge	.L1
	cmpl	4(%rsi,%r9), %edx
	je	.L17
.L8:
	addl	$2, %edi
	cmpl	%edi, %ecx
	jle	.L1
	cmpl	8(%rsi,%r9), %edx
	je	.L18
.L1:
	ret
	.p2align 4,,10
	.p2align 3
.L16:
	addl	$1, %eax
	jmp	.L7
	.p2align 4,,10
	.p2align 3
.L17:
	addl	$1, %eax
	jmp	.L8
	.p2align 4,,10
	.p2align 3
.L15:
	ret
	.p2align 4,,10
	.p2align 3
.L18:
	addl	$1, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L11:
	xorl	%eax, %eax
	ret
.L12:
	xorl	%edi, %edi
	xorl	%eax, %eax
	jmp	.L3
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
