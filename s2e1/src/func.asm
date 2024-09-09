bits 64
default rel

extern log
extern cos

section .text
global f

kPi     dd 3.141592653589793115997963468544185161590576171875
kA      dd 2.0
kHalfA  dd 1.0
kThreeA dd 6.0
kSignMask dd 0x7fffffff

f:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 16

    movss   dword [rbp-4], xmm0

    ; 1st stage
    subss   xmm0, [kHalfA]

    movss   xmm1, [kSignMask]
    andps   xmm0, xmm1

    cvtss2sd xmm0, xmm0
    call log wrt ..plt
    cvtsd2ss xmm0, xmm0
    movss    dword [rbp-8], xmm0

    ; 2nd stage
    movss   xmm0, dword [rbp-4]
    mulss   xmm0, [kPi]
    divss   xmm0, [kThreeA]
    cvtss2sd xmm0, xmm0
    call cos wrt ..plt
    cvtsd2ss xmm0, xmm0

    ; 1-2 interstage
    addss   xmm0, dword [rbp-8]

    ;; 3rd stage
    movss   xmm1, dword [rbp-4]
    mulss   xmm1, xmm1
    divss   xmm1, [kA]

    movss   xmm2, dword [rbp-4]
    divss   xmm2, [kA]

    addss   xmm1, xmm2
    
    addss   xmm1, [kHalfA]

    divss   xmm0, xmm1

    add     rsp, 16
    pop     rbp
    ret