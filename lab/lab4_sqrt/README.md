# cis11_fall2024
ARM assembly, raspberry pi

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