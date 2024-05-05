section .data
	int_format db "%ld",10,0


	global _main
	extern _printf
section .text


_start:	call _main
	mov rax, 60
	xor rdi, rdi
	syscall


_main:	push rbp
	mov rbp, rsp
	sub rsp, 192
	mov esi, 10
	mov [rbp-32], esi
	mov esi, [rbp-32]
	mov [rbp-88], esi
	mov esi, -10
	mov [rbp-72], esi
	mov esi, [rbp-72]
	mov [rbp-96], esi
	mov esi, 1
	mov [rbp-64], esi
	mov esi, 0
	mov [rbp-8], esi
	mov edi, [rbp-8]
	mov eax, [rbp-64]
	cmp eax, edi
	mov [rbp-64], eax
	jz lab1274
	jmp lab1277
lab1274:	mov esi, 10
	mov [rbp-16], esi
	mov esi, [rbp-88]
	mov [rbp-56], esi
	mov edi, [rbp-16]
	mov eax, [rbp-56]
	imul eax, edi
	mov [rbp-56], eax
	mov esi, [rbp-56]
	lea rdi, [rel int_format]
	mov eax, 0
	call _printf
	mov rax, 0
	jmp finish_up
lab1277:	mov esi, 10
	mov [rbp-48], esi
	mov esi, [rbp-96]
	mov [rbp-40], esi
	mov edi, [rbp-48]
	mov eax, [rbp-40]
	imul eax, edi
	mov [rbp-40], eax
	mov esi, [rbp-40]
	lea rdi, [rel int_format]
	mov eax, 0
	call _printf
	mov rax, 0
	jmp finish_up
finish_up:	add rsp, 192
	leave 
	ret 

