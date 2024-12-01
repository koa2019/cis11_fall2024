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

	//get the parmeters ready for outputArr
	//r0, array
	//r1, size
	ldr r0, =array
	mov r1, #25
	bl outputArr 		@ outputArr( a, 25); 

	ldr r4, =array
	mov r2, #0 			//int i = 0
mainLoop:				@ for( int i = 0; i < 25; i++ ){
	cmp r2, #25			//i < 25
	bge mainLoopEnd

	@ get a random nummber
	@ bl getRandNum

	mov r0, #0
	bl time  //gets current time time(0)
	bl srand  //sets the seed for the puesdo random number generator
	bl rand  //calls the rand function
	and r0, r0, #99  //filters out the numbers to reasonable size without it you can get a 32bit number
	
	@ mov r2, r0	@ r2=random number

	@ Print random Number
	mov r1, r0
	ldr r0, =derefRand
	bl printf

		//store a value into the array address
	str r2, [r4]		@ a[i] = i;
	
	@ 1<<2 == 1 * 4
	@ 0x00 0x04 0x08 
	//TODO FIX THIS ERROR INFRONT OF THE CLASS!!!!!!!
	add r2, #1			// i++
	add r4, r4, r2, lsl #2 //r0 = r0 + (r2*4)
	bal mainLoop

mainLoopEnd:   			@ }
	ldr r0, =array
	mov r1, #25
	bl outputArr 		@ outputArr( a, 25);

	mov r0, #0
	pop {pc} 			@ return 0;	
@ }


outputArr: 				@ void outputArr( int arr[], int size ){
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
	ldr r2, [r0]		//loads arr[i]
	mov r1, r4			//copies my i
	ldr r0, =outStr		//str loaded
	bl printf 			@ printf( "a[%d] = %d\n", i, arr[i] );
	pop {r0-r3}
	//TODO come back
	add r4, #1			@ i++
	add r0, r4, lsl #2	//next address in the array r0=r0+(r4*4)
	bal outputLoop
outputLoopEnd:			@ }
	pop {r4,pc} @ return;
@ }

getRandNum:
	push {lr}
	mov r0, #0
	bl time  //gets current time time(0)
	bl srand  //sets the seed for the puesdo random number generator
	bl rand  //calls the rand function
	and r0, r0, #99  //filters out the numbers to reasonable size without it you can get a 32bit number

	@ @ Print random Number
	@ mov r1, r0
	@ ldr r0, =derefRand
	@ bl printf

	pop {pc}

