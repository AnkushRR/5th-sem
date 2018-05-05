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
           if(__builtin_types_compatible_p(typeof($1),double)){
              if(__builtin_types_compatible_p(typeof($3),double)){
                printf("%c = %f * %f\n",temp_num,$1,$3);
              }else if(__builtin_types_compatible_p(typeof($3),int)){
                printf("%c = (float)%d\n",temp_num,$3);
                temp_num++;
                printf("%c = %f * %c\n",temp_num,$1,(temp_num-1));
              }
           }else if(__builtin_types_compatible_p(typeof($1),int) && $1.a<10){
              if(__builtin_types_compatible_p(typeof($3),int)){
                printf("%c = %d * %d\n",temp_num,$1,$3);
              }else if(__builtin_types_compatible_p(typeof($3),double)){
                printf("%c = (float)%d\n",temp_num,$1);
                temp_num++;
                printf("%c = %c * %f\n",temp_num,(temp_num-1),$3);
              }
           }else if($1.a>60){
              if(__builtin_types_compatible_p(typeof($3),int)){
                printf("%c = %c * %d\n",temp_num,$1,$3);
              }else if(__builtin_types_compatible_p(typeof($3),double)){
                printf("%c = (float)%d",temp_num,$3);
                temp_num++;
                printf("%c = %c * %c",temp_num,$1,(temp_num-1));
              }
           }
           $$.a=temp_num++;
         }
         |
         expr '+' TER
         {
          printf("%c = %d + %d\n",temp_num,$1,$3);
          $$.a=temp_num++;
         }
         |
         expr '-' TER
         {
          printf("%c = %d - %d \n",temp_num,$1,$3);
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
