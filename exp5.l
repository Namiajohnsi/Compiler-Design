%{
#include "y.tab.h"
#include <stdlib.h>
#include <string.h>
%}

%%
[0-9]+\.[0-9]+        { yylval.fval = atof(yytext); return FLOAT; }   /* float constant */
[0-9]+                { yylval.ival = atoi(yytext); return INT; }     /* int constant */
[a-zA-Z][a-zA-Z0-9]*  { yylval.str = strdup(yytext); return ID; }     /* identifier */
[\+\-\*/]             { return yytext[0]; }
[()]                  { return yytext[0]; }
[ \t]                 { /* ignore spaces/tabs */ }
\n                    { return '\n'; }
.                     { return yytext[0]; }
%%

int yywrap() { return 1; }
