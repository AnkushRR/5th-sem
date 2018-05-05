%{
#include "y.tab.h"
#include <stdio.h>
#include <math.h>
#include<string.h>
#include<stdlib.h>
#define PI 3.141592

int result;
int increment =-1;
int RETURN;

int incrementFn()
{
	increment = increment +1;
	return increment;
}


char yy;

%}

%union
{
   
   char variable[300];
   int integer;
   
}


%token <variable>var
%left '+''-'
%left '*''/'
%left '('')'
%type <variable> E

%%

P : P var '='E '\n' { printf("ST %s,%s " , $4, $2);}
  |
  ;
E : E '+' E {   strcpy($$ , $1);
		printf("ADD %s, %s\n",$1, $3); 
	    }
  | E '-' E {  strcpy($$ , $1);
		printf("SUB %s, %s \n",  $1, $3); 
	     }
  | E '*' E {   strcpy($$ , $1);
		printf("MUL %s, %s \n",  $1, $3);  
	     }
  | E '/' E {   strcpy($$ , $1);
		printf("DIV %s, %s \n",  $1, $3);     
	     }

  | var        {  
		   char rec[10]; 	
		int res = incrementFn();
		char str[10];
                sprintf(str, "%d", res);
		rec[0] = 'R' ; rec[1] =str[0]; rec[2] = '\0';
		strcpy($$ , rec);
		printf("MOV R%d , %s\n" , res, $1);	
		}
  ; 
%%

extern FILE*yyin;

int main()
{
//yyin=fopen("input.txt","r");
	//do{
		yyparse();
	//}while(!feof(yyin));
}

yyerror(char*a)
{
	
        
	printf("parser error");
	return 0;
}

