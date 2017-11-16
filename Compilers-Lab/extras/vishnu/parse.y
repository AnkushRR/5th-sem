%{
	#include<stdio.h>

	struct node {
	float value;
	struct node* left;
	struct node* mid;
	struct node* right;
	}

	struct node* join_node(struct node* r1,struct node* r2,struct node* r3,float v);

struct node* join_node(struct node* r1,struct node* r2,struct node* r3,float v)
{
struct node *tmp;
tmp=(struct node*)malloc(sizeof(struct node));
tmp->value=v;
tmp->left=r1;
tmp->mid=r2;
tmp->right=r3;
return tmp; 
}
	void inOrder(struct node* r)
{/%
    if(r!=NULL){
        inOrder(r->left);
        printf("%d ", r->value);
        inOrder(r->right);
    }%/
}

void preOrder(struct node* r)
{/%
    if(r!=NULL){
        printf("%d ", r->value);
        preOrder(r->left);
        preOrder(r->right);
    }%/
}
%}

%start program

%union {
		float a;
		nodeType *c;
	   };

%token DIGIT LETTER

%right '+' '-'
%right '*' '/' 
%right UMI

%%
program : 	
			|
			list stat '\n'
			|
			list error '\n'
			{
			yyerrok;
			}
			; 

stat 	:	expr
			{/%
			 
                  printf("%.2f\n",$1.c->value);
                  printf("Pre-Order:\t");preorder($1.c);
                  printf("\n");
                  printf("In-Order:\t");inorder($1.c);
                  printf("\n\n");%/
			}
			;


expr	:	expr '*' expr
			{
				$2.c=join_node(NULL,NULL,NULL,$1.c->value*$3.c->value);
			 $$.c = join_node($1.c,$2.c,$3.c,$2.c->value);
			}
			|
			expr '/' expr
			{
				$2.c=join_node(NULL,NULL,NULL,$1.c->value/$3.c->value);
			 $$.c = join_node($1.c,$2.c,$3.c,$2.c->value);
			}
			|
			expr '+' expr
			{
				$2.c=join_node(NULL,NULL,NULL,($1.c->value+$3.c->value));
			 $$.c = join_node($1.c,$2.c,$3.c,$2.c->value);
			}
			|expr '-' expr
			{
				$2.c=join_node(NULL,NULL,NULL,$1.c->value-$3.c->value);
			 $$.c = join_node($1.c,$2.c,$3.c,$2.c->value);
			}
			|
			number
			{
			 $$.c = join_node(NULL,NULL,NULL,$1.c->value);
			}
			;

number  :	DIGIT
			{
			 $$.c=join_node(NULL,NULL,NULL,$1.a);
			}
			

%%
main()
{
	return(yyparse());
}
int yywrap(void){
 	return 1;
 }