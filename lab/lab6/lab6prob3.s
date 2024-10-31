@ To compile & run in terminal: gcc -o lab6prob3 lab6prob3.s && ./lab6prob3
.global main

.align 4 
.section .rodata @ all constant initalized data goes here
deref: .asciz "%d"      @ tells it a number is coming
derefN:  .asciz "%d\n"
out: .asciz "%dF  == %dC\n"

.align 4
.text
main:                   @ int main(){
    push {lr}           @ push link register r14 to top of stack

    mov r4, #0          @ int i=0
    mov r5, #5          @ stop loop
    mov r6, #0          @ Celisus

    for:
        cmp r4, r5      @ i-20==?
        bgt endFor      @ if(i>20), then end loop

        @ (Fahrenheit-32)
        sub r6, r4, #32

        ldr r0, =out
        mov r1, r4
        mov r2, r6
        bl printf

        add r4, #1
        bal for

endFor:
    mov r0, #0  @return 0
    pop {pc}    @return to where i was. Pop whatever on top of stack into program counter r15
