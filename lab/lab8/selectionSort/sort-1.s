@ HOW TO COMPILE AND RUN: g++ sort-1.s && ./a.out
@ Danielle
@ 12-02-2024 Lab 8 Problem 2: Selection sort on random array of numbers
.global main

.align 4
.section .rodata
deref: .asciz "%d "
endl: .asciz "\n "
outStr: .asciz "a[%d] = %d\n"
outStr2: .asciz "%d, "
outArr: .asciz "\n\nArray:\n"
outRandArr: .asciz "\nRandom Array:\n"

.align 4
.section .data
array: .skip 100  		@ int a[25]. array of 25 4-byte elements
						@ so 25*4 makes 100 byte total space needed

.text
main: 					@ int main(){
	push {lr}

	@@-------- SET RANDOM NUMBER SEED --------@@

	mov r0, #0	    	@ r0=0
	bl time  	     	@ gets current time time(0)
	bl srand  	     	@ sets the seed for the puesdo random number generator
		
	@@-------- RESET ARRAY VALUES W/RANDOM NUMBER--------@@
	@ ldr r0, =array		@ load array before i loop
	@ mov r1, #25			@ r5=size=25
	bl setRandArr


	@@-------- Print random array --------@@
	ldr r0, =outRandArr
	bl printf 		
	ldr r0, =array		
	mov r1, #25
	bl printArr 		@ printArr( arr, 25);
	ldr r0, =endl		@ load string
	bl printf 			@ printf("\n")

	mov r0, #0
	pop {pc} 			@ return 0;	
@ }


@@ --------------------------------------------------- @@
@@ -------------------- FUNCTIONS -------------------- @@
@@ --------------------------------------------------- @@


@@-------- RESET ARRAY VALUES W/RANDOM NUMBER--------@@

 setRandArr:			@ setRandArr(int arr[], int size)
 	push {lr}
	ldr r4, =array		@ load array before i loop
	mov r5, #25			@ r5=size=25
	@ mov r4, r0		@ load array before i loop
	@ mov r5, r1			@ r5=size=25
	mov r6, #0 			@ r6 = i = 0
forLoop:				@ for(i < 25)
	
	cmp r6, r5			@ (i-25)==? Set flags
	bge forLoopEnd		@ if(i >= 25) then end loop

	bl getRandNum	 	@ Call randNum() and returns r0=randNum
	mov r9, r0	     	@ r9=random number

	@ store a value into the array address	
	str r9, [r4]		@ arr[i] = i; @ str source, [destination]
		
	@ Increment i and array address
	add r4, r4, r6, lsl #2 @ GET ADDRESS OF NEXT INDEX?? @ r4 = arr + (i*2^2)
	add r6, #1			   @ i++
	bal forLoop			   @ keep looping

forLoopEnd:   			
	pop {pc}


@@ -------------------- Get and return a random number -------------------- @@
getRandNum:
	push {lr}
	bl rand  	     @ calls the rand function
	and r0, r0, #0xff  @ filters out the numbers to reasonable size without it you can get a 32bit number
	pop {pc}


@@ -------------------- PRINT Function -------------------- @@

printArr: 				@ void printArr( int arr[], int size ){
@ r0 = array address
@ r1 = size

	@ Get variables ready before loop starts
	push {r0-r6, lr}	@ protect these registers from this function changing its value
	mov r4, r0			@ r4=arr address
	mov r5, #0			@ i=0
	mov r6, r1			@ r6=size
printLoop:				@ for( i < size ){
	cmp r5, r6			@ (i-size==set flags)
	bge printLoopEnd	@ if(i >= size), then end loop
	
	
	@ ldr r0, =outStr		@ load deref string
	@ mov r1, r5			@ r1=r5=i
	@ mov r2, r4			@ r2=arr address
	@ ldr r2, [r2]		    @ loads r2 with value of arr[i]
	@ bl printf 			@ printf( "a[%d] = %d\n", i, arr[i] );

	ldr r0, =outStr2	@ load deref string
	mov r1, r4			@ load arr address
	ldr r1, [r1]		@ arr[i]
	bl printf 			@ printf(" %d,", arr[i])

	add r4, r5, lsl #2	@ next address in the array r4=r4+(r5*4)
	add r5, #1			@ i++
	bal printLoop
printLoopEnd:			@ }
	ldr r0, =endl		@ load string
	bl printf 			@ printf("\n")
	pop {r0-r6, pc} 	@ return;
@ }
