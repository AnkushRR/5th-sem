%{
#include<stdio.h>

int temp_num='A';
%}

%start list

%union { int a;}


%token DIGIT LETTER

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
stat:    
         LETTER '=' expr
         {
           printf("%c = %c\n",$1.a,$3.a);
         }

         ;

expr:    '(' expr ')'
         {
           $$.a = $2.a;
         }
         |
         expr '*' expr
         {
           printf("%c = %c * %c\n",temp_num,$1.a,$3.a);
           $$.a=temp_num++;
         }
         |
         expr '/' expr
         {
          printf("%c = %c / %c\n",temp_num,$1.a,$3.a);
          $$.a=temp_num++;
         }
         |
         expr '+' expr
         {
          printf("%c = %c + %c\n",temp_num,$1.a,$3.a);
          $$.a=temp_num++;
         }
         |
         expr '-' expr
         {
          printf("%c = %c - %c \n",temp_num,$1.a,$3.a);
          $$.a=temp_num++;
         }
         |
         LETTER
         {
           $$.a = $1.a;
         }
         ;

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
