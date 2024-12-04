@ compile & run in terminal: g++ final-1.s && ./a.out
.global main

.align 4
.section .rodata        @ readonly data   
outInstruct: .asciz "\n\tWelcome to Mastermind.\n\tGuess the 4 digit secret code.\n\tYou have 10 chances to win!\n\n"
outTry: .asciz "\n\tAttempt #%d:\n"
deref: .asciz "%d"
derefN: .asciz "%d\n"
endl: .asciz "\n"
outCode: .asciz "Code:  "
outGuess: .asciz "\nGuess: "
outWrong: .asciz " is a Wrong Guess. Try Again.\n\n"
outRight: .asciz "Right Guess! Congratulations You've Won! \n"    
outTy: .asciz "\nGAME OVER. Good Bye\n\n"
inOneDigit: .asciz "Input one digit and then press Enter: "    
inCode: .asciz "input 4 digit code "
results: .asciz "\n\nResults:\n"


.align 4
.section .data
size: .word 4          @ int size=4
numTrys: .word 1  
code: .word 6, 6, 1, 5
guess: .word 6, 2, 1, 4

.text
main:                   @ int main(){
    push {lr}           @ push link register r14 to top of stack

    @ Output code and guess arrays
    bl outputArrays  

    ldr r0, =outInstruct   
    bl printf          


    @ User has 10 attempts to guess the correct code
    mov r4, #0          @ i=0
    for:                @ for(int i=1; i<=numTrys; i++){
        cmp r4, #3      @ i-numTrys==set flags
        bge endForLoop

        @ Output number of attempts to guess code
        ldr r0, =outTry
        mov r1, r4      @ r4=i
        bl printf       @ printf(outTry,i) 

        ldr r0, =guess  @ Set user's guess in an array
        ldr r1, =size
        ldr r1, [r1]
        bl setGuess     @ setGuess(guess,size)

        
    @ Check user's guess to the code
    @ int isPassword = checkPassword(code,guess,size);

    @ if(isPassword==1){
    @        printf(outRight);
    @        i=numTrys;  // if correct, then stop user from guessing
    @ } else {
    @         printArr(guess,size)
    @         printf(outWrong)            
    @ }
    
    endForLoop:    

    @ Output code and guess arrays
    bl outputArrays

    ldr r0, =outTy
    bl printf       @ printf(outTy)
    mov r0, #0  @return 0
    pop {pc}    @return to where i was. Pop whatever on top of stack into program counter r15


@@ --------------------------------------------------- @@
@@ -------------------- FUNCTIONS -------------------- @@
@@ --------------------------------------------------- @@

@@ -------------------- setGuess(guess,size) -------------------- @@
@ r0 = guess[]
@ r1 = size
setGuess:           // Set user's guess in an array     
    push {r4-r6, lr}
    
        @     //BUG. saves all 4 digits in guess[0]
        @     //printf(inCode)
        @     //scanf("%d", &guess)

    @ Loop through array to set each index
    mov r4, r0          @ r4=guess[]
    mov r5, r1          @ r5=size
    mov r6, #0          @ i=0
    setGuessLoop:       @ for(int i=0i<sizei++){

        cmp r6,r5       @ i-size==set flags
        bge endSetGuess @ if(i>=size), then end loop


        ldr r0, =inOneDigit
        bl printf       @ printf(inOneDigit)
        
        ldr r0, =deref
        mov r1, r4      @ r1=guess[]
        bl scanf        @ scanf("%d", &guess[i])

        @ increment i and array
        add r4, #4      @ guess[guess+4bytes]
        add r6, #1      @ i++
        bal setGuessLoop
    endSetGuess: 
    pop {r4-r6, pc}


@@ -------------------- PRINT 1 Array -------------------- @@
printArr: 				@ void printArr( int arr[], int size ){
@ r0 = array address
@ r1 = size

	@ Get variables ready before loop starts
    @ LOOK AT RISHER array1.s outputArr: func for push/pop {r0-r3}
	push {r0-r6, lr}	@ protect these registers from this function changing its value
	mov r4, r0			@ r4=arr address
	mov r5, #0			@ i=0
	mov r6, r1			@ r6=size
    printLoop:				@ for( i < size ){
        cmp r5, r6			@ (i-size==set flags)
        bge printLoopEnd	@ if(i >= size), then end loop

        ldr r0, =deref	@ load deref string
        mov r1, r4			@ load arr address
        ldr r1, [r1]		@ arr[i]
        bl printf 			@ printf(" %d", arr[i])

        add r4, r5, lsl #2	@ next address in the array r4=r4+(r5*4)
        add r5, #1			@ i++
        bal printLoop
    printLoopEnd:			@ }
        ldr r0, =endl		@ load string
        bl printf 			@ printf("\n")
        pop {r0-r6, pc} 	@ return;


@@ -------------------- PRINT code and guess arrays -------------------- @@
outputArrays:
    push {lr}

    @@-------- Print code array --------@@
    ldr r0, =results
	ldr r1, =outCode
	bl printf           @ printf(results) @ printf(outCode); 		
	ldr r0, =code		
	ldr r1, =size
	ldr r1, [r1]
	bl printArr 		@ printArr(code[],size=4)
	ldr r0, =endl		@ load string
	bl printf 			@ printf("\n")
    
    @@-------- Print guess array --------@@
    ldr r0, =outGuess   @ printf(outGuess)
	bl printf           @ printf(results) @ printf(outCode); 		
	ldr r0, =guess		
	ldr r1, =size
	ldr r1, [r1]
	bl printArr 		@ printArr(guess[],size=4)
	ldr r0, =endl		@ load string
	bl printf 			@ printf("\n")
   
    pop {pc}
