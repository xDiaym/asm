.PHONY: clean

all: build

clean:
	rm *.o *.out

build:
	nasm -f elf64 -o main.o main.asm
	ld -lc --dynamic-linker /lib64/ld-linux-x86-64.so.2 main.o -o a.out
