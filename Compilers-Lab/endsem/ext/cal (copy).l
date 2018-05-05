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
yylval.a = c;
return(LETTER);
}
[^a-z0-9\b] {
c = yytext[0];
return(c);
}
%%
