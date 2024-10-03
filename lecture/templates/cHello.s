@ To compile & run in terminal: gcc -o fileName fileName.s && ./fileName
.global main // start program at this label

// Use c lang. to run assembly code

// cpp code in netbeans
//int main(){
//    char str[50]="Hello World\n";
//    return 0; }

.align 4
.section .rodata 
// readonly constants initalized math pi, etc
helloStr: .asciz "Hello World\n" //char str[50]="HelloWorld\n";

.text
main:                       // int main()
    
        push {lr}           // push Link Register r14 to top of stack

        ldr r0, =helloStr  // load register 0 with this string
        bl printf          // printf(str); branch link. Keeps track of where we've been

        mov r0, #0          @return 0;                   
        pop {pc}            //puts lr(r14) in prog counter(r15)
        