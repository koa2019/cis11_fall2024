@ To compile & run in terminal:
@ gcc -o lab6prob3 lab6prob3.s && ./lab6prob3
@ gcc lab6prob3.s && ./a.out
@ gcc lab6prob3.s divmod.s && ./a.out

.global main
.extern divMod

.align 4 
.section .rodata @ all constant initalized data goes here
deref: .asciz "%d "      @ tells it a number is coming
derefN:  .asciz "%d\n"
out: .asciz "%dF  == %dC\n"

.align 4
.text
main:                   @ int main(){
    push {lr}           @ push link register r14 to top of stack

    mov r4, #0          @ int i=0
    mov r5, #20         @ stop loop
    mov r6, #0          @ Celisus
    mov r7, #5          @ (Fahrenheit-32) * 5
    @mov r8, #0xBF800000 @ -1


for:
        cmp r4, r5      @ i-20==?
        bgt endFor      @ if(i>20), then end loop

        @ Calculate Fahrenheit to Celisus
        sub r6, r4, #32         @ C = (Fahrenheit-32)
        mul r6, r6, r7          @ C = (Fahrenheit-32) * 5
        mov r0, r6              @ abs() needs Celisus to be in r0
        bl abs                  @ abs() returns value in r0
        mov r6, r0              @ r6=r0


        @ Divide Celisus by 9
        mov r6, r6, lsr #3          @ C = C/2^3
        @ mov r0, r6
        @ bl divMod //the division goes into r0 which is the return value for all functions
        @ mov r6, r0


        @ Output results
        ldr r0, =out
        mov r1, r4
        mov r2, r6              @ mov r2, r9
        bl printf

        add r4, #1          @ i++
        bal for             @ branch always for loop

endFor:
    mov r0, #0  @return 0
    pop {pc}    @return to where i was. Pop whatever on top of stack into program counter r15

abs: 						@ int abs( int x ){
	push {lr}
	cmp r0, #0
	bge absEnd
	rsb r0, r0, #0  		@ return ( x < 0  ) ? -x : x; 
	//another way to do it is using 2's comp
	// mvn r0, r0  mov negative number. 1's comp to r0
	// add r0, #1  add 1 to make it a 2's comp
absEnd:
@ //ternary is a 1 line if
	pop {pc}
@ }

