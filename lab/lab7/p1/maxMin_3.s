@ 11-15-24 Lab 7 Array Question 1: Find max and min.
@ compile & run in terminal: 
@       g++ maxMin_3.s
@       ./a.out
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
len: .word 3          @ int size=10
arr: .skip 12 @int arr[10]. Each element is 4 bytes, 10*4=40 spaces
max: .word 0            @ int max=0
min: .word 0            @ int min=0


.text
main:                   @ int main(){
	str lr, [sp, #-4]!  //push {lr}

    @ set variables before for loop
    mov r4, #0          @ int i=0
    mov r5, #0          @ int max=0
    mov r6, #0          @ int min=0
    
    @ get arr ready for user input
    ldr r7, =arr
    ldr r8, =len        @ int size=10
    ldr r8,[r8]

    @ Output instructions
    ldr r0, =out1
    bl printf

for:
    cmp r4, r8          @ (i-size)==set flags
    bge printArr          @ if(i>size)(Z==0 or N==V), then exit for loop  


    @ Prompt for user's input
    ldr r0, =outGetN
    bl printf

    @ Get and set variable with user input
    ldr r0, =deref
    mov r1, r7          @ mov r1=arr
    bl scanf			@ scanf( "%d", &a[i] )

    @ output user's input
    ldr r0, =derefN
    mov r1, r7
    bl printf


increForLoop:
    @ incre for loop & the array
	add r7, #4			@ arr[i]++. +4-bytes
    add r4, r4, #1      @ i++ 
    bal for             @ keep looping



    @output arr
printArr:
    cmp r4, r8          @ (i-size)==set flags
    bge endFor          @ if(i>size)(Z==0 or N==V), then exit for loop  

    @ output arr[i]
    ldr r0, =derefN
    mov r1, r7
    @ldr r1, =arr
    @ldr r1, [r1]
    bl printf

    @ incre for loop & the array
	add r7, #4			@ arr[i]++. +4-bytes
    add r4, r4, #1      @ i++ 
    bal printArr             @ keep looping

    
@ isMax:
@     cmp r7,r5           @ (r7-r5==?). (input-max==N? V?)
@     bgt setMax          @ if(input>=max)->(N==V)
@     ble isMin           @ if(num<=max)->(Z==1 OR N!=V)

@ setMax:
@     mov r5, r7          @ max=r7 reset max with current input   
@     ldr r0, =outNewMax  @ output msg each time a new max is found
@     mov r1, r5
@     bl printf
@     bal isMin           @ branch to if input is a new min 

@ isMin:  
@     cmp r7, r6          @ (r7-r6==?). (input-min==N? V?)
@     blt setMin          @ if(input<min)->(N!=V)
@     bge increForLoop          @ if(input>=min)->(N==V). branch to endFor loop

@ setMin:
@     mov r6, r7          @ reset min with current input
@     ldr r0, =outNewMin
@     mov r1, r6
@     bl printf           @ output msg each time a new max is found
@     bal increForLoop    @ branch to if input is a new min 

endFor: 
@     ldr r0, =outMax
@     mov r1, r5
@     bl printf           @ output max

@     ldr r0, =outMin
@     mov r1, r6
@     bl printf           @ output min

    ldr r0, =ty
    bl printf           @ output endOfFile

    mov r0, #0  
    pop {pc}            @ return 0 to where i was. Pop whatever on top of stack into program counter r15
