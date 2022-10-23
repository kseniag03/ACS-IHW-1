	.file	"file_output.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"w"
.LC1:
	.string	"%d "
	.text
	.p2align 4
	.globl	file_output
	.type	file_output, @function
file_output:
.LFB23:
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
	subq	$8, %rsp
	.cfi_def_cfa_offset 48
	call	fopen@PLT
	testq	%rax, %rax
	je	.L1
	movq	%rax, %rbp
	testl	%r12d, %r12d
	jle	.L3
	leaq	ARRAY_B(%rip), %rbx
	leal	-1(%r12), %edx
	leaq	4(%rbx), %rax
	leaq	.LC1(%rip), %r12
	leaq	(%rax,%rdx,4), %r13
	.p2align 4,,10
	.p2align 3
.L4:
	movl	(%rbx), %ecx
	movq	%r12, %rdx
	movl	$1, %esi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	addq	$4, %rbx
	call	__fprintf_chk@PLT
	cmpq	%r13, %rbx
	jne	.L4
.L3:
	addq	$8, %rsp
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
.L1:
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
.LFE23:
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
