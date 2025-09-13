%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int yylex(void);
int yyerror(char *s);
%}

/* Declare the union type for semantic values */
%union {
    char* str;
}

/* Tokens use the <str> field of the union */
%token <str> ID NUM
%type <str> expr

%left '+' '-'
%left '*' '/'

%%
stmt: expr { printf("Result in %s\n", $1); }
;

expr: expr '+' expr {
          char* t = malloc(5);
          sprintf(t, "t%d", tempCount++);
          printf("%s = %s + %s\n", t, $1, $3);
          $$ = t;
      }
    | expr '-' expr {
          char* t = malloc(5);
          sprintf(t, "t%d", tempCount++);
          printf("%s = %s - %s\n", t, $1, $3);
          $$ = t;
      }
    | expr '*' expr {
          char* t = malloc(5);
          sprintf(t, "t%d", tempCount++);
          printf("%s = %s * %s\n", t, $1, $3);
          $$ = t;
      }
    | expr '/' expr {
          char* t = malloc(5);
          sprintf(t, "t%d", tempCount++);
          printf("%s = %s / %s\n", t, $1, $3);
          $$ = t;
      }
    | ID   { $$ = $1; }
    | NUM  { $$ = $1; }
;
%%
