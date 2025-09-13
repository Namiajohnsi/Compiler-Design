%{
#include "y.tab.h"
%}

%%
"if"        { return IF; }
"else"      { return ELSE; }
"while"     { return WHILE; }
"for"       { return FOR; }
"switch"    { return SWITCH; }
"case"      { return CASE; }
"default"   { return DEFAULT; }

[a-zA-Z][a-zA-Z0-9]*   { return ID; }
[0-9]+                 { return NUM; }

"=="|"<="|">="|"!="|"<"|">"   { return RELOP; }

"="         { return '='; }
";"         { return ';'; }
":"         { return ':'; }
"{"         { return '{'; }
"}"         { return '}'; }
"("         { return '('; }
")"         { return ')'; }

[ \t\n]     ;    /* ignore whitespace */
.           { return yytext[0]; }  /* return any other single character */
%%

int yywrap() { return 1; }
