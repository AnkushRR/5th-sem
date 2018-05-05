%{
#include "y.tab.h"
#include<math.h>
%}

x [0-9]

%%
{x} {yylval.integer=atoi(yytext);
          return NUMBER;}

[\t' ' ]+ ;

\n|. {return yytext[0];};
%%


