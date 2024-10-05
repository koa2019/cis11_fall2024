@ To compile & run in terminal: gcc -o fileName fileName.s && ./fileName
.global main
.func main

.align 4
.section .rodata @ all constant initalized data goes here
deref: .asciz "%d"      @ tells it a number is coming
output: .asciz "Your number is: %d\n" @ like scanf syntax in C lang
hello: .asciz "Hello World\n"

.align 4 
.section .bss @ all the uninitalized data goes here - wont use this tille we get into dynamic arrays

.align 4
.section .data @ all non-constant initalized data goes here
value: .word 66          @ int value=66

.align 4
.text
main:                   @ int main(){
    push {lr}           @ push link register r14 to top of stack

    ldr r0, =hello
	bl printf

    mov r0, #0  @return 0
    pop {pc}    @return to where i was. Pop whatever on top of stack into program counter r15
