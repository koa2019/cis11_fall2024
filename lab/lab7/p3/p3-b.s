@ 11-15-24 Lab 7 Array Question 3: Reverse array's order.
@ compile & run in terminal: 
@       g++ p3-b.s
@       ./a.out
@
@ printArr outputs a predefined array
.global main


.align 4
.section .rodata            @ readonly data   
deref:   .asciz "%d"        @ tells it a number is coming
derefN:  .asciz "%d\n"
out1:    .asciz "\n\nProgram reverses the order of an array.\n\n"
outGetN: .asciz "Enter a number: " 
outNum:    .asciz "\tYou entered: %d\n"
outArr:  .asciz "%d, " 
ty: .asciz "\nGood Bye\n\n"


.align 4
.section .data
size: .word 6          @ int size=6
arr1: .word 11,12,13,14,15,17
arr2: .skip 24 @int arr[10]. Each element is 4 bytes, 6*4=24 spaces


.text
main:                   @ int main(){
	str lr, [sp, #-4]!  @ push {lr}

    @ load arr for print function
    ldr r5, =arr1
    ldr r6, =size
    ldr r6, [r6]
    bl printArr

    @ Reverse array's order
    @arr2[0]=arr[5];

end:
    ldr r0, =ty
    bl printf           @ output endOfFile

    mov r0, #0  
    pop {pc}            @ return 0 to where i was. Pop whatever on top of stack into program counter r15


printArr:               @ printArr(int arr[]=r5, int size=r6)
    push {r4-r6, lr}
    mov r4, #0          @ int i=0

for2:                   @ output arr
    cmp r4, r6          @ (i-size)==set flags
    bge endFor2          @ if(i>size)(Z==0 or N==V), then exit for loop  

    @ output arr[i]
    ldr r0, =outArr
    ldr r1, [r5]
    bl printf

    @ incre for loop & the array
	add r5, #4			@ arr[i]++. +4-bytes
    add r4, r4, #1      @ i++ 
    bal for2            @ keep looping

endFor2:
    pop {r4-r6, lr}
