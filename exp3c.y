%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);          
int yyerror(char *s);  
%}

%token IF ELSE WHILE FOR SWITCH CASE DEFAULT ID NUM RELOP

%start stmts
%%
stmts
    : ifstmt
    | whilestmt
    | forstmt
    | switchstmt
    | assign
    | ';'
    ;
assign
    : ID '=' NUM ';'
    | ID '=' ID ';'
    ;
ifstmt
    : IF '(' cond ')' stmts
    | IF '(' cond ')' stmts ELSE stmts
    ;

whilestmt
    : WHILE '(' cond ')' stmts
    ;

forstmt
    : FOR '(' assign ';' cond ';' assign ')' stmts
    ;

switchstmt
    : SWITCH '(' ID ')' '{' cases '}'
    ;

cases
    : CASE NUM ':' stmts cases
    | DEFAULT ':' stmts
    ;

cond
    : ID RELOP ID
    | ID RELOP NUM
    ;

assign
    : ID '=' NUM
    | ID '=' ID
    ;
%%

int main() {
    printf("Enter a control structure: ");
    yyparse();
    return 0;
}

int yyerror(char *s) {
    printf("Invalid Syntax\n");
    exit(0);
}
