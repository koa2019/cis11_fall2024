@ compile & run in terminal: gcc -o fileName fileName.s && ./fileName
@  09-16-24
.global main

.align 4
.section .rodata
prompt: .asciz "Enter a number: "   
inputPattern: .asciz "%d"
output: .asciz "Your number is: %d\n"

.align 4
.section .data
value: .word 0      @ int value=0;

.text
main:           @ int main(){
    push {lr}

    @ Ask for input
    ldr r0, =prompt
    bl printf           @ printf("Enter a number:")
    
    @  get number
    ldr r0, =inputPattern
    ldr r1, =value
    bl scanf            @ scanf("%d", &value);

    @ output number
    ldr r0, =output
    ldr r1, =value
    ldr r1, [r1]
    bl printf           @ printf("Your number is: %d\n", value);

    mov r0, #0  @return 0; }
    pop {pc}    @return to where i was
