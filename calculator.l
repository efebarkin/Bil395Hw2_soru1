%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
void yyerror(char *s);
extern int line_num;
%}

%%
[0-9]+\.[0-9]+  { yylval.dval = atof(yytext); return NUMBER; }
[0-9]+          { yylval.dval = atof(yytext); return NUMBER; }
"+"             { return PLUS; }
"-"             { return MINUS; }
"*"             { return TIMES; }
"/"             { return DIVIDE; }
"^"             { return POWER; }
"**"            { return POWER; }  /* Alternative exponentiation syntax */
"("             { return LPAREN; }
")"             { return RPAREN; }
[\n]            { return EOL; }
[ \t]           { /* ignore whitespace */ }
.               { 
                  char msg[100];
                  snprintf(msg, sizeof(msg), "Unknown character: '%s'", yytext);
                  yyerror(msg);
                }
%%

int yywrap(void) {
    return 1;
}

