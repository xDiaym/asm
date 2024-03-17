global  _start
extern  printf, scanf, fopen, fclose, fprintf, fscanf 
section   .text

; int digit_sum(int)
digit_sum:
    push    rbp
    push    rbx
    mov     rbp, rsp
    sub     rsp, 8

    ; rdi - 
    mov     rbx, 10
    mov     rax, rdi
    mov     qword [rbp-8], 0
    .loop:
    mov     rdx, 0
    div     rbx
    add     [rbp-8], rdx
    test    rax, rax
    jnz     .loop

    mov     rax, [rbp-8]
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
    mov     rsi, read2_fmt
    lea     rdx, [rbp-12]
    call    fscanf

    .iter:
        mov     rdi, [rbp-8]
        mov     rsi, read2_fmt
        lea     rdx, [rbp-16]
        call    fscanf

        mov     rdi, read1_fmt
        mov     esi, [rbp-16]
        call    printf

        dec     dword [rbp-12]
        cmp     dword [rbp-12], 0
        jnz      .iter

    mov     rdi, [rbp-8]
    call    fclose

    mov     rax, sys_exit
    xor     rdi, rdi
    syscall

section  .data
sys_exit            equ 60
input_file          db "input.txt", 0
input_file_mode     db "r", 0
output_file         db "output.txt", 0
output_file_mod     db "w", 0
read1_fmt           db "%i", 10, 0
read2_fmt           db "%i", 0
