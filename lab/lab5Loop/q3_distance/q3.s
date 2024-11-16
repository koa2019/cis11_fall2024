@ 10-16-24 Lab 5 Loops Question 3: Find distance traveled.
@ compile & run in terminal: gcc -o q3 q3.s && ./q3
@ how2Compile.txt

.global main

.align 4
.section .rodata
deref: .asciz "%d"
derefN: .asciz "%d\n"
derefN2: .asciz " %d       %d\n"
out1: .asciz "\n\nProgram finds distanced traveled.\n"
outGetMph: .asciz "\nEnter speed in mph, miles per hour:  "
outGetTime: .asciz "\nEnter time in hours:  "
outBadMph: .asciz "\n\tInvalid mph. Must be a positive number."
outBadTime: .asciz "\n\tInvalid time. Must be greater or equal to 1 hour."
outDist: .asciz "\n\n Hr   Distance\n----  -------\n"
outI: .asciz "\ni: %d"
ty: .asciz "\nGood Bye\n\n"


.align 4
.section .data
speed: .word 0          @ int speed=0
time: .word 0           @ int time=0

.text
main:

    push {lr}

    ldr r0, =out1
    bl printf

doWhileSpeed:   
    
    ldr r0, =outGetMph
    bl printf           @ Prompt for user's input

    
    ldr r0, =deref
    ldr r1, =speed
    bl scanf            @ Get and set variable with input
    
    ldr r4, =speed
    ldr r4, [r4]        @ load speed

isValidSpd:             @ do while(speed<=0)
    cmp r4, #0          @ (r4-0==?)
    ble notValidSpd     @ if(speed<=0),then keep looping

doWhileTime:            @ do while(time<1)
   
    ldr r0, =outGetTime
    bl printf           @ Prompt for user's input

    
    ldr r0, =deref
    ldr r1, =time
    bl scanf            @ Get and set variable with input

    
    ldr r5, =time
    ldr r5, [r5]        @ load speed in r5

isValidTime:
    cmp r5, #1          @ (time-1==?)
    blt notValidTime     @ if(time<1),then keep looping


    @-------- CALCULATE DISTANCE --------@
    
    ldr r0, =outDist
    bl printf               @ Output header for distance

    mov r6, #1              @ int i=1
forDist:                    @ for(int i=1;i<=time;i++)

    cmp r6, r5              @ (i - time ==?)
    bgt endFor              @ (i <= time) -> (Z==0 && N==V)

    mul r7, r4, r6         @ distance=speed*i

    
    ldr r0, =derefN2
    mov r1, r6              @ r1=i
    mov r2, r7              @ r2=distance per hour
    bl printf               @ Output distance traveled every hour

    add r6, r6, #1          @ i++
    bal forDist             @ keep looping

notValidSpd:                @ if(speed<=0)
    ldr r0, =outBadMph
    bl printf
    bal doWhileSpeed

notValidTime:               @if(time<1)
    ldr r0, =outBadTime
    bl printf
    bal doWhileTime

endFor:
    ldr r0, =ty
    bl printf
    mov r0, #0
    pop {pc}                @ return 0
