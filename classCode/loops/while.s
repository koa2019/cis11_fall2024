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

while:              @ while(i<stop)

    // output i
    ldr r0, =deref
    mov r1, r4
    bl printf

    add r4, r4, #1  @ i++
    cmp r4, r5      @ r0-r4==0 set zero=1, negative=?, overflow=?
    bge endLoop     @ if(r0>=stop). negative==overflow
    bal while       @ always loop

endLoop:
    mov r0, #0
    pop {pc}
