bits 64
default rel

section .text
global asm_strtok
extern memset

;; https://github.com/bminor/musl/blob/master/src/string/strspn.c
global asm_strspn
asm_strspn:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 256

    mov     qword [rbp-256], 0
    mov     qword [rbp-248], 0
    mov     qword [rbp-240], 0
    mov     qword [rbp-232], 0
    mov     qword [rbp-224], 0
    mov     qword [rbp-216], 0
    mov     qword [rbp-208], 0
    mov     qword [rbp-200], 0
    mov     qword [rbp-192], 0
    mov     qword [rbp-184], 0
    mov     qword [rbp-176], 0
    mov     qword [rbp-168], 0
    mov     qword [rbp-160], 0
    mov     qword [rbp-152], 0
    mov     qword [rbp-144], 0
    mov     qword [rbp-136], 0
    mov     qword [rbp-128], 0
    mov     qword [rbp-120], 0
    mov     qword [rbp-112], 0
    mov     qword [rbp-104], 0
    mov     qword [rbp-96], 0
    mov     qword [rbp-88], 0
    mov     qword [rbp-80], 0
    mov     qword [rbp-72], 0
    mov     qword [rbp-64], 0
    mov     qword [rbp-56], 0
    mov     qword [rbp-48], 0
    mov     qword [rbp-40], 0
    mov     qword [rbp-32], 0
    mov     qword [rbp-24], 0
    mov     qword [rbp-16], 0
    mov     qword [rbp-8], 0

    mov     r12, rdi  ;; save start of src strting

    test     rsi, rsi
    jz      .empty_src

    ;; fill char mask
    .mask_fill:
    movsx   r8, byte [rsi]
    test    r8, r8
    jz      .mask_check
    or      byte [rsp+r8], 1
    inc     rsi
    jmp     .mask_fill

    .mask_check:
    movsx   r8, byte [rdi]
    test    r8, r8
    jz      .cmp_end
    movsx   r9, byte [rsp+r8]
    test    r9, r9
    jz      .cmp_end
    inc     rdi
    jmp     .mask_check


    .cmp_end:
    mov     rax, rdi
    sub     rax, r12
    jmp     .end

    .empty_src:
    mov     rax, 0

    .end:
    add     rsp, 256
    pop     rbp
    ret

asm_strtok:
    push    rbp
    mov     rbp, rsp

    test    rbp, rbp
    jnz     .nonzero
    mov     [saveptr], rdi

    .nonzero:

    mov     rax, 0

    pop rbp
    ret

section .data
hello_fmt   db "Hello world!", 10, 0

section .bss
saveptr     resq 1

