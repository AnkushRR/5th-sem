digit [0-9]
%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
float c;
%}
%%
" "       ;
{digit}+([.]{digit}+)?  {
			            	c = atof(yytext);
					    	yylval.b=c;
			            	return(DIGIT);
			         	}

[^0-9\b]    {
                c = yytext[0];
                return(c);
             }
%%