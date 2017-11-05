digit [0-9]
%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
float c;

struct node {
char operand;
float value;
struct node *left;
struct node *right;
};

struct node* create_node(char a,float v)
{
struct node *tmp;
tmp=(struct node*)malloc(sizeof(struct node));
tmp->operand=a;
tmp->value=v;
tmp->left=NULL;
tmp->right=NULL;
return tmp;
}
%}
%%
" "       ;
{digit}+([.]{digit}+)?     {
            c = atof(yytext);
	    yylval.c=create_node('f',c);
            return(DIGIT);
          }
[^a-z0-9\b]    {
                 c = yytext[0];
                 return(c);
              }
%%
