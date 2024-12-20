@ 11-15-24 Lab 7 Array Question 3: Reverse array's order.
@ compile & run in terminal: 
@       g++ p3-c_reverse.s && ./a.out
.global main


.align 4
.section .rodata            @ readonly data   
deref:   .asciz "%d"        @ tells it a number is coming
derefN:  .asciz "%d\n"
out1:    .asciz "\n\nProgram reverses the order of an array.\n\n"
outGetN: .asciz "Enter a number: " 
outNum:  .asciz "\nUser Array:\n"
outArr:  .asciz "%d, "
outUsrArrIndx: .asciz "userArr[%d]=%d == " 
outRevArrIndx: .asciz "revArr[%d] = %d\n"
outRev: .asciz "\nReversed Array: \n"
outBefore: .asciz "\n\nBefore...\n"
outInside: .asciz "\n\nInside reversed function...\n\n"
outAfter: .asciz "\n\nAfter...\n"
ty: .asciz "\n\nGood Bye\n\n"


.align 4
.section .data
size: .word 6          @ int size=6
defUserArr: .word 6, 5, 4, 3, 2, 1
userArr: .skip 24 @int arr[10]. Each element is 4 bytes, 6*4=24 spaces
revArr: .skip 24
defRevArr: .word 100, 90, 80, 70, 66, 50


.text
main:                   @ int main(){
	str lr, [sp, #-4]!  @ push {lr}

    @ load predefined arr for print function    
    ldr r0, =outBefore
    bl printf

    ldr r0, =outNum
    bl printf

    ldr r0, =defUserArr
    ldr r1, =size
    ldr r1, [r1]
    bl printArr1         @ printArr(defUserArr[]=r5, size=r6)

    @ Load and output prefined revArr[] before anything is altered 
    ldr r0, =outRev
    bl printf

    ldr r0, =defRevArr
    ldr r1, =size
    ldr r1, [r1]
    bl printArr1       @ printArr1(defRevArr[]=r0, size=r1)

    @ Reverse user array
    ldr r0, =defUserArr
    ldr r1, =size
    ldr r1, [r1]
    bl reversed         @ reversed(arr=r0,size=r1)

    @ AFTER
    @ Load and output revArr for print function         
    ldr r0, =outAfter
    bl printf

    ldr r0, =outNum
    bl printf

    ldr r0, =defUserArr
    ldr r1, =size
    ldr r1, [r1]
    bl printArr1         @ printArr(defUserArr[]=r5, size=r6)

    ldr r0, =outRev
    bl printf

    ldr r0, =defRevArr
    ldr r1, =size
    ldr r1, [r1]
    bl printArr1       @ printArr1(defRevArr[]=r0, size=r1)

end:
    ldr r0, =ty
    bl printf           @ output endOfFile

    mov r0, #0  
    pop {pc}            @ return 0 to where i was. Pop whatever on top of stack into program counter r15


            @@ --------- FUNCTION IMPLEMENTATIONS --------- @@

reversed:               @ reversed(userArr=r0, size=r1)

    push {r4-r8, lr}    @ protect safe registers from being overwritten in function

    @ Do this: Reverse array
    @ for(int i=0, j=size-1; i<size; i++, j--){
    @     revArr[j]=userArr[i]; }

    @ set variables before for the loop
    mov r4, #0          @ int i=0
    mov r5, r1          @ int j=size==6
    sub r5, r5, #1      @ j=6-1. My descending index for the reversed array
    mov r6, r1          @ stop=size==6
    mov r7, r0          @ r7=userArr[]
    ldr r8, =defRevArr  @ defRevArr[]={100,90,80,70,66,50}
    @ldr r8, =revArr     @ r8=revArr
    @ldr r8, [r8]        @ load value of revArr[]


    @ Output prefined revArr[]    
    ldr r0, =outInside
    bl printf

    @ {
    forI:                    @ for(int i=0, j=size-1; i<size; i++, j--)
        cmp r4, r6           @ (i-size)==set flags
        bge endForI          @ if(i>=size)(Z==0 or N==V), then exit for loop  

        @ Reset revArr[j] to equal userArr[i]
        @ mov r0, r7          @ r0=r7=userArr
        @ ldr r0, [r0]        @ load userArr[i]
        @ str r7, [r8]        @ str src, dest --> str userArr[i], revArr[j]

        @ldr r8, [r8]
        @ldr r7, [r7]
        @str r7, [r8]        @ str src, dest --> str userArr[i], revArr[j]


        @ output userArr[i]
        ldr r0, =outUsrArrIndx      @ 
        mov r1, r4                  @ r4=i
        ldr r2, [r7]                @ load value of r7=userArr[i]
        bl printf                   

        @ output revArr index
        ldr r0, =outRevArrIndx
        mov r1, r5                  @ r5=j
        ldr r2, [r8]                @ r2=value of r8=defRevArr[?]
        bl printf


        @ increament i loop & the userArr array's address
        add r7, #4			@ userArr[i]++. +4-bytes    
        add r4, r4, #1      @ i++ 

        @ decreament j & the revArr array's address
        sub r8, #4			@ revArr[j]--. +4-bytes
        sub r5, r5, #1      @ j--
        bal forI            @ keep looping

    endForI:
        pop {r4-r8, lr}     @ pop {pc}
        @ {



@ --------- PRINT FUNCTION --------- @

printArr1:                      @ printArr1(usedefRevArrrArr[]=r5, size=r6)
    push {r4-r6, lr}            @ push {lr}
    mov r4, #0                  @ int i=0
    mov r5, r0                  @ r5=defRevArr
    mov r6, r1                  @ r6=size

    @ {
    printFor1:                   @ output arr
        cmp r4, r6              @ (i-size)==set flags
        bge endPrintFor1         @ if(i>size)(Z==0 or N==V), then exit for loop  

        @ output arr[i]
        ldr r0, =outArr
        ldr r1, [r5]            @ r5=userArr[i]
        bl printf

        @ incre for loop & the array
        add r5, #4			@ arr[i]++. +4-bytes
        add r4, r4, #1      @ i++ 
        bal printFor1            @ keep looping

    endPrintFor1:
        pop {r4-r6, pc}     @ pop {pc}
    @ {
