@ To compile & run in terminal: gcc -o fileName fileName.s && ./fileName
@ 09-11-24
.global main
.func main

.align 4
.section .rodata
outputStr: .asciz "%d\n"

main:   @int main(){
    push {lr}

    mov r7, #5  @ int r7=5
    mov r8, #10 @ int r8=10
    
    @add r2, r7, r8 @ r2 = r7 + r8
    @rsb r2, s7, s8 @reverse subtract
    sub r2, r8, r7  @ r2 = r7 - r8

    ldr r0, =outputStr
    mov r1, r2
    bl printf      @ printf("%d\n", r2) 

    @add r3, r7, r7 @ r3 = r7 + r7
    sub r3, r7, r7  @ r2 = r7 - r7

    ldr r0, =outputStr
    mov r1, r3
    bl printf   @ printf("%d\n", r3) 
    
    mov r0, #0  @return 0;
    pop {pc}    
