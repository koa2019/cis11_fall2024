// How to compile & run: 
//         g++ fileName.cp
//         ./a.out
// how2Compile.txt
#include <stdio.h>

int main(){

    char inCode[] = "input 4 digit code ";
    char *deref = "%d";
    char *derefN = "%d\n";
    char *endl = "\n";
    char *outCode = "\nCode: ";
    char *outCodeDeref = "\nCode: %d\n";
    char *outGuess = "\nGuess: ";
    char *outGuessDeref = "\nGuess: %d\n";
    char *outWrong = "Wrong Guess. \n";
    char *outRight = "Right Guess. \n";

    int size=4;    
    int code[] = {6,6,1,5};
    int guess[size] = {};//{1,2,3,4};//*guess={};


    // Get user's guess
    printf(inCode);
    scanf(deref, &guess);


    // Output guess 
    printf(outGuessDeref, guess[0]);
    printf(outCodeDeref, code[0]);

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
   




end:
    return 0;
}