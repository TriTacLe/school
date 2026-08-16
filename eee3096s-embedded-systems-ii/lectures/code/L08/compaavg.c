/* compaavg: compare first parameter A to average of the two parameters
   Set up two signed 32-bit integer variables A and B.
   Form the average of these (i.e. add them together and divide by two), and set
   this average to a third variable AVG.
   If A > AVG then set the result r0 to 1
   If A < AVG then set the result r0 to -1
   If A = AVG then set the result r0 to 0

*/

#include <stdio.h>

int compaavg ( int a, int b )
{
    int avg;
    a = 100;
    b = 200;
    avg = (a+b)/2;
    if (a>avg) return 1;
    if (a<avg) return -1;
    if (a==avg) return 0;
    return 0;
}


int main ()
{
    int a = 100, b = 200, res = 0;
    res = compaavg(a,b);
    printf("%d acmp %d --> Result = %d\n",a,b,res);
    return 0;
}
