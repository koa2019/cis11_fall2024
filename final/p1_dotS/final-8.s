@ Danielle
@ cis 11 Final Problem 1: Master Mind
@ 12-05-2024
@ Compile & run in terminal:            g++ final-7.s && ./a.out
@
@ Version Notes:
@ Need to change how the game prints out wrong guesses. It should print all 4 digits and then show which ones are right and wrong. As of now it will stop printing at the first occurence of a wrong digit guess.
@ Check notes.txt

.global main

.align 4
.section .rodata    @ readonly data   
deref: .asciz "%d"
derefN: .asciz "%d\n"
endl: .asciz "\n"
outInstruct: .asciz "\n\tWelcome to Mastermind.\n\tGuess the 4 digit secret code.\n\tYou have 10 chances to win!\n\n"
inOneDigit: .asciz "Input one digit and then press Enter: "    
outTry: .asciz "\n\t     Attempt #%d:\n"
outCode: .asciz "Code:  "
outGuess: .asciz "Guess: "
outWrong: .asciz " is a Wrong Guess. Try Again.\n\n"
outRight: .asciz "Right Guess! Congratulations You've Won! \n"    
outI: .asciz "[%d]: "
outEq: .asciz " %d==%d\n"
outNotEq:  .asciz " %d != ?\n"
outVerifyMsg: .asciz "\tVerifying your code...\n"
results: .asciz "\n--- Results ---\n"
outTy: .asciz "GAME OVER. Good Bye\n\n"


.align 4
.section .data
size: .word 4                       @ int size=4
numTrys: .word 2                    @ Player gets 10 guesses  
code: .word 6, 6, 1, 5
guess: .word 6, 6, 1, 5             @ Player's 4 digit guess
lastIndx: .word 3                   @ size-1


.text
main:                               @ int main(){
    push {lr}                       @ push link register r14 to top of stack

    ldr r0, =outInstruct   
    bl printf          

    @ ------ User has 10 attempts to guess the correct code ------ @@
    mov r4, #1                      @ i=1
    ldr r5, =numTrys
    ldr r5, [r5]
    for:                            @ for(int i=1; i<=numTrys; i++){
        cmp r4, r5                  @ ( i-numTrys ) ? Set Register Flags
        bgt endForLoop              @ ( i > numTrys )

        
        ldr r0, =outTry             @ Output number of attempts to guess code
        mov r1, r4                  @ r4=i
        bl printf                   @ printf(outTry,i) 

        @@ -------------- Set user's guess in an array -------------- @@
        ldr r0, =guess  
        ldr r1, =size
        ldr r1, [r1]
        bl setGuess                 @ setGuess(guess,size)

        
        @@ --------------  Check user's guess against the secret code --------------@@
        ldr r0, =outVerifyMsg
        bl printf                   @ printf(outVerifyMsg);
   
                                    @ load function parameters
        ldr r0, =code               @ code[]
        ldr r1, =guess              @ guess[]
        ldr r2, =size
        ldr r2, [r2]                @ size
        bl checkPassword            @ int isPassword = checkPassword(code,guess,size);
        mov r6, r0                  @ r6=r0=isTrue

        @@ -------------- Print msg depending on isTrue's value -------------- @@
        cmp r6, #1                  @ (r0-1==Set Zero flag) {
        bne notPassword             @ (0-1==-1) ? Z==0 FALSE
        
            @ isPassword:           @ if(isPassword==1 true)
            ldr r0, =outRight   
            bl printf               @ printf(outRight);
            
            @ if guess is correct, then stop user from guessing
            mov r4, r5              @ r4=i=numTrys
            b endForLoop
            
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



@@ ---------------- int checkPassword code[],guess[],size) ---------------- @@
checkPassword:            @ Check if user's guess is correct   

    @ r4 = r0 = code address
    @ r5 = code[i]
    @ r6 = r1 = guess address
    @ r7 = guess[i]
    @ r8 = i = 0
    @ r9 = r2 = size
    @ r10 = return isTrue;
    @ r11 = (size-1)

    push {r4-r11, lr}         @ protect these registers from this function from altering them
                          @ Get variables ready before loop starts 
    mov r4, r0            @ r4=code[]   
    mov r6, r1            @ r5=guess[]
    mov r8, #0            @ r8=i=0;
    mov r9, r2            @ r9=size
    mov r10, #0           @ return isTrue=false
    pWLoop:               @ for(i=0;i<size;i++){
        
        cmp r8, r9        @ (i-size)
        bge endPWLoop

        @@ ----------- Load code[i] ----------- @@
        ldr r5, [r4, r8, lsl #2]
        @ add r4, r4, r8, lsl #2	@ r4 = array address -> code[code+(i*2^2bytes)]
        @ ldr r5, [r4]		    @ r5 = code[i]

        @@ ----------- Load guess[i] ----------- @@
        ldr r7, [r6, r8, lsl #2]


        @ Print counter and then array comparison results
        ldr r0, =outI
        mov r1, r8                  @ r8=i
        bl printf                   @ printf(outI, i);

        cmp r5, r7                  @ ( code[i] - guess[i] == Set Zero Flag)
        bne isWrong                 @ if ( code[i] != guess[i] ) ? Z==0 False
        beq isRight                 @ if ( code[i] == guess[i] ) ? Z==1 True
        


            isWrong:                @ guess[i] does NOT equal code[i]
                ldr r0, =outNotEq   
                mov r1, r7          @ r7 = guess[i]
                bl printf           @ printf(outNotEq,guess[i]);           
                b endPWLoop         @ goto endPWLoop

            isRight:                @ guess[i] equals code[i]
                ldr r0, =outEq
                mov r1, r5          @ r5 = code[i]
                mov r2, r7          @ r7 = guess[i]
                bl printf           @ printf( outEq, code[i], guess[i] );


    @@ -----------  if(i == last index)  ----------- @@
    ldr r11, =lastIndx
    ldr r11, [r11]

    cmp r8, r11                     @ ( i - last ) == Set Zero Flag
    bne pwLoopIncrmnt               @ ( i-3 != 0  ) Z==0
    beq checkLastIndx               @ 3-3==0 Z==1

        checkLastIndx:        
        ldr r5, [r4, r8, lsl #2]    @ Load code[i]        
        ldr r7, [r6, r8, lsl #2]    @ Load guess[i] 


        @@ -----------  if(code[last] == guess[last]){  ----------- @@
        cmp r5, r7                  @ ( code[last]  - guess[last] ) == Set Flags
        bne pwLoopIncrmnt           @ ( code[last] != guess[last] ) ? Z==0 False :
        beq setIsTrue               @ ( code[last] == guess[last] ) ? Z==1     
        
        setIsTrue:                  @ if(code[last] == guess[last])        
        mov r10, #1                 @ set return isTrue=TRUE       
        bal endPWLoop             

    pwLoopIncrmnt:    
    add r8, #1           @ i++
    bal pWLoop

    endPWLoop:
    mov r0, r10          @ r0=r10. Set return register r0=isTrue
    pop {r4-r11, pc}         @ return r0 = bool isTrue;
@ }



@@ -------------------- setGuess(guess[],size) -------------------- @@
setGuess:               @ Set user's guess in an array 

    @ r4 = r0 = guess
    @ r5 = r1 = size
    
    push {r4-r6, lr}    @ protect these registers from this function from altering them
    
    @ Loop through array to set each index
    mov r4, r0          @ r4=guess
    mov r5, r1          @ r5=size
    mov r6, #0          @ i=0
    setGuessLoop:       @ for(int i=0i<sizei++){

        cmp r6,r5       @ i-size==set flags
        bge endSetGuess @ if(i>=size), ? end loop

        ldr r0, =inOneDigit
        bl printf       @ printf(inOneDigit)
        
        ldr r0, =deref
        mov r1, r4      @ r1=guess
        bl scanf        @ scanf("%d", &guess[i])

        @ increment i and array
        add r4, #4      @ guess[guessAddress+4bytes]
        add r6, #1      @ i++
        bal setGuessLoop
    endSetGuess: 
    pop {r4-r6, pc}
@ }



@@ -------------------- PRINT 1 Array -------------------- @@
printArr: 				        @ void printArr(arr[], size){

    @ r4 = r0 = array address
    @ r5 = r1 = size
	                            
	push {r4-r6, lr}	        @ protect these registers from this function changing its value
                                @ Get variables ready before loop starts
	mov r4, r0			        @ r4=arr address	
	mov r5, r1			        @ r5=size
    mov r6, #0			        @ i=0
    printLoop:				    @ for( i < size ){
        cmp r6, r5			    @ (i-size==set flags)
        bge printLoopEnd	    @ if(i >= size), then end loop

        ldr r0, =deref	        @ load deref string
        mov r1, r4              @ arr address
        ldr r1, [r1]		    @ arr[i]
        bl printf 			    @ printf(" %d", arr[i])

        add r4, #4              @ increment array address to next index
        add r6, #1			    @ i++
        b printLoop
    printLoopEnd:		
    pop {r4-r6, pc} 	        @ return;
@ }



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
    ldr r0, =endl		@ load string
    bl printf 			@ printf("\n")

    @@-------- Print guess array --------@@
    ldr r0, =outGuess   
	bl printf           @ printf(outGuess) 		
	ldr r0, =guess		
	ldr r1, =size
	ldr r1, [r1]
	bl printArr 		@ printArr(guess,size=4)
    ldr r0, =endl		@ load string
    bl printf 			@ printf("\n")
    pop {pc}
@ }
