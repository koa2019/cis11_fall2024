// How to compile & run: 
//                      gcc lab6prob3.c && ./a.out
// how2Compile.txt
#include <stdio.h>

int main(){

    int c=0, f=0;

    for(int i=0; i<=20;i++){
        
        c=i-32;
        c=c*5;
        c=c/9;

        printf("%dF == %dC\n",i,c);
    }

    return 0;
}