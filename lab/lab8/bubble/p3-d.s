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
    ldr r0, =derefN
	ldr r1, =arr1			//reload since r0-r3 could change
	ldr r2, =size
	ldr r2, [r2]
    bl printArr

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
    
	push {r4-r7,lr}
	sub r1, r1, #1			//len - 1 since we never len by itself
	mov r2, #0				//i = 0
	bsOuterLoop:			@ for( int i = 0; i < len - 1; i++ ){
		cmp r2, r1			@ (i-len-1)
		bge bsOuterLoopEnd
		//set up next for loop
		mov r3, #0			@ int j=0
		bsInnerLoop: 		@ for( int j = 0; j < len - 1; j++ ){
			cmp r3, r1		@ (j-len-1)
			bge bsInnerLoopEnd
				//load arr[j]
				add r4, r0, r3, lsl #2	//the address of arr[j]
				ldr r5, [r4]			//the value of arr[j]

				//load arr[j+1]
				add r6, r3, #1			//get j+1
				add r6, r0, r6, lsl #2	//baseAdr + ( (j+1) * 4 ). address of arr[j+1]
				ldr r7, [r6]			//value of arr[j+1]

				cmp r5, r7				// if arr[j] > arr[j+1]
										@ if( arr[j] > arr[j + 1]) { //if the current is bigger then the next move to the right
				ble bsNoSwap
				//no need for temp since the address and value of both items
				@ ldr dest, where
				@ str where, dest
				str r7, [r4]			//store arr[j+1] into the arr[j] spot
										@ arr[ j ] = arr[ j + 1 ];	//saved the smaller where the big was, moving the small values to the left
				str r5, [r6]			//store arr[j] into the arr[j+1] spot
										@ arr[ j + 1 ] = temp;		//the value that was smaller is now the bigger value moving the bigger to the right
				bsNoSwap: 				@ }
				//increment the inner loop j
				add r3, r3, #1
				bal bsInnerLoop
		bsInnerLoopEnd: 		@ }
		//increment the outer loop i
		add r2, r2, #1
		bal bsOuterLoop
	bsOuterLoopEnd: 		@ }

	pop {r4-r7,pc}
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
   