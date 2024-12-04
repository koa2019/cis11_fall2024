// Danielle F
// 12-01-2024 Final Problem 1: Mastermind
//
// How to compile & run on pi4: 
//         g++ final-7.c
//         ./a.out
// how2Compile.txt
//
//   final-7.c:
// * Added a loop to allow the user to guess 10 times.
// * 
//
// TO DO:
// * Add a random function to set code array.

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
            //printf(outNotEq,guess[i],code[i]);
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

    char outInstruct[] = "\n\tWelcome to Mastermind.\n\tGuess the 4 digit secret code.\n\tYou have 10 chances to win!\n\n";
    char outTry[] = "\n\tAttempt #%d:\n";
    char inCode[] = "input 4 digit code ";
    char inOneDigit[] = "Input one digit and then press Enter: ";
    char deref[] = "%d";
    char derefN[] = "%d\n";
    char endl[] = "\n";
    char outCode[] = "\nCode:  ";
    char outGuess[] = "\nGuess: ";
    char outWrong[] = "Wrong Guess. Try Again.\n\n";
    char outRight[] = "Right Guess! Congratulations You've Won! \n";    
    char outTy[] = "\nGAME OVER. Good Bye\n\n";

    int size=4;  
    int numTrys=3;  
    int code[] = {6,6,1,5};
    int guess[] = {6,2,1,4};
 

    // Get user's guess
    printf(outInstruct);
    
    // User has 10 attempts to guess the correct code
    int i=0;
    for(int i=1;i<=numTrys;i++){

        //Output number of attempts to guess code
        printf(outTry,i);
        //BUG
        //printf(inCode);
        //scanf(deref, &guess);


        //setGuess();
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
    }

    // Output code and guess 

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