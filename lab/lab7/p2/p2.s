@ 11-15-24 Lab 7 Array Question 2: Find total,average, max and min rainfall.
@ compile & run in terminal: 
@       g++ maxMin_3.s
@       ./a.out
@       gcc p2.s divmod.s && ./a.out

.global main
.extern divMod


.align 4
.section .rodata            @ readonly data   
deref:   .asciz "%d"        @ tells it a number is coming
derefN:  .asciz "%d\n"
out1:    .asciz "\n\nProgram reverses the order of an array.\n\n"
outGetN: .asciz "Enter a number: " 
outNum:    .asciz "\n\tYou entered: %d\n"
outArr:  .asciz "%d, "
ty: .asciz "Good Bye\n\n"


.align 4
.section .data
len: .word 12          @ int size=10
arr: .skip 48 @int arr[10]. Each element is 4 bytes, 12*4=48 spaces
max: .word 0            @ int max=0
min: .word 0            @ int min=0


.text
main:                   @ int main(){
	str lr, [sp, #-4]!  //push {lr}

    @ set variables before for loop
    mov r4, #0          @ int i=0
    mov r5, #0          @ int max=0
    mov r6, #0          @ int min=0
    mov r9, #0          @ int sum=0

    @ get arr ready for user input
    ldr r7, =arr
    ldr r8, =len        @ int size=12
    ldr r8,[r8]

    @ Output instructions
    ldr r0, =out1
    bl printf

for:
    cmp r4, r8          @ (i-size)==set flags
    bge endFor          @ if(i>size)(Z==0 or N==V), then exit for loop  


doWhile:  @ Ask for user's input until it's a positive integer

    @ Prompt for user's input
    ldr r0, =outGetN
    bl printf

    @ Get and set variable with user input
    ldr r0, =deref
    mov r1, r7          @ mov r1=arr
    bl scanf			@ scanf( "%d", &a[i] )

    @ validate user input is positive integer
    ldr r0, [r7]        @ load variable's address
    //ldr r0, [r0]        @ load variable's value
    cmp r0, #0          @ r4-0==set flags
    ble doWhile         @ do...while(n<=0). (Z==1 or N!=V)

    @ output user's input
    ldr r0, =outNum
    ldr r1, [r7]
    bl printf

    ldr r0, [r7]
    add r9, r0          @ sum = sum+arr[i]

isMax:
    ldr r0, [r7]
    cmp r0, r5           @ (r7-r5==?). (input-max==N? V?)
    bgt setMax          @ if(input>=max)->(N==V)
    ble isMin           @ if(num<=max)->(Z==1 OR N!=V)

setMax:
    ldr r5, [r7]          @ max=arr[i]
    //mov r5, r7          @ max=arr[i]. Reset max with current input   
    @ ldr r0, =outNewMax  @ output msg each time a new max is found
    @ mov r1, r5
    @ bl printf
    bal isMin           @ branch to if input is a new min 

isMin:  
    ldr r0, [r7]
    cmp r4, #0
    beq setMinZero
    cmp r0, r6          @ (r7-r6==?). (input-min==N? V?)
    blt setMin          @ if(input<min)->(N!=V)
    bge increForLoop          @ if(input>=min)->(N==V). branch to endFor loop

setMinZero:
    ldr r6, [r7]          @ min=arr[0]
setMin:
    ldr r6, [r7]          @ min=arr[i]
    //mov r6, r7          @ min=arr[i]. Reset min with current input
    @ ldr r0, =outNewMin
    @ mov r1, r6
    @ bl printf           @ output msg each time a new max is found
    bal increForLoop    @ branch to if input is a new min 

increForLoop:
    @ incre for loop & the array
	add r7, #4			@ arr[i]++. +4-bytes
    add r4, r4, #1      @ i++ 
    bal for             @ keep looping

endFor:

    @bl printArr
    b outResults

outResults: 

    ldr r0, =outSum
    mov r1, r9
    bl printf

    // Calculate average rainfall for the year 
    ldr r0, =arr
    ldr r1, =len
    //ldr r1, [r1]
    bl divMod               @ int divMod(r0=arr[], r1=size)

    mov r1, r0
    ldr r0, =outAvg
    bl printf


    ldr r0, =outMax
    mov r1, r5
    bl printf           @ output max

    ldr r0, =outMin
    mov r1, r6
    bl printf           @ output min

    ldr r0, =ty
    bl printf           @ output endOfFile

    mov r0, #0  
    pop {pc}            @ return 0 to where i was. Pop whatever on top of stack into program counter r15

@     mov r4, #0          @ int i=0
@ printArr:               @ output arr
@     cmp r4, r8          @ (i-size)==set flags
@     bge endFor          @ if(i>size)(Z==0 or N==V), then exit for loop  

@     @ output arr[i]
@     ldr r0, =derefN
@     ldr r1, [r7]
@     bl printf

@     @ incre for loop & the array
@ 	add r7, #4			@ arr[i]++. +4-bytes
@     add r4, r4, #1      @ i++ 
@     bal printArr             @ keep looping
