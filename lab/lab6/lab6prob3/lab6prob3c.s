@ 10-30-24 Lab6 Prob 3
@ To compile & run in terminal:
@ gcc lab6prob3c.s && ./a.out
@ gcc lab6prob3c.s divmod.s && ./a.out

@ ADD DIVMOD
@ ADD int celisus (int f)

.global main
.global celsius             @ int celisus(int f)


.align 4 
.section .rodata            @ all constant initalized data goes here
deref: .asciz "%d "         @ tells it a number is coming
derefN:  .asciz "%d\n"
out: .asciz "%dF  == %dC\n"

.text
celsius:                    @ int celisus(int r0=f)

	push {lr}

    @ Calculate Fahrenheit to Celisus
    mov r1, #5              @ (F-32) * 5
    sub r0, r0, #32         @ C = (F-32)
    mul r0, r0, r1          @ C = (F-32) * 5
    bl abs                  @ abs() returns value in r0

    @ Divide Celisus by 9
    mov r0, r0, lsr #3      @ celisus = celisus/2^3
    pop {pc}


.align 4
.text
main:                   @ int main(){
    push {lr}           @ push link register r14 to top of stack

    mov r4, #0          @ int i=0
    mov r5, #20         @ stop loop

for:
        cmp r4, r5      @ i-20==?
        bgt endFor      @ if(i>20), then end loop

        mov r0, r4      @ 1st parameter of celisus(int r4=fahrenheit)
        bl celsius      @ int celisus(int r0)
        mov r6, r0      @ int celisus() returns r0=celisus

        @ Output results
        ldr r0, =out
        mov r1, r4      @ fahrenheit
        mov r2, r6      @ celisus
        bl printf

        add r4, #1      @ i++
        bal for         @ branch always for loop

endFor:
    mov r0, #0          @ return 0
    pop {pc}            @ return to where i was. Pop whatever on top of stack into program counter r15

abs: 					@ int abs( int x ){
	push {lr}
	cmp r0, #0
	bge absEnd
	rsb r0, r0, #0  		@ return ( x < 0  ) ? -x : x; 
	@ Another way to do it is using 2's comp
	@ mvn r0, r0  mov negative number. 1's comp to r0
	@ add r0, #1  add 1 to make it a 2's comp

absEnd:@ ternary is a 1 line if
	pop {pc}
