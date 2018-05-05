digit [0-9]
%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
float c;
struct node{
  char str[100];
};
struct node* create(char *a)
{
struct node *tmp;
tmp=(struct node*)malloc(sizeof(struct node));
strcpy(tmp->str,a);
return tmp;
}
%}
%%
" " {

}
{digit}+[.]{digit}+     {
	        yylval.a=create(yytext);
            return(FLOAT);
          }
{digit}+     {
	        yylval.a=create(yytext);
            return(INTEGER);
          }
[a-z]     {
	        yylval.a=create(yytext);
            return(LETTER);
          }          
[^a-z0-9\b] {
c = yytext[0];
return(c);
}
%%
