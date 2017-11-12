digit [0-9]
%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include "y.tab.h"
float c;

char *my_itoa(int num, char *str)
{
        if(str == NULL)
        {
                return NULL;
        }
        sprintf(str, "%d", num);
        return str;
}

struct node {
char type;
float value;
char string_arr[100];
struct node *left;
struct node *right;
};

struct node* create_node(char a,float v)
{
struct node *tmp;
tmp=(struct node*)malloc(sizeof(struct node));
tmp->type=a;
tmp->value=v;
tmp->left=NULL;
tmp->right=NULL;
my_itoa(v,tmp->string_arr);
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
