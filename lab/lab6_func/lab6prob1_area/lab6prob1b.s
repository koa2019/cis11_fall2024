@ 10-30-24 Lab6 Prob 1 Area using functions
@ compile & run in terminal: gcc lab6prob1b.s && ./a.out
.global main

.align 4
.section .rodata        @ readonly data   
deref: .asciz "%d"      @ tells it a number is coming
derefN: .asciz "%d\n"      @ tells it a number is coming
inW: .asciz "Input Width: "
inL: .asciz "Input Length: "
outGetPositive: .asciz "\nEnter a positive number: " 
outW:    .asciz "\tWidth: %d\n"
outL:    .asciz "\tLength: %d\n"
outArea1: .asciz "\n\nWidth x Length = Area\n" @ like scanf syntax in C lang
outArea2: .asciz "%d x %d = " @ like scanf syntax in C lang

.align 4
.section .data
w: .word 0          @ int w=0
l: .word 0          @ int w=0


.text
main:                   @ int main(){
    push {lr}           @ push link register r14 to top of stack

getWidth:               @ Ask for user's input until it's a positive integer


    ldr r0, =inW        @ load register 0 with this string
    bl printf           @ branch link to print. Keeps track of where we've been

    @ Get user's input and set variable n with input
    ldr r0, =deref      
    ldr r1, =w
    bl scanf

    @ validate user input is positive integer
    ldr r4, =w          @ load variable's address
    ldr r4, [r4]        @ set r4=width
    cmp r4, #0          @ r4-0==set flags
    ble getWidth        @ do...while(n<=0). (Z==1 or N!=V)

getLength:             @ Ask for user's input until it's a positive integer


    ldr r0, =inL       @ load register 0 with this string
    bl printf          @ branch link to print. Keeps track of where we've been

    @ Get user's input and set variable n with input
    ldr r0, =deref      
    ldr r1, =l
    bl scanf

    @ validate user input is positive integer
    ldr r5, =l          @ load variable's address
    ldr r5, [r5]        @ set r5=length
    cmp r5, #0          @ r4-0==set flags
    ble getLength       @ do...while(n<=0). (Z==1 or N!=V)

    @ Caluculate Area=Width*Length
    mul r6, r4, r5

    @ Output results
    ldr r0, =outArea1
    bl printf
    ldr r0, =outArea2
    mov r1, r4
    mov r2, r5 
    bl printf
    ldr r0, =derefN
    mov r1, r6
    bl printf

    mov r0, #0  @return 0
    pop {pc}    
