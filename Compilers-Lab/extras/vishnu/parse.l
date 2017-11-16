%{
#include<stdio.h>
#include "y.tab.h"
float c;
char *yylval;
%}

%%
" "			;
[a-z]		{
				c= yytext[0];
				yylval.a=c - 'a';
				return(LETTER);
			}

[0-9]+(.[0-9]+)?	{
				c= atof(yytext[0]);
				yylval.a=c;
				return(DIGIT);
			}

[^a-z0-9]	{
				c=yytext[0];
				return(c);
			}

%%

int yywrap(void){
	return 1;
}