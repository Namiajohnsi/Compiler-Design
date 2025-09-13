%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);
int yyerror(char *s);
%}

/* Union to store int, float, or string values */
%union {
    int   ival;
    float fval;
    char* str;
}

/* Tokens with semantic types */
%token <ival> INT
%token <fval> FLOAT
%token <str>  ID

%type <fval> expr

%left '+' '-'
%left '*' '/'

%%
input:
      /* empty */
    | input expr '\n'   { printf("Result: %f\n", $2); }
    ;

expr: expr '+' expr   { $$ = $1 + $3; }
    | expr '-' expr   { $$ = $1 - $3; }
    | expr '*' expr   { $$ = $1 * $3; }
    | expr '/' expr   { 
                          if ($3 == 0) {
                              yyerror("Division by zero");
                              $$ = 0;
                          } else {
                              $$ = $1 / $3;
                          }
                      }
    | '(' expr ')'    { $$ = $2; }
    | INT             { $$ = (float)$1; }   /* promote int → float */
    | FLOAT           { $$ = $1; }
    ;
%%

int main() {
    printf("Enter expressions (Ctrl+Z to end):\n");
    yyparse();
    return 0;
}

int yyerror(char *s) {
    printf("Error: %s\n", s);
    return 0;
}
