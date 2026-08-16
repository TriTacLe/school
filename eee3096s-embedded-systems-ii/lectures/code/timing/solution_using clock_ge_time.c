/* REFERENCE SOURCE: https://stackoverflow.com/questions/361363/how-to-measure-time-in-milliseconds-using-ansi-c
   as per posting:
 
    use the clock_gettime() function, returning time from the CLOCK_MONOTONIC clock. The time returned is
    the amount of time, in seconds and nanoseconds, since some unspecified point in the past, such as
    system startup of the epoch.
	
	Using this example code:
	
	
*/

#include <stdio.h>
#include <stdint.h>
#include <time.h>

int64_t timespecDiff(struct timespec *timeA_p, struct timespec *timeB_p)
{
  return ((timeA_p->tv_sec * 1000000000) + timeA_p->tv_nsec) -
           ((timeB_p->tv_sec * 1000000000) + timeB_p->tv_nsec);
}

int main(int argc, char **argv)
{
  struct timespec start, end;
  
  // Get start time
  clock_gettime(CLOCK_MONOTONIC, &start);

  // Do some code I am interested in measuring

  printf("TEST!\n"); // <- just for testing, print takes many us

  // Get end time:
  clock_gettime(CLOCK_MONOTONIC, &end);

  // calculate time difference in ns
  uint64_t timeElapsed = timespecDiff(&end, &start);

  // print the time difference between start and end
  printf("DURATION = %lu us\n",(long unsigned)timeElapsed);
}
