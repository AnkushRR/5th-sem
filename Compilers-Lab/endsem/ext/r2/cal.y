%{
#include<stdio.h>
#include<string.h>
int temp_num='A';
struct node{
  char str[100];
  char type;
};

struct node* creat(char a,char b)
{
struct node *tmp;
tmp=(struct node*)malloc(sizeof(struct node));
tmp->str[0]=a;
tmp->type=b;
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
%left '+' '-'
%left '*' '/'
 
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
           if($1.a->type=='f'&& $3.a->type=='i')
           {
           printf("%c=(float)%s\n",temp_num++,$3.a->str);
           printf("%c=%s*%s\n",temp_num,$1.a->str,$3.a->str);
           $$.a=creat(temp_num++,'f');
           }
           else if($1.a->type=='i'&& $3.a->type=='f')
           {
           printf("%c=(float)%s\n",temp_num++,$1.a->str);
           printf("%c=%s*%s\n",temp_num,$1.a->str,$3.a->str);
           $$.a=creat(temp_num++,'f');
           }
           else if($1.a->type=='i'&& $3.a->type=='i')
           {
           printf("%c=%s*%s\n",temp_num,$1.a->str,$3.a->str);
           $$.a=creat(temp_num++,'i');
           }
           else if($1.a->type=='f'&& $3.a->type=='f')
           {
           printf("%c=%s*%s\n",temp_num,$1.a->str,$3.a->str);
           $$.a=creat(temp_num++,'f');
           }

         }
         |
         expr '+' ter %prec KK
         {
            if($1.a->type=='f'&& $3.a->type=='i')
           {
           printf("%c=(float)%s\n",temp_num++,$3.a->str);
           printf("%c=%s+%s\n",temp_num,$1.a->str,$3.a->str);
           $$.a=creat(temp_num++,'f');
           }
           else if($1.a->type=='i'&& $3.a->type=='f')
           {
           printf("%c=(float)%s\n",temp_num++,$1.a->str);
           printf("%c=%s+%s\n",temp_num,$1.a->str,$3.a->str);
           $$.a=creat(temp_num++,'f');
           }
           else if($1.a->type=='i'&& $3.a->type=='i')
           {
           printf("%c=%s+%s\n",temp_num,$1.a->str,$3.a->str);
           $$.a=creat(temp_num++,'i');
           }
           else if($1.a->type=='f'&& $3.a->type=='f')
           {
           printf("%c=%s+%s\n",temp_num,$1.a->str,$3.a->str);
           $$.a=creat(temp_num++,'f');
           }
         }
         |
         expr '-' ter %prec LL
         {
           if($1.a->type=='f'&& $3.a->type=='i')
           {
           printf("%c=(float)%s\n",temp_num++,$3.a->str);
           printf("%c=%s-%s\n",temp_num,$1.a->str,$3.a->str);
           $$.a=creat(temp_num++,'f');
           }
           else if($1.a->type=='i'&& $3.a->type=='f')
           {
           printf("%c=(float)%s\n",temp_num++,$1.a->str);
           printf("%c=%s-%s\n",temp_num,$1.a->str,$3.a->str);
           $$.a=creat(temp_num++,'f');
           }
           else if($1.a->type=='i'&& $3.a->type=='i')
           {
           printf("%c=%s-%s\n",temp_num,$1.a->str,$3.a->str);
           $$.a=creat(temp_num++,'i');
           }
           else if($1.a->type=='f'&& $3.a->type=='f')
           {
           printf("%c=%s-%s\n",temp_num,$1.a->str,$3.a->str);
           $$.a=creat(temp_num++,'f');
           }
         }
         |
	       ter %prec TT
         {
           $$.a=$1.a;
         }

ter:
        expr %prec TYPE
          {
            $$.a=$1.a ;
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
