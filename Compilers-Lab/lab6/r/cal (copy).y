%{
#include<stdio.h>

int regs[26];
int base;

%}

%start list

%union { int a; 
         float b; }


%token DIGIT LETTER

%left '|'
%left '&'
%left '+' '-'
%left '*' '/' '%'
%left UMINUS  /*supplies precedence for unary minus */

%%                   /* beginning of rules section */

list:                       /*empty */
         |
        list stat '\n'
         |
        list error '\n'
         {
           yyerrok;
         }
         ;
stat:    expr
         {
           printf("%f\n",$1.b);
         }
         |
         LETTER '=' expr
         {
           regs[$1.a] = $3.b;
         }

         ;

expr:    '(' expr ')'
         {
           $$.b = $2.b;
         }
         |
         expr '*' expr
         {
           $$.b = $1.b * $3.b;
         }
         |
         expr '/' expr
         {
           $$.b = $1.b / $3.b;
         }
         |
         expr '+' expr
         {
           $$.b = $1.b + $3.b;
         }
         |
         expr '-' expr
         {
           $$.b = $1.b - $3.b;
         }
         |

        '-' expr %prec UMINUS
         {
           $$.b = -$2.b;
         }
         |
         LETTER
         {
           $$.b = regs[$1.a];
         }

         |
         number
         ;

number:  DIGIT
         {
           $$.b = $1.b;
         }        
%%
main()
{
 return(yyparse());
}

yyerror(s)
char *s;
{
  fprintf(stderr, "%s\n",s);
}

yywrap()
{
  return(1);
}
