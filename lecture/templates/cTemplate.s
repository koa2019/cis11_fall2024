.global main

@ compile & run in terminal: gcc -o fileName fileName.s && ./fileName

.align 4
.section .rodata        @ readonly data
prompt: .asciz "Enter a number: "   
inputPattern: .asciz "%d" @ tells it a number is coming
output: .asciz "Your number is: %d\n"

.align 4
.section .data
value: .word 0          @ int value=0;
deref: .asciz "%d\n"    @ tells it a number is coming

.text
main:                   @ int main(){
    push {lr}           @ push link register r14 to top of stack

    @ldr r0, =prompt  // load register 0 with this string
    @bl printf          // branch link to print. Keeps track of where we've been

    mov r0, #0  @return 0; }
    pop {pc}    @return to where i was. Pop whatever on top of stack into program counter r15
