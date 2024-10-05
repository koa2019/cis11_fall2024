@ week 5  9-16-24
@ compile: 
.global _start // start program at this label

.text
_start: 

        mov r0, #10
        cmp r0, #0      @ if(r0<0), then
        movmi r1, #60   @ move minus r1=60
        movpl r1, #0    @ move plus r1=0

        mov r7, #1
        mov r0, r1
        swi 0           @ syscall exit
