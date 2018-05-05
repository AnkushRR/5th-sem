digit [0-9]
%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
float c;
struct node{
  char str[100];
  char type;
};
struct node* create(char *a,char b)
{
struct node *tmp;
tmp=(struct node*)malloc(sizeof(struct node));
strcpy(tmp->str,a);
tmp->type=b;
return tmp;
}
%}
%%
" " {

}
{digit}+[.]{digit}+     {
	        yylval.a=create(yytext,'f');
            return(FLOAT);
          }
{digit}+     {
	        yylval.a=create(yytext,'i');
            return(INTEGER);
          }
[a-z]     {
	        yylval.a=create(yytext,'c');
            return(LETTER);
          }          
[^a-z0-9\b] {
c = yytext[0];
return(c);
}
%%
