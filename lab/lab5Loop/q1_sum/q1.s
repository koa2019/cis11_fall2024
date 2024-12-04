@ 10-14-24 Lab 5 Loops
@ how2Compile.txt
@ compile & run in terminal: gcc -o q1 q1.s && ./q1
.global main

.align 4
.section .rodata            @ readonly data   
deref:   .asciz "%d"        @ tells it a number is coming
derefN:  .asciz "%d\n"
out1:    .asciz "Program finds the sum of 1 to n.\n"
outGetN: .asciz "\nEnter a positive number: " 
outN:    .asciz "\nn: %d\n"
outI:    .asciz "i: %d\n"
outSum:  .asciz "Sum: %d\n\n"

.align 4
.section .data
n: .word 0          @ int n=0

.text
main:                   @ int main(){
    push {lr}           @ push link register r14 to top of stack

    ldr r0, =out1       @ load register 0 with this string
    bl printf           @ branch link to print. Keeps track of where we've been


@ Ask for user's input until it's a positive integer
doWhile:        

    @ Prompt user
    ldr r0, =outGetN
    bl printf

    @ Get user's input and set variable n with input
    ldr r0, =deref      
    ldr r1, =n
    bl scanf

    @ validate user input is positive integer
    ldr r0, =n          @ load variable's address
    ldr r0, [r0]        @ load variable's value
    cmp r0, #0          @ r4-0==set flags
    ble doWhile         @ do...while(n<=0). (Z==1 or N!=V)

endDoWhile:
    @ output user's input for n
    ldr r0, =outN
    ldr r1, =n
    ldr r1, [r1]
    bl printf


    @ set variables before loops
    mov r6, #1          @ int i=1
    mov r7, #0          @ int sum=0

    @ load n's value
    ldr r5, =n          
    ldr r5, [r5]  

for:@ For loop to accumilate sum    

    cmp r6, r5          @ (i-n)==set flags
    bgt endFor          @ if(i>n). (Z==0 or N==V)    

    @ Calculate sum
    add r7, r7, r6      @ sum=sum+1
    
    add r6, r6, #1      @ i++ 
    bal for             @ keep looping

endFor:

    ldr r0, =outI
    mov r1, r6
    bl printf

    @ output user's input
    ldr r0, =outSum
    mov r1, r7
    bl printf

    mov r0, #0  
    pop {pc}    @return to where i was. Pop whatever on top of stack into program counter r15
