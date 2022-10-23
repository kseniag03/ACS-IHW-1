.intel_syntax noprefix
.globl count_if_equals_element
.type count_if_equals_element, @function

.text
	
count_if_equals_element:
	push	rbp
	mov	rbp, rsp
	mov	r13d, edi			# r13d = n
	mov	r14, rsi			# r14 = int arr[]
	mov	r15d, edx			# r15d = int element
	
	mov	r11d, 0				# cnt = 0
	mov	r12d, 0				# i = 0
	jmp	.LOOP				# переход к циклу
	
.INCCNT:
	lea	rdx, 0[0 + rax * 4]		# rdx := rax * 4
	mov	rax, r14			# rax := &arr
	add	rax, rdx			# rax += rdx
	mov	eax, DWORD PTR [rax]		# eax := arr[i]
	cmp	r15d, eax			# сравнение element и arr[i]
	jne	.INCI				# если arr[i] != elementn, переход к INCI
	add	r11d, 1				# иначе ++cnt;
	
.INCI:
	add	r12d, 1				# ++i
	
.LOOP:
	cmp	r12d, r13d			# сравнение i и n
	jl	.INCCNT				# если i < n, переход к INCCNT
	mov	eax, r11d			# return cnt
	pop	rbp				# очистка стека
	ret					# выполняется выход из программы
