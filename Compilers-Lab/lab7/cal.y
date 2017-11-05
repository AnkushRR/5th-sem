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

struct node* new_op_node(char a)
{
struct node *tmp;
tmp=(struct node*)malloc(sizeof(struct node));
tmp->type=a;
tmp->left=NULL;
tmp->center=NULL;
tmp->right=NULL;
return tmp;
}

struct node* new_node(char a,float v,struct node* left,struct node* center,struct node* right)
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

void inorder(struct node *a)
{
if (a != NULL)
{
inorder(a->left);
inorder(a->center);
if(a->type=='f')
{
printf("%.2f ",a->value);
}
else
{
printf("%c ",a->type);
}
inorder(a->right);
}
}

void preorder(struct node *a)
{
if (a != NULL)
{
if(a->type=='f')
{
printf("%.2f ",a->value);
}
else
{
printf("%c ",a->type);
}
preorder(a->left);
preorder(a->center);
preorder(a->right);
}
}

%}

%start list

%union { struct node *c ;}


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
           printf("\nValue : %.2f\n",$1.c->value);
	   printf("\nIn-Order traversal of the parse-tree:\n");
	   inorder($1.c);
       printf("\nPre-Order traversal of the parse-tree:\n");
       preorder($1.c);
           printf("\n\n");
         }

         ;

expr:    
         expr '*' expr
         {
	   $$.c = new_node('E',$1.c->value*$3.c->value,$1.c,new_op_node('*'),$3.c);
         }
         |
         expr '/' expr
         {
	   $$.c = new_node('E',$1.c->value/$3.c->value,$1.c,new_op_node('/'),$3.c);
         }
         |
         expr '+' expr
         {
	   $$.c = new_node('E',$1.c->value+$3.c->value,$1.c,new_op_node('+'),$3.c);
         }
         |
         expr '-' expr
         {
	   $$.c = new_node('E',$1.c->value-$3.c->value,$1.c,new_op_node('-'),$3.c);
         }
         |
         number
         {
         $$.c = new_node('E',$1.c->value,NULL,$1.c,NULL);
         }

         ;

number:  DIGIT
         {
           $$.c = new_node('D',$1.c->value,NULL,$1.c,NULL);
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
