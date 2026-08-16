---
type: note
status: active
project: uct
course: EEE3096S
tags: [uct, embedded, stm32, course]
---
## L09 ARM Assembly Programming 2 of 3
Outline: recap of ARM instruction types, ARM Assembly Activity #1, Activity #1 solution, explanation and simulation.
### Instruction Set Summary
**ARM Instruction Set**
- Six types: Branch (B, BX, BL), Data Processing (ADD, SUB, CMP, MOV, etc.), Status Register Transfer (MSR, MRS), Load and Store (LDR, STR, LDM, STM), Coprocessor (LDC, CDP, MRC, STC), Exception-generating (SWI)
- Complete table available with all variants: LDRH, LDRSH, LDRB, LDRBT, LDRT, STRH, STRB, STRBT, STRT, and shifted operand forms (ASL, ASR, LSR, ROR, RRX)

**Conditional Execution (reminder)**
- Every instruction can execute conditionally based on CPU flags (N, Z, C, V)
- EQ (Z set), NE (Z clear), CS/HS (C set), CC/LO (C clear), MI (N set), PL (N clear), VS (V set), VC (V clear), HI (C set and Z clear), LS (C clear or Z set), GE (N and V match), LT (N and V differ), GT (Z clear and N, V match), LE (Z set or N, V differ)

**GAS Syntax**
- Label (optional), instruction, suffix (optional for conditional and flag setting), operands
- Comments start with @
- S suffix updates flags (e.g., ADDS, SUBS, CMP is like SUBS with result discarded)
### The Two-Pass Learning Approach
**CPU Instructions Lecture Strategy**
- Pass one: dream up your own assembly code, think what instructions might be useful and how they would look
- Pass two: with a basic understanding of ARM instructions and GAS coding, write real assembly code that could run on an ARM processor
- This lecture covers the second pass with real code

**Program Description: compaavg**
- C code: declare int variables a, b, avg, res; set a=100, b=200; calculate avg=(a+b)/2; compare a to avg and set res accordingly (res=1 if a>avg, res=-1 if a<avg, res=0 if a==avg)
- Available in Vula resources as completed assembly version (compaavg.s)
### Activity #1: Compare and Average
**Activity #1 Problem Description**
- Write ARM assembly to perform the same processing as the C code from above
- Think about which ARM instructions covered in this lecture would be used
- Do not fully solve yet, but contemplate the ARM instructions available
- True solution available next slide with explanation
- Note: use proper ARM instructions, not pseudo-code like in the previous activity

**Activity #1 Solution Approach**
Step 1: make a starting point for the procedure. compaavg: is a function that compares a parameter to average of parameters a+b

Step 2: choose registers (say r1, r2) to hold values for a and b
- mov r1, #100 (set r1 = a = 100)
- mov r2, #200 (set r2 = b = 200)

Step 3: find avg = (a+b) / 2. Do the /2 by arithmetic logic shift right instead of using a divide
- add r3, r1, r2 (avg = r3 = a + b)
- asr r3, r3, #1 (avg = avg / 2)

Step 4: compare a to avg, which will set the flags gt (if a>avg) or lt (if a<avg) or eq (if a==avg). Only need two branches because the last option doesn't need a branch
- cmp r1, r3 (compare r1 to r3, i.e. a vs. avg)
- bgt Greater (branch to Greater if a>avg)
- blt Lesser (branch to Lesser if a<avg)
- Equal: (can put a label for this default, execution proceed here if a==avg)
- mov r0, #0 (set ret = 0 and return)
- b Return (branches to return)

Step 5: handle a==avg default case
- Equal: can put a label for other option, execution proceed here if a==avg
- mov r0, #0 (set ret = 0 and return)
- b Return (branches to return)

Step 6: handle a>avg and a<avg branch bodies
- Greater: mov r0, #1 (set ret = 0 and return)
- b Return
- Lesser: mov r0, #0 (a bit more complicated because -1 is 0xFFFFFFFF)
- sub r0, r0, #1 (so is more that 12 bits available in an instruction therefore I'm just subtracting 1 from 0 to get -1)
- b Return

Step 7: finally doing the return
- Return: bx lr (standard returns from function - the rule for C is that the return value is stored in r0, which is what we have set up)

**OakSim: Online ARM Simulator**
- OakSim is a useful ARM AArch32 simulator, suited to starting out in learning ARM assembly coding
- Website: https://wunkolo.github.io/OakSim/
- Simple functionality but well-suited for learning, usual file extension for GCC or NASM ARM assembly is .s
- When starting OakSim, put in a while loop example code
- Controls to run, step, or reset the program; view registers; view machine code and memory contents

**Testing compaavg.s on OakSim**
- Select and delete all text in the left window (assembly code)
- Copy and paste contents of compaavg.s into that window
- Press Reset
- Step through the code to see how registers change
- Final result should get R0 = -1

**Assembly Activity Done**
- Second pass of learning assembly: writing an ARM assembly program using real ARM instructions
- Now understand the specific approach of writing ARM assembly that can be combined by GAS
- You might get something like this in a test or exam, but the important aspect is knowing what instructions are commonly available on a CPU and how they work

**Concluding Remarks**
- This is a brief starting point to ARM coding; we haven't yet looked at calling convention for assembly routines, the passing of parameters, using the stack, etc.
- Lecture 11 clarifies many of these issues explaining how to mix C and assembly code, because, nowadays, it is seldom that you will ever write a program entirely in assembly
## L10 ARM Assembly Programming 3 of 3
Outline: reading assignment, best practices for embedded software development, mixing C and ARM Assembly, implementing an assembly function, calling function from C, compiling the C and assembly program.
### Reading Assignment and Best Practices
**Reading Assignment**
- Read up on object and executable file formats (read file EEE3096S-L10 Reading on Object Files.pdf in resources)
- Think about how computers store programs on disk and in memory

**Common Assembly Misassumptions**
- Avoid: The hardware definitely works, so I'll write the code, then test the board and code together
- Avoid: I can skip commenting this as it's so obvious
- Avoid: Changing these two lines won't affect the rest of my program
- Incorrect assumptions can prove costly and time consuming. They're learned through experience and you're sure to come up with some more as you gain experience in this type of coding

**Other Common Misassumptions**
- Everything is plug and play, sure this too
- The peripheral will surely work fine when I connect it
- My board is broken because all my connections are right and my software is perfect
- My Pi is bad (it's gone vrot) because my code is flawless and yet it still doesn't work

**Strategies for C and Assembly Development**
- When programming in C, take small steps. Think after every step. A bit of thinking is cheaper and faster than debugging and rewriting
- When programming in assembly, take tiny steps. Assembly language programs are subtle and quick to anger (like wizards)
### Mixing C and Assembly
**Why Mix C and Assembly**
- Interfacing an assembly program with a C library (or vice-versa)
- Performance: writing speed-critical key parts of a program in assembly, and leaving the rest in C, may significantly boost overall performance
- Size: human written assembly can be smaller than compiler generated code
- Main reason: because nowadays, if you ever write any assembly it's usually a tiny piece of your (larger C) program that does something very fast and specialized

**Functions in Assembly**
- You can't specify a prototype in the assembler
- You need to ensure that the assembly implementation matches the prototype the C compiler is using
- The interface between a C function and an assembly function can be a good hiding place for bugs, some care is required
- You need to ensure you are using the same Application Binary Interface (ABI) as is being used by the C compiler

**What is an ABI?**
- Put very generally, an Application Binary Interface (ABI) is an interface between two binary program modules. Where 'modules' are usually functions (as opposed to code modules that store a collection of functions)
- However 'module' is used in this case because it might not always be functions that are being connected to, you may, for example, be communicating in some way with a control element (e.g. mutex, I/O or data structure, which is not a function but is a form of application element)
- An ABI might have various types of module, in addition to functions, that one can interact with
- However, in our case we can assume an ABI is defining just how one function invokes another

**Why do we need to consider the ABI?**
- An ABI would need to be adhered to in, for example, a situation where a library module (e.g. strcpy) is connected to and invoked by another function, e.g. a function in your own user program
- The adhering to an ABI (which may or may not follow an officially standardized) is usually the responsibility of the compiler. And also the responsibility of the authors of the operating system and other libraries that you are making use of
- However, an application programmer may have to deal with the adherence to an ABI explicitly. Particularly when writing assembly language that you want to connect to from compiled high-level (e.g. C) code. Or when you may be wanting to mix different programming languages, or mix compiled objects generated by different compilers
- Adapted from, and more details of these issues at https://en.wikipedia.org/wiki/Application_binary_interface

**API vs ABI**
- API = Application Programming Interface: defines the interface between software components at the source code level (usually a list of functions and data structures available in the application library)
- ABI is lower-level, defining the binary or machine code connection to modules in the application

**Developing an Assembly Function**
- The following slides will show how to put together an assembly function, using the standard GCC C++ ABI

**Functions in Assembly (2)**
- The assembler has some commands which are used to support interfacing:
- `.global <name>`: indicates that name is a global symbol, accessible from other modules
- `.type <name>, function` @: indicates that the symbol name is a function
- `<name>:` tells assembler to create a symbol with name at this position (yes, this is just a label)

**Functions in Assembly (3)**
- In a C header file (e.g. asm_module.h):
  char *strcpy(char * a, char * b); // Prototype
- In the assembly language listing:
  .global strcpy
  .type strcpy, function
  strcpy:
  ...implementation of the function...

**Calling Conventions**
- Definition: Calling Convention is the way that parameters, return values, local variables and return addresses are handled. It is called a calling convention
- Different platforms and operating systems use different conventions
- The calling convention is part of the Application Binary Interface (ABI) being adhered to
- We will describe the calling convention GCC uses on ARM

**Dealing with Parameters**
- The first 13 input parameters are passed to the function using registers r0 to r12
- char *strcpy(char *out, char *in);
  - r0: first parameter (out pointer)
  - r1: second parameter (in pointer)

**Dealing with Results**
- The results are returned in r0
- char *strcpy(char *out, char *in);
  - r0: return value (out pointer)
### Stack Frames and Local Variables
**Stack Frames**
- The stack space allocated to a specific function is called a stack frame
- The stack frame contains parameters, local variables and the return address
- At the start of the function FP == SP
- The stack grows down on the ARM
- SP points to the next free location in the stack

**Assembly Function Prologue**
- Starting the function strcpy:
- @Save sp
- mov ip, sp
- @stmfd: store multiple, post dec (essentially a PUSH instruction)
- stmfd sp!, {fp, ip, lr, pc} (fp points to old fp on stack)
- @fp points to old fp on stack
- sub fp, ip, #4 (@allocate 4 more words on stack)
- sub sp, sp, #16
- The ARM instruction stmfd sp!, {r1, r2} corresponds to C code: unsigned int* sp; unsigned int r1,r2; *sp = r1; sp++; *sp = r2; sp++;

**Assembly Function Epilogue**
- Ending the function strcpy:
- ... code ...
- @pop registers stored on stack
- @starting at fp (which we set in prolog)
- @ldmea = pre-decrement load
- ldmea fp, {fp, sp, pc}
- @ note how value of lr gets loaded into pc, undoing the effects of BL and returning from the function
- BL = Branch and Link, it is the instruction used to call a function
- BL rx does: lr = pc+1, pc=rx, and continues execution from address rx, where rx is a register value. You can branch relative to the pc also (pc=pc+x)

**Stack Frame Example**
Three diagrams showing the stack pointer and memory layout at different points:
1. Instruction: bl strcpy (Stack Pointer points to free space)
2. Instruction: mov ip, sp (Stack Pointer still pointing to free space, Index Pointer now = SP)
3. Instruction: stmfd sp!, {fp, ip, lr, pc} (Stack contains sp, ip, lr, pc; Stack Pointer lower, Index Pointer shows where all stored)

**Stack Frame Example continued**
- Instruction: sub fp, ip, #4 (Frame Pointer set to start of first word in frame for this function)

**Stack Frame Example with stmfd**
- stmfd does: mem[ip]=sp, ip+=4; mem[ip]=ip, ip+=4; mem[ip]=lr, ip+=4; mem[ip]=pc, ip+=4
- Stack Pointer (SP) is now lower, Index Pointer (IP) points to where they are stored
- Instruction: sub fp, ip, #4 (i.e. the new frame pointer is set to the address word after the index pointer)

**Stack Frame Example locals declared**
- Instruction: sub sp, sp, #16 (i.e. space for local variables is declared by moving sp ahead by the amount needed)

**Saving Local Variables**
There are two basic ways in which you can save local variables so that a given function does not change local variables of the calling function:
- Store Before Call (SBC) (possibly more optimal): In this case, the code before a function call is design so that all local variables are saved to memory before the function call is made
  - void calling_function (void) { int myvar = 100; called_function(); printf("%d",myvar); // show 100 }
  - This used in some implementations of the -O2 compiler optimization level
  - Example: use registers (e.g., use of r0-r7) ... might have finished with r0,r2,r3,r4. Store registers currently in use (str r1,r5,r6,r7). Call_function() // uses 20 registers r0-r19. Restore registers that were in use (ldr r1,r5,r6,r7). FUNCTION INVOCATION OVERHEAD = 4 * 2 store/load = 8 mem accesses

- Call Before Store (CBS) also known as Store Before Use (SBU) (typical method used): In this case, the code at the start of a function stores all the registers to be used in the function, whether or not the registers were actually used by the calling function
  - void calling_function (void) { int v1 = 500; int v2 = 300; }
  - Typical method used. Use registers (e.g., use of r0-r7) ... might have finished with r0,r2,r3,r4. Only some registers currently in use (i.e. r1,r5,r6,r7). Call_function () // uses 20 registers r0-r19 store r0-r19. ... do body of function. load r0-r19. return. Continue using r1,r5,r6,r7 in calling function. FUNCTION INVOCATION OVERHEAD = 20 * 2 store/load = 40 mem accesses
  - Hint: take note of what the function invocation overhead is and how it is calculated, as this is a useful thing for considering the optimality of your code, and also a favourite type of test question
### A Real-World Example
**Concatenate Strings**
- We are going to write a function which adds one string to the end of another
- Similar to one in the C library called strcat

**A Real World Example (C implementation)**
```c
char *strcat(char *out, char *in) {
  int i = 0, j = 0;
  while (out[i])
    i++; // Go to end of out
  while (in[j])
    // Copy characters from in to out:
    out[i++] = in[j++];
  out[i] = 0; // Terminate out string
  return out; // return the out pointer
}
```

**The Assembly Coding Strategy**
We follow the usual process to implement this as assembly:
1. First you (probably) want to think about the algorithm, what assembly command you are going to use, what parameters, what sort of looping, what registers to use (maybe play around with the design as pen on paper)
2. Once you've decided the registers to use, set up your prologue (you might do the epilogue at the same time)
3. 'Declare' any local variables you may need ... you might not bother to assign them to anything at this point (I say 'declare' because you're already allocated space for them in step 2, but haven't assigned them values as yet)
4. Implement the routine... obviously this is the hard part, but if you've done #1 effectively it should be pretty mechanical going from pseudocode to instructions
5. Complete the epilogue and the return operation

**Define the C prototype for the assembly**
You can tell C about the assembly module by putting a prototype of the function into a h file. We are effectively creating a module. I've called the module strcpyx.h and the assembly file is strcpyx.s (s being the extension for assembly)
```c
// File strcpyx.h:
// Prototype declaration of strcat
char *strcat(char *out, char *in);
```

**Function Prologue**
C code: char *strcat(char *out, char *in) {
ASM: .text
     .align 2
     .global strcat
     .type strcat, function
     strcat:
     mov ip, sp
     stmfd sp!, {fp, ip, lr, pc}
     sub fp, ip, #4

We are clearly expecting 'store before call' method to be used... the 'store before use' would simply be adding r0-r4 into the register list in the stmfd instruction.

**Stack Frame View (at end of prolog)**
- Frame Pointer (FP) points to: old_fp
- Below that: ip, lr, pc
- Stack Pointer (SP) points to: free space
- No space for local variables yet

**Declare Local Variables**
C code: int i = 0, j = 0;
ASM: sub sp, sp, #16 @Space for 4 locals
     str r0, [fp, #-16] @ [fp - 16] = out
     str r1, [fp, #-20] @ [fp - 20] = in
     mov r3, #0
     str r3, [fp, #-24] @ [fp - 24] = i
     mov r4, #0
     str r4, [fp, #-28] @ [fp - 28] = j

We directly assignment values to the registers (we're assuming 'store before call'), and could copy them through to the stack memory as has been shown (this isn't so optimal unless these registers are needing for other things before getting used in the body of the function.)

**Start Processing**
C code: while (out[i]) i++;
ASM: ldr r2, [fp, #-16] @ r2 = out
     ldr r3, [fp, #-24] @ r3 = i
     loop1:
     ldrb r1, [r2, r3] @ load byte (i.e. out[i])
     cmp r1, 0 @ r1 == 0?
     be next @ yes -> goto next
     add r3, r3, #1 @ no -> i++;
     b loop1 @ loop back around
     next: @end of loop

(I applied some optimization / lazy typing by not saving the change to r3, 'i', to address fp, #-24)

**Copy String Data**
C code: while (in[j]) out[i++] = in[j++];
ASM: Exercise: Write this code.
     Tips:
     - Load j into a register
     - Use ldrb and strb to copy byte data
     - Use cmp to compare
     - Use be to branch

**Final Part and Epilogue**
C code: out[i] = 0; return out;
ASM: ret_out:
     add r2, r2, r3 @r2 = out + i
     mov r3, #0
     strb r3, [r2, #0] @ out[i] = 0
     ldr r0, [fp, #-16] @ return out pointer
     ldmea fp, {fp, sp, pc} @ do call return

Put a '\0' at the end of the concatenated string (the final part of the function body) and the function returns the length of this concatenated string in r0. The last instruction, ldmea, restores the stack frame and returns to the calling function. Notice that again we are assuming the 'store before call' method, we haven't bothered replacing registers used.

**Testing the module**
- Now you've got the strcpyx.s file sorted, and the header file strcpyx.h
- Let's connect the strcpy in the .s file to a C program, i.e. to a main() function that will be the entry point of the application

**Test program and compiling it**
```c
/* EEE3096S Example of combining C and Assembly
 * C entry point for testing the special strcat function */
#include <stdio.h>
#include "strcpyx.h"
void main ()
{
  char a[100] = "Hello ";  // set a the a string, make sure there's
  char b[]     = "There!"; // set up the b string
  printf("Before:\n");     // print strings before calling function
  printf("a = %s\n",a);
  printf("b = %s\n",b);
  strcat(a,b);            // call the strcat we implemented in assembly
  printf("After:");        // print out the result of the strings
  printf("a = %s\n",a);    // should get: a = Hello There!
  printf("b = %s\n",b);    //
  printf("Done!\n");
  return;
}
```

**Compiling the solution**
- First you'd need to make sure you have the right compiler (a GCC-ARM compiler)
- For the Raspberry Pi you can use a cross-compiler (running in Ubuntu to compile for the Pi) as arm-linux-gnueabihf-gcc
- Or, running on the Pi directly you can just use the built-in gcc
- The command use is explained next slide
- Quick instructions for getting this working from pre-build executables are available at: https://stackoverflow.com/questions/19162072/how-to-install-the-raspberry-pi-cross-compiler-on-my-linux-host-machine

**Compiling the solution**
- To compile on Ubuntu / Linux PC use:
  arm-linux-gnueabihf-gcc -O2 strcpyx.s main.c
  (note: -O2 optimizations assumes use of SBC calling convention, which we were using)
- To compile directly on the Raspberry Pi use:
  gcc -O2 strcpyx.s main.c
  (note assumes O2 optimizations applied to use SBC calling convention)
- Let's see the anticipated results on next page
- See example files in armasm_example1.zip: compile.sh, main.c, strcpyx.h, strcpyx.s, strcpyx.c (for example sake, not needed)

**Example Result**
- Screenshot shown that the code was cross-compiled on a PC in Ubuntu, then copied via scp to a Raspberry Pi and run on the Pi, and producing the expected result
- Of course you could have just compiled and run the program directly on the Pi
### Inline Assembly
**Inline Assembly: Adding assembly code directly into a C function**
- Assembler code can be included in C code
- Useful for accessing hardware or CPU features that aren't exposed by the C language
- Inline Assembly is not standardized in ANSI C
- GCC uses the asm keyword
  asm("instruction": inputs: outputs);
- Other compilers use other keywords and syntax
- Code with inline asm is not ANSI C

**Inline Assembly**
- Assembler code can be included in C code
- Useful for accessing hardware or CPU features that aren't exposed by the C language
- Inline Assembly is not standardized in ANSI C
- GCC uses the asm keyword
  asm("instruction": inputs: outputs);
- Other compilers use other keywords and syntax
- Code with inline asm is not ANSI C

**Inline Assembly Best Practice**
- Wrap inline assembly in #ifdef, #endif pair to hide it from other compilers
- Wrap inline assembly in C functions and keep it in a separate file, so the body of your code is still ANSI compliant
- Some purists say: Don't use inline assembly at all, rather keep assembly code in a separate module
- Inline assembly can prevent the compiler's optimizer from working, making your code run slower

**GCC Inline Assembly**
Example: rotate a value right one bit
```c
int rotRight(int val) {
  int result;
  asm("mov %0, %1, ror #1"  // i.e. result = val ror #1
      : "=r" (result)
      : "r" (val));
  return result;
}
```
Great document can be found here: http://www.ethernut.de/en/documents/arm-inline-asm.html

**Conclusion**
Writing assembly code is not particularly hard, but:
- You need a methodical approach
- You need to comment your code, assembly code is much harder to read than C
- Take small steps, and you should be OK
## L10 Reading on Object Files
### Object Files and File Formats
**Object File**
- In computer science, object file or object code is an intermediate representation of code generated by a compiler after it processes a source code file
- Object files contain compact, pre-parsed code, often called binaries, that can be linked with other object files to generate a final executable or code library
- An object file is mostly machine code but directly understandable by a computer's CPU
- An object file format is a computer file format used for the storage of object code and related data typically produced by a compiler or Assembler
- Object files contain not only object code, but also relocation information that the linker uses to assemble the object files into an executable or library, program symbols (names of variables and functions), and debugging information
- Many different object file formats exist; originally each type of computer had its own unique format, but with the advent of Unix and other portable operating systems, some formats, such as COFF and ELF, have been defined and used on different kinds of systems
- It is common for the same file format to be used both as linker input and output, and thus as the library and executable file format
- The simplest object file format is the DOS COM format, which is simply a file of raw bytes that is always loaded at a fixed location. Other formats are an elaborate array of structures and substructures whose specification runs to many pages
- Debugging information may either be an integral part of the object file format, as in COFF, or a semi-independent format which may be used with several object formats, such as stabs or DWARF

**Object File Formats**
Types of data supported by typical object file formats: BSS (block started by symbol), text segment, data segment
Notable formats: COM (DOS), EXE (DOS), a.out (Unix/Linux), COFF (Unix/Linux), XCOFF (AIX), ECOFF (Mips), ELF (Unix/Linux), SOM (HP), Mach-O (NeXT, Mac OS X), Portable Executable (Windows), NLM, OMF, PEF (Macintosh), IEEE-695 (embedded), S-records (embedded), IBM 360 object format
### Executable Formats
**a.out Format**
- a.out is the default filename for executable output from many compilers, especially in Unix environments. It stands for "assembler output"
- a.out is also an old object file format for executables, now superseded by the ELF and COFF formats
- (Note: the default object file format of a compile/linker might be ELF and used to be a.out in earlier versions, but the default file name is still "a.out")

**COFF (Common Object File Format)**
- COFF is an object file format that was introduced in Unix System V Release 3, and was later adopted by Microsoft for Windows NT
- It was superseded by the more powerful ELF in System V Release 4, as of 2005 COFF is still used in Windows as Portable Executable
- The original Unix object file format a.out is a very simple design, and was too limited to effectively handle the additions of SVR3, such as shared libraries
- COFF's main improvement was the introduction of multiple named sections in the object file. Different object files could have different numbers and types of sections
- In addition, a debug data format was defined. However, COFF design soon turned out to be too limited; there was a limit on the maximum number of sections, a limit on the length of section names, and so forth
- In addition, the debug info was really only capable of supporting C debugging; for instance, C++ had additional constructs that had no way to be represented, and the debug info was designed to be extensible
- IBM solved this in the AIX with the XCOFF format, MIPS and others used ECOFF, and GNU tools adopted the workaround of encoding stabs info, which was extensible, into special COFF sections in a technique known as stabs-in-coff

**Executable and Linkable Format**
- The Executable and Linkable Format (ELF) is a common standard in computing for executables and object code
- First published in the Tool Interface Standard and the System V Application Binary Interface, it was quickly accepted among different vendors of Unix systems
- Today the ELF format has replaced the proprietary (or sometimes just platform-specific) and less extensible executable formats (primarily COFF) in the Linux, Solaris, Irix, and almost all modern BSD operating systems

**ELF File Layout**
- Each ELF file is made up of one ELF header, followed by zero or more segments and zero or more sections
- The segments contain information that is necessary for runtime execution of the file, while sections contain important data for linking and relocation
- Each byte in the entire file is taken by no more than one section at a time, but there can be orphan bytes, which are not covered by a section. In the normal case of a UNIX executable one or more sections are enclosed in one segment
- The segments and sections of the file are listed in a program header table and section header table respectively
- On many UNIX systems the command: man elf (may provide some more details)
- Tools: readelf is a UNIX binary utility that displays information about one or more ELF files. A GPL implementation is provided by GNU Binutils; elfdump is a Solaris command for viewing ELF information in an elf file
- External links: Tool Interface Standard (TIS) Executable and Linking Format (ELF) Specification Version 1.2 (http://x86.ddj.com/ftp/manuals/tools/elf.pdf); Description of the ELF binary format (http://www.cs.ucdavis.edu/~haungs/paper/node10.html); Article "LibELF and GELF - A Library to Manipulate ELF Files" (http://developers.sun.com/solaris/articles/elf.html) by Neelakanth Nadgir; free ELF object file access library (http://www.stud.uni-hannover.de/~michael/software/english.html); manual page (http://www.dac.neu.edu/cgi-bin/man-cgi?libell); Elf library routines

**HEX File Format**
A HEX file is made of HEX records, one record per line. The format for the HEX record is as follows:
1. Start with a colon (:)
2. Then two hex digits give the number of data bytes in the record
3. Then two four hex digits give the starting address of where to place the data in memory
4. Then there is a two-hex-digit identifying tag. The only two values you care about are 00 for data records and 01 for the terminating record in the file
5. Then there are N two-digit hex numbers where N is the number of data bytes in the record
6. Finally there is a two-digit hex checksum which is the lower two digits of the two's-complement of the sum of all the previous two-digit fields (the four-digit address is split into two 2-digit fields)

Example HEX format:
:100080D08D32F20C08353203DF0F0D82D083DF
:030090002200004B
:00000001FF

Benefits of HEX format: they are simply to generate, and to interpret; they provide the ability to load bytes into any address, not necessarily in a sequential order; and they are, to some degree, human-readable and manually modifiable
HEX files are not really a standard. For instance, some HEX files have 16-bit addresses (taking 4 hex digits), others 32-bit (which take 8 hex digits), so you have to ensure that you use the correct interpreter to parse a given HEX format. Sometimes the checksum at the end is also implemented in a different way, and this sort of thing tends to discourage the use of HEX files in situations where it is important that the executable be represented in a standard format. Perhaps, if a HEX file had a standard mechanism by which to identify these variations on the theme, they would become an acceptable standard; but then this would make the format more complex

Reference: http://xess.com/faq/M0000181.HTM
### Binary File Formats
**BIN Files**
- The nice thing about binary (BIN) files, are they that they don't conform to any standard. They simply contain raw, unaltered, plain binary data
- A BIN file typically contain a verbatim byte-for-byte representation of what is to be put into memory
- When using BIN files, you have to tell the linker which address the binary file starts at, and you must ensure that the binary file is loaded to that address on the target platform before you execute it
- It is customary to put the start() function as the first entry in a BIN file, unless the BIN file contains bytes (such as vector table values) which are placed in lower addresses to the start function

One thing to watch out for, when using BIN files, are gaps between memory segments. Consider, for instance, that you have a 32 byte exception vector starting at address 0x00000000, which goes into SRAM, and then a large gap until address 0x20100000 which contains the application code that goes to SDRAM. If you tell the linker these two addresses, and then simply generate a BIN file from this configuration, you will find that the resultant BIN file is a megabyte, i.e. contains a copy of what should go into memory starting at address 0 until the last application address. In this situation, you either need to use two binary files, loading, for the example the vectors to address 0, then the application to address 0x20100000; or you need to use a different object file format (such as ELF), or you need to be inventive; such as making the application's start() function assign the exception vectors

Binary files are generally used in cases where there is either no loader (e.g. the binary file contains the loader program), or for downloading programs directly into RAM without having to process a file format (this is often the case when you are testing or debugging embedded code on the target platform, and are frequently downloading slightly modified application programs)

**OBJCOPY**
- objcopy (part of GNU BinTools) section: GNU Development Tools (1), name: objcopy - copy and translate object files
- Synopsis (excerpt): objcopy [-F bfdname|--target=bfdname] [-I bfdname|--input-target=bfdname] [-O bfdname|--output-target=bfdname] [-S|--strip-all] [-g|--strip-debug] [-N symbolname|--strip-symbol=symbolname] [-R sectionname|--remove-section=sectionname] [--gap-fill=val] [--pad-to=address] [--set-start=val] [--adjust-start=incr] [--change-section-address section={=,+,-}val] [--set-section-flags section=flags] [-v|--verbose] [-V|--version] [--help] infile [outfile]
- Description: The GNU objcopy utility copies the contents of an object file to another. objcopy uses the GNU BFD Library to read and write the object files. It can write the destination object file in a format different from that of the source object file. The exact behavior of objcopy is controlled by command-line options. Note that objcopy should be able to copy a fully linked file between any two formats. However, copying a relocatable object file between any two formats may not work as expected
- objcopy creates temporary files to do its translations and deletes them afterward. objcopy uses BFD to do all its translation work; it has access to all the formats described in BFD and thus is able to recognize most formats without being told explicitly
- objcopy can be used to generate S-records by using an output target of srec (e.g., use -O srec)
- objcopy can be used to generate a raw binary file by using an output target of binary (e.g., use -O binary). When objcopy generates a raw binary file, it will essentially produce a memory dump of the contents of the input object file. All symbols and relocation information will be discarded. The memory dump will start at the load address
- When generating an S-record or a raw binary file, it may be helpful to use -S to remove sections containing debugging information. In some cases -R will be useful to remove sections which contain information that is not needed by the binary file
- Note - objcopy is not able to change the endianness of its input files. If the input format has an endianness, (some formats do not), objcopy can only copy the inputs into file formats that have the same endianness or which have no endianness (eg srec)
