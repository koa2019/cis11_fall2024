# cis11_fall2024
ARM7 assembly, raspberry pi

To run program:

    * Download lab4_sqrt folder

    * Open terminal and move to this folder:
            cd lab4_sqrt

    * To compile in terminal type:
            make build && ./tri

    * Enter 2 sides of a right triangle as positive integers.

    * Program will out the user's 2 sides, their squared sums and the  
      hypotenuse of this right triangle.


1. Program asks user for 2 integer inputs(sideA, sideB), validates they're greater 
   or equal to 1 & outputs them.
2. Squares sideA, resets its variable with new value & adds it to sum.
3. Squares sideB, resets its variable with new value & adds it to sum.
4. Prints sum, sideA, sideB new values.
5. Calculates the hypotenuse by finding the integer square root of sum.
6. Output hypotenuse.


Lab 4 instructions:

Program that calculates the hypotenuse of a right triangle using Pythagorean's theorem.

    Prompt the user to enter two integers side A and side B of the right triangle.
    If A or B is less than or equal to zero the program should prompt the user of the error and end the program.
    Use the function "intSqrt" to do the square root.

You need to download the code template for this homework to work. Do not change the intSqrt.c or the tri.s file names. All code should be written in the tri.s.

How to compile:

Unlike your previous examples the code will not compile just using gcc like it did with other examples. To compile you will run this command

make build

it will compile the intSqrt.c into an object and then compile the tri.s and intSqrt.o together to make the program work. Then to run the program use the command

./tri

Important Notes:

    intSqrt wants a single parameter in r0, and will return the square root into r0
    Here is the equation to find the hypotenuse 