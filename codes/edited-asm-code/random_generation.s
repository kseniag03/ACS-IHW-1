.intel_syntax noprefix
.text
.globl	random_generation
.type	random_generation, @function

random_generation:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi

	mov	edi, 0				# 1-й агрумент -- 0 (NULL)
	call	time@PLT			# time(NULL)
	mov	edi, eax			# 1-й агрумент -- возвращаемое знач. из time(NULL)
	call	srand@PLT			# srand(time(NULL))
	call	rand@PLT			# вызов ф-и rand()
	mov	ecx, DWORD PTR SIZEMAX[rip]	# ecx := SIZEMAX
	idiv	ecx				# % SIZEMAX

	mov	rax, QWORD PTR -24[rbp]		# rax := *n
	mov	DWORD PTR [rax], edx		# n = edx (rand())
	mov	eax, DWORD PTR [rax]		# eax := n
	test	eax, eax			# логическое сравнение (< 1)
	jg	.TOLOOP				# если *n > 1, переход к объявлению i и циклу (TOLOOP)
	mov	rax, QWORD PTR -24[rbp]
	mov	eax, DWORD PTR [rax]		# eax := n
	lea	edx, 1[rax]			# ++*n
	mov	rax, QWORD PTR -24[rbp]		# rax := *n
	mov	DWORD PTR [rax], edx		# n = edx

.TOLOOP:
	mov	r12d, 0				# i = 0
	jmp	.LOOP				# переход к циклу LOOP

.GENERATEELEM:
	call	rand@PLT			# вызов ф-и rand()
	mov	ecx, VALUEMAX[rip]		# ecx := VALUEMAX
	idiv	ecx				# % VALUEMAX
	mov	ecx, edx			#
	mov	eax, r12d			#

	lea	rdx, 0[0 + rax * 4]		# 		
	lea	rax, ARRAY_A[rip]		#	
	mov	DWORD PTR [rdx + rax], ecx	# 	
	add	r12d, 1				# ++i

.LOOP:
	mov	rax, QWORD PTR -24[rbp]		# rax := *n
	mov	eax, DWORD PTR [rax]		# eax := n
	cmp	r12d, eax			# сравнение i и n
	jl	.GENERATEELEM			# если i < n, переход к GENERATEELEM
	leave					# очистка стека
	ret					# выполняется выход из программы
