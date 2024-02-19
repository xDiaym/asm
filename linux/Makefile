
all: gas fasm nasm

gas:
	as gas.S -o gas.o
	ld gas.o -o gas.out

fasm:
	fasm fasm.asm fasm.out

nasm:
	nasm -felf64 nasm.asm -o nasm.o
	ld nasm.o -o nasm.out

clean:
	rm *.o *.out