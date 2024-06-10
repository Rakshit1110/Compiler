%{
#include <stdio.h>
#include <string.h>
#include <math.h>
#include<stdlib.h>
int yylex();
void yyerror(char const *e);
extern FILE *yyin,*yyout,*outfile;
%}

%token INT CHAR WHILE IF ELSE RETURN COMMA ASSIGNMENT ADD SUB DIVIDE MULTIPLY SEMICOLON LEFT_CURLY RIGHT_CURLY LEFT_ROUND RIGHT_ROUND LEFT_SQUARE RIGHT_SQUARE GREATER_THAN LESS_THAN EQUAL LESS_THAN_EQUAL GREATER_THAN_EQUAL NOT_EQUAL
%union{
    int num;
    char *str;
}
%token <num> NUM
%token <str> ID
%token <str> STRING
// setting precidences and associativity of Operators
%left ADD SUB
%left MULTIPLY DIVIDE
%left LEFT_ROUND RIGHT_ROUND
%%
programs : program ;
program : var_declaration  {fprintf(yyout,"\n");}
    | function_declaration {fprintf(yyout,"\n");}
    | function_definition  {fprintf(yyout,"\n");}
    | program var_declaration  {fprintf(yyout,"\n");}
    | program function_declaration {fprintf(yyout,"\n");}
    | program function_definition {fprintf(yyout,"\n");}  ;
var_declaration : int identifier SEMICOLON  
    | int identifier ASSIGNMENT expr SEMICOLON  {fprintf(yyout,"ASSIGNMENT: =\n");}
    | char identifier SEMICOLON              
    | char identifier ASSIGNMENT string SEMICOLON  {fprintf(yyout,"ASSIGNMENT: =\n");} 
    | char identifier ASSIGNMENT identifier SEMICOLON  {fprintf(yyout,"ASSIGNMENT: =\n");} ;
function_declaration : int identifier LEFT_ROUND function_args RIGHT_ROUND SEMICOLON  {fprintf(yyout,"Function declared above\n\n");}
    | int identifier LEFT_ROUND RIGHT_ROUND SEMICOLON  {fprintf(yyout,"Function declared above\n\n");}
    | char identifier LEFT_ROUND function_args RIGHT_ROUND SEMICOLON  {fprintf(yyout,"Function declared above\n\n");}
    | char identifier LEFT_ROUND RIGHT_ROUND SEMICOLON    {fprintf(yyout,"Function declared above\n\n");} ;
function_definition : int identifier LEFT_ROUND function_args RIGHT_ROUND function_body  {fprintf(yyout,"Function Defined above\n\n");}
    | int identifier LEFT_ROUND RIGHT_ROUND function_body   {fprintf(yyout,"Function Defined above\n\n");}
    | char identifier LEFT_ROUND function_args RIGHT_ROUND function_body  {fprintf(yyout,"Function Defined above\n\n");}
    | char identifier LEFT_ROUND RIGHT_ROUND function_body  {fprintf(yyout,"Function Defined above\n\n");} ;
function_args : int identifier {fprintf(yyout,"Function Arguments Passed Above\n\n");}
    | int identifier COMMA function_args
    | char identifier  {fprintf(yyout,"Function Arguments Passed Above\n\n");}
    | char identifier COMMA function_args ;
int : INT {fprintf(yyout,"Datatype : int\n");} ;
char : CHAR {fprintf(yyout,"Datatype : char *\n");} ;
function_body : LEFT_CURLY stmt_list RIGHT_CURLY
    | stmt ;
stmt_list : stmt stmt_list 
    | stmt ;
stmt : ASSIGNMENT_stmt
    | function_call {fprintf(yyout,"Function call ends \n\n");}
    | return_ {fprintf(yyout,"Return statement \n\n");}
    | condition   {fprintf(yyout,"If Condition Ends \n\n");}
    | while_loop  {fprintf(yyout,"While Loop Ends \n\n");}
    | var_declaration ;
ASSIGNMENT_stmt : expr ASSIGNMENT bool SEMICOLON ;

return_ : RETURN SEMICOLON
    | RETURN expr SEMICOLON ;
function_call : identifier LEFT_ROUND RIGHT_ROUND SEMICOLON
    | identifier LEFT_ROUND call_args RIGHT_ROUND SEMICOLON ;
call_args : bool {fprintf(yyout,"Function called \n\n");}
    | bool COMMA call_args {fprintf(yyout,"Function calling continues \n\n");} ;
condition : IF LEFT_ROUND bool RIGHT_ROUND function_body
    | IF LEFT_ROUND bool RIGHT_ROUND function_body ELSE function_body ;

while_loop : WHILE LEFT_ROUND bool RIGHT_ROUND function_body ;
bool : bool LESS_THAN bool   {fprintf(yyout,"Operator : < \n");}
    | bool GREATER_THAN bool {fprintf(yyout,"Operator : > \n");}
    | bool EQUAL bool  {fprintf(yyout,"Operator : == \n");}
    | bool NOT_EQUAL bool {fprintf(yyout,"Operator : != \n");}
    | bool LESS_THAN_EQUAL bool {fprintf(yyout,"Operator : <= \n");}
    | bool GREATER_THAN_EQUAL bool {fprintf(yyout,"Operator : >= \n");}
    | expr ;
identifier : ID      {fprintf(yyout,"Variable : %s \n", $1);} ;
number : NUM    {fprintf(yyout,"Value : %d \n", $1);} ;
string : STRING {fprintf(yyout,"Value : %s \n", $1);} ;
expr : LEFT_ROUND expr RIGHT_ROUND
    | expr ADD expr  {fprintf(yyout,"Operator : + \n");}
    | expr SUB expr  {fprintf(yyout,"Operator : - \n");}
    | expr MULTIPLY expr  {fprintf(yyout,"Operator : * \n");}
    | expr DIVIDE expr   {fprintf(yyout,"Operator : / \n");}
    | arr  {fprintf(yyout,"Array \n");}
    | number                    
    | identifier ;
arr : identifier LEFT_SQUARE expr RIGHT_SQUARE ;
%%

int main()
{
    yyin=fopen("inputFile.cu","r"); // can change name of input file here
    yyout=fopen("parser.txt","w");
    outfile=fopen("lexer.txt","w");
    yyparse();
    return 0;
}
void yyerror(char const *e){
    printf("Syntax Error\n");
}
