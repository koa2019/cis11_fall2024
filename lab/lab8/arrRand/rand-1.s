.global main

.section .rodata
deref: .asciz "%d "
derefRand: .asciz "\n\tRandom Num: %d \n"
outStr: .asciz "a[%d] = %d\n"

.section .data

array: .skip 100  		@ int a[25]. array of 25 4-byte elements
						@ so 25*4 makes 100 byte total space needed

.text
main: 					@ int main(){
	push {lr}

	@ get the parmeters ready for printArr
	@ r0, array
	@ r1, size
	ldr r0, =array
	mov r1, #25
	bl printArr 		@ printArr( a, 25); 


	ldr r4, =array		@ load array before i loop
	mov r2, #0 			@ r2 = i = 0
forLoop:				@ for( int i = 0; i < 25; i++ ){
	
	cmp r2, #25			@ i-25==?
	bge forLoopEnd		@ if(i >= 25) then end loop


	@@-------- GET RANDOM NUMBER --------@@

	@ bl getRandNum

	@ mov r0, #0	   @ r0=0
	@ bl time  		   @ gets current time time(0)
	@ bl srand  	   @ sets the seed for the puesdo random number generator
	@ bl rand  		   @ calls the rand function
	@ and r0, r0, #99  @ filters out the numbers to reasonable size without it you can get a 32bit number
	
	@ mov r9, r0	   @ r9=random number
	mov r9, #66

	@ @ Print random Number
	@ ldr r0, =derefRand
	@ mov r1, r9
	@ bl printf


	@ get next index of array??
	add r4, r4, r2, lsl #2 @ r4 = r4 + (i*2^2)

	@ store a value into the array address
	@ str source, [destination]
	str r9, [r4]		@ a[i] = i;

	
	@ Increment i loop
	add r2, #1			@  i++
	bal forLoop

forLoopEnd:   			@ }
	ldr r0, =array
	mov r1, #25
	bl printArr 		@ printArr( a, 25);

	mov r0, #0
	pop {pc} 			@ return 0;	
@ }


printArr: 				@ void printArr( int arr[], int size ){
/*
r0 = array address
r1 = size
 */
	push {r4,lr}
	mov r4, #0			@ i = 0
outputLoop:				@ for( int i = 0; i < size; i++ ){
	cmp r4, r1			@ i < size
	bge outputLoopEnd
	
	push {r0-r3}
	ldr r2, [r0]		@ loads arr[i]
	mov r1, r4			@ copies my i
	ldr r0, =outStr		@ str loaded
	bl printf 			@ printf( "a[%d] = %d\n", i, arr[i] );
	pop {r0-r3}
	@ TODO come back
	add r4, #1			@ i++
	add r0, r4, lsl #2	@ next address in the array r0=r0+(r4*4)
	bal outputLoop
outputLoopEnd:			@ }
	pop {r4,pc} @ return;
@ }

getRandNum:
	push {lr}
	mov r0, #0
	bl time  @ gets current time time(0)
	bl srand  @ sets the seed for the puesdo random number generator
	bl rand  @ calls the rand function
	and r0, r0, #99  @ filters out the numbers to reasonable size without it you can get a 32bit number

	@ @ Print random Number
	@ mov r1, r0
	@ ldr r0, =derefRand
	@ bl printf

	pop {pc}

