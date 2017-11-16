%{
#include<stdio.h>
#include<stdlib.h>

struct node {
char node_point;
float value;
struct node *left;
struct node *right;
};

struct node* new_node(char node_point,float value,struct node* left,struct node* right)
{
struct node *tmp;
tmp=(struct node*)malloc(sizeof(struct node));
tmp->node_point=node_point;
tmp->value=value;
tmp->left=left;
tmp->right=right;
return tmp; 
}

void preorder(struct node *a){
    if (a != NULL){
      if(a->node_point=='n')
      printf("num(%.2f),",a->value);
      else
      printf("%c, ",a->node_point);

    preorder(a->left);
    preorder(a->right);
  }
}

void inorder(struct node *a){
  if (a != NULL){
    inorder(a->left);
    inorder(a->mid);
    
    if(a->node_point=='n')
    printf("num(%.2f),",a->value);
    else 
    printf("%c, ",a->node_point);

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
%right UMI  

%%                            

list:                         
         |list stat '\n'
         |list error '\n'       {yyerrok;}
         ;
stat:    expr   { 
                  printf("%.2f\n",$1.c->value);
                  printf("Pre-Order:\t");preorder($1.c);
                  printf("\n");
                  printf("In-Order:\t");inorder($1.c);
                  printf("\n\n");
                }
         ;

expr:    expr '*' expr    { 
                            $$.c = new_node('*',$1.c->value*$3.c->value,$1.c,$3.c);
                          }
         |expr '/' expr    { 
                            $$.c = new_node('/',$1.c->value/$3.c->value,$1.c,$3.c);
         |expr '+' expr    { 
                            $$.c = new_node('+',$1.c->value+$3.c->value,$1.c,$3.c);
                            }
         |expr '-' expr    { 
                            $$.c = new_node('-',$1.c->value-$3.c->value,$1.c,$3.c);
                            }
         |number          {
                            $$.c = new_node('n',$1.c->value,$1.c,NULL);
                          }
         ;

number:  DIGIT          {$1.c = new_node('n',$1.b,NULL,NULL); $$.c=$1.c;}
%%

int main()
{
 return(yyparse());
}

yyerror(s)
char *s;
{
  fprintf(stderr, "%s\n",s);
}

int yywrap()
{
  return(1);
}
