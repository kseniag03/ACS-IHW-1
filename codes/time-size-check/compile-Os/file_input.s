	.file	"file_input.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"r"
.LC1:
	.string	"Unable to open file '%s'\n"
.LC2:
	.string	"%d"
.LC3:
	.string	"Reading file '%s' error\n"
.LC4:
	.string	"The num of elems in arr must be from 1 to %d\n"
	.text
	.globl	file_input
	.type	file_input, @function
file_input:
.LFB13:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%rsi, %r12
	leaq	.LC0(%rip), %rsi
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	movq	%r12, %rdi
	pushq	%rcx
	.cfi_def_cfa_offset 64
	call	fopen@PLT
	testq	%rax, %rax
	jne	.L2
	movq	%r12, %rdx
	leaq	.LC1(%rip), %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L13
.L2:
	leaq	.LC2(%rip), %r15
	movq	%rax, %rbp
	movq	%rax, %rdi
	movq	%rbx, %rdx
	xorl	%eax, %eax
	movq	%r15, %rsi
	call	__isoc99_fscanf@PLT
	testl	%eax, %eax
	jle	.L14
	movl	(%rbx), %eax
	movl	SIZEMAX(%rip), %edx
	testl	%eax, %eax
	jle	.L5
	leaq	ARRAY_A(%rip), %r14
	xorl	%r13d, %r13d
	cmpl	%edx, %eax
	jle	.L8
.L5:
	leaq	.LC4(%rip), %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L12
.L8:
	xorl	%eax, %eax
	movq	%r14, %rdx
	movq	%r15, %rsi
	movq	%rbp, %rdi
	call	__isoc99_fscanf@PLT
	testl	%eax, %eax
	jg	.L7
.L14:
	movq	%r12, %rdx
	leaq	.LC3(%rip), %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
.L12:
	movq	%rbp, %rdi
	call	fclose@PLT
.L13:
	movl	$1, %eax
	jmp	.L1
.L7:
	incl	%r13d
	addq	$4, %r14
	cmpl	%r13d, (%rbx)
	jg	.L8
	movq	%rbp, %rdi
	call	fclose@PLT
	xorl	%eax, %eax
.L1:
	popq	%rdx
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE13:
	.size	file_input, .-file_input
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
