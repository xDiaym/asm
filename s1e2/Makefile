AS?=nasm
LD?=ld

all:
	nasm -felf64 main.asm -o main.o
	ld main.o -lc --dynamic-linker /lib/ld-linux-x86-64.so.2 -o a.out