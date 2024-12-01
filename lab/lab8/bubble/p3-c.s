@ 11-15-24 Lab 7 Array Question 3: Reverse array's order.
@ compile & run in terminal: 
@       g++ p3-c.s
@       ./a.out
@
@ reverse user's array
.global main


.align 4
.section .rodata            @ readonly data   
deref:   .asciz "%d"        @ tells it a number is coming
derefN:  .asciz "%d\n"
out1:    .asciz "\n\nProgram reverses the order of an array[6].\n\n"
outGetN: .asciz "Enter a number: " 
outNum:    .asciz "\tYou entered: %d\n"
outArr:  .asciz "%d, " 
outArrEq:  .asciz "%d=%d\n" 
outRev: .asciz "\nBubble Sort\n"
ty: .asciz "\nGood Bye\n\n"


.align 4
.section .data
size: .word 6                   @ int size=6
arr1: .word 131,412,53,2,25,66  @ int arr1[]={1,2,3,4,5,6}
arr2: .skip 24 @ int arr[10]. Each element is 4 bytes, 6*4=24 spaces
revArr: .skip 24                @ revArr[6]={0}

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

    @ @ Print reversed array
    @ ldr r0, =outRev
    @ bl printf

    @ Reverse array's order
    ldr r5, =arr1   
    ldr r6, =size
    ldr r6, [r6]
    bl bubbleSort       @ bubbleSort(int userArr[], int size)

    @ Print sorted array
    @ ldr r7, =revArr
    @ ldr r6, =size
    @ ldr r6, [r6]
    @ bl printArr

end:
    ldr r0, =ty
    bl printf           @ output endOfFile

    mov r0, #0  
    pop {pc}            @ return 0 to where i was. Pop whatever on top of stack into program counter r15

@@ --------- FUNCTION IMPLEMENTATIONS --------- @@

bubbleSort:             @ Asceneding sort user's array
    @ for(int i=0; i<size-1;i++)
        @ for(int j=0; j<size-1;j++)
            @if(arr[j]>arr[j+1]), then swap

    @ Print reversed array
    ldr r0, =outRev
    bl printf
    
    push {r4-r6, lr}    @ protect safe registers from being overwritten in function


    @ initialize loop variables before for loop
    @ r0=userArr passed into function as argument
    @ r1=size passed into function as argument
    mov r2, #0          @ int i=0
    sub r1, #1          @ stop=size-1
    mov r3, #0          @ int j=0
    mov r4, r0          @ r4=r0==userArr
    @ldr r8, =revArr     @ r8=revArr

    @ { for(int i=0; i<stop;i++)
    forI:               @ output arr
        cmp r2, r6      @ (i-size-1)==set flags
        bge endForI     @ if(i>size-1)(Z==0 or N==V), then exit for loop  

        @ { for(int j=0; j<stop;j++)
        forJ:               @ output arr
            cmp r3, r6      @ (j-stop)==set flags
            bge endForJ     @ if(j>=stop)(Z==0 or N==V), then exit for loop 

            @ load address of userArr[j]
            add r4, r4, r3, lsl #2  @ arr[j]

            @ load value of userArr[j]
            ldr r5, [r4]    @ r5=arr[j] value

            @ load address of userArr[j+1]
            add r6, r3, #1      @ r6=j+1
            add r6, r4, r6, lsl #2      @ r6=userArr[j+1] address

            @ load value userArr[j+1]
            ldr r7, [r6]

            @ output old and new array
            ldr r0, =outArrEq
            ldr r1, [r5]    @ arr[j]
            ldr r2, [r7]    @ arr[j+1]
            bl printf

            @ incre j++ & the userArr[j]++
            @ add r4, #4			@ userArr[j+4bytes]
            @ add r6, #4			@ userArr[j+1+4 bytes]
            add r3, r3, #1      @ j++ 
            bal forJ            @ keep looping
        endForJ:
        @ }

        @ incre i loop & user array
        add r5, #4			@ arr[i]++. +4bytes
        add r2, r2, #1      @ i++ 
        bal forI            @ keep looping
    endForI:
    @ }

    pop {r4-r6, pc}            @ return 0 to where i was. Pop whatever on top of stack into program counter r15
    @ }


printArr:               @ Output array
    push {r4-r6, lr}    @ protect safe registers from being overwritten in function
    mov r4, #0          @ int i=0
    @ {
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
        pop {r4-r6, pc}            @ return 0 to where i was. Pop whatever on top of stack into program counter r15
    @ }

@ Prompt for user's array of integers
getInput:

    push {lr}       @ push {lr}    
    ldr r0, =out1
    bl printf           @ Output instructions

    @ {
    for:
        cmp r4, r6          @ (i-size)==set flags
        bge endFor          @ if(i>size)(Z==0 or N==V), then exit for loop  

        @ {
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
        @ }
    endFor:
        mov r0, r2          @ return user array in r0
        pop {pc} 		@ return arr1;
    @ }
   