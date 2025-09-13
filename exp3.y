%{
#include <stdio.h>
#include <stdlib.h>
int yylex();                   // declare lexer
void yyerror(const char *s);   // declare error handler
%}

%token NUM

%%
expr: expr '+' expr   { printf("Valid Expression\n"); }
    | expr '-' expr   { printf("Valid Expression\n"); }
    | expr '*' expr   { printf("Valid Expression\n"); }
    | expr '/' expr   { printf("Valid Expression\n"); }
    | '(' expr ')'
    | NUM
    ;
%%

int main() {
    printf("Enter an arithmetic expression: ");
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    printf("Invalid Expression\n");
    exit(0);
}
