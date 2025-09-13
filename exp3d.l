%{
#include "y.tab.h"
%}

%%
[0-9]+      { yylval.val = atoi(yytext); return NUM; }
[ \t\n]     ;   /* ignore whitespace */
.           { return yytext[0]; }
%%

int yywrap() { return 1; }
