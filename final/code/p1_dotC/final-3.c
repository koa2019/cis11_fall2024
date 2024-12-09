// How to compile & run: 
//         g++ fileName.c
//         ./a.out
// how2Compile.txt

// final-3.c: in main it creates a for loop to check if the two arrays are equal.

#include <stdio.h>

int main(){

    char inCode[] = "input 4 digit code ";
    char *deref = "%d";
    char *derefN = "%d\n";
    char *endl = "\n";
    char *outCode = "\nCode:  ";
    char *outCodeDeref = "\nCode:  %d\n";
    char *outGuess = "\nGuess: ";
    char *outGuessDeref = "\nGuess: %d\n";
    char *outWrong = "Wrong Guess. \n";
    char *outRight = "Right Guess. \n";
    char *outEq = " %d==%d\n";
    char *outNotEq = " %d!=%d\n";
    char *outTy = "\nGood Bye";

    int size=4;    
    int code[] = {6,6,1,5};
    int guess[] = {6,6,1,4};//*guess={};
 

    // Get user's guess
    // printf(inCode);
    // scanf(deref, &guess);


    // Output guess 

    int i=0;

    printf(outCode);
    for(i=0; i<size;i++){
        printf(deref, code[i] );
    }
    printf(endl);

    printf(outGuess);
    for(i=0; i<size;i++){
        //printf(deref, guess[0]);
        printf(deref, guess[i] );
    }
    printf(endl);

    for(i=0;i<size;i++){
        if(code[i]!=guess[i]){
            goto endLoop;
        }
    }
    endLoop:
    printf(outWrong);

end:
    printf(outTy);
    return 0;
}