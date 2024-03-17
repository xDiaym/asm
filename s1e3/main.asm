global  _start
extern  printf, scanf, fopen, fclose, fprintf, fscanf 
section   .text

; int digit_sum(int)
digit_sum:
    push    rbp
    push    rbx
    mov     rbp, rsp
    sub     rsp, 8

    ; abs(x) = (x XOR y) - y, y = x >> 31
    mov     eax, edi
    sar     eax, 31
    xor     edi, eax
    sub     edi, eax

    mov     ebx, 10
    mov     eax, edi
    mov     qword [rbp-8], 0
    .loop:
    mov     edx, 0
    div     ebx
    add     [rbp-8], edx
    test    eax, eax
    jnz     .loop

    mov     eax, [rbp-8]
    add     rsp, 8
    pop     rbx
    pop     rbp
    ret

_start:
    mov     rbp, rsp
    sub     rsp, 32

    mov     rdi, input_file
    mov     rsi, input_file_mode
    call    fopen
    mov     [rbp-8], rax

    mov     rdi, [rbp-8]
    mov     rsi, print_fmt
    lea     rdx, [rbp-12]
    call    fscanf

    mov     dword [rbp-20], 0  ; A_i, such digit_sum(A_i) > digit_sum(A_j), j=1..i
    mov     dword [rbp-24], 0  ; digit_sum(A_i)
    .iter:
        mov     rdi, [rbp-8]
        mov     rsi, scan_fmt
        lea     rdx, [rbp-16]
        call    fscanf

        mov     edi, [rbp-16]
        call    digit_sum
        mov     [rbp-28], eax

        cmp     [rbp-24], eax
        jl      .update
        jne     .ignore_update
        mov     eax, [rbp-16]
        cmp     [rbp-20], eax
        jl      .update
        jmp     .ignore_update

        .update:
        mov     [rbp-20], eax
        mov     eax, [rbp-28]
        mov     [rbp-24], eax

        .ignore_update:
        dec     dword [rbp-12]
        cmp     dword [rbp-12], 0
        jnz      .iter

    mov     rdi, [rbp-8]
    call    fclose

    mov     rdi, print_fmt
    mov     esi, [rbp-20]
    call    printf

    mov     rax, sys_exit
    xor     rdi, rdi
    syscall

section  .data
sys_exit            equ 60
input_file          db "input.txt", 0
input_file_mode     db "r", 0
output_file         db "output.txt", 0
output_file_mod     db "w", 0
print_fmt           db "%i", 10, 0
scan_fmt           db "%i", 0
