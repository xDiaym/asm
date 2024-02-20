@echo Cleaning
del *.bin *.exe *.obj *.lnk

@echo Compiling MASM 
ml64 masm.asm /link /entry:main

@echo Compiling NASM
nasm\nasm.exe -f win64 nasm.asm
link /entry:start /subsystem:console nasm.obj kernel32.lib

@echo Compiling FASM
SET INCLUDE=..\fasmw17332\INCLUDE
fasmw17332\FASM.EXE fasm.asm

@echo Post build cleaning
del *.bin *.obj *.lnk
