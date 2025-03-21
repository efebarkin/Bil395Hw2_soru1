%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
void yyerror(char *s);
int yylex(void);

/* For better error reporting */
int line_num = 1;
%}

%union {
    double dval;
}

%token <dval> NUMBER
%token PLUS MINUS TIMES DIVIDE POWER LPAREN RPAREN
%token EOL

%left PLUS MINUS
%left TIMES DIVIDE
%right POWER
%nonassoc UMINUS

%type <dval> expr

%%

program:
    /* empty */
    | program line
    ;

line:
    EOL             { line_num++; }
    | expr EOL      { printf("Result: %.6g\n", $1); line_num++; }
    | error EOL     { yyerrok; line_num++; }
    ;

expr:
    expr PLUS expr      { $$ = $1 + $3; }
    | expr MINUS expr   { $$ = $1 - $3; }
    | expr TIMES expr   { $$ = $1 * $3; }
    | expr DIVIDE expr  { 
                          if ($3 == 0.0) {
                              yyerror("Division by zero");
                              $$ = 0.0;
                          } else {
                              $$ = $1 / $3;
                          }
                        }
    | expr POWER expr   { $$ = pow($1, $3); }
    | LPAREN expr RPAREN { $$ = $2; }
    | MINUS expr %prec UMINUS { $$ = -$2; }
    | NUMBER           { $$ = $1; }
    ;

%%

void yyerror(char *s) {
    fprintf(stderr, "Error at line %d: %s\n", line_num, s);
}

int main(void) {
    printf("Enhanced Calculator with Floating-Point and Exponentiation\n");
    printf("Enter expressions, Ctrl+D to exit\n");
    yyparse();
    return 0;
}

