// How to compile & run: 
//         1. click run button
//         2. g++ fileName.c
//            ./a.out
//         3. how2Compile.txt
//
//  Largest/Smallest Array Values
// 	Write a program that lets the user enter ten values into an array. 
// 	The program should then display the largest and smallest values stored in the array.
#include <stdio.h>

int main(){
    int max=0;
    int min=0;
    int num=0;
    int stop=10;
    int arr[stop]={};
    int in[]={5,3,99,87,-1,12,66,99,151,650};


    // 
    printf("\nInput 10 integers.\n");

    for(int i=0; i<stop; i++){

        //printf("\nInput num: ");
        //scanf("%d", &num);
        //arr[i]=num;
        arr[i]=in[i];
        if(arr[i]>max){max=arr[i];}
        else if(arr[i]<min){min=arr[i];}
      
    }

    for(int i=0; i<stop; i++){
        printf("%d\n", arr[i]);
    }

    printf("\n\nmax: %d", max);
    printf("\nmin: %d\n\n", min);
    
    return 0;
}