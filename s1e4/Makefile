CC?=clang

.PHONY: clean

all: test

lab4:
	nasm -f elf64 main.asm -o main.o

test: lab4
	$(CC) $(CFLAGS) -no-pie test.c main.o -o test.out

clean:
	rm *.out *.o