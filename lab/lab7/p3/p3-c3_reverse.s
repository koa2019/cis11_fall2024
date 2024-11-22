@ 11-21-24 Lab 7 Array Question 3: Reverse array's order.
@ compile & run in terminal: 
@       g++ p3-c3_reverse.s && ./a.out

.global main


.align 4
.section .rodata            @ readonly data   
deref:   .asciz "%d"        @ tells it a number is coming
derefN:  .asciz "%d\n"
outr8: .asciz "\tr8=%d\n"
outR9:  .asciz "\tr9=%d \n"
outR11:  .asciz "\tr10=%d\n"
out1:    .asciz "\n\nProgram reverses the order of an array.\n\n"
outGetN: .asciz "Enter a number: " 
outUsrEntered: .asciz "\nYou entered: %d\n"
outUserArray:  .asciz "\nUser Array:\n"
outArr:  .asciz "%d, "
outUsrArrIndx: .asciz "userArr[%d]=%d == " 
outRevArrIndx: .asciz "revArr[%d] = %d\n"
outRev: .asciz "\nreverse Array: \n"
outPreDefArr: .asciz "\nPredefined Array: \n"
outBubble: .asciz "\nBubble Sort: \n"
outSort: .asciz "\nSort: \n"
outBefore: .asciz "\n\nBefore Reverse()..\n"
outInside: .asciz "\n\nInside reverse function...\n\n"
outAfter: .asciz "\nAfter Reverse()...\n"
ty: .asciz "\n\nGood Bye\n\n"
bubble: .asciz "\n\n---Bubble Sort---\n"
sortSection: .asciz "\n\n---Sort---\n"


.align 4
.section .data
size: .word 6          @ int size=6
userArrPreDef: .word 131,412,53,2,25,76 @6, 5, 4, 3, 2, 1
userArr: .skip 24 @int arr[10]. Each element is 4 bytes, 6*4=24 spaces
@revArr: .skip 24
revArr: .word 64,65,66,67,68,69  @131,412,53,2,25,66


.text
main:                   @ int main(){
	str lr, [sp, #-4]!  @ push {lr}

    @@ -------------------- Get user inputs -------------------- @@
    @ @ get arr ready for user input
    @ ldr r5, =userArr
    @ ldr r6, =size        @ int size=12
    @ ldr r6, [r6]    
    @ bl getInput          @ getInput(int arr[]=r0, int size=r1)

    @ @ load user arr for print function
    @ ldr r0, =userArr          @ user inputted array
    @ ldr r1, =size
    @ ldr r1, [r1]
    @ bl printArr

    @@ -------------------- Output both arrays before reverse-------------------- @@

    @ Output userArr[]    
    ldr r0, =outBefore
    bl printf

    ldr r0, =outUserArray
    bl printf
   
    ldr r0, =userArrPreDef @ predefined array
    ldr r1, =size          @ r1=size
    ldr r1, [r1]           @ r1=&size==6
    bl printArr           @ printArr(r0=userArr[], r1=size)

    @ Output revArr[] 
    ldr r0, =outRev
    bl printf

    ldr r0, =revArr         @ r0=reverse array
    ldr r1, =size           @ r1=size
    ldr r1, [r1]            @ r1=&size==6
    bl printArr            @ printArr(r0=userArr[], r1=size)

    @@ -------------------- Reverse(r0=userArr[], r1=size) -------------------- @@

    ldr r0, =userArrPreDef  @ user array
    ldr r1, =size           @ r1=size
    ldr r1, [r1]            @ r1=&size==6
    bl reverse             @ int *reverse(r0=userArr[], r1=size)

    @@ -------------------- Output both arrays after reverse -------------------- @@

    mov r4, r0              @ r0=returned array. reverse() returned array in r0     
    ldr r0, =outAfter
    bl printf
    
    ldr r0, =outUserArray
    bl printf

    ldr r0, =userArrPreDef  @ user array
    ldr r1, =size           @ r1=size
    ldr r1, [r1]            @ r1=&size==6
    bl printArr            @ printArr(arr[]=r0, size=r1)

    ldr r0, =outRev
    bl printf

    mov r0, r4
    ldr r1, =size
    ldr r1, [r1]
    bl printArr          @ printArr(r0=userArr[], r1=size)


end:
    ldr r0, =ty
    bl printf           @ output endOfFile

    mov r0, #0  
    pop {pc}            @ return 0 to where i was. Pop whatever on top of stack into program counter r15


@@ --------- FUNCTION IMPLEMENTATIONS --------- @@

reverse:                    @ reverse(r0=userArr[], r1=size)

    push {r4-r9, lr}         @ protect safe registers from being overwritten in function

    @ Reverse array
    @ for(int i=0, j=size-1; i<size; i++, j--){
    @     revArr[j]=userArr[i]; }

    @ set variables before for the loop
    mov r4, #0                @ i=0
    mov r5, r1                @ j=size==6
    sub r5, r5, #1            @ j=6-1. My descending index for the revArr[]
    mov r6, r1                @ stop=size==6
    mov r7, r0                @ r7=userArr[]   
    ldr r8, =revArr           @ r8=revArr[]={0}
    mov r9, #24               @ base address for j == 24=6*4bytes
    add r8, r9                @ revArr[5]

    ldr r0, =outInside        @ "inside reverse()"
    bl printf

    forI:                     @ for(int i=0, j=size-1; i<size; i++, j--)
    @{
        cmp r4, r6            @ (i-size)==set flags
        bge endForI           @ if(i>=size)(Z==0 or N==V), then exit for loop  

        @ start at revArr[5] and then store userArr[0] in it
        if:
            cmp r4, #0        @ i-0==
            beq iEqZero
            bne else
        
        iEqZero:
            sub r8, #4        @ revArr[24-4]
            @@ ---------- revArr[j] = userArr[i] ---------- @@            
         
            @mov r0, r7          @ r0=r7=userArr
            ldr r0, [r7]        @ load userArr[i]
            str r7, [r8]        @ str src, dest --> str userArr[i], revArr[j]

            @ ldr r0, [r7]         @ r0=userArr        
            @ ldr r1, [r8]         @ r1=revArr[]
            @ str r0, [r1]         @ str src, dest --> str userArr[i], revArr[j]

            bal endIf

        else:

            @ incre/decre both array's addresses
            add r7, #4		 @ usrArr[i+4bytes]   
            sub r8, #4       @ address-(i*4)   

        endIf:

        @@ -------- Output both array's value for every iteration -------- @@

        ldr r0, =outUsrArrIndx      @ "userArr[i]" 
        mov r1, r4                  @ r4=i
        ldr r2, [r7]                @ r2=&r7=userArr[i]
        bl printf                   
        
        ldr r0, =outRevArrIndx      @ output revArr[j]
        mov r1, r5                  @ r5=j==5,4,3,2,1
        ldr r2, [r8]                @ r2=&r8=revArr[?]
        bl printf


        @ incre/decre indicies        
        add r4, r4, #1      @ i++
        sub r5, r5, #1      @ j--
        bal forI            @ keep looping

    endForI:
        mov r0, r8
        pop {r4-r9, lr}     @ pop {pc}
    @{
    

@ --------- PRINT FUNCTION --------- @

printArr:                       @ printArr(arr[]=r0, size=r1)

    push {r4-r6, lr}            @ push {lr}
    mov r4, #0                  @ int i=0
    mov r5, r0                  @ r5=arr
    mov r6, r1                  @ r6=size

    printFor1:                   @ output arr
    @{
        cmp r4, r6               @ (i-size)==set flags
        bge endPrintFor1         @ if(i>size)(Z==0 or N==V), then exit for loop  

        @ output arr[i]
        ldr r0, =outArr
        ldr r1, [r5]             @ r5=userArr[i]
        bl printf

        @ incre for loop & the array
        add r5, #4			     @ arr[i]++. +4-bytes
        add r4, r4, #1           @ i++ 
        bal printFor1            @ keep looping

    endPrintFor1:
        pop {r4-r6, pc}          @ pop {pc}
    @ {


@ --------- INPUT FUNCTION --------- @

getInput:                   @ Prompt for user's array of integers

    push {lr}               @ push {lr}  

    ldr r0, =out1           @ Output instructions
    bl printf               

    for:
    @{
        cmp r4, r6          @ (i-size)==set flags
        bge endFor          @ if(i>size)(Z==0 or N==V), then exit for loop  

        doWhile:  @ Ask for user's input until it's a positive integer
        @{
            @ Prompt for user's input
            ldr r0, =outGetN
            bl printf

            @ Get and set variable with user input
            ldr r0, =deref
            mov r1, r5          @ r1=r5=arr address
            bl scanf			@ scanf( "%d", &a[i] )

            @ validate user input is positive integer
            ldr r0, [r5]        @ r0=&r5
            cmp r0, #0          @ r4-0==set flags
            ble doWhile         @ do...while(n<=0). (Z==1 or N!=V)

            @ output user's input
            ldr r0, =outUsrEntered
            ldr r1, [r5]        @ r1=&r5
            bl printf            
  
            @ incre loop & the array's address
            add r5, #4			@ arr[i+4bytes]
            add r4, r4, #1      @ i++ 
            bal for             @ keep looping
        @}
    endFor:
        mov r0, r2              @ return user array in r0
        pop {pc} 		        
    @{
