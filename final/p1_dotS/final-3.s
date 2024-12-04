@ Danielle
@ cis 11 Final Problem 1: Master Mind
@ 12-03-2024
@ Compile & run in terminal: g++ final-3.s && ./a.out
@
@ Notes:
@ Edited isPassword/notPassword conditionals that print whether or not the user's guess 
@ is correct. I had to manually set cmp register because checkPassword() isn't working.
.global main

.align 4
.section .rodata    @ readonly data   
deref: .asciz "%d"
derefN: .asciz "%d\n"
endl: .asciz "\n"
outInstruct: .asciz "\n\tWelcome to Mastermind.\n\tGuess the 4 digit secret code.\n\tYou have 10 chances to win!\n\n"
inOneDigit: .asciz "Input one digit and then press Enter: "    
inCode: .asciz "input 4 digit code "
outTry: .asciz "\n\tAttempt #%d:\n"
outCode: .asciz "Code:  "
outGuess: .asciz "Guess: "
outWrong: .asciz " is a Wrong Guess. Try Again.\n\n"
outRight: .asciz "Right Guess! Congratulations You've Won! \n"    
results: .asciz "\n--- Results ---\n"
outTy: .asciz "\nGAME OVER. Good Bye\n\n"
outI: .asciz "[%d]: "
outEq: .asciz " %d==%d\n"
outNotE:  .asciz " %d!=?\n"
outVerifyMsg: .asciz "\n\n\tVerifying your code...\n"

.align 4
.section .data
size: .word 4          @ int size=4
numTrys: .word 1  
code: .word 6, 6, 1, 5
guess: .word 6, 2, 1, 4
isTrue: .word 0   @ false=0
last: .word size-1   @ size-1

.text
main:                   @ int main(){
    push {lr}           @ push link register r14 to top of stack

    @ Output code and guess arrays
    @bl output2Arrays  

    ldr r0, =outInstruct   
    bl printf          

    @ User has 10 attempts to guess the correct code
    mov r4, #1          @ i=1
    ldr r5, =numTrys
    ldr r5, [r5]
    for:                @ for(int i=1; i<=numTrys; i++){
        cmp r4, r5      @ ( i-numTrys ) ? Set Register Flags
        bgt endForLoop

        @ Output number of attempts to guess code
        ldr r0, =outTry
        mov r1, r4      @ r4=i
        bl printf       @ printf(outTry,i) 

        ldr r0, =guess  @ Set user's guess in an array
        ldr r1, =size
        ldr r1, [r1]
        bl setGuess     @ setGuess(guess,size)

        
        @ Check user's guess against the secret code
        ldr r0, =outVerifyMsg
        bl printf               @ printf(outVerifyMsg);
   
        @bl checkPassword        @ int isPassword = checkPassword(code,guess,size);
        mov r0, #1              @ guess is correct
        @mov r0, #0              @ guess is wrong

        cmp r0, #1              @ (r0-1==Set Zero flag) {
        beq isPassword          @ (1-1==0) ? Z==1
        bmi notPassword         @ (0-1!=0) ? Z==0
        
        isPassword:             @ isPassword==1 true
            ldr r0, =outRight   
            bl printf           @ printf(outRight);
            
            ldr r0, =numTrys
            ldr r0, [r0]
            mov r4, r0          @ i=numTrys; if correct, then stop user from guessing
            b incrILoop
            
        notPassword:            @ isPassword==0 false
            ldr r0, =guess      
            ldr r1, =size
            ldr r1, [r1]        
            bl printArr         @ printArr(guess,size)
            ldr r0, =outWrong    
            bl printf           @ printf(outWrong)
                       
                
    incrILoop:
    add r4, #1                  @ i++
    bal for

    endForLoop:  
    bl output2Arrays            @ Output code and guess arrays

    ldr r0, =outTy
    bl printf                   @ printf(outTy)
    mov r0, #0                  @ return 0
    pop {pc}                    @ return to where i was. Pop whatever on top of stack into program counter r15


@@ --------------------------------------------------- @@
@@ -------------------- FUNCTIONS -------------------- @@
@@ --------------------------------------------------- @@

@@ -------------------- setGuess(guess,size) -------------------- @@

// Check if user's guess is correct
checkPassword:          @ int checkPassword(int *code, int *guess, const int size){

    push {r4-r9, lr}    @ protect these registers from this function from altering them
    @ ldr r4, =code
    @ ldr r5, =guess
    @ ldr r6, size
    @ ldr r6, [r6]
    @ mov r7, #0          @ i=0;
    @ pssWrdLoop:         @ for(i=0;i<size;i++){
        
    @                     @ Print counter and then array comparison results
    @     ldr r0, =outI
    @     ldr r1, r7      @ r7=i
    @     bl printf       @ printf(outI, i);


    @     @@ ----------- Load code[i] ----------- @@

    @     add r8, r4, r7, lsl #2	@ r1 = array address -> arr[arr+(i*2^2bytes)]
    @     ldr r8, [r8]		    @ r8 = code[i]

    @     @@ ----------- Load guess[i] ----------- @@

    @     add r9, r5, r7, lsl #2	@ r1 = array address -> arr[arr+(i*2^2bytes)]
    @     ldr r9, [r9]		    @ r9 = guess[i]

    @     cmp r4, r5              @ code[i]-guess[i]==Set Zero Flag
    @     @ {
    @     bne isWrong             @ ( code[i] != guess[i] ) ? Zero Flag==0 False
    @     beq isRight             @ ( code[i] == guess[i] ) ? Zero Flag==1 True
        
    @     isWrong:                @ if guess[i] does NOT equal code[i]
    @         ldr r0, =outNotEq   @ printf(outNotEq,guess[i]);
    @         b endLoop           @ goto endLoop;
    @     isRight:                @ } else {
    @         ldr r0, =outEq
    @         mov r1, r8          @ r8 = code[i]
    @         ldr r1, [r1]
    @         mov r2, r9          @ r9 = guess[i]
    @         ldr r2, [r2]
    @         bl printf @ printf( outEq, code[i], guess[i] );
    @     @ }


    @ @    @@ ----------- if i==(size-1) AND array indices are eqaul than set return variable  ----------- @@

    @ @                             @ Load code[last] 
    @ @     add r0, r4, r7, lsl #4	@ r0 = array address -> arr[ arr + ( 4 * 2^2 bytes)]
    @ @     ldr r0, [r0]		    @ r8 = code[i]

    @ @                             @ Load guess[last] 
    @ @     add r1, r5, r7, lsl #4	@ r1 = array address -> arr[ arr + ( 4 * 2^2 bytes)]
    @ @     ldr r1, [r1]		    @ r9 = guess[i]

    @ @     cmp r0, r1              @ ( code[last] - guess[last] ) == Set Zero Flag
    @ @     beq isEqLastIndx        @ ( code[last] == guess[last]) ? Z==1 True :
    @ @     bne notEqLastIndx       @ ( code[last] != guess[last]) ? Z==0 Flase

    @ @     isEqLastIndx:           @ set return value to true
    @ @         mov r0, #1          @ isTrue=1;   // 1=true          
    @ @         b endLoop
    @     @ notEqLastIndx:          @ set return value to false
    @         mov r0, #0          @ isTrue=0    // 0=false
        
    endLoop:
    pop {r4-r9, pc}             @ return r0=isTrue;
@ }


@@ -------------------- setGuess(guess[],size) -------------------- @@
@ r0 = guess
@ r1 = size
setGuess:           // Set user's guess in an array     
    push {r4-r6, lr}
    
        @     //BUG. saves all 4 digits in guess[0]
        @     //printf(inCode)
        @     //scanf("%d", &guess)

    @ Loop through array to set each index
    mov r4, r0          @ r4=guess
    mov r5, r1          @ r5=size
    mov r6, #0          @ i=0
    setGuessLoop:       @ for(int i=0i<sizei++){

        cmp r6,r5       @ i-size==set flags
        bge endSetGuess @ if(i>=size), then end loop


        ldr r0, =inOneDigit
        bl printf       @ printf(inOneDigit)
        
        ldr r0, =deref
        mov r1, r4      @ r1=guess
        bl scanf        @ scanf("%d", &guess[i])

        @ increment i and array
        add r4, #4      @ guess[guess+4bytes]
        add r6, #1      @ i++
        bal setGuessLoop
    endSetGuess: 
    pop {r4-r6, pc}


@@ -------------------- PRINT 1 Array -------------------- @@
printArr: 				@ void printArr( int arr, int size ){
    @ r0 = array address
    @ r1 = size

	                            @ Get variables ready before loop starts
	push {r4-r6, lr}	        @ protect these registers from this function changing its value
	mov r4, r0			        @ r4=arr address	
	mov r5, r1			        @ r5=size
    mov r6, #0			        @ i=0
    printLoop:				    @ for( i < size ){
        cmp r6, r5			    @ (i-size==set flags)
        bge printLoopEnd	    @ if(i >= size), then end loop

        ldr r0, =deref	        @ load deref string
        add r1, r4, r6, lsl #2	@ load arr address arr[arr+(i*2^2bytes)]
        ldr r1, [r1]		    @ arr[i]
        bl printf 			    @ printf(" %d", arr[i])

        add r6, #1			    @ i++
        b printLoop
    printLoopEnd:		
        pop {r4-r6, pc} 	    @ return;


@@ -------------------- PRINT code and guess arrays -------------------- @@
output2Arrays:
    push {lr}

    @@-------- Print code array --------@@
    ldr r0, =results
    bl printf           @ printf(results) 
	ldr r0, =outCode
	bl printf           @ printf(outCode); 		
	ldr r0, =code		
	ldr r1, =size
	ldr r1, [r1]
	bl printArr 		@ printArr(code,size=4)
    ldr r0, =endl		    @ load string
    bl printf 			    @ printf("\n")

    @@-------- Print guess array --------@@
    ldr r0, =outGuess   
	bl printf           @ printf(outGuess) 		
	ldr r0, =guess		
	ldr r1, =size
	ldr r1, [r1]
	bl printArr 		@ printArr(guess,size=4)
    ldr r0, =endl		    @ load string
    bl printf 			    @ printf("\n")
    pop {pc}
