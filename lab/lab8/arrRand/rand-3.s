@ HOW TO COMPILE AND RUN: g++ rand-3.s && ./a.out
.global main

.align 4
.section .rodata
deref: .asciz "%d "
derefRand: .asciz "\n\tRandom Num: %d \n"
outStr: .asciz "a[%d] = %d\n"

.align 4
.section .data
array: .skip 100  		@ int a[25]. array of 25 4-byte elements
						@ so 25*4 makes 100 byte total space needed

.text
main: 					@ int main(){
	push {lr}

	@@-------- SET RANDOM NUMBER SEED --------@@
	mov r0, #0	     @ r0=0
	bl time  	     @ gets current time time(0)
	bl srand  	     @ sets the seed for the puesdo random number generator
	
	

	ldr r0, =array
	mov r1, #25
	bl printArr 		@ printArr( arr, 25); 


	@@-------- RESET ARRAY VALUES W/RANDOM NUMBER--------@@

	ldr r4, =array		@ load array before i loop
	mov r5, #25			@ r5=size=25
	mov r6, #0 			@ r6 = i = 0
forLoop:				@ for(i < 25)
	
	cmp r6, #25			@ (i-25)==? Set flags
	bge forLoopEnd		@ if(i >= 25) then end loop


	@@-------- GET RANDOM NUMBER SEED --------@@

	 bl getRandNum	 @ returns r0=randNum
	 mov r9, r0	     @ r9=random number

	@ @ Print random Number
	@ ldr r0, =derefRand
	@ mov r1, r9
	@ b printf

	@mov r9, r6			@ r9=r6=i. Sets array with 0-24 values

	@ store a value into the array address	
	str r9, [r4]		@ arr[i] = i; @ str source, [destination]
	
	@ GET ADDRESS OF NEXT INDEX??
	add r4, r4, r6, lsl #2 	@ r4 = arr + (i*2^2)

	@ Increment i loop
	add r6, #1			@  i++
	bal forLoop

forLoopEnd:   			

	ldr r0, =array		
	mov r1, #25
	bl printArr 		@ printArr( arr, 25);

	mov r0, #0
	pop {pc} 			@ return 0;	
@ }


@@ --------------------------------------------------- @@
@@ -------------------- FUNCTIONS -------------------- @@
@@ --------------------------------------------------- @@

getRandNum:
	push {lr}

	bl rand  	     @ calls the rand function
	and r0, r0, #0xff  @ filters out the numbers to reasonable size without it you can get a 32bit number

	pop {pc}



printArr: 				@ void printArr( int arr[], int size ){
@ r0 = array address
@ r1 = size

	push {r4-r6, lr}		@ protect these registers from this function changing its value
	mov r4, r0			@ r4=arr address
	mov r5, #0			@ i=0
	mov r6, r1			@ r6=size
forLoop2:				@ for( i < size ){
	cmp r5, r6			@ (i-size==set flags)
	bge forLoop2End		@ if(i >= size), then end loop
	
	ldr r0, =outStr		@ load deref string
	mov r1, r5			@ r1=r5=i
	mov r2, r4			@ r2=arr address
	ldr r2, [r2]		@ loads r2 with value of arr[i]
	bl printf 			@ printf( "a[%d] = %d\n", i, arr[i] );

	add r4, r5, lsl #2	@ next address in the array r4=r4+(r5*4)
	add r5, #1			@ i++
	bal forLoop2
forLoop2End:			@ }
	pop {r4-r6, pc} 	@ return;
@ }
