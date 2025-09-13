%{
#include <stdio.h>
#include <string.h>

typedef struct {
    char name[50];
    char type[20];
    char kind[20];
    char scope[20];
    char value[50];
    int address;
} Symbol;

Symbol symTable[50];
int symCount = 0;
char lastType[20] = "";
int currAddress = 1000; // starting memory address

// Return size of a type
int getSize(char *type) {
    if (strcmp(type, "int") == 0) return 4;
    if (strcmp(type, "float") == 0) return 4;
    if (strcmp(type, "char") == 0) return 1;
    if (strcmp(type, "double") == 0) return 8;
    return 0; // default
}

// Add symbol only if not already present
void addSymbol(char *name, char *type, char *kind, char *scope, char *value) {
    for (int i = 0; i < symCount; i++) {
        if (strcmp(symTable[i].name, name) == 0)
            return; // already exists
    }
    strcpy(symTable[symCount].name, name);
    strcpy(symTable[symCount].type, type);
    strcpy(symTable[symCount].kind, kind);
    strcpy(symTable[symCount].scope, scope);
    strcpy(symTable[symCount].value, value);

    // assign memory address only for variables
    if (strcmp(kind, "variable") == 0) {
        symTable[symCount].address = currAddress;
        currAddress += getSize(type);
    } else {
        symTable[symCount].address = -1; // no memory
    }

    symCount++;
}
%}

IDENTIFIER    [a-zA-Z_][a-zA-Z0-9_]*
NUMBER        [0-9]+
TYPE          (int|float|char|double)
OPERATOR      (\+|\-|\*|\/|=|==|<=|>=|<|>)
COMMENT1      \/\/.*
COMMENT2      \/\*([^*]|\*+[^*/])*\*+\/

%%
{TYPE}        { 
                 printf("Type: %s\n", yytext); 
                 strcpy(lastType, yytext); 
                 addSymbol(yytext, "-", "keyword", "global", "-"); 
              }

{IDENTIFIER}  { 
                 printf("Identifier: %s\n", yytext); 
                 if (strlen(lastType) > 0) {
                     addSymbol(yytext, lastType, "variable", "global", "-");
                     strcpy(lastType, ""); 
                 } else {
                     addSymbol(yytext, "-", "variable", "global", "-");
                 }
              }

{NUMBER}      { 
                 printf("Number: %s\n", yytext); 
                 addSymbol(yytext, "-", "constant", "literal", yytext); 
              }

{OPERATOR}    { printf("Operator: %s\n", yytext); }
{COMMENT1}    { printf("Single-line Comment\n"); }
{COMMENT2}    { printf("Multi-line Comment\n"); }
[ \t\n]       ; // ignore spaces and newlines
.             ; // ignore any other character
%%

int main() {
    yylex();
    printf("\n%-10s %-10s %-10s %-10s %-10s %-10s\n", 
           "Name", "Type", "Kind", "Scope", "Value", "Address");
    printf("---------------------------------------------------------------------\n");
    for (int i = 0; i < symCount; i++) {
        printf("%-10s %-10s %-10s %-10s %-10s %-10d\n",
               symTable[i].name,
               symTable[i].type,
               symTable[i].kind,
               symTable[i].scope,
               symTable[i].value,
               symTable[i].address);
    }
    return 0;
}
int yywrap(){
return 1;
}