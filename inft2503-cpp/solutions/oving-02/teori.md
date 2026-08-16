## Oving 2 teorioppgaver

### Oppgave 2
```cpp
char *line = nullptr;   // or char *line = 0;
strcpy(line, "Dette er en tekst");
```
`line` points at nothing (the null address). `strcpy` writes the source string to the memory `line` points at, so it dereferences the null pointer and writes there. This is undefined behaviour: in practice the program crashes with a segmentation fault. No memory was allocated for the text, so there is nowhere to copy it. A fix is to give `line` real storage first, e.g. `char line[64];` or `char *line = new char[64];`.

### Oppgave 3
```cpp
char text[5];
char *pointer = text;
char search_for = 'e';
cin >> text;
while (*pointer != search_for) {
    *pointer = search_for;
    pointer++;
}
```
Problems:
- `char text[5]` holds at most 4 characters plus the terminating `'\0'`. `cin >> text` does no bounds checking, so a longer input overflows the buffer.
- If the input never contains `'e'`, the loop condition `*pointer != search_for` never becomes false. `pointer` keeps advancing past the end of `text`, reading and writing memory that does not belong to the array (buffer overrun, undefined behaviour).
- The loop body overwrites every character with `'e'` before checking the next one, so it also destroys the input it walks over. There is no check against the string terminator `'\0'` to stop at the end of the text.
