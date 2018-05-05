%{
#include<stdio.h>
#include<string.h>
int temp_num='A';
struct node{
  char str[100];
};

struct node* creat(char a)
{
struct node *tmp;
tmp=(struct node*)malloc(sizeof(struct node));
tmp->str[0]=a;
return tmp;
}
%}

%start list

%union { struct node *a; 
         }


%token INTEGER FLOAT LETTER

%left TT
%left TYPE  
%left KK
%left LL 
%left YY
%left JJ
%right '+' '-'
%right '*' '/'
 
/*supplies precedence integer */

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
           printf("%s = %s\n\n",$1.a->str,$3.a->str);
         }

         ;

expr:    
         expr '*' ter %prec YY
         {
           printf("%c=%s*%s\n",temp_num,$1.a->str,$3.a->str);
           $$.a=creat(temp_num++);
         }
         |
         expr '/' ter %prec JJ
         {
          printf("%c=%s/%s\n",temp_num,$1.a->str,$3.a->str);
          $$.a=creat(temp_num++);
         }
         |
         expr '+' ter %prec KK
         {
          printf("%c=%s+%s\n",temp_num,$1.a->str,$3.a->str);
          $$.a=creat(temp_num++);
         }
         |
         expr '-' ter %prec LL
         {
          printf("%c=%s-%s\n",temp_num,$1.a->str,$3.a->str);
          $$.a=creat(temp_num++);
         }
         |
	       ter %prec TT
         {
           $$.a=$1.a;
         }

ter:
        expr %prec TYPE
          {
            printf("%c=(float)%s\n",temp_num,$1.a->str);
            $$.a=creat(temp_num++);
          }
        |
         INTEGER
          {
            $$.a=$1.a ;
          }
        |
         FLOAT
          {
            $$.a=$1.a ;
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
