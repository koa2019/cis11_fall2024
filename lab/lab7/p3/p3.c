#include <stdio.h>


void outputArr( int arr[], int size ){
	for( int i = 0; i < size; i++ ){
		// printf( "a[%d] = %d\n", i, arr[i] );
        printf( "%d, ",arr[i]);
	}
    printf("\n");
	return;
}

void outputRevArr( int arr[], int size ){
    for( int i = 0, j=size-1; i < size; i++, j-- ){
    printf( "revArr[%d] = %d\n", i, arr[i] );
    }
}


int main(){
    int size = 6;
	int userArr[] = {6, 5, 4, 3, 2, 1};
    int revArr[size]={0};

    printf("User Array:\n");
    outputArr(userArr, size);

    // Reverse array
    for(int i = 0, j=size-1; i < size; i++, j--){
        revArr[j]=userArr[i];
    }


    // Print reversed array
    printf("Reversed Array:\n");
    outputArr(revArr, size);
    //outputRevArr(revArr,size);

	return 0;
}