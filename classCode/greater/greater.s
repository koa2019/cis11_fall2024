@ week 5  09-16-24
@ compile:          gcc -o greater greater.s && ./greater
.global main

.align 4
.section .rodata
deref: .asciz "%d\n"

.text
main:
    push {lr}

    mov r4, #99
    @ mov r4, #75
    mov r5, #75
    @ mov r5, #76

    cmp r4, r5
    movgt r6, #2        @ if r4>r5, then r6=2
    movle r6, #1        @ if r4==r5, then r6=1
    movlt r6, #0        @ if r4<r5, then r6=0

    ldr r0, =deref
    mov r1, r6
    bl printf

    mov r0, #0
    pop {pc}
