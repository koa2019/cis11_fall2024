// to compile in terminal:         make build && ./tri
// to print last prgm in terminal: echo $?
// 09-27-24     Lab 4 Pythagorean Thm
// See README file for write-up
.global main
.extern intSqrt //DO NOT REMOVE


.align 4
.section .rodata // read only data here
derefN: .asciz "%d\n"
deref: .asciz "%d"
prompt: .asciz "\n\nThis program finds the hypontenuse of a right angle.\n"
promptA: .asciz "\nEnter side as an integer: "
promptB: .asciz "\nEnter side B as an integer: "
outA: .asciz "\nSide A: %d\n"
outB: .asciz "Side B: %d\n"
outAB: .asciz  "%d + %d"
outSum: .asciz " = %d\n"
outHyp: .asciz "Hypotenuse = %d\n\n\n"
outEq: .asciz "\nError. Zero is invalid input.\n\n"
outLess: .asciz "\nError. Negative input.\n\n"
outGt: .asciz "\nValid input\n"


.align 4
.section .data  // data here
sideA: .word 3  // side A of the right angle = 0. integer value
sideB: .word 4  // side B of the right angle = 0. integer value
sum: .word 0    // accumulate sum
hyp: .word 0    // hyp = sqrt(a^2+b^2)
temp: .word 0 // temp for user inputs

.text
main:
    push {lr}            // push link register r14 to top of stack
      
    ldr r0, =prompt     // load welcome message in r0
    bl printf           // print string in r0


    @----------------- sideA ------------------@


    @bl getSide          @ get & validate user input
    ldr r0, =promptA    // load this string in r0
    bl printf           // print string in r0

    @ input sideA
    ldr r0, =deref // tells program a number is coming
    ldr r1, =sideA      // load r1 with sideA
    bl scanf            // saves input as sideA in r1

    @ validate input is greater than zero
    ldr r0, =sideA      @ get var address
    ldr r0, [r0]        @ dereference address to get value
    cmp r0, #0          @ cmp(sideA-0)==+,0,-s
    blt lessThan        @ if(sideA<0)  goto lessThan
    beq equal 		    @ if(sideA==0) goto equal  
  

    @ @ set sideA
    @ ldr r0, =temp
    @ ldr r0, [r0]
    @ ldr r1, =sideA
    @ ldr r1, [r0]


    @----------------sideB ----------------@

    @ input sideB
    ldr r0, =promptA
    bl printf     
    ldr r0, =deref // tells program a number is coming
    ldr r1, =sideB      // load r1 with sideB
    bl scanf            // r1=sideB         

    @ validate input is greater than zero
    ldr r0, =sideB      @ get var address
    ldr r0, [r0]        @ dereference address to get value
    cmp r0, #0          @ (sideB-0)==?
    blt lessThan        @ if(sideB<0)  goto lessThan
    beq equal 		    @ if(sideB==0) goto equal


  @------------------ Output User Inputs -----------------@

    @ output sideA
    ldr r0, =outA       // get this string's address
    ldr r1, =sideA      // get this variable's address
    ldr r1, [r1]        // deref address to get value
    bl printf           // branch link to print. Keeps track of where we've been 

    @ output sideB
    ldr r0, =outB       // get this string's address
    ldr r1, =sideB      // get this variable's address
    ldr r1, [r1]        // deref address to get value
    bl printf           // branch link to print. Keeps track of where we've been
    

    @------------------ Calculations -----------------@   

    // square sideA and add to r7
    ldr r0, =sideA      // get sideA's address
    ldr r0, [r0]        // deref address to get value in r0
    mul r8, r0, r0      // r8=sideA*sideA 
    mov r7, r8          // set r7=sideA   

    @ square and add sideB to r7
    ldr r1, =sideB      // get sideB's address
    ldr r1, [r1]        // dere address to get value in r1
    mul r9, r1, r1      // r9=sideB*sideB
    add r7, r7, r9      // r7 += sideB


   @------------------ Reinitialize Variables -----------------@

    @ store r8 in sideA
    mov r0, r8              @ copy r8 to r0
    ldr r2, =sideA          @ get sideA's address  
    str r8, [r2]            @ str source, deset. a^2, sideA 

    @ store r9 in sideB
    mov r0, r9              @ copy r9 to r0
    ldr r2, =sideB          @ get sideB's address   
    str r9, [r2]            @ str source, deset. b^2, sideB
    
    @ store r7 in sum
    mov r0, r7
    ldr r2, =sum
    str r7, [r2]            @ str source, deset 

 @-------------------- output c=a^2+b^2  --------------------@
  
    ldr r0, =outAB          @ concatente var+str+var
    ldr r1, =sideA          
    ldr r1, [r1]            @ sideA=sideA^2 
    ldr r2, =sideB          @ sideB=sideB^2
    ldr r2, [r2]
    bl printf               @ output a^2+b^2

    ldr r0, =outSum         
    ldr r1, =sum       
    ldr r1, [r1]                  
    bl printf               @ output the sum of a^2+b^2    

    @-------------------- Calculate sqRt(sum) --------------------@
    ldr r1, =sum
    ldr r1, [r1]        @ get this variables value
    mov r0, r1          @ copy value to r0
    bl intSqrt          @ Call a square root routine  

    @-------------------- Output hypotenuse=sqrt(r0) --------------------@
    
    mov r1, r0
    ldr r0, =outHyp
    bl printf 
    bal end

getSide:

  
    @bal setA
    

isValid:

setSide:

equal:
    ldr r0, =outEq
    bl printf 		@ printf( "equal to\n" );
    bal end 		@ branch always to the end
    
lessThan:
    ldr r0, =outLess
    bl printf
    bal end
end:
    mov r0, #0  @return 0; }    
    pop {pc} // should return 2 if the sqrt is working

