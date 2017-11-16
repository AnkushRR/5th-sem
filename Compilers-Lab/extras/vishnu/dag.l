digit [0-9]
%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
float c;

%}
%%
{digit}+([.]{digit}+)?  {
			            	c = atof(yytext);
			            	//printf("-->%f\n",c);
					    	yylval.b=c;
			            	return(DIGIT);
			         	}
[a-z]+					{
			            	yylval.val=(char *)malloc(sizeof(char));
			            	snprintf(yylval.val,strlen(yytext)+1,"%s",yytext);
			            	return(LETTER);
			         	}

[^0-9\b]    {
                c = yytext[0];
                return(c);
             }
%%
