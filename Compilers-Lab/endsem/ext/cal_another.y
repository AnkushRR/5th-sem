%{
#include<stdio.h>

int temp_num='A';
%}

%start list

%union {int a;int b;float c;}


%token LTR INTGR FLT

%left '+' '-'
%left '*'

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
         LTR '=' expr
         {
           printf("%c = %c\n",$1.a,$3.a);
         }

         ;

expr:    expr '*' TER
         {
           printf("%c = %d * %d\n",temp_num,$1.a,$3);
           $$.a=temp_num++;
         }
         |
         expr '+' TER
         {
          printf("%c = %d + %d\n",temp_num,$1.a,$3);
          $$.a=temp_num++;
         }
         |
         expr '-' TER
         {
          printf("%c = %d - %d \n",temp_num,$1.a,$3);
          $$.a=temp_num++;
         }
         |
         TER
         {
          $$.b=$1.b;
         }
         ;
TER:     LTR
         {
           $$.a = $1.a;
         }
         |
         INTGR
         {
           $$.b=$1.b;
         }
         |
         FLT
         {
           $$.c=$1.c;
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
