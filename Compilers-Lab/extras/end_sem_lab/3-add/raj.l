%{
#include "y.tab.h"
#include<math.h>
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
%}

x [a-z][a-z]*

%%
{x} 	{	strcpy(yylval.variable , yytext);
		
              	return var;
	}

[\t' ' ]+ ;

\n|. {return yytext[0];};
%%


