// Danielle F
// 12-01-2024 Final Problem 1: Mastermind
//
// How to compile & run on pi4: 
//         g++ final-8.c
//         ./a.out
// how2Compile.txt
//
//   final-8.c:
// * Moved user inputting their guess into a function
// * Created printArr() to print any int array
//
// TO DO:
// * Add a random function to set code array.
// * Change input from one digit at a time to all in one line of input

// #include <stdio.h>


// // Check if user's guess is correct
// int checkPassword(int *code, int *guess, const int size){

//     char outI[]     = "[%d]: ";
//     char outEq[]    = " %d==%d\n";
//     char outNotEq[] = " %d!=?\n";
//     int isTrue=0;   //false=0
//     int last=size-1;

//     printf("\n\n\tVerifying your code...\n");
//     int i=0;
//     for(i=0;i<size;i++){
        
//         printf(outI,i);

//         if(code[i]!=guess[i]){
//             printf(outNotEq,guess[i]);
//             goto endLoop;
//         } else {
//             printf(outEq,guess[i],code[i]);
//         }
//         if(code[last]==guess[last]){
//             isTrue=1;   //true=1          
//         }
//     }
//     endLoop:
//     return isTrue;
// }


// // Set user's guess in an array
// void setGuess(int guess[], int size){
    
//     char inOneDigit[] = "Input one digit and then press Enter: ";    
//     char inCode[] = "input 4 digit code ";
    
//     //BUG
//     //printf(inCode);
//     //scanf("%d", &guess);

//     // Loop through array to set each index
//     for(int i=0;i<size;i++){

//             printf(inOneDigit);
//             scanf("%d", &guess[i]);
//         }
// }

// // Print array
// void printArr(int arr[], int size){
//     int i=0;
//     for(i=0; i<size;i++){
//         printf("%d", arr[i]);
//     }
// }


// int main(){

//     char outInstruct[] = "\n\tWelcome to Mastermind.\n\tGuess the 4 digit secret code.\n\tYou have 10 chances to win!\n\n";
//     char outTry[] = "\n\tAttempt #%d:\n";
//     char deref[] = "%d";
//     char derefN[] = "%d\n";
//     char endl[] = "\n";
//     char outCode[] = "Code:  ";
//     char outGuess[] = "\nGuess: ";
//     char outWrong[] = " is a Wrong Guess. Try Again.\n\n";
//     char outRight[] = "Right Guess! Congratulations You've Won! \n";    
//     char outTy[] = "\nGAME OVER. Good Bye\n\n";

//     int size=4;  
//     int numTrys=3;  
//     int code[] = {6,6,1,5};
//     int guess[] = {6,2,1,4};
 

//     // Get user's guess
//     printf(outInstruct);
    
//     // User has 10 attempts to guess the correct code
//     int i=0;
//     for(int i=1;i<=numTrys;i++){

//         //Output number of attempts to guess code
//         printf(outTry,i);

//         // Set user's guess in an array
//         setGuess(guess,size);
        

//         // Check user's guess to the code
//         int isPassword = checkPassword(code,guess,size);

//         if(isPassword==1){
//             printf(outRight);
//             i=numTrys;  // if correct, then stop user from guessing
//         }else {
//             printArr(guess,size);
//             printf(outWrong);
            
//         }
//     }

    // // Output code and guess 

    // printf("\n\nResults:\n");
    // printf(outCode);
    // printArr(code,size);

    // printf(outGuess);
    // printArr(guess,size);
    // printf(endl);

// end:
//     printf(outTy);
//     return 0;
// }