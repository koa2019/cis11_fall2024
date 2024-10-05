@ To compile & run in terminal: gcc -o store store.s && ./store
@ wk 5_ 9-18-24

.global main

.align 4
.section .data
value: .word 0           @ int value=0;
deref: .asciz "%d\n"     @ tells it a number is coming

.text
main:                   @ int main(){
    push {lr}           @ push link register r14 to top of stack

    mov r0, #15

    @ get location in memory aka address
    ldr r2, =value
    
    @ store the value of r0 and put it into address at r2
    @ str source, deset
    str r0, [r2]

    ldr r0, =deref
    ldr r1, =value
    ldr r1, [r1]    @ load the value stored at r1's address
    bl printf       @ printf(prompt); branch link. Keeps track of where we've been
    
    mov r0, #0  @return 0; }
    pop {pc}    @return to where i was. Pop whatever on top of stack into program counter r15
