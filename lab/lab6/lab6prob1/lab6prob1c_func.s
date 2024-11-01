@ compile & run in terminal: gcc lab6prob1c_func.s && ./a.out

@ danielle: switch labels to functions

.global main
.global getWidth
.global getLength
@ .global getArea
@ .global displayData

.align 4
.section .rodata           @ readonly data   
deref: .asciz "%d"         @ tells it a number is coming
derefN: .asciz "%d\n"      @ tells it a number is coming
inW: .asciz "Input Width: "
inL: .asciz "Input Length: "
outGetPositive: .asciz "\nEnter a positive number: " 
outW:    .asciz "\tWidth: %d\n"
outL:    .asciz "\tLength: %d\n"
outArea1: .asciz "\n\nWidth x Length = Area\n" @ like scanf syntax in C lang
outArea2: .asciz "%d x %d = " @ like scanf syntax in C lang

.align 4
.section .data
w: .word 0          @ int w=0
l: .word 0          @ int w=0

.text
getWidth:               @ int getWidth() return width in r0

    push {lr}           @ push link register r14 to top of stack
    ldr r0, =inW        @ load register 0 with this string
    bl printf           @ branch link to print. Keeps track of where we've been

    @ Get user's input and set width with input
    ldr r0, =deref      
    ldr r1, =w
    bl scanf

    @ return width in r0
    ldr r0, =w
    ldr r0, [r0]
    pop {pc}

.text
getLength:             @ int getLength() return r0=length
    push {lr}
    ldr r0, =inL       @ load register 0 with this string
    bl printf          @ branch link to print. Keeps track of where we've been

    @ Get user's input and set variable n with input
    ldr r0, =deref      
    ldr r1, =l
    bl scanf

    @ return width in r0
    ldr r0, =l 
    ldr r0, [r0]
    pop {pc}

.text 
getArea:                @ int getArea(int width, int length)                
    push {lr}           @ push link register r14 to top of stack    
    mul r0, r0, r1      @ Caluculate Area=Width*Length
    pop {pc}

.text    
displayData:            @ Output results
    push {lr}           @ push link register r14 to top of stack
    push {r2}
    push {r1}
    push {r0}
    ldr r0, =outArea1
    bl printf
    ldr r0, =outArea2
    pop {r1}             @ mov r1, r4. Print width
    pop {r2}            @ mov r2, r5. Print length
    bl printf
    ldr r0, =derefN
    pop {r1}            @ mov r1, r6
    bl printf
    pop {pc}

.text
main:                   @ int main(){
    push {lr}           @ push link register r14 to top of stack

doWhile:                @ Ask for user's input until it's a positive 
 
    bl getWidth         @ Call function

    cmp r0, #0          @ r0-0==set flags. Validate user input is positive integer
    ble doWhile         @ do...while(n<=0). (Z==1 or N!=V)
    mov r4, r0          @ set r4=width

doWhile2:               @ Ask for user's input until it's a positive integer

    bl getLength        @ Call function

    cmp r0, #0         @ r4-0==set flags. Validate user input is positive integer
    ble doWhile2       @ do...while(n<=0). (Z==1 or N!=V)
    mov r5, r0         @ set r5=length

    mov r0, r4         @ 1st parameter for getArea(int,int)
    mov r1, r5         @ 2nd parameter for getArea(int,int)
    bl getArea         @ Caluculate Area. int getArea(int width, int length)
    mov r6, r0         @ getArea() returns value in r0. Set r6=area

    mov r0, r4         @ 1st parameter for displayData(int,int,int)
    mov r1, r5         @ 2nd parameter for displayData(int,int,int)
    mov r2, r6         @ 3rd parameter for displayData(int,int,int)
    bl displayData     @ Call displayData(int,int,int)

    mov r0, #0  @return 0
    pop {pc}    
