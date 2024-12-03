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

	@mov r9, r6			@ r9=r6=i

	@ GET ADDRESS OF NEXT INDEX??
	@add r4, r4, r6, lsl #2 	@ r4 = arr + (i*2^2)

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

	@ @ Print random Number
	@ mov r1, r0
	@ ldr r0, =derefRand
	@ bl printf

	pop {pc}



printArr: 				@ void printArr( int arr[], int size ){
@ r0 = array address
@ r1 = size

	push {r4,lr}
	mov r4, #0			@ i = 0
forLoop2:				@ for( int i = 0; i < size; i++ ){
	cmp r4, r1			@ i < size
	bge forLoop2End
	
	push {r0-r3}
	ldr r2, [r0]		@ loads arr[i]
	mov r1, r4			@ copies my i
	ldr r0, =outStr		@ str loaded
	bl printf 			@ printf( "a[%d] = %d\n", i, arr[i] );
	pop {r0-r3}


	add r0, r4, lsl #2	@ next address in the array r0=r0+(r4*4)
	add r4, #1			@ i++
	bal forLoop2
forLoop2End:			@ }
	pop {r4,pc} 		@ return;
@ }
