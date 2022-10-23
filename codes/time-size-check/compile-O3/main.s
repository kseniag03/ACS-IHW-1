	.file	"main.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"arg = %s"
.LC1:
	.string	"input.txt"
.LC2:
	.string	"No arguments"
.LC3:
	.string	"output.txt"
.LC4:
	.string	"Elapsed: %ld ns\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB39:
	.cfi_startproc
	endbr64
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	subq	$72, %rsp
	.cfi_def_cfa_offset 96
	movq	%fs:40, %rax
	movq	%rax, 56(%rsp)
	xorl	%eax, %eax
	cmpl	$1, %edi
	jle	.L2
	movq	8(%rsi), %r12
	movl	$1, %edi
	movq	%rsi, %rbp
	leaq	.LC0(%rip), %rsi
	movq	%r12, %rdx
	call	__printf_chk@PLT
	movl	$10, %edi
	call	putchar@PLT
	movq	%r12, %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtol@PLT
	leaq	12(%rsp), %rdi
	cmpl	$1, %eax
	je	.L15
	cmpl	$2, %eax
	je	.L16
	call	random_generation@PLT
	leaq	ARRAY_A(%rip), %rbp
	movl	12(%rsp), %edi
	movq	%rbp, %rsi
	call	command_line_output@PLT
.L8:
	leaq	16(%rsp), %rsi
	movl	$1, %edi
	call	clock_gettime@PLT
	movl	12(%rsp), %edi
	movq	%rbp, %rsi
	call	get_min_from_array@PLT
	movl	12(%rsp), %edi
	movq	%rbp, %rsi
	movl	%eax, %edx
	movl	%eax, %r12d
	call	count_if_equals_element@PLT
	movl	12(%rsp), %edi
	movl	%r12d, %edx
	movl	%edi, %ebp
	subl	%eax, %ebp
	movl	%ebp, %esi
	call	fill_ARRAY_B@PLT
	leaq	32(%rsp), %rsi
	movl	$1, %edi
	call	clock_gettime@PLT
	movq	16(%rsp), %rdx
	movq	24(%rsp), %rcx
	movq	32(%rsp), %rdi
	movq	40(%rsp), %rsi
	call	timespec_difference@PLT
	leaq	ARRAY_B(%rip), %rsi
	movl	%ebp, %edi
	movq	%rax, %r12
	call	command_line_output@PLT
	leaq	.LC3(%rip), %rsi
	movl	%ebp, %edi
	call	file_output@PLT
	movq	%r12, %rdx
	movl	$1, %edi
	xorl	%eax, %eax
	leaq	.LC4(%rip), %rsi
	call	__printf_chk@PLT
	xorl	%eax, %eax
.L1:
	movq	56(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L17
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
.L2:
	.cfi_restore_state
	leaq	.LC2(%rip), %rdi
	call	puts@PLT
	xorl	%eax, %eax
	jmp	.L1
.L16:
	leaq	.LC1(%rip), %rsi
	leaq	ARRAY_A(%rip), %rbp
	call	file_input@PLT
	testl	%eax, %eax
	je	.L8
.L7:
	movl	$1, %eax
	jmp	.L1
.L15:
	movq	%rbp, %rsi
	leaq	ARRAY_A(%rip), %rbp
	call	command_line_input@PLT
	testl	%eax, %eax
	je	.L8
	jmp	.L7
.L17:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE39:
	.size	main, .-main
	.globl	ARRAY_B
	.bss
	.align 32
	.type	ARRAY_B, @object
	.size	ARRAY_B, 400000
ARRAY_B:
	.zero	400000
	.globl	ARRAY_A
	.align 32
	.type	ARRAY_A, @object
	.size	ARRAY_A, 400000
ARRAY_A:
	.zero	400000
	.globl	VALUEMAX
	.section	.rodata
	.align 4
	.type	VALUEMAX, @object
	.size	VALUEMAX, 4
VALUEMAX:
	.long	100000
	.globl	SIZEMAX
	.align 4
	.type	SIZEMAX, @object
	.size	SIZEMAX, 4
SIZEMAX:
	.long	100000
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
