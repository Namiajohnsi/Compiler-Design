%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
int yyerror(char *s);
int result;   /* final value */
%}

%union {
    int val;
}

%token <val> NUM
%type  <val> expr
%start expr

%%
expr
    : expr '+' expr   { $$ = $1 + $3; result = $$; }
    | expr '-' expr   { $$ = $1 - $3; result = $$; }
    | expr '*' expr   { $$ = $1 * $3; result = $$; }
    | expr '/' expr   { $$ = $1 / $3; result = $$; }
    | '(' expr ')'    { $$ = $2; result = $$; }
    | NUM             { $$ = $1; result = $$; }
    ;
%%

int main() {
    printf("Enter expression: ");
    if (yyparse() == 0)
        printf("Result: %d\n", result);
    return 0;
}

int yyerror(char *s) {
    printf("Error: %s\n", s);
    return 0;
}
