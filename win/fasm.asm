format PE console
include 'win32ax.inc'

section '.code' code readable executable
start:
    cinvoke printf, "Hello, world!%c", 10


section '.idata' import data readable
library msvcrt, 'msvcrt.dll', kernel32, 'kernel32.dll'
import msvcrt, printf, 'printf'
