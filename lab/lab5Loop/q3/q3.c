// 10-16-24 Lab 5 Loops Question 3: Find distance traveled.
// How to compile & run:    g++ q3.c && ./a.out
// how2Compile.txt

#include <stdio.h>

int main(){

    char deref[]="%d";
    char derefN[]="%d\n";
    char derefN2[]=" %d       %d\n";
    char out1[]="\n\nProgram finds distanced traveled.\n";
    char outGetMph[]="\nEnter speed in mph, miles per hour:  ";
    char outGetTime[]="\nEnter time in hours:  ";
    char outBadMph[]="\n\tInvalid mph. Must be a positive number.";
    char outBadTime[]="\n\tInvalid time. Must be greater or equal to 1 hour.";
    char outDist[]="\n\n Hr   Distance\n----  -------\n";
    int speed=0;
    int time=1;
    
    printf(out1);

    // Prompt & validate user for speed. speed>0.
    do {
        printf(outGetMph);
        scanf(deref,&speed);
        if(speed<=0){printf(outBadMph);}
    }while(speed<=0);

    // Prompt & validate user for time. time>=1
    do {
        printf(outGetTime);
        scanf(deref,&time);
        if(time<=1){printf(outBadTime);}
    }while(time<=1);

    // Output distance traveled for every hour
    int distance=0;
    printf(outDist);
    for(int i=1;i<=time;i++){
        distance=speed*i;        
        printf(derefN2, i,distance);
    }

    return 0;
}