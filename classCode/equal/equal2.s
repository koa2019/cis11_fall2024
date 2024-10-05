@ wk 5 09-16-24
@ compile:      gcc -o equal2 equal2.s && ./equal2
.global main

.align 4
.section .rodata
deref: .asciz "%d\n"
outEq: .asciz "if %d==%d, then r6=%d\n\n"
outNE: .asciz "if %d!=%d, then r6=%d\n\n"

.text
main:
    push {lr}

    mov r4, #10
    mov r5, #99     
    @ mov r5, #10

    cmp r4, r5
    beq equal       @ if r4==r5, then branch to this label        
    bne notEq       @ if r4!=r5, then branch to this label  
    
    equal:
        mov r6, #50
        ldr r0, =outEq
        mov r1, r4
        mov r2, r5
        mov r3, r6
        bl printf
        b end

    notEq:
        mov r6, #0
        ldr r0, =outNE
        mov r1, r4
        mov r2, r5
        mov r3, r6
        bl printf
        b end

    end:
    mov r0, #0
    pop {pc}


