
global  _start
extern  printf
extern  scanf

section   .text

; int is_prime(int n)
is_prime:
    push    rbx
    push    rbp
    mov     rbp, rsp

    mov     rax, 0
    cmp     rdi, 2
    jl      .end

    mov     rax, 1
    cmp     rdi, 2
    je      .end

    mov     rbx, rdi
    shr     rbx, 1

    mov     rcx, 2
    .loop:
    xor     rdx, rdx
    mov     rax, rdi
    div     rcx

    test     rdx, rdx
    jz      .test_failed

    inc     rcx
    cmp     rcx, rbx
    jle     .loop

    mov     eax, 1
    jmp     .end

    .test_failed:
    mov     rax, 0

    .end:
    mov     rsp, rbp
    pop     rbp
    pop     rbx
    ret


; int count_primes(int n)
count_primes:
    push    rbx
    push    rbp
    mov     rbp, rsp
    sub     rsp, 16

    mov     rax, 0
    cmp     rdi, 1
    jle     .end

    mov     qword [rbp-8], 0  ; primes counter
    mov     rbx, rdi  ; top limit
    shl     rbx, 1
    mov     qword [rbp-16], 2    ; loop counter
    .loop:
    mov     rdi, [rbp-16]
    call    is_prime
    add     [rbp-8], rax
    
    inc     qword [rbp-16]
    cmp     [rbp-16], rbx
    jl      .loop

    mov     rax, [rbp-8]
    .end:
    mov     rsp, rbp
    pop     rbp
    pop     rbx
    ret


_start:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 8

    mov     rdi, scan_fmt
    lea     rsi, [rbp-8]
    call    scanf

    mov     rdi, [rbp-8]
    call    count_primes

    mov     rdi, print_fmt
    mov     rsi, rax
    call    printf

    add     rsp, 8
    pop     rbp

    mov     rax, 60
    xor     rdi, rdi
    syscall

section   .data
scan_fmt:   db  "%ld", 0
print_fmt:  db  "%ld", 10, 0