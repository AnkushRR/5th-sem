%{
#include<stdio.h>
#include<stdlib.h>

struct node {
char self;
float value;
struct node *child[3];
};

struct node* new_node(char self,float value,struct node* c1,struct node* c2,struct node* c3)
{
struct node *tmp;
tmp=(struct node*)malloc(sizeof(struct node));
tmp->self=self;
tmp->value=value;
tmp->child[0]=c1;
tmp->child[1]=c2;
tmp->child[2]=c3;
return tmp; 
}

void inorder(struct node *a){
  if (a != NULL){
    inorder(a->child[0]);
    inorder(a->child[1]);
    
    if(a->self=='n')
    printf("num(%.2f), ",a->value);
    else if (a->self=='E')
    printf("%c, ",a->self);
    else if (a->self=='*'||a->self=='-'||a->self=='+'||a->self=='/')
    printf("%c, ",a->self);

    inorder(a->child[2]);
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

%%                             /* beginning of rules section */

list:                           /*empty */
         |list stat '\n'
         |list error '\n'       {yyerrok;}
         ;
stat:    expr   { 
                  printf("%.2f\n",$1.c->value);
                  printf("In-Order Traversal of parse-tree:\n");
                  inorder($1.c);
                  printf("\n\n");
                }
         ;

expr:    expr '*' expr    { $2.c = new_node('*',$1.c->value*$3.c->value,NULL,NULL,NULL);
                            $$.c = new_node('E',$2.c->value,$1.c,$2.c,$3.c);
                          }
         |expr '/' expr    { $2.c = new_node('/',$1.c->value/$3.c->value,NULL,NULL,NULL);
                            $$.c = new_node('E',$2.c->value,$1.c,$2.c,$3.c);
                            }
         |expr '+' expr    { $2.c = new_node('+',$1.c->value+$3.c->value,NULL,NULL,NULL);
                            $$.c = new_node('E',$2.c->value,$1.c,$2.c,$3.c);
                            }
         |expr '-' expr    { $2.c = new_node('-',$1.c->value-$3.c->value,NULL,NULL,NULL);
                            $$.c = new_node('E',$2.c->value,$1.c,$2.c,$3.c);
                            }
         |number          {$$.c = new_node('E',$1.c->value,$1.c,NULL,NULL);}
         ;

number:  DIGIT          {$1.c = new_node('n',$1.b,NULL,NULL,NULL); $$.c=$1.c;}
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
