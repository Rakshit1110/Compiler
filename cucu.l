%{
#include <stdio.h>
#include <string.h>
#include <math.h>
#include<stdlib.h>
#include "cucu.tab.h"
FILE *outfile;
%}

%%
"char *"   {fprintf(outfile,"TYPE : char*\n"); return CHAR;}
"int" {fprintf(outfile,"TYPE : int\n"); return INT;}
"while" {fprintf(outfile,"WHILE : while\n"); return WHILE;}
"if"   {fprintf(outfile,"IF : if\n"); return IF;}
"else"  {fprintf(outfile,"ELSE : else\n"); return ELSE;}
"return" {fprintf(outfile, "RETURN : return\n"); return RETURN;}
";"  {fprintf(outfile,"SEMICOLON : ;\n"); return SEMICOLON;}
","  {fprintf(outfile,"COMMA : ,\n"); return COMMA;}
[a-zA-Z_][a-zA-Z0-9_]*  {fprintf(outfile,"ID : %s\n", yytext); yylval.str=strdup(yytext); return ID;}
(\"[a-zA-Z0-9]*\")  {fprintf(outfile, "TYPE : string\n"); yylval.str=strdup(yytext); return STRING;}
[0-9]+   {fprintf(outfile,"NUM : %d\n", yylval.num=atoi(yytext)); return NUM;}
\/\*([^(\*\/)]|\n)*\*\/         ;
"+"   {fprintf(outfile,"ADD : +\n"); return ADD;}
"*"   {fprintf(outfile,"MULTIPLY : *\n"); return MULTIPLY;}
"/"   {fprintf(outfile,"DIVIDE : /\n"); return DIVIDE;}
"-"   {fprintf(outfile,"SUB : +\n"); return SUB;}
[\(]   {fprintf(outfile,"LEFT_ROUND : (\n"); return LEFT_ROUND;}
[\)]   {fprintf(outfile,"RIGHT_ROUND : )\n"); return RIGHT_ROUND;}
[\{]   {fprintf(outfile,"LEFT_CURLY : {\n"); return LEFT_CURLY;}
[\}]   {fprintf(outfile,"RIGHT_CURLY : }\n"); return RIGHT_CURLY;}
[\[]   {fprintf(outfile,"LEFT_SQUARE : [\n"); return LEFT_SQUARE;}
[\]]   {fprintf(outfile,"RIGHT_SQUARE : ]\n"); return RIGHT_SQUARE;}
">"   {fprintf(outfile,"GREATER_THAN : >\n"); return GREATER_THAN;}
"<"   {fprintf(outfile,"LESS_THAN : <\n"); return LESS_THAN;}
"=="  {fprintf(outfile,"EQUAL : ==\n"); return EQUAL;}
"="   {fprintf(outfile,"ASSIGNMENT : =\n"); return ASSIGNMENT;}
"!="  {fprintf(outfile,"NOT_EQUAL : !=\n"); return NOT_EQUAL;}
"<="  {fprintf(outfile,"LESS_THAN_EQUAL : <=\n"); return LESS_THAN_EQUAL;}
">="  {fprintf(outfile,"GREATER_THAN_EQUAL : >=\n"); return GREATER_THAN_EQUAL;}
[ \t\n]+   ;
%%

int yywrap(){
    return 1;
}
