// g++ randArr.c && ./a.out

#include <stdio.h>
#include <cstdlib> // rand()
#include <ctime>   // time()

void printArr( int arr[], int size ){

	for( int i = 0; i < size; i++ ){
		//printf( "arr[%d] = %d\n", i, arr[i] );
        printf("%d, ", arr[i]);
	}
    printf("\n");
}

int main(){
    int size=25;
	int numArr[size];

    //Set random number seed once here
    srand(static_cast<unsigned int>(time(0)));
    //int randNum = rand()%90+10;//2 digit numbers

    // Print un-initialized array
    printf("\n\nUn-Initializied Array:\n");
	printArr( numArr, size);

    // Initialize array
	for( int i = 0; i < size; i++){
		//numArr[i] = j;
        numArr[i] = rand()%90+10;//2 digit numbers
	}

    // Print random array
    printf("\n\nRandom Array:\n");
	printArr( numArr, size);
    printf("\n\n");
	return 0;
}