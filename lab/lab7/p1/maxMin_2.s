@ 11-15-24 Lab 7 Array Question 1: Find max and min.
@ compile & run in terminal: g++ maxMin_2.s
@                            ./a.out
@ how2Compile.txt

.global main

.align 4
.section .rodata            @ readonly data   
deref:   .asciz "%d"        @ tells it a number is coming
derefN:  .asciz "%d\n"
out1:    .asciz "\n\nInput as many integers as you want and\nthe program will find the largeset and smallest number.\n\n"
outGetN: .asciz "Enter an integer: " 
outN:    .asciz "\nYou entered: %d\n"
outMax:  .asciz "\nMax: %d\n"
outMin:  .asciz "Min: %d\n"
outNewMax: .asciz "\t\tNew Max: %d!\n"
outNewMin: .asciz "\t\tNew Min: %d!\n"
ty: .asciz "Good Bye\n\n"


.align 4
.section .data
input: .word 0          @ int input=0
max: .word 0            @ int max=0
min: .word 0            @ int min=0


.text
main:                   @ int main(){
    push {lr}           @ push link register r14 to top of stack

    @ set variables before for loop
    mov r5, #0          @ int max=0
    mov r6, #0          @ int min=0
    mov r4, #0          @ int i=0
    mov r8, #3          @ int stop=10

    ldr r0, =out1
    bl printf

for:
    cmp r4, r8          @ (i-stop)==set flags
    bge endFor          @ if(i>stop)(Z==0 or N==V), then exit for loop  


    @ Prompt for user's input
    ldr r0, =outGetN
    bl printf

    @ Get and set variable with input
    ldr r0, =deref
    ldr r1, =input
    bl scanf

    @ load input
    ldr r7, =input
    ldr r7, [r7]        @ input=r7
    
isMax:
    cmp r7,r5           @ (r7-r5==?). (input-max==N? V?)
    bgt setMax          @ if(input>=max)->(N==V)
    ble isMin           @ if(num<=max)->(Z==1 OR N!=V)

setMax:
    mov r5, r7          @ max=r7 reset max with current input   
    ldr r0, =outNewMax  @ output msg each time a new max is found
    mov r1, r5
    bl printf
    bal isMin           @ branch to if input is a new min 

isMin:  
    cmp r7, r6          @ (r7-r6==?). (input-min==N? V?)
    blt setMin          @ if(input<min)->(N!=V)
    bge increForLoop          @ if(input>=min)->(N==V). branch to endFor loop

setMin:
    mov r6, r7          @ reset min with current input
    ldr r0, =outNewMin
    mov r1, r6
    bl printf           @ output msg each time a new max is found
    bal increForLoop    @ branch to if input is a new min 

increForLoop:
    @ incre for loop
    add r4, r4, #1      @ i++ 
    bal for             @ keep looping


endFor: 
    ldr r0, =outMax
    mov r1, r5
    bl printf           @ output max

    ldr r0, =outMin
    mov r1, r6
    bl printf           @ output min

    ldr r0, =ty
    bl printf           @ output endOfFile

    mov r0, #0  
    pop {pc}            @ return 0 to where i was. Pop whatever on top of stack into program counter r15
