// to compile in terminal:         make build && ./tri
// to print last prgm in terminal: echo $?
.global main
.extern intSqrt //DO NOT REMOVE


.align 4
.section .data // your data here
sideA: .word 0 // side A of the right angle = 0. integer value
sideB: .word 4  // side B of the right angle = 0. integer value
sum: .word 0    // accumulate sum
hyp: .word 0    // hyp = sqrt(a^2+b^2)


.align 4
.section .rodata // your read only data here
numPattern: .asciz "%d"
prompt: .asciz "\n\nThis program finds the hypontenuse of a right angle.\n"
promptA: .asciz "Enter side A as an integer: "
promptB: .asciz "Enter side B as an integer: "
outputA: .asciz "\nSide A: %d\n"
outputB: .asciz "\nSide B: %d\n"
outputSum: .asciz "Sum: %d\n"
outputHyp: .asciz "Hypotenuse: %d\n"
errorMsg: .asciz "Error. Invalid input.\n"


.text
main:
    push {lr}            // push link register r14 to top of stack

    @@---------- input sideA ---------@@
      
    ldr r0, =prompt     // load welcome message in r0
    bl printf           // print string in r0
    ldr r0, =promptA    // load this string in r0
    bl printf           // print string in r0

    @ get int sideA
    ldr r0, =numPattern // tells program a number is coming
    ldr r1, =sideA      // load r1 with sideA
    bl scanf            // saves input as sideA in r1

    @ validate input is an integer
    ldr r0, =sideA
    cmp r0, #1
    blt error       // if(r0 < 1) goto end

    @ output sideA
    ldr r0, =outputA    // load this string in r0
    ldr r1, =sideA      // load r1 with sideA address
    ldr r1, [r1]        // get value stored in the address thats load in r1
    bl printf          // print value of sideA


    @@---------- input sideB ---------@@ 
    ldr r0, =promptB
    bl printf      

    @  get integer value for sideB
    ldr r0, =numPattern // tells program a number is coming
    ldr r1, =sideB      // load r1 with sideB
    bl scanf            // r1=sideB         

    @ output sideB
    ldr r0, =outputB    // load this string in r0
    ldr r1, =sideB      // load r1 with sideB address
    ldr r1, [r1]        // load value stored in r1's address
    bl printf          // print value of sideB
    
    
    @@---------- calculations ---------@@   

    // set r7 with sideA^2
    ldr r0, =sideA      // load r0 with sideA address
    ldr r0, [r0]        // load value stored in r0's address
    mul r0, r0, r0      // r1=sideB^2
    mov r7, r0          // r7=sideA


    @@ ???? how to set sideA = r7 or just print r0 here    ?????
    @@ output sideA^2 (r0)
    @ mov r1, r7
    @ bl printf



    @ // square and add sideB to r7
    ldr r1, =sideB      // load r1 with sideA address
    ldr r1, [r1]        // dereference address thats loaded in r1
    mul r1, r1, r1      // r1=sideB^2
    add r7, r7, r1      // r7 += sideB

    @ output sideB^2 (r1)



    @ //------------ output sum (r1) -----------------//

    ldr r0, =outputSum    // load this string in r0
    mov r1, r7            // load r7's address  
    bl printf          // print value of sum


    @ //------------ Calcul & output hypot=sqrt(r0) -----------------//


    @ @ //?????????? How do u print intSqrt or save to register ??????????

         
    mov r0, r7
    //ldr r0, =outputHyp    
    //mov r1, r7            // copy r7's address in r1
    bl intSqrt            // Call a square root routine
    //bl printf          // print value of sum

    bal end
error:
    ldr r0, =errorMsg
    bal end
end:
    //mov r0, #0  @return 0; }    
    pop {pc} // should return 2 if the sqrt is working
