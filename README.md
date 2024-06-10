# Compiler
To run the code-> 
1. flex cucu.l
2. bison -d cucu.y
3. gcc lex.yy.c cucu.tab.c
4. ./a.out or ./a.exe 

NOTE -> In case you use lex and yacc compiler then in cucu.l #include "cucu.tab.h" needs to be changed to #include "y.tab.h" 
May be some more changes would be required for lex and yacc so please prefer using flex and bison compiler

Some sample files are provided named Sample1.cu and Sample2.cu in which there is non-error and error code respctively.
Whichever sample you want to test you can paste in inputFile.cu or change the input file name in the code at line 95 in cucu.y 

cucu.l :
This code parses the sample and returns tokens to the cucu.y file.

cucu.y :
This code contains the grammar for the cucu compiler and gives output "Syntax Error" if it encounters any error.

The lexer and parser file will contain the desired output as given in question
