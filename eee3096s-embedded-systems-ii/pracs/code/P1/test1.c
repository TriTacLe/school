/**  Simple program to illustrate how GDB works. 
     This program should generate a segfault at line 25.*/

/** Include libraries */
#include <stdio.h>
#include <string.h>

/** A looping function */
void copyend (int n, char* a, char* s)  {
  int i;
  for (i=0; i<n; i++) strcat(s,a);
}

/** Entry point to the program, which calls some functions */
int main() {
   char s[10] = "Hello";  /* takes 6 bytes of 10 available */
   char t[10] = "     ";  /* a temporary string */
   printf("Testing program started!\n");
   printf("Start: s='%s'  t='%s'\n",s,t);
   copyend(2,"a",s);  /* copy string "a" to end of s 2x - should be fine  */
   copyend(3,NULL,s); /* copy null to end of s 3 times - causes a problem */
   printf("End  : s='%s'  t='%s'\n",s,t);
   printf("Testing program ended without crashing!\n");
   return 0;
}

