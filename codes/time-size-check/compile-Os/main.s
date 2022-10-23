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
	.globl	main
	.type	main, @function
main:
.LFB24:
	.cfi_startproc
	endbr64
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	subq	$56, %rsp
	.cfi_def_cfa_offset 80
	movq	%fs:40, %rax
	movq	%rax, 40(%rsp)
	xorl	%eax, %eax
	decl	%edi
	jle	.L2
	movq	8(%rsi), %rbp
	movl	$1, %edi
	movq	%rsi, %r12
	leaq	.LC0(%rip), %rsi
	movq	%rbp, %rdx
	call	__printf_chk@PLT
	movl	$10, %edi
	call	putchar@PLT
	movq	%rbp, %rdi
	call	atoi@PLT
	leaq	4(%rsp), %rdi
	cmpl	$1, %eax
	jne	.L3
	movq	%r12, %rsi
	call	command_line_input@PLT
.L15:
	testl	%eax, %eax
	je	.L8
	movl	$1, %eax
	jmp	.L1
.L3:
	cmpl	$2, %eax
	jne	.L6
	leaq	.LC1(%rip), %rsi
	call	file_input@PLT
	jmp	.L15
.L6:
	call	random_generation@PLT
	movl	4(%rsp), %edi
	leaq	ARRAY_A(%rip), %rsi
	call	command_line_output@PLT
	jmp	.L8
.L2:
	leaq	.LC2(%rip), %rdi
	call	puts@PLT
	jmp	.L16
.L8:
	leaq	8(%rsp), %rsi
	movl	$1, %edi
	leaq	ARRAY_A(%rip), %rbp
	call	clock_gettime@PLT
	movl	4(%rsp), %edi
	movq	%rbp, %rsi
	call	get_min_from_array@PLT
	movl	4(%rsp), %edi
	movq	%rbp, %rsi
	movl	%eax, %edx
	movl	%eax, %r12d
	call	count_if_equals_element@PLT
	movl	4(%rsp), %edi
	movl	%r12d, %edx
	movl	%edi, %ebp
	subl	%eax, %ebp
	movl	%ebp, %esi
	call	fill_ARRAY_B@PLT
	leaq	24(%rsp), %rsi
	movl	$1, %edi
	call	clock_gettime@PLT
	movq	8(%rsp), %rdx
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdi
	movq	32(%rsp), %rsi
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
.L16:
	xorl	%eax, %eax
.L1:
	movq	40(%rsp), %rdx
	subq	%fs:40, %rdx
	je	.L9
	call	__stack_chk_fail@PLT
.L9:
	addq	$56, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE24:
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
