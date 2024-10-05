@ To compile & run in terminal: gcc -o avg avg.s && ./avg
.global main
.func main

.align 4
.section .rodata @ all constant initalized data goes here
deref: .asciz "%d"      @ tells it a number is coming
derefN: .asciz "%d\n"      @ tells it a number is coming
prompt: .asciz "Input a number: "
outAvg: .asciz "Average: %d\n\n"
stop: .word 5       @ stop loop

.align 4
.section .data @ all non-constant initalized data goes here
num: .word 0
avg: .word 0

.align 4
.text
main:                   @ int main(){
    push {lr}           @ push link register r14 to top of stack
    mov r4, #0          @ int i=0
    ldr r5, =stop       @ load var stop
    ldr r5,[r5]         @ load its value
    mov r6, #0          @ sum=0

for:                @ for(int i=0; i<stop; i++)

    @ ask for input
    ldr r0, =prompt
    bl printf

    @ get user input
    ldr r0, =deref
    ldr r1, =num
    bl scanf            @ scanf(inDec, &num);

    @ load value in num
    ldr r1, =num
    ldr r1, [r1]
    add r6, r1          @ sum+=num

    @ Calculations
    mov r7, #0x334      @ hex rep of 1/5=.2. It was shifted right 12 places
    mul r8, r6, r7      @ r8=(sum *0.2)
    lsr r8, r8, #12     @ shift right 12 to account for the fraction

    add r4, r4, #1      @ i++
    cmp r4, r5
    blge endFor          @ if(i>=stop)
    bal for             @ always loop
    bal end

endFor:    
    ldr r0, =outAvg
    mov r1, r8
	bl printf
end:
    mov r0, #0  @return 0
    pop {pc}    @return to where i was. Pop whatever on top of stack into program counter r15
