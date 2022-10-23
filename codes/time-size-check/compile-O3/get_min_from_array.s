	.file	"get_min_from_array.c"
	.text
	.p2align 4
	.globl	get_min_from_array
	.type	get_min_from_array, @function
get_min_from_array:
.LFB0:
	.cfi_startproc
	endbr64
	movl	(%rsi), %eax
	movl	%edi, %r8d
	movq	%rsi, %rdx
	cmpl	$1, %edi
	jle	.L1
	leal	-2(%rdi), %ecx
	leal	-1(%rdi), %esi
	cmpl	$2, %ecx
	jbe	.L7
	movl	%esi, %ecx
	movd	%eax, %xmm4
	leaq	4(%rdx), %rax
	shrl	$2, %ecx
	pshufd	$0, %xmm4, %xmm0
	subl	$1, %ecx
	salq	$4, %rcx
	leaq	20(%rdx,%rcx), %rcx
	.p2align 4,,10
	.p2align 3
.L4:
	movdqu	(%rax), %xmm1
	movdqu	(%rax), %xmm3
	addq	$16, %rax
	pcmpgtd	%xmm0, %xmm1
	pand	%xmm1, %xmm0
	pandn	%xmm3, %xmm1
	por	%xmm1, %xmm0
	cmpq	%rcx, %rax
	jne	.L4
	movdqa	%xmm0, %xmm2
	movl	%esi, %edi
	psrldq	$8, %xmm2
	andl	$-4, %edi
	movdqa	%xmm2, %xmm1
	leal	1(%rdi), %ecx
	pcmpgtd	%xmm0, %xmm1
	pand	%xmm1, %xmm0
	pandn	%xmm2, %xmm1
	por	%xmm1, %xmm0
	movdqa	%xmm0, %xmm2
	psrldq	$4, %xmm2
	movdqa	%xmm2, %xmm1
	pcmpgtd	%xmm0, %xmm1
	pand	%xmm1, %xmm0
	pandn	%xmm2, %xmm1
	por	%xmm0, %xmm1
	movd	%xmm1, %eax
	cmpl	%edi, %esi
	je	.L10
.L3:
	movslq	%ecx, %rsi
	leaq	0(,%rsi,4), %rdi
	movl	(%rdx,%rsi,4), %esi
	cmpl	%esi, %eax
	cmovg	%esi, %eax
	leal	1(%rcx), %esi
	cmpl	%esi, %r8d
	jle	.L1
	movl	4(%rdx,%rdi), %esi
	cmpl	%esi, %eax
	cmovg	%esi, %eax
	addl	$2, %ecx
	cmpl	%ecx, %r8d
	jle	.L1
	movl	8(%rdx,%rdi), %edx
	cmpl	%edx, %eax
	cmovg	%edx, %eax
.L1:
	ret
	.p2align 4,,10
	.p2align 3
.L10:
	ret
.L7:
	movl	$1, %ecx
	jmp	.L3
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
