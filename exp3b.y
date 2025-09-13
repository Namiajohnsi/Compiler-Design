%{
#include <stdio.h>
#include <stdlib.h>

// Forward declarations
int yylex(void);
void yyerror(const char *s);
%}

%token LETTER DIGIT

%%
variable: LETTER rest { printf("Valid Variable\n"); }
rest: LETTER rest
    | DIGIT rest
    | /* empty */
    ;
%%

int main() {
    printf("Enter a variable name: ");
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    printf("Invalid Variable\n");
    exit(0);
}