@ compile & run in terminal: gcc lab6prob1a.s && ./a.out
.global main

.align 4
.section .rodata           @ readonly data   
deref: .asciz "%d"         @ tells it a number is coming
derefN: .asciz "%d\n"      @ tells it a number is coming
outD:    .asciz "\tDistance: %d\n"
outT:    .asciz "\Time: %d\n"
outResults: .asciz "%d sec = %d meters\n" @ like scanf syntax in C lang

.text
main:                   @ int main(){
    push {lr}           @ push link register r14 to top of stack

    mov r0, #0
    pop {pc}