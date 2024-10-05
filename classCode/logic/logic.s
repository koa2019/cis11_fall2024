@ compile & run in terminal: gcc -o logic logic.s && ./logic    
@ wk 4_09-11-24
.global main
.func main

.align 4
.section .rodata
outputStr: .asciz "%d\n"

main:           @ int main(){
    push {lr}

    mov r0, #0b0111  @ int r0=0b0111 == 7
    mov r1, #0b1001  @ int r1=0b1001 == 9
    mov r2, #0b0011  @ int r2=0b0011 == 3

    and r1, r0, r1   @ int r2 = r0 & r1 -> 1
    @orr r1, r0, r1   @ int r2 = r0 | r1 -> 15 or f
    @eor r1, r0, r1   @ int r2 = r0 ^ r1 -> 14 or e
    @bic r1, r0, r2   @ r2 = ~r2 AND int r1 = r0 & r2 -> 4

    ldr r0, =outputStr
    bl printf      @ printf("%d\n", r2) 

    mov r0, #0     @ return 0;
    pop {pc}    
