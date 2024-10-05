.global main

.align 4
.section .rodata
deref: .asciz "%d\n"

.text
main:
    push {lr}

    @ initialize start and stop points outside of loop
    mov r4, #0      @ int i=0
    mov r5, #3      @ int stop=3

for:                @ for(int i=0; i<=stop;i++)
    
    // output i
    ldr r0, =deref
    mov r1, r4
    bl printf

    cmp r4, r5      @ r0-r4== set status flag
    beq endLoop     @ if r0==stop, then go to this label
    @ bge endLoop     @ if r0>=stop, then go to this lable

    add r4, r4, #1  @ i++
    bal for         @ loop

endLoop:
    mov r0, #0
    pop {pc}
