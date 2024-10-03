@ wk7_10-02-24
@ compile: gcc -o leftshift2 leftshift2.s && ./leftshift2
.global main

.align 4
.section .rodata
out: .asciz "%d\n"
outAdd: .asciz "ADD  %d + (%d^1 x 2^1) =  %d\n"
outSub: .asciz "SUB  %d - (%d^1 x 2^2) = %d\n"
outRsb: .asciz "RSB  (%d^1 x 2^2) - %d =  %d\n"


.text
main:
    push {lr}
    mov r4, #2
    mov r5, #3

    @ To multiply by 2, shift left 1. 0010<1 = 0100 = 4
    add r6, r5, r4, lsl #1      @ r6=7. r6= 3+(2^1 * 2^1) = 3+(2^2) = 3+4=7
    ldr r0, =outAdd
    mov r1, r5
    mov r2, r4
    mov r3, r6
    bl printf

    @  Subtract. To multiply by 4, shift left 2. 0010<2 = 1000 = 8
    sub r7, r5, r4, lsl #2      @ r7=-5. r7= 3-(2^1 * 2^2)=  3-(2^3) = 3-8=-5
    ldr r0, =outSub
    mov r1, r5
    mov r2, r4
    mov r3, r7
    bl printf

    @ reverse subtract. To multiply by 4, shift left 2. 0010<2 = 1000 = 8
    rsb r8, r5, r4, lsl #2      @ r8=5. r8= (2^1 * 2^2)-3 = (2^3)-3 = 8-3=5
    ldr r0, =outRsb
    mov r1, r4
    mov r2, r5
    mov r3, r8
    bl printf

    mov r0, #0
    pop {pc}
