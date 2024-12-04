@ To compile & run in terminal: 
@ 1. g++ fileName.s
@    ./a.out
@ 2. how2Compile.txt
@
@  Largest/Smallest Array Values
@  Write a program that lets the user enter ten values into an array. 
@  The program should then display the largest and smallest values stored in the array.
.global main

.align 4
.section .rodata            @ readonly data   
deref:   .asciz "%d"        @ tells it a number is coming
derefN:  .asciz "%d\n"
out1:    .asciz "Program finds Max and Min.\n"
outGetNum: .asciz "\nEnter a positive number: " 
outNum:    .asciz "\nn: %d\n"
outI:    .asciz "i: %d\n"
outMax:  .asciz "Max: %d\n\n"
outMin:  .asciz "Min: %d\n\n"

.align 4
.section .data
num: .word 0          @ int num=0

.text
main:                   @ int main(){
    push {lr}           @ push link register r14 to top of stack

    ldr r0, =out1       @ load register 0 with this string
    bl printf           @ branch link to print. Keeps track of where we've been


@ Ask for user's input until it's a positive integer
doWhile:        

    @ Prompt user
    ldr r0, =outGetNum
    bl printf

    @ Get user's input and set variable n with input
    ldr r0, =deref      
    ldr r1, =num
    bl scanf

    @ validate user input is positive integer
    ldr r0, =num          @ load variable's address
    ldr r0, [r0]        @ load variable's value
    cmp r0, #0          @ r4-0==set flags
    ble doWhile         @ do...while(n<=0). (Z==1 or N!=V)

endDoWhile:
    @ output user's input for num
    ldr r0, =outNum
    ldr r1, =num
    ldr r1, [r1]
    bl printf


    @ set variables before for loop
    mov r4, #5          @ int stop=10
    mov r6, #1          @ int i=1
    mov r7, #0          @ int max=0
    mov r8, #0          @ int min=0

    @ load num's value
    ldr r5, =num          
    ldr r5, [r5]  

for:@ For loop to accumilate sum    

    cmp r6, r4          @ (i-stop)==set flags
    bgt endFor          @ if(i>stop)(Z==0 or N==V), then exit for loop  

    @ incre for loop
    add r6, r6, #1      @ i++ 
    bal for             @ keep looping

endFor:


    ldr r0, =outI
    mov r1, r6
    bl printf

    @ output Max
    ldr r0, =outMax
    mov r1, r7
    bl printf

    @ output Min
    ldr r0, =outMin
    mov r1, r8
    bl printf

    mov r0, #0  
    pop {pc}    @return to where i was. Pop whatever on top of stack into program counter r15
