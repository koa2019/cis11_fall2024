@ HOW TO COMPILE AND RUN: g++ sort-1.s && ./a.out
@ Danielle
@ 12-02-2024 Lab 8 Problem 2: Selection sort on random array of numbers
@ Based off of rand-5.s. 
.global main

.align 4
.section .rodata
deref: .asciz "%d "
derefN: .asciz "%d\n"
endl: .asciz "\n"
outMin: .asciz "minIndx = %d\n "
outResetMin: .asciz "\t\tarr[minIndx] > arr[j]. Updated minIndx = %d\n "
outJ: .asciz "\tj = %d\n "
outSwap: .asciz "Load.   arrMinIndx[%d] = %d  <->  "
outSwap2: .asciz "Stored. arrMinIndx[%d] = %d  <->  "
outMinIndx: .asciz "\tarrMinIndx[%d] = %d\n"
outStr: .asciz "arr[%d] = %d\n"
outStr2: .asciz "%d, "
outSortArr: .asciz "\n\nSorted Array:\n"
outRandArr: .asciz "\nRandom Array:\n"

.align 4
.section .data
size: .word 25
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

	ldr r0, =array		@ load array before i loop
	ldr r1, =size	    @ r5=size=25
	ldr r1, [r1]
	bl setRandArr

	@@-------- Print random array --------@@
	ldr r0, =outRandArr
	bl printf 		
	ldr r0, =array		
	ldr r1, =size
	ldr r1, [r1]
	bl printArr 		@ printArr(arr, 25);
	ldr r0, =endl		@ load string
	bl printf 			@ printf("\n")

	@@-------- Selection Sort --------@@

	ldr r0, =array		@ load array before i loop
	ldr r1, =size	    @ r5=size=25
	ldr r1, [r1]
	bl selectSort

@@-------- Print sorted array --------@@
	ldr r0, =outSortArr
	bl printf 		
	ldr r0, =array		
	ldr r1, =size
	ldr r1, [r1]
	bl printArr 		@ printArr(arr, 25);
	ldr r0, =endl		@ load string
	bl printf 			@ printf("\n")

	mov r0, #0
	pop {pc} 			@ return 0;	
@ }


@@ --------------------------------------------------- @@
@@ -------------------- FUNCTIONS -------------------- @@
@@ --------------------------------------------------- @@


@@-------- SORT ARRAY OF W/RANDOM NUMBER--------@@
selectSort:
 	push {r4-r11, lr}
	mov r4, r0				@ load array before i loop
	mov r5, r1				@ r5=size=25
	sub r5, r5, #1			@ r5=25-1
	mov r6, #0 				@ r6=i=0
	mov r7, r6				@ minIndx=i; // Find the minimum element in unsorted array


	outteriLoop:				@ for(i < 25-1)
		cmp r6, r5			@ (i-25)==? Set flags
		bge endOutteriLoop	@ if(i >= 25-1) then end i loop

		mov r7, r6				@ minIndx=i; // Find the minimum element in unsorted array

				@ PRINT minIndx
				ldr r0, =outMin	@ load deref string
				mov r1, r7			@ r1=minIndx
				bl printf

		// Find the minimum element in unsorted array
		// Compare arr[i] to all indices right of it

		mov r8, r6				@ r8=j=i
		add r8, #1					@ r8 = j+1
		innerjLoop: 				@ for(j=i+1;j<size;j++){
			cmp r8, #25				@ (j-25)==set flags
			bge endInnerjLoop		@ if(j>=25) then end j loop

					@ @ PRINT j
					@ ldr r0, =outJ	@ load deref string
					@ mov r1, r8		@ r2=j
					@ bl printf

			@@----------- Load array values  ----------- @@

			@ r4 = array address
			@ r5 = (25-1)
			@ r6 = i
			@ r7 = minIndx
			@ r8 = j. Current index in the unsorted part
			@ r9 = arr[minIndx]
			@ r10 = arr[j]


			// load arr[minIndx]
			@ add r0, r4, r7, lsl #2	// r9 = arr +(minIndx*2^2)
			@ ldr r9, [r0]			// r10 = arr[minIndx]
			ldr r9,  [r4, r7, lsl #2]		@ r9  = arr[minIndx] 

			// load arr[j]
			@ add r1, r4, r8, lsl #2	// baseAdr + ((j)*4). address of arr[j]
			@ ldr r10, [r1]			// value of arr[j]
			ldr r10,  [r4, r8, lsl #2]		@ r9  = arr[minIndx] 


			@@----------- Compare if(arr[minIndx] > arr[j]) ----------- @@
			cmp r9, r10					
			ble dontResetMinIndx			@ if(arr[minIndx] <= arr[j], then dont swap				
			
			@ else reset minIndx index to current j index
			mov r7, r8						@ minIndx=j; 
				
					@ PRINT minIndx
					ldr r0, =outResetMin	@ load deref string
					mov r1, r7			@ r1=minIndx
					bl printf

			dontResetMinIndx:		
			add r8, #1			   @ j++
			bal innerjLoop		   @ keep j looping

		endInnerjLoop:

			@@----------- LOAD AND SWAP ----------- @@
			
			// Swap the found minimum element with current index in the unsorted part
			@ bl swap						@ swap(a[i],a[minIndx]);

			@ r4 = array address
			@ r5 = (25-1)
			@ r6 = i
			@ r7 = minIndx
			@ r8 = j. Current index in the unsorted part
			@ r9 = arr[minIndx]
			@ r10 = arr[j]
			@ r11 = arr[i]
		
			@ ldr dest, source	
			@ldr r9, [r4, r7, lsl #2]		@ r9  = arr[minIndx] 			
			ldr r11, [r4, r6, lsl #2]		@ r10 = arr[i] 

			@ str source, dest
			str r9, [r4, r6, lsl #2]		@ r9  = arr[minIndx] = arr[i];  
			str r11, [r4, r7, lsl #2] 		@ r10 = arr[i] = arr[minIndx];

			@ PRINT swapped array values
			@ ldr r0, =outSwap2	
			@ mov r1, r7			@ r1=minIndx
			@ mov r2, r9			@ r2=arr address
			@ ldr r2, [r2]		@ loads r2 with value of arr[minIndx]
			@ bl printf 			@ printf( "Swap minIndx[%d] = ", minIndx, arr[minIndx] );
				
			@ ldr r0, =outStr		
			@ mov r1, r6			@ r1=r6=i
			@ mov r2, r11			@ r2=arr address
			@ ldr r2, [r2]		    @ loads r2 with value of arr[i]
			@ bl printf 			@ printf( "a[%d] = %d\n", i, arr[i] );

		@ Increment inner loop: i and arr[i] address to next
		add r4, r4, r6, lsl #2 @ r4 = arr + (i*2^2)
		add r6, #1			   @ i++
		bal outteriLoop		   @ keep i looping

	endOutteriLoop:
 	pop {r4-r11, pc}


@@----------- LOAD AND SWAP ----------- @@

@ swap:						@ swap(a[i],a[minIndx]);
@ @ arr[i]=arr[minIndx];
@ @ arr[minIndx]=temp;
@ 	push {r4-r11, lr}
@ 	pop {r4-r11, pc}

@@-------- RESET ARRAY VALUES W/RANDOM NUMBER--------@@

setRandArr:			@ setRandArr(int arr[], int size)
 	push {r4-r6, lr}
	mov r4, r0		@ load array before i loop
	mov r5, r1			@ r5=size=25
	mov r6, #0 			@ r6 = i = 0

	forLoop:				@ for(i < 25)
		
		cmp r6, r5			@ (i-25)==? Set flags
		bge forLoopEnd		@ if(i >= 25) then end loop

		bl getRandNum	 	@ Call randNum() and returns r0=randNum
		mov r9, r0	     	@ r9=random number

		@ store a value into the array address	
		str r9, [r4]		@ arr[i] = i; @ str source, [destination]
			
		@ Increment i and array address to next
		add r4, r4, r6, lsl #2 @ r4 = arr + (i*2^2)
		add r6, #1			   @ i++
		bal forLoop			   @ keep looping

	forLoopEnd:   			
	pop {r4-r6, pc}


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
