// g++ selectionSort.c && ./a.out

#include <stdio.h>
#include <cstdlib> // rand()
#include <ctime>   // time()


void selSort(int a[],int n){
    for(int i=0;i<n-1;i++){
        int indx=i;
        for(int j=i+1;j<n;j++){
            if(a[indx]>a[j]){
                indx=j;
            }
        }
        //swap1(a[i],a[indx]);
        int temp=a[i];
        a[i]=a[indx];
        a[indx]=temp;
    }
}

void swap1(int &a,int &b){ // &a and &b arederef array indicies
    int temp=a;
    a=b;
    b=temp;
}


void printArr( int arr[], int size ){
    printf("\n\n");
	for( int i = 0; i < size; i++ ){
		//printf( "arr[%d] = %d\n", i, arr[i] );
        printf("%d, ", arr[i]);
	}
    printf("\n\n");
	return;
}

int main(){
    int size=25;
	int numArr[size];

    //Set random number seed once here
    srand(static_cast<unsigned int>(time(0)));
    //int randNum = rand()%90+10;//2 digit numbers

    // Print un-initialized array to see logic ug
	// printArr( numArr, size);

    // Initialize array
	for( int i = 0; i < size; i++){
		//numArr[i] = j;
        numArr[i] = rand()%90+10;//2 digit numbers
	}

    // Print random array
	printArr( numArr, size);

    // Sort
    selSort(numArr,size);
    
    // Print sorted array
    printArr( numArr, size);

	return 0;
}