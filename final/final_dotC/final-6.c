// How to compile & run on pi4: 
//         g++ final-6.c
//         ./a.out
// how2Compile.txt

// final-6.c:
// * I went back to version final-4 because switching the arrays to char instead of int created way too 
//   many problems.
// * Fixed the BUG when the user inputs their code. Before scanf was saving all 4 digits in index zero. I
//   fixed it by adding a loop and then deferencing each index of the array inside of the loop.

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

    char outInstruct[] = "\nWelcome to Mastermind. Guess the 4 digit secret code to win!\n\n";
    char inCode[] = "input 4 digit code ";
    char inOneDigit[] = "input a digit and then press Enter: ";
    char deref[] = "%d";
    char derefN[] = "%d\n";
    char endl[] = "\n";
    char outCode[] = "\nCode:  ";
    char outGuess[] = "\nGuess: ";
    char outWrong[] = "Wrong Guess. GAME OVER. \n";
    char outRight[] = "Right Guess! Congratulations You've Won! \n";    
    char outTy[] = "\nGood Bye";

    int size=4;    
    int code[] = {6,6,1,5};
    int guess[] = {6,2,1,4};
 

    // Get user's guess
    printf(outInstruct);

    //BUG
    //printf(inCode);
    //scanf(deref, &guess);

    for(int i=0;i<size;i++){

        //guess[i]=getchar();

        printf(inOneDigit);
        scanf(deref, &guess[i]);
        //scanf(deref, guess[i]);
    }


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