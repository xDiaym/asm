bits 64
default rel

extern log

section .text
global f

kPi     dd 3.141592653589793
kA      dd 2.0
kHalfA  dd 1.0
kThreeA dd 6.0
kSignMask dd 0x7fffffff

f:
    push    rbp
    mov     rbp, rsp

    movss   xmm7, xmm0

    ; 1st stage
    subss   xmm0, [kHalfA]

    movss   xmm1, [kSignMask]
    andps   xmm0, xmm1

    cvtss2sd xmm0, xmm0
    call log wrt ..plt
    cvtsd2ss xmm0, xmm0

    ; 2nd stage
    movss   xmm1, xmm7
    mulss   xmm1, [kPi]
    divss   xmm1, [kThreeA]

    ; 1-2 interstage
    addss   xmm0, xmm1

    ; 3rd stage
    movss   xmm1, xmm7
    mulss   xmm1, xmm1
    divss   xmm1, [kA]

    movss   xmm2, xmm7
    divss   xmm2, [kA]

    addss   xmm1, xmm2
    
    addss   xmm1, [kHalfA]

    divss   xmm0, xmm1

    pop     rbp
    ret