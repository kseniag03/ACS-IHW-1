	.file	"command_line_input.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"The num of elems in arr must be from 1 to %d\n"
.LC1:
	.string	"Not enough elems in arr"
	.text
	.globl	command_line_input
	.type	command_line_input, @function
command_line_input:
.LFB24:
	.cfi_startproc
	endbr64
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movq	%rsi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	pushq	%rcx
	.cfi_def_cfa_offset 48
	movq	16(%rsi), %rdi
	call	atoi@PLT
	movl	SIZEMAX(%rip), %edx
	movl	%eax, 0(%rbp)
	testl	%eax, %eax
	jle	.L2
	xorl	%ebx, %ebx
	leaq	ARRAY_A(%rip), %r13
	cmpl	%edx, %eax
	jle	.L3
.L2:
	leaq	.LC0(%rip), %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L10
.L3:
	movq	24(%r12,%rbx,8), %rdi
	testq	%rdi, %rdi
	jne	.L5
	leaq	.LC1(%rip), %rdi
	call	puts@PLT
.L10:
	movl	$1, %eax
	jmp	.L1
.L5:
	call	atoi@PLT
	movl	%eax, 0(%r13,%rbx,4)
	incq	%rbx
	cmpl	%ebx, 0(%rbp)
	jg	.L3
	xorl	%eax, %eax
.L1:
	popq	%rdx
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
.LFE24:
	.size	command_line_input, .-command_line_input
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
