	.file	"command_line_input.c"
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC0:
	.string	"The num of elems in arr must be from 1 to %d\n"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"Not enough elems in arr"
	.text
	.p2align 4
	.globl	command_line_input
	.type	command_line_input, @function
command_line_input:
.LFB39:
	.cfi_startproc
	endbr64
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	movl	$10, %edx
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movq	%rdi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$8, %rsp
	.cfi_def_cfa_offset 48
	movq	16(%rsi), %rdi
	xorl	%esi, %esi
	call	strtol@PLT
	movl	SIZEMAX(%rip), %edx
	movl	%eax, (%r12)
	testl	%eax, %eax
	jle	.L2
	xorl	%ebx, %ebx
	leaq	ARRAY_A(%rip), %r13
	cmpl	%edx, %eax
	jle	.L3
	jmp	.L2
	.p2align 4,,10
	.p2align 3
.L5:
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtol@PLT
	movl	%eax, 0(%r13,%rbx,4)
	addq	$1, %rbx
	cmpl	%ebx, (%r12)
	jle	.L11
.L3:
	movq	24(%rbp,%rbx,8), %rdi
	testq	%rdi, %rdi
	jne	.L5
	leaq	.LC1(%rip), %rdi
	call	puts@PLT
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	movl	$1, %eax
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L2:
	.cfi_restore_state
	leaq	.LC0(%rip), %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	movl	$1, %eax
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L11:
	.cfi_restore_state
	addq	$8, %rsp
	.cfi_def_cfa_offset 40
	xorl	%eax, %eax
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
.LFE39:
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
