%{
#include<stdio.h>

struct node {
char operand;
float value;
struct node *left;
struct node *right;
};

struct node* new_node(char a,float v,struct node* left,struct node* right)
{
struct node *tmp;
tmp=(struct node*)malloc(sizeof(struct node));
tmp->operand=a;
tmp->value=v;
tmp->left=left;
tmp->right=right;
return tmp; 
}

void preorder(struct node *a)
{
if (a != NULL)
{
if(a->operand=='f')
{
printf("%.2f(num)",a->value);
}
else
{
printf("%c",a->operand);
}
preorder(a->left);
preorder(a->right);
}
}

void inorder(struct node *a)
{
if (a != NULL)
{
inorder(a->left);
if(a->operand=='f')
{
printf("%.2f(num)",a->value);
}
else
{
printf("%c",a->operand);
}
inorder(a->right);
}
}

void postorder(struct node *a)
{
if (a != NULL)
{
postorder(a->left);
postorder(a->right);
if(a->operand=='f')
{
printf("%.2f(num)",a->value);
}
else
{
printf("%c",a->operand);
}
}
}

%}

%start list

%union { 
struct node *c ;
}


%token DIGIT LETTER

%left '+' '-'
%left '*' '/' 
%left UMI  /*supplies precedence for unary minus */


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
printf("Value : %.2f\n",$1.c->value);
printf("\nPre-order traversal : ");
preorder($1.c);
printf("\nIn-order traversal : ");
inorder($1.c);
printf("\nPost-order traversal : ");
postorder($1.c);
printf("\n\n");
}

;

expr:    
expr '*' expr
{
$$.c = new_node('*',$1.c->value*$3.c->value,$1.c,$3.c);
}
|
expr '/' expr
{
$$.c = new_node('/',$1.c->value/$3.c->value,$1.c,$3.c);
}
|
expr '+' expr
{
$$.c = new_node('+',$1.c->value+$3.c->value,$1.c,$3.c);
}
|
expr '-' expr
{
$$.c = new_node('-',$1.c->value-$3.c->value,$1.c,$3.c);
}
|
number
;

number:  DIGIT
{
$$.c = $1.c;
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
