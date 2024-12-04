.global main

.section .data
numbers: .word 1, 2, 3, 4, 5, 6
size: .word 6
out: .asciz "%d, "
newline: .asciz "\n"

.text
main:
	push {lr}

	@ load 3 arguments for reverseArray(arr,end,start)
	ldr r0, =numbers	@ int numbers[]
	ldr r1, =size		@ int stop=size
	ldr r1, [r1] 		@ stop = size - 1
	sub r1, r1, #1		@ stop--
	mov r2, #0 			@ start value

	bl reverseArray		@ Call reverseArray(arr,end,start) 
						@ returns r0=array and r1=size

	@ reverseArray() returns array and arraySize
	ldr r0, =numbers
	ldr r1, =size
	ldr r1, [r1]
	bl printArr 	@ printArr( numbers, size ); function call

	mov r0, #0 @ return o
	pop {pc}


reverseArray:		@ reverseArray(arr,end,start)
@ r0=numbers,
@ r1=end=5,
@ r2=start=0

	push {r4,lr}
	raLoop:
		cmp r2, r1  @ while( start < end ){
		bge done
	

		@@----------- LOAD AND SWAP ----------- @@

		@ IS [ ] CALCULATING THE ADDRESS OF ARR[START]??
		@ r0 base add numbers(arr) + ( r2 * 4 )

		@ arr[right] = [numbers + (start * 2^2)]
		ldr r3, [r0, r2, lsl #2] @ int temp = arr[start]; @ reads the left side and stores it into temp
		
		@ arr[left] = [numbers + (end * 2^2)]
		ldr r4, [r0, r1, lsl #2] @ get the value at the right end of the array by taking the base address of numbers
								 @ adding end(r1) * 4 to get the correct offset in memory

		@ ldr dest, from						
		@ str from, dest
		str r4, [r0, r2, lsl #2] @ arr[start] = arr[end];
								 @ take the right hand side and stores it in the left
		str r3, [r0, r1, lsl #2] @ arr[end] = temp;

		add r2, r2, #1 @ increment my start index aka left side
		sub r1, r1, #1 @ decrement my end index aka right side

		b raLoop
done:
	pop {r4,pc}

/**
r0 numbers 
r1 size
 */
printArr:
	push {r4-r6,lr}
	mov r4, r0 @ numbers moved r4
	mov r5, r1 @ moved because unsafe registers for fn calls
	mov r6, #0 @ int i = 0
paLoop:
	cmp r6, r5
	bge paEnd

	ldr r0, =out
	add r1, r4, r6, lsl #2 	@ numbers[baseAddress + i * 4]
	ldr r1, [r1] 			@ get the value not address
	bl printf 				@ print it
	
	add r6, #1
	b paLoop
paEnd:
	ldr r0, =newline
	bl printf
	pop {r4-r6,lr}
	bx lr