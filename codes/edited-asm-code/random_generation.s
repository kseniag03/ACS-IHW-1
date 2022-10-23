	.intel_syntax noprefix
	.text
	.globl	random_generation
	.type	random_generation, @function
random_generation:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi
	mov	edi, 0
	call	time@PLT
	mov	edi, eax
	call	srand@PLT
	call	rand@PLT
	mov	ecx, DWORD PTR SIZEMAX[rip]
	cdq
	idiv	ecx
	mov	rax, QWORD PTR -24[rbp]
	mov	DWORD PTR [rax], edx
	mov	rax, QWORD PTR -24[rbp]
	mov	eax, DWORD PTR [rax]
	test	eax, eax
	jg	.L2
	mov	rax, QWORD PTR -24[rbp]
	mov	eax, DWORD PTR [rax]
	lea	edx, 1[rax]
	mov	rax, QWORD PTR -24[rbp]
	mov	DWORD PTR [rax], edx
.L2:
	mov	DWORD PTR -4[rbp], 0
	jmp	.L3
.L4:
	call	rand@PLT
	mov	ecx, DWORD PTR VALUEMAX[rip]
	cdq
	idiv	ecx
	mov	ecx, edx
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	lea	rax, ARRAY_A[rip]
	mov	DWORD PTR [rdx+rax], ecx
	add	DWORD PTR -4[rbp], 1
.L3:
	mov	rax, QWORD PTR -24[rbp]
	mov	eax, DWORD PTR [rax]
	cmp	DWORD PTR -4[rbp], eax
	jl	.L4
	leave
	ret
