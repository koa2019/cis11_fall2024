@ wk 5 09-16-24
@ compile:      gcc -o equal equal.s && ./equal
.global main

.align 4
.section .rodata
deref: .asciz "%d\n"

.text
main:
    push {lr}

    mov r4, #10
    @ mov r5, #99     
    mov r5, #10

    cmp r4, r5
    moveq r6, #50       @ if r4==r5, then set r6=50
    movne r6, #0        @ if r4!=r5, then set r6=0

    ldr r0, =deref
    mov r1, r6
    bl printf

    mov r0, #0
    pop {pc}


