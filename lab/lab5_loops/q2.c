// How to compile & run: 
//         g++ q2.c && ./a.out
// how2Compile.txt
#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>

int main(){

    // Declare & initialize variables
    char out1[] ="Input as many integers as you want.\nProgram will find the largeset and smallest numbers.\n";
    char deref[]   ="%d";
    char derefN[]  ="%d\n";
    char outGetN[] = "Enter a positive number. Enter -99 to STOP: ";
    char outN[]    = "\nYou entered: %d\n";
    char outMax[]  = "\nMax: %d\n";
    char outMin[]  = "\nMax: %d\n";
    int num, stop=-99, max, min;
    num=max=min=0;

    // Output program's intent
    printf("%s",out1);    

    // Ask for user's input until it's a positive integer
    do {
        printf(outGetN);
        scanf(deref, &num);
        printf(outN,num);

        if(num!=stop && num<min){ min=num; }
        else if(num>max){ max=num; };

    }while(num!=stop);

    // Output max & min
    printf(outMax,max);
    printf(outMin,min);
    
    return 0;
}