#include <cstdio>

// compile & run in terminal: g++ scanf.cpp && ./a.out
// 09-16-24

int main(){

    int value;
    //Ask for input
    printf("Enter a number: ");

    //get number
    scanf("%d", &value);

    //output number
    printf("Your number is: %d\n", value);

    return 0;
}