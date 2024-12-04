// 10-13-24 Lab 5 Loops Question 1: Accumulate sum from 1 to n.
// How to compile & run:    g++ q1.c && ./a.out
// how2Compile.txt
#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>

int main(){

    // Declare & initialize variables
    int n=0;
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
        scanf(deref, &n);
        printf(derefN,n);
    }while(n<=0);

    printf(outN,n);

    // Calculate sum. sum=1+2+...+i
    for(int i=1;i<=n;i++){
        sum = sum + i;
    }

    // Output sum
    printf(outSum,sum);
    
    return 0;
}