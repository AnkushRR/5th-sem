%{
#include<stdio.h>

int temp_num='A';
struct node{
  int flag;
  union{int a;int b;float c;}
};
%}

%union {struct node n}


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
           printf("%c = %c\n",$1.n->a,$3.n->a);
         }

         ;

expr:    expr '*' TER
         {
          if($1.n->flag==0 && $3.n->flag==1){
            printf("%c = %c * %d\n",temp_num,$1.n->a,$3.n->b);
            $$.n->a=temp_num++;
            $$.n->flag=0;
          }else if($1.n->flag==0 && $3.n->flag==2){
            printf("");
          }
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
          if($1.n->flag==0){
            $$.n->a=$1.n->a;
            $$.n->flag=0;
          }else if($1.n->flag==1){
            $$.n->b=$1.n->b;
            $$.n->flag=1;
          }else if($1.n->flag==2){
            $$.n->c=$1.n->c;
            $$.n->flag=2;
          }
         }
         ;
TER:     LTR
         {
           $$.n->a = $1.n->a;
           $$.n->flag=0;
         }
         |
         INTGR
         {
           $$.n->b=$1.n->b;
           $$.n->flag=1;
         }
         |
         FLT
         {
           $$.n->c=$1.n->c;
           $$.n->flag=2;
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
