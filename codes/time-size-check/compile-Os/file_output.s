	.file	"file_output.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"w"
.LC1:
	.string	"%d "
	.text
	.globl	file_output
	.type	file_output, @function
file_output:
.LFB13:
	.cfi_startproc
	endbr64
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movl	%edi, %r12d
	movq	%rsi, %rdi
	leaq	.LC0(%rip), %rsi
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	pushq	%rcx
	.cfi_def_cfa_offset 48
	call	fopen@PLT
	testq	%rax, %rax
	je	.L11
	movq	%rax, %rbp
	xorl	%ebx, %ebx
	leaq	ARRAY_B(%rip), %r13
.L2:
	cmpl	%ebx, %r12d
	jle	.L12
	movl	0(%r13,%rbx,4), %ecx
	movl	$1, %esi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	leaq	.LC1(%rip), %rdx
	incq	%rbx
	call	__fprintf_chk@PLT
	jmp	.L2
.L12:
	popq	%rdx
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	movq	%rbp, %rdi
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	jmp	fclose@PLT
.L11:
	.cfi_restore_state
	popq	%rax
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
.LFE13:
	.size	file_output, .-file_output
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
