%{
#include<stdio.h>

float regs[26];

struct node {
char type;
float value;
struct node *left;
struct node *center;
struct node *right;
};
struct node *parent;

struct node* creat_node(char a)
{
struct node *tmp;
tmp=(struct node*)malloc(sizeof(struct node));
tmp->type=a;
tmp->left=NULL;
tmp->center=NULL;
tmp->right=NULL;
return tmp;
}

struct node* join_node(char a,float v,struct node* left,struct node* center,struct node* right)
{
struct node *tmp;
tmp=(struct node*)malloc(sizeof(struct node));
tmp->type=a;
tmp->value=v;
tmp->left=left;
tmp->center=center;
tmp->right=right;
return tmp; 
}

void preorder(struct node *a)
{
if (a != NULL)
{
if(a->type=='f')
{
printf("%.2f(%c)",a->value,a->type);
}
else
{
printf("%c",a->type,a->value);
}
preorder(a->left);
preorder(a->center);
preorder(a->right);
}
}

void inorder(struct node *a)
{
if (a != NULL)
{
inorder(a->left);
if(a->type=='f')
{
printf("%.2f(%c)",a->value,a->type);
}
else
{
printf("%c",a->type);
}
inorder(a->center);
inorder(a->right);
}
}

%}

%start list

%union { int a; 
         float b;
         struct node *c ;}


%token DIGIT LETTER

%right '+' '-'
%right '*' '/' 
%right UMI  /*supplies precedence for unary minus */

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
           printf("%.2f\n",$1.c->value);
	   printf("PRE_ORDER\n");
	   preorder($1.c);
           printf("\n");
	   printf("IN_ORDER\n");
	   inorder($1.c);
           printf("\n\n");
         }

         ;

expr:    
         expr '*' expr
         {
	   $$.c = join_node('E',$1.c->value*$3.c->value,$1.c,creat_node('*'),$3.c);
         }
         |
         expr '/' expr
         {
	   $$.c = join_node('E',$1.c->value/$3.c->value,$1.c,creat_node('/'),$3.c);
         }
         |
         expr '+' expr
         {
	   $$.c = join_node('E',$1.c->value+$3.c->value,$1.c,creat_node('+'),$3.c);
         }
         |
         expr '-' expr
         {
	   $$.c = join_node('E',$1.c->value-$3.c->value,$1.c,creat_node('-'),$3.c);
         }
         |
         number
         {
         $$.c = join_node('E',$1.c->value,NULL,$1.c,NULL);
         }

         ;

number:  DIGIT
         {
           $$.c = join_node('D',$1.c->value,NULL,$1.c,NULL);
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
