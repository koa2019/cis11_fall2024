@ 10-30-24 Lab6 Prob 2 Falling Distance using functions
@ compile & run in terminal: gcc lab6prob2a.s && ./a.out

.global main
.global fallingDistance

.align 4
.section .rodata                    @ readonly data   
deref: .asciz "%d"                  @ tells it a number is coming
derefN: .asciz "%d\n"               @ tells it a number is coming
outD:    .asciz "\tDistance: %d\n"
outT:    .asciz "\Time: %d\n"
out: .asciz "%d sec  = %d meters\n" @ like scanf syntax in C lang

.text
fallingDistance:                @ int fallingDistance(int time) 
    push {lr}
    mov r1, #9                  @ r1 = gravity 9 meters/sec
    mul r0, r0, r0              @ time = time^2
    mul r0, r0, r1              @ distance = gravity*time^2
    mov r0, r0, lsr #1          @ distance/2^1
    pop {pc}


.text
main:                           @ int main(){
    push {lr}                   @ push link register r14 to top of stack

    @ set for loop variables
    mov r4, #1                  @ int i=0
    mov r5, #10                 @ stop loop
    mov r6, #0                  @ distance

for:
        cmp r4, r5              @ i-20==?
        bgt endFor              @ if(i>20), then end loop
         
        @ Calculate distance
        mov r0, r4              @ r0=time. Argument for fallingDistnace(int time)
        bl fallingDistance      @ int fallingDistnace(int time) returns r0=distance
        mov r6, r0              @ save distance in r6
        
        @ Output results
        ldr r0, =out
        mov r1, r4              @ time
        mov r2, r6              @ distance
        bl printf

        add r4, #1          @ i++
        bal for             @ branch always for loop

endFor:
    mov r0, #0
    pop {pc}
