digit [0-9]
%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
%}

%%
" "       ;
{digit}+([.]{digit}+)?  {
			            	*(yylval.lex) = *(yytext);
			            	//printf("%s %s",yytext,c);
			            	return(DIGIT);
			         	}

[a-z]		{
            	yylval.lex = yytext;
            	//printf("%s %s",yytext,c);
            	return(ID);
         	}

[^0-9\b]    {
                return(yytext[0]);
             }
%%