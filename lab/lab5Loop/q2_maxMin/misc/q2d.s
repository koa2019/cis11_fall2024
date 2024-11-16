@ 10-14-24 Lab 5 Loops
@ compile & run in terminal: gcc -o q2d q2d.s && ./q2d
@ how2Compile.txt
@ This version used a different cmp than the 2 previous versions.
.global main

.align 4
.section .rodata            @ readonly data   
deref:   .asciz "%d"        @ tells it a number is coming
derefN:  .asciz "%d\n"
out1:    .asciz "\n\nInput as many integers as you want and\nthe program will find the largeset and smallest number.\n"
outGetN: .asciz "\nEnter a positive number: " 
outN:    .asciz "\nYou entered: %d\n"
outMax:    .asciz "\nMax: %d\n"
outMin:  .asciz "Min: %d\n"
ty: .asciz "\nGood Bye\n\n"


.align 4
.section .data
num: .word 0            @ int num=0
max: .word 0            @ int max=0
min: .word 0            @ int min=0


.text
main:                   @ int main(){
    push {lr}           @ push link register r14 to top of stack

    @ set variables
    mov r4, #99          @ int stop=-99      
    mov r5, #0           @ int max=0
    mov r6, #0           @ int min=0

    ldr r0, =out1
    bl printf

@doWhile:

    @ Prompt for user's input
    ldr r0, =outGetN
    bl printf

    @ Get and set variable num with input
    ldr r0, =deref
    ldr r1, =num
    bl scanf

    @ load num
    ldr r7, =num
    ldr r7, [r7]          @ num=r7

    @------- Check for max -------@    
    cmp r5,r7           @ (r5-r7==?). (max-num==?)
    blt setMax          @ if(max<num) (N!==V)
    bge endMax          @ if(max>=num) (N==V)

setMax:
    mov r5, r7          @ max=r7 current num   

endMax:
    ldr r0, =outMax
    mov r1, r5
    bl printf

endDoWhile:
    ldr r0, =ty
    bl printf

    mov r0, #0  
    pop {pc}    @return to where i was. Pop whatever on top of stack into program counter r15
