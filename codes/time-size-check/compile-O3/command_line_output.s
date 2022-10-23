	.file	"command_line_output.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"[ "
.LC1:
	.string	"%d "
	.text
	.p2align 4
	.globl	command_line_output
	.type	command_line_output, @function
command_line_output:
.LFB23:
	.cfi_startproc
	endbr64
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	xorl	%eax, %eax
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movl	%edi, %ebp
	movl	$1, %edi
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rsi, %rbx
	leaq	.LC0(%rip), %rsi
	call	__printf_chk@PLT
	testl	%ebp, %ebp
	jle	.L2
	leal	-1(%rbp), %eax
	leaq	.LC1(%rip), %rbp
	leaq	4(%rbx,%rax,4), %r12
	.p2align 4,,10
	.p2align 3
.L3:
	movl	(%rbx), %edx
	movq	%rbp, %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	addq	$4, %rbx
	call	__printf_chk@PLT
	cmpq	%r12, %rbx
	jne	.L3
.L2:
	movl	$93, %edi
	call	putchar@PLT
	popq	%rbx
	.cfi_def_cfa_offset 24
	movl	$10, %edi
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	jmp	putchar@PLT
	.cfi_endproc
.LFE23:
	.size	command_line_output, .-command_line_output
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
