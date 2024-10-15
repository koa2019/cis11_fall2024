// How to compile & run: 
//         g++ lab5.c
//         ./a.out
// how2Compile.txt
#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>

int main(){

    // Declare & initialize variables
    char n;
    int sum=0;
    char* out1 ="Program finds the sum of 1 to n.\n";
    char* deref="%d";
    char* derefN="%d\n";
    char* outGetN = "Enter a positive number: ";
    char* outN = "\nN: %d\n";
    char* outSum = "Sum: %d\n\n";

    // Output program's intent
    printf("%s",out1);    

    // Ask for user's input until it's a positive integer
    do {
        printf(outGetN);
        scanf("%c", &n);
        printf("%c",n);
    }while(n<=48 || n>57);//0-9==48-57
    //}while(n<=0 );

    printf(outN,n);

    // Calculate sum. sum=1+2+...+n
    for(int i=1;i<=n;i++){
        sum = sum + i;
    }

    // Output sum
    printf(outSum,sum);
    
    return 0;
}