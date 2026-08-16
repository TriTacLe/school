CC=gcc
# note the -g below for debugging
CFLAGS=-I. -g
DEPS = test1.h
OBJ = test1.o

%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

test1: $(OBJ)
	$(CC) -o $@ $^ $(CFLAGS)

clean:
	rm -f -r test1 *.o


