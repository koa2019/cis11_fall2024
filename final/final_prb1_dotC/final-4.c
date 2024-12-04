// How to compile & run on pi4: 
//         g++ final-4.c
//         ./a.out
// how2Compile.txt

// final-4.c:
// * builds on final-3 and moves the for loop that checks if the two arrays are equal into 
//   a function that returns 1 or 0 if they are equal.
// * checkPassword func outputs whether each index is equal or not.

#include <stdio.h>

int checkPassword(int *code, int *guess, const int size){

    char outI[]     = "[%d]: ";
    char outEq[]    = " %d==%d\n";
    char outNotEq[] = " %d!=%d\n";
    int isTrue=0;   //false=0
    int last=size-1;

    printf("\n\n\tVerifying for code...\n");
    int i=0;
    for(i=0;i<size;i++){
        
        printf(outI,i);

        if(code[i]!=guess[i]){
            printf(outNotEq,guess[i],code[i]);
            goto endLoop;
        } else {
            printf(outEq,guess[i],code[i]);
        }
        if(code[last]==guess[last]){
            isTrue=1;   //true=1          
        }
    }
    endLoop:
    return isTrue;
}

int main(){

    char inCode[] = "input 4 digit code ";
    char *deref = "%d";
    char *derefN = "%d\n";
    char *endl = "\n";
    char *outCode = "\nCode:  ";
    char *outGuess = "\nGuess: ";
    char *outWrong = "Wrong Guess. \n";
    char *outRight = "Right Guess. \n";    
    char *outTy = "\nGood Bye";

    int size=4;    
    int code[] = {6,6,1,5};
    int guess[] = {6,2,1,4};
 

    // Get user's guess
    // printf(inCode);
    // scanf(deref, &guess);

    // Check user's guess to the code
    int isPassword = checkPassword(code,guess,size);

    if(isPassword==1){
        printf(outRight);
    }else {
        printf(outWrong);
    }

    // Output code and guess 

    int i=0;
    printf(outCode);
    for(i=0; i<size;i++){
        printf(deref, code[i] );
    }

    printf(outGuess);
    for(i=0; i<size;i++){
        printf(deref, guess[i] );
    }
    printf(endl);

end:
    printf(outTy);
    return 0;
}