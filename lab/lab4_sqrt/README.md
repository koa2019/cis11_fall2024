# cis11_fall2024
ARM assembly, raspberry pi

To run program:
    * Download lab4_sqrt folder

    * Open terminal and cd to this folder

    * To compile in terminal type:
            make build && ./tri

    * To print hypotenuse in terminal type: 
            echo $?

Logic bug: 
Can't figure out how to save or print r0 after bl intSqrt is called on line 145.

1. Program asks user for 2 integer inputs(sideA, sideB), validates they're greater 
   or equal to 1 & outputs them.
2. Squares sideA, resets its variable with new value & adds it to sum.
3. Squares sideB, resets its variable with new value & adds it to sum.
4. Prints sum, sideA, sideB new values.
5. Calculates square root of sum.
6. Must type echo $? in terminal to view the square root results.  

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