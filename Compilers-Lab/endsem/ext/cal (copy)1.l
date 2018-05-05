digit [0-9]
%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
int c;
%}
%%

" " {

}

[a-z] {
c = yytext[0];
yylval.n->a=c;
yylval.n->flag=0;
return(LTR);
}

{digit}[.]{digit} {
c = atof(yytext);
yylval.n->c=c;
yylval.n->flag=2;
return(FLT);
}

{digit} {
c = atoi(yytext);
yylval.n->b=c;
yylval.n->flag=1;
return(INTGR);
}

[^a-z0-9\b] {
c = yytext[0];
return(c);
}
%%
