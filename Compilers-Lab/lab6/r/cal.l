digit [0-9]
%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
float c;
%}
%%
" " {

}
[a-z] {
c = yytext[0];
yylval.a = c - 'a';
return(LETTER);
}
{digit}+([.]{digit}+)? {
c = atof(yytext);
yylval.b=c;
return(DIGIT);
}
[^a-z0-9\b] {
c = yytext[0];
return(c);
}
%%
