@ Program only uses arm7 assembly. No C language.
@ wk 4  9-11-24
@ compile: 
@               as -o fileName.o fileName.s 
@               ld -o fileName fileName.o
@               ./fileName

.global _start // start program at this label

// cpp code in netbeans
//int main(){
//    char str[50]="Hello World\n";
//    printf(str);
//    return 0;
//}


.section .rodata 
// readonly constants initalized math pi, etc
helloStr: .ascii "Hello World\n" //char str[50]="HelloWorld\n";

.section .bss
//un-initalized dynamic arrays

.section .data
//non-constants initalized values

.text
_start:  //int main()
    
        //write with syscall
        mov r7, #4           // write syscall number
        mov r0, #1          // stdout
        ldr r1, =helloStr   // load string into r1
        mov r2, #12         // string length
        swi 0               // run this syscall

        mov r0, #0      // return 0 in cpp
        mov r7, #1      // return 0 syscall
        swi 0           // run this syscall
        