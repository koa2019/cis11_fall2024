# cis11_fall2024 final project 1: Master Mind
Hardware: Raspberry pi
Languages: Assembly, C Language
gitHub Repo: https://github.com/koa2019/cis11_fall2024/tree/master/final

Instructions to run program:
1. On your Raspberry pi, download df_cis11_final.zip to your "Downloads" Folder.
2. Open a new "File Explorer " window, then
    * Open "Downloads" folder by double click its icon
    * Right click the "df_cis11_final.zip" and select "Extract All" files. 
2. Open a new Terminal window and change directories into the "df_cis11_final" folder 
   by typing: NOTE: Don't type the quotation marks. Only type the words in between them.
    * "cd Downloads" enter 
    * "cd df_cis11_final" enter
    3. To compile and build the game. In the terminal window type:
        * "g++ final-8.s" enter
    4. To run the game. In the terminal window type:
        * "./a.out" 
    5. To play the game. In the terminal window:
        * Type your first digit and press enter.
        * Type your second digit and press enter.
        * Type your third digit and press enter.
        * Type your fourth digit and press enter.
        6. The game will check your guess.
        7. Then it will let you know which/if any of your numbers were correct by outputting your  
           results in the terminal window. 
        8. If your guess is correct, then a win message will be outputted. Else the game will let  
           you continue guessing up to 10 times before ending the game.
       


Object of the game:
Guess a secret four digit code within 10 guesses.

Project Instructions:

All submissions must have a readme document that explains how to run, compile, build, and play your project. These instructions need to be written for someone that has no experience in computer science. I also want a video for all projects of you playing the game if you are building a GPIO project show me the board as well as any console content.

Project 1:
    Master Mind - In this project, you will write an ARM32 assembly program to implement a simplified Mastermind game. The program will use arrays to store a predefined 4-digit secret code and the user’s guesses. You will need to implement functions such get input (to read user input using scanf), check guess (to compare the guess with the secret code), and print feedback (to display the number of exact and partial matches using printf). The game will loop up to 10 times, providing feedback after each guess and ending if the player guesses correctly or exhausts all attempts. mastermind game instructions.jpg

Submitting:

Zip the following all code, makefiles, external functions, readme document, and the video into a single zip file. Then submit on canvas. There is NO LATE SUBMISSIONS! 

