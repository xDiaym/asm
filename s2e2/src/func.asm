bits 64
default rel

extern sin

section .text
global f

kPhase      dd 100.0
kN          dd 2.0
kA          dd 4.0
kZero       dd 0.0
kZero2      dd 1071644672

kFrom       dd 1.0
kTo         dd 4.0

int_f:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 16

    movss       dword [rbp-4], xmm0

    mulss       xmm0, [kPhase]
    cvtss2sd    xmm0, xmm0
    call        sin wrt ..plt
    cvtsd2ss    xmm0, xmm0

    movss       xmm1, dword [rbp-4]
    mulss       xmm1, xmm1
    divss       xmm0, xmm1
    
    add     rsp, 16
    pop     rbp
    ret

f:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 24
    mov     DWORD   [rbp-20], edi
    movss   xmm0, DWORD   [kTo]
    movss   xmm1, DWORD   [kFrom]
    subss   xmm0, xmm1
    pxor    xmm1, xmm1
    cvtsi2ss        xmm1, DWORD   [rbp-20]
    divss   xmm0, xmm1
    movss   DWORD   [rbp-12], xmm0
    mov     eax, DWORD   [kFrom]
    movd    xmm0, eax
    call    int_f
    movss   DWORD   [rbp-24], xmm0
    mov     eax, DWORD   [kTo]
    movd    xmm0, eax
    call    int_f
    addss   xmm0, DWORD   [rbp-24]
    pxor    xmm1, xmm1
    cvtss2sd        xmm1, xmm0
    movsd   xmm0, QWORD   [kZero]
    mulsd   xmm0, xmm1
    cvtsd2ss        xmm0, xmm0
    movss   DWORD   [rbp-4], xmm0
    mov     DWORD   [rbp-8], 0
    jmp     .L4
.L5:
    pxor    xmm0, xmm0
    cvtsi2ss        xmm0, DWORD   [rbp-8]
    movaps  xmm1, xmm0
    mulss   xmm1, DWORD   [rbp-12]
    movss   xmm0, DWORD   [kFrom]
    addss   xmm1, xmm0
    movd    eax, xmm1
    movd    xmm0, eax
    call    int_f
    movss   xmm1, DWORD   [rbp-4]
    addss   xmm0, xmm1
    movss   DWORD   [rbp-4], xmm0
    add     DWORD   [rbp-8], 1
.L4:
    mov     eax, DWORD   [rbp-8]
    cmp     eax, DWORD   [rbp-20]
    jl      .L5
    movss   xmm0, DWORD   [rbp-4]
    mulss   xmm0, DWORD   [rbp-12]
    leave
    ret