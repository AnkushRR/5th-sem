%{
#include "y.tab.h"
#include <stdio.h>
#include <math.h>
#define PI 3.141592
int i,j;
%}

%union
{
   float  integer;
   double doublevalue;	
}

%token <integer>NUMBER
%left '*''/'
%left '-''+'
%type <integer> E

%%

P : P E '\n' {printf("final result %2f\n" , $2);}
  |
  ;
E : E E '+'  {$$ =$1+$2;}
  | E E'-'  {$$ = $1 - $2;}
  | E E '*'  {$$ = $1 * $2;}
  | E E '/'  {$$ = $1 / $2; }
  | NUMBER   {$$ = $1;}
  ; 
%%

extern FILE*yyin;

int main()
{
	do{
		yyparse();
	}while(!feof(yyin));
}

yyerror(char*a)
{
	//fprintf(stderr,"parse error!!!");
        
	printf("parser error");
	return 0;
}

