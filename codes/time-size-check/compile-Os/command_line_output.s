	.file	"command_line_output.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"[ "
.LC1:
	.string	"%d "
	.text
	.globl	command_line_output
	.type	command_line_output, @function
command_line_output:
.LFB13:
	.cfi_startproc
	endbr64
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	xorl	%eax, %eax
	leaq	.LC1(%rip), %r13
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movq	%rsi, %r12
	leaq	.LC0(%rip), %rsi
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movl	%edi, %ebp
	movl	$1, %edi
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	xorl	%ebx, %ebx
	pushq	%rdx
	.cfi_def_cfa_offset 48
	call	__printf_chk@PLT
.L2:
	cmpl	%ebx, %ebp
	jle	.L6
	movl	(%r12,%rbx,4), %edx
	movq	%r13, %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	incq	%rbx
	call	__printf_chk@PLT
	jmp	.L2
.L6:
	movl	$93, %edi
	call	putchar@PLT
	popq	%rax
	.cfi_def_cfa_offset 40
	movl	$10, %edi
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	jmp	putchar@PLT
	.cfi_endproc
.LFE13:
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
