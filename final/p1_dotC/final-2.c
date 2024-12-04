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
   
   // Compare arrays
   if(guess[0]==code[0] && guess[1]==code[1] && guess[2]==code[2] && guess[3]==code[3]){
        printf(outRight);
   } else {
        if(guess[0]!=code[0]){
            printf("[0]: ");
            printf(outNotEq,guess[0],code[0]);
            goto endLoop;
        } else if(guess[1]!=code[1]){
                printf("[0]: ");
                printf(outEq,guess[0],code[0]);
                printf("[1]: ");
                printf(outNotEq,guess[1],code[1]);
                goto endLoop;
        } else if(guess[2]!=code[2]){
                printf("[0]: ");
                printf(outEq,guess[0],code[0]);
                printf("[1]: ");
                printf(outEq,guess[1],code[1]);
                printf("[2]: ");
                printf(outNotEq,guess[2],code[2]);
                goto endLoop;
        } else if(guess[3]!=code[3]){
                printf("[0]: ");
                printf(outEq,guess[0],code[0]);
                printf("[1]: ");
                printf(outEq,guess[1],code[1]);
                printf("[2]: ");
                printf(outEq,guess[2],code[2]);
                printf("[3]: ");
                printf(outNotEq,guess[3],code[3]);
                goto end;
        } else {
                printf(outWrong);
        }
   }

endLoop:
    //printf(outWrong);

end:
    printf(outTy);
    return 0;
}