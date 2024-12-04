// How to compile & run on pi4: 
//         g++ final-5.c && ./a.out
// how2Compile.txt

// final-5.c:
// * changed the arrays from int to char
// * Added user input to get one character at a time
// * BUG: outputs ASCII values instead of numbers. I wont know how to change that in assembly.

#include <stdio.h>

int checkPassword(char code[], char guess[], const int size){

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
    char deref[] = "%d";
    char derefN[] = "%d\n";
    char endl[] = "\n";
    char outCode[] = "\nCode:  ";
    char outGuess[] = "\nGuess: ";
    char outWrong[] = "Wrong Guess. \n";
    char outRight[] = "Right Guess. \n";    
    char outTy[] = "\nGood Bye";

    int size=4;    
    char code[] = {'6','6','1','5'}; //{6,2,1,5};
    char guess[] = {'6','6','1','5'}; //{6,2,1,4};
 

    // Get user's guess
    printf(inCode);
    // for(int i=0;i<4;i++){
    //     guess[i]=getchar();
    // }
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