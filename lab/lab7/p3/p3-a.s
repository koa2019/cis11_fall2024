@ 11-15-24 Lab 7 Array Question 3: Reverse array's order.
@ compile & run in terminal: 
@       g++ p3-a.s
@       ./a.out
@
@ getInput() let's user input 6 numbers AND printArr prints
.global main


.align 4
.section .rodata            @ readonly data   
deref:   .asciz "%d"        @ tells it a number is coming
derefN:  .asciz "%d\n"
out1:    .asciz "\n\nProgram reverses the order of an array[6].\n\n"
outGetN: .asciz "Enter a number: " 
outNum:    .asciz "\tYou entered: %d\n"
outArr:  .asciz "%d, " 
ty: .asciz "\nGood Bye\n\n"


.align 4
.section .data
size: .word 6          @ int size=6
arr1: .word 131,412,53,2,25,66
arr2: .skip 24 @int arr[10]. Each element is 4 bytes, 6*4=24 spaces


.text
main:                   @ int main(){
	str lr, [sp, #-4]!  @ push {lr}

    @ @ get arr ready for user input
    @ ldr r5, =arr2
    @ ldr r6, =size        @ int size=12
    @ ldr r6, [r6]    
    @ bl getInput          @ getInput(int arr[]=r0, int size=r1)

    @ @ load user arr for print function
    @ ldr r5, =arr2
    @ ldr r6, =size
    @ ldr r6, [r6]
    @ b printArr

    @ load predefined arr for print function
    ldr r5, =arr1
    ldr r6, =size
    ldr r6, [r6]
    bl printArr

end:
    ldr r0, =ty
    bl printf           @ output endOfFile

    mov r0, #0  
    pop {pc}            @ return 0 to where i was. Pop whatever on top of stack into program counter r15

@@ --------- FUNCTION IMPLEMENTATIONS --------- @@

printArr:               @ Output array
    push {lr}
    mov r4, #0          @ int i=0

printFor:               @ output arr
    cmp r4, r6          @ (i-size)==set flags
    bge endPrintFor          @ if(i>size)(Z==0 or N==V), then exit for loop  

    @ output arr[i]
    ldr r0, =outArr
    ldr r1, [r5]
    bl printf

    @ incre for loop & the array
	add r5, #4			@ arr[i]++. +4-bytes
    add r4, r4, #1      @ i++ 
    bal printFor            @ keep looping

endPrintFor:

    ldr r0, =ty
    bl printf           @ output endOfFile
    pop {pc}            @ return 0 to where i was. Pop whatever on top of stack into program counter r15


@ Prompt for user's array of integers
getInput:

    push {lr}       @ push {lr}    
    ldr r0, =out1
    bl printf           @ Output instructions

for:
    cmp r4, r6          @ (i-size)==set flags
    bge endFor          @ if(i>size)(Z==0 or N==V), then exit for loop  


doWhile:  @ Ask for user's input until it's a positive integer

    @ Prompt for user's input
    ldr r0, =outGetN
    bl printf

    @ Get and set variable with user input
    ldr r0, =deref
    mov r1, r5          @ mov r1=arr
    bl scanf			@ scanf( "%d", &a[i] )

    @ validate user input is positive integer
    ldr r0, [r5]        @ load variable's address
    cmp r0, #0          @ r4-0==set flags
    ble doWhile         @ do...while(n<=0). (Z==1 or N!=V)

    @ output user's input
    ldr r0, =outNum
    ldr r1, [r5]
    bl printf
    
    increForLoop:
    @ incre for loop & the array
	add r5, #4			@ arr[i]++. +4-bytes
    add r4, r4, #1      @ i++ 
    bal for             @ keep looping

endFor:
	mov r0, r2          @ return user array in r0
	pop {pc} 		@ return arr1;
   