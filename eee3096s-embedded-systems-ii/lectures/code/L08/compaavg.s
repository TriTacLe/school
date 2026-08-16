@ EEE3096S 2020 Assmeble Programming Class Activity 1

compaavg:       @ function compaavg that compares
                @ param a to average of params a+b
  mov  r1, #100 @ set r1 = a = 100
  mov  r2, #200 @ set r2 = b = 200
  add     r3, r1, r2  @ avg = r3 = a + b
  asr     r3, r3, #1  @ avg = avg / 2
  cmp     r1, r3   @ compare r1 to r3, i.e. a vs. avg
  bgt     Greater  @ branch to Greater if a>avg
  blt     Lesser   @ branch to Lesser if a<avg
Equal:             @ can put a label for other option,
                   @ execution proceed here if a==avg
  mov     r0, #0   @ set ret = 0 and return
  b       Return

Greater:
  mov     r0, #1   @ set ret = 0 and return
  b       Return
Lesser:
  mov     r0, #0      @ a bit more complicated because -1 is 0xFFFFFFFF
  sub     r0, r0, #1  @ so that takes more that 16 bits to store in the instruction
  b       Return      @ therefore I'm just subtracting 1 from 0 to get -1.
Return:
  bx      lr	@ returns from the functon

