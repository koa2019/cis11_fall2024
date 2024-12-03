// g++ selectionSort.c && ./a.out

#include <stdio.h>
#include <cstdlib> // rand()
#include <ctime>   // time()

// Selection Sort
// Start with the entire list as unsorted.
// Start traversing the list from the first element.
//  For each element:
//        Find the smallest element from the current position to the end of the list.
//        Swap it with the current element to place it in its correct position.
//  Move to the next element and repeat until all elements are sorted.
void selSort(int arr[],int size){
    int i;
    int minIndx;
    int right;


    // Start with the whole array as unsored.
    // one by one move boundary of unsorted subarray towards right
    for(i=0;i<size-1;i++){  // if(i<25-1)

        // Find the minimum element in unsorted array
        minIndx=i;
        int j;
        for(j=i+1;j<size;j++){         // if(adjacentRight<25). Compare arr[i] to all indices right of it
            if(arr[minIndx]>arr[j]){       // if(value of minIndx > value of adjacentRight)
                minIndx=j;             // then reset minIndx index to current adjRight index
            }
        }

        // Swap the found minimum element with 
        // current index in the unsorted part
        // swap(a[i],a[minIndx]);
        int temp=arr[i];
        arr[i]=arr[minIndx];
        arr[minIndx]=temp;
    }
}

void swap(int &a,int &b){ // &a and &b arederef array indicies
    int temp=a;
    a=b;
    b=temp;
}


void printArr( int arr[], int size ){

	for( int i = 0; i < size; i++ ){
		//printf( "arr[%d] = %d\n", i, arr[i] );
        printf("%d, ", arr[i]);
	}
    printf("\n");
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
    printf("\n\nRandom Array:\n");
	printArr( numArr, size);

    // Sort
    selSort(numArr,size);
    
    // Print sorted array
    printf("\nSorted Array:\n");
    printArr( numArr, size);
    printf("\n");
    
	return 0;
}