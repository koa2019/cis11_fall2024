#include <stdio.h>

int main(){
    int r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10;

    int input;

    char *instructions = "Enter a non-negative number\n";
    char *inDec = "%d";
    char *inPrompt = "Enter a number: ";
    char *outAvg = "Your average is %d\n";
    char *outError = "Enter only positive numbers!\n";

    printf( instructions );

    printf( inPrompt );
    scanf( inDec, &input );

    r7 = input;

    printf( inPrompt );
    scanf( inDec, &input );

    r7 = r7 + input;

    printf( inPrompt );
    scanf( inDec, &input );

    r7 = r7 + input;

    printf( inPrompt );
    scanf( inDec, &input );

    r7 = r7 + input;

    printf( inPrompt );
    scanf( inDec, &input );

    r7 = r7 + input;

    r6 = 0x334; //bp -12 wd 12

    printf(inDec,r6);

    if( r7 == 0 ) goto error;

    r1 = r7 * r6;
    r1 = r1 >> 12; // right shift 12 places to make it account for multiplying by a decimal. 1/5=0.2
    
    printf( outAvg, r1 );

    goto end;

error:
    printf( outError );
    goto end;
end:
    return 0;
}