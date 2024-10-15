// How to compile & run: 
//         g++ fileName.c
//         ./a.out
// how2Compile.txt
#include <stdio.h>

int main(){
    int n=5, c=0;

    while(n!=1){
        if(n & 1){ 
            n =3*n+1;
        } else { 
           n = n/2;   
        }
        // if(n%2==0){ n = n/2; } 
        // else { n =3*n+1; }
        c=c+1;
        printf("%d, ",n);
    }

    printf("\n%d times \n",c);
    
    return 0;
}