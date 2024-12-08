@ Danielle
@ cis 11 Final Problem 1: Master Mind
@ 12-07-2024
@ Compile & run in terminal:            g++ final-10.s && ./a.out
@
@ Version 10 Notes:
@ Reintialized code[] with random numbers. Used code from lab8.
@ Check notes.txt

.global main

.align 4
.section .rodata    @ readonly data   
deref: .asciz "%d"
derefC: .asciz "%d, "
derefN: .asciz "%d\n"
endl: .asciz "\n"
outInstruct: .asciz "\n\tWelcome to Mastermind.\n\tGuess the 4 digit secret code.\n\tYou have 10 chances to win!\n\n"
inOneDigit: .asciz "Input a positive integer and then press Enter: "    
outInvalid: .asciz "\n\tInvalid Input. Number must be greater or equal to zero. Try again.\n"
outTry: .asciz "\n\t     Attempt #%d:\n"
outCode: .asciz "\nSecret Code:  "
outGuess: .asciz "Guess:        "
outWrong: .asciz " is a Wrong Guess. Try Again.\n\n"
outRight: .asciz "Right Guess! Congratulations You've Won! \n"    
outI: .asciz "[%d]: "
outEq: .asciz    "      %d  ==  %d\n"
outNotEq:  .asciz "      ?  !=  %d\n"
outVerifyMsg: .asciz "\n\tVerifying your code...\n      Secret Code    User Guess\n"
results: .asciz "\n\t--- Results ---\n"
outTy: .asciz "GAME OVER. Good Bye\n\n"


.align 4
.section .data
size: .word 4                       @ int size=4
numTrys: .word 2                    @ Player gets 10 guesses  
code: .word 6, 6, 1, 5
guess: .word 6, 2, 1, 5             @ Player's 4 digit guess
lastIndx: .word 3                   @ size-1


.text
main:                               @ int main(){
    push {lr}                       @ push link register r14 to top of stack

    @@-------- SET RANDOM NUMBER SEED --------@@
	mov r0, #0	    	@ r0=0
	bl time  	     	@ gets current time time(0)
	bl srand  	     	@ sets the seed for the puesdo random number generator
		

	@@-------- RESET ARRAY VALUES W/RANDOM NUMBER--------@@
	ldr r0, =code		    @ load function's 1st parameter
	ldr r1, =size	        @ load functions's 2nd parameter
	ldr r1, [r1]            @ r1=size=4
	bl setRandArr           @ setRandArr(code[],size)

    ldr r0, =outInstruct    @ Print game's instructions
    bl printf          

    @ ------ User has 10 attempts to guess the correct code ------ @@
    mov r4, #1              @ i=1
    ldr r5, =numTrys
    ldr r5, [r5]
    for:                    @ for(int i=1; i<=numTrys; i++){
        cmp r4, r5          @ ( i-numTrys ) ? Set Register Flags
        bgt endForLoop      @ ( i > numTrys )

        @ FOR TESTING/GRADING PURPOSES: I'm printing the secret random code[]]
        bl printSecret
        
        ldr r0, =outTry     @ Output number of attempts to guess code
        mov r1, r4          @ r4=i
        bl printf           @ printf(outTry,i) 

        @@ -------------- Set user's guess in an array -------------- @@
        ldr r0, =guess  
        ldr r1, =size
        ldr r1, [r1]
        bl setGuess         @ setGuess(guess,size)

        
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


@@-------- RESET ARRAY VALUES W/RANDOM NUMBER--------@@
setRandArr:			@ setRandArr(int arr[], int size)
@{
 	push {r4-r7, lr}
	mov r4, r0		        @ load array before i loop
	mov r5, r1			    @ r5=size=4
	mov r6, #0 			    @ r6 = i = 0
	forLoop:				@ for(i < 4)
		
		cmp r6, r5			@ (i-4)==? Set flags
		bge forLoopEnd		@ if(i >= 25) then end loop

		bl getRandNum	 	@ Call randNum() and returns r0=randNum
		mov r7, r0	     	@ r7=random number

		@ store a value into the array address	
		str r7, [r4]		@ arr[i] = i; @ str source, [destination]
			
		@ Increment i and array address to next
		add r4, #4			   @ increment array address
		add r6, #1			   @ i++
		bal forLoop			   @ keep looping

	forLoopEnd:   			
	pop {r4-r7, pc}
@}

@@ -------------------- Get and return a random number -------------------- @@
getRandNum:
@{
	push {lr}
	bl rand  	       @ calls the rand function
	and r0, r0, #0xff  @ filters out the numbers to reasonable size without it you can get a 32bit number
	pop {pc}
@}


@@ ---------------- int checkPassword code[],guess[],size) ---------------- @@
checkPassword:            @ Check if user's guess is correct   
@ {
    @ r4 = r0 = code address
    @ r5 = code[i]
    @ r6 = r1 = guess address
    @ r7 = guess[i]
    @ r8 = i = 0
    @ r9 = r2 = size
    @ r10 = zeroTo3Correct=TRUE
    @ r11 = return isTrue=FALSE


    push {r4-r11, lr}     @ protect these registers from this function from altering them
                          @ Get variables ready before loop starts 
    mov r4, r0            @ r4=code[]   
    mov r6, r1            @ r5=guess[]
    mov r8, #0            @ r8=i=0;
    mov r9, r2            @ r9=size
    mov r10, #1           @ r10=isZeroTo3Correct= 
    mov r11, #0           @ r11=return isTrue=FALSE
    pwLoop:               @ for(i=0;i<size;i++)
    @ {    
        cmp r8, r9        @ (i-size) == Set Flags
        bge endPWLoop     @ if(i>=size) ? N==V

        @@ ----------- Load code[i] ----------- @@
        ldr r5, [r4, r8, lsl #2]

        @@ ----------- Load guess[i] ----------- @@
        ldr r7, [r6, r8, lsl #2]


        @ For each index, Print i and then arrays comparison results
        ldr r0, =outI
        mov r1, r8                  @ r8=i
        bl printf                   @ printf(outI, i);

        @@ -----------  if(code[last] == guess[last]){  ----------- @@
        cmp r5, r7                  @ ( code[i] - guess[i] == Set Zero Flag)
        bne isWrong                 @ if ( code[i] != guess[i] ) ? Z==0 False
        beq isRight                 @ if ( code[i] == guess[i] ) ? Z==1 True
        @ {
            isWrong:                @ code[i] != guess [i]
                mov r10, #0         @ isZeroTo3Correct=FALSE
                ldr r0, =outNotEq   
                mov r1, r7          @ r7 = guess[i]
                bl printf           @ printf(outNotEq,guess[i]);   
                b checkIsLastIndxANDTrue
            isRight:                @ code[i] == guess[i]
                ldr r0, =outEq
                mov r1, r5          @ r5 = code[i]
                mov r2, r7          @ r7 = guess[i]
                bl printf           @ printf( outEq, code[i], guess[i] );
        @ }

        @@ --- if(i == lastIndx && isZeroTo3Correct == TRUE && code[last] == guess[last])  --- @@
        checkIsLastIndxANDTrue:
        ldr r0, =lastIndx
        ldr r0, [r0]

        @@ -----------  if(i == lastIndx)  ----------- @@
        cmp r8, r0                       @ ( i - last ) == Set Zero Flag
        bne incremntPWLoop               @ ( i-3 != 0 ) ? Z==0 FALSE
        @ beq checkZeroTo3                @ ( 3-3 == 0 ) ? Z==1 TRUE
        @ {
            
            @@ -----------  if(isZeroTo3Correct == TRUE)  ----------- @@
            @checkZeroTo3: 
            cmp r10, #1                 @ ( isZeroTo3Correct - 1 ) == Set Zero Flag
            bne incremntPWLoop          @ ( 0-1==-1 ) ? Z==0 False :
            @ beq checkLastIndx
            @ {

                @@ -----------  if(code[last] == guess[last]){  ----------- @@
                checkLastIndx:
                ldr r5, [r4, r8, lsl #2]    @ Load code[i]        
                ldr r7, [r6, r8, lsl #2]    @ Load guess[i] 
            
                cmp r5, r7                  @ ( code[last]  - guess[last] ) == Set Flags
                bne incremntPWLoop          @ ( code[last] != guess[last] ) ? Z==0 False : 
                @ beq setIsTrue              @ ( 1-1==0 ) ? Z==1                
                @ {
                    setIsTrue:              @ if(code[last] == guess[last])        
                    mov r11, #1             @ set return isTrue=TRUE       
                    bal endPWLoop                            
        @ }}}

        incremntPWLoop:    
        add r8, #1           @ i++
        bal pwLoop
    @ }
    endPWLoop:
    mov r0, r11          @ r0=r11. Set return register r0=isTrue
    pop {r4-r11, pc}     @ return r0 = bool isTrue;
@ }



@@ -------------------- setGuess(guess[],size) -------------------- @@
setGuess:               @ Set user's guess in an array 
@ {
    @ r4 = r0 = guess
    @ r5 = r1 = size
    
    push {r4-r6, lr}    @ protect these registers from this function from altering them
    
    @ Loop through array to set each index
    mov r4, r0          @ r4=guess
    mov r5, r1          @ r5=size
    mov r6, #0          @ i=0
    setGuessLoop:       @ for(int i=0i<sizei++){
    cmp r6,r5           @ i-size==set flags
    bge endSetGuess     @ if(i>=size), ? end loop
    @{
        doWhile:  @ Ask for user's input until it's a positive integer
        @{        @ do...while(guess[i]<1)
            ldr r0, =inOneDigit
            bl printf       @ printf(inOneDigit)
            
            ldr r0, =deref
            mov r1, r4      @ r1=guess
            bl scanf        @ scanf("%d", &guess[i])

            @ validate user input is positive integer
            ldr r0, [r4]        @ load variable's address
            cmp r0, #0          @ r4-1==set flags
            bge incrmntSetGuess @ if( i>= 0) N==V
            @{
                @ invalid input message
                ldr r0, =outInvalid
                bl printf        
                b doWhile         @ (guess[i]<1). N!=V
            @}
        @}

        incrmntSetGuess:@ increment i and array
        add r4, #4      @ guess[guessAddress+4bytes]
        add r6, #1      @ i++
        bal setGuessLoop
        
    @}
    endSetGuess: 
    pop {r4-r6, pc}
@ }



@@ -------------------- PRINT 1 Array -------------------- @@
printArr: 				        @ void printArr(arr[], size){
@ {
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

        ldr r0, =derefC	        @ load deref string
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
@ {
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


@ FOR TESTING/GRADING PURPOSES: I'm printing the secret random code[]]
printSecret:
@{   
    push {lr}
    ldr r0, =outCode
	bl printf           @ printf(outCode); 		
	ldr r0, =code		
	ldr r1, =size
	ldr r1, [r1]
	bl printArr 		@ printArr(code,size=4)
    ldr r0, =endl		@ load string
    bl printf 			@ printf("\n")
    pop {pc}
@}