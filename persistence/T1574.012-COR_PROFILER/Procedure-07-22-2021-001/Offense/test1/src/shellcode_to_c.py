#!/usr/bin/env python3

import binascii
import sys

if len(sys.argv) != 3:
    print(f'useage: {sys.argv[0]} <shellcode> <xor key>')
    sys.exit()

shellcode_file = sys.argv[1]
xor_key = sys.argv[2]
xor_key_size = len(xor_key)

raw_hex = b''
escaped_hex = []

shellcode_bytes = b''
shellcode_size = 0

# read shellcode
with open(shellcode_file, 'rb') as shellcode:
    shellcode_bytes = bytearray(shellcode.read())

shellcode_size = len(shellcode_bytes)

# xor shellcode with xor_key
for byte in range(0, shellcode_size):
    shellcode_bytes[byte] ^= ord(xor_key[byte % xor_key_size])

# convert bytes to hex
raw_hex = binascii.b2a_hex(shellcode_bytes).decode('ascii')

# format hex so it's escaped for C
for byte in range(0, len(raw_hex)-1, 2):
    escaped_hex.append(f'\\x{raw_hex[byte]}{raw_hex[byte+1]}')

# print output
print(f'XOR Key Size: {xor_key_size}')
print(f'XOR Key: {xor_key}')
print()
print(f'Payload size: {shellcode_size}')
print(f'Payload:\n')

# print hex in C format, like msfvenom does
print('unsigned char buf[] =\n"', end='')

count = 0
while escaped_hex:
    if count == 15:
        print('"\n"', end='')
        count = 0

    print(f'{escaped_hex[0]}', end='')
    del escaped_hex[0]
    count += 1

print('";')
