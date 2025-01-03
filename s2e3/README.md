# s2e3

## Build

Start VM:

```bash
qemu-system-i386 -fda DOS622.img -fdb file.ima
```

Compile code:
```bash
tasm cons_m.asm
tlink cons_m.obj
exe2com cons_m.exe cons_m.sys
```
