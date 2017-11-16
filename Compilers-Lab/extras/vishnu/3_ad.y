%{
#include<stdio.h>
#include<stdlib.h>
#include <string.h>

int temp_count=1;
void yyerror(char *s);
int yylex();

void gen(char *buff,char *addr1,char *addr2,char op,char *addr3){
  //char buff[100];
  int len=strlen(addr1)+strlen(addr2)+strlen(addr3)+7;
  snprintf(buff,len,"%s = %s %c %s",addr1,addr2,op,addr3);
}

void gen_uminus(char *buff,char *addr1,char *addr2){
  int len=strlen(addr1)+strlen(addr2)+5;
  snprintf(buff,len,"%s = -%s",addr1,addr2);
}

void temp(char *buff){
  //char *t="";
  //struct tem t;
  //t.lex="";
  sprintf(buff,"t%d",temp_count++);
}

char *buff;
%}

%start list



%union { char *lex; 
         //char *addr;
         }


%token DIGIT ID

%left '+' '-'
%left '*' '/' 
%right UMINUS  

%%                             /* beginning of rules section */

list:                           /*empty */
         |list stat '\n'
         |list error '\n'       {yyerror("error in format");}
         ;
stat:    id '=' expr   {  //gen_assign($1.lex,'=',$3.lex);
                              int len=strlen($1.lex)+strlen($3.lex)+4;
                              snprintf(buff,len,"%s = %s",$1.lex,$3.lex);
                              printf("%s\n",buff);
                              //printf("%s,%s\n",$1.lex,$3.lex);
                              temp_count=1;
                            }
         ;

expr:    expr '*' expr    {
                            $$.lex=(char *)malloc(5*sizeof(char));
                            temp($$.lex);
                            gen(buff,$$.lex,$1.lex,'*',$3.lex);
                            printf("%s\n",buff);
                            //printf("%s,%s,%s\n",$$.lex,$1.lex,$3.lex); 
                          }

         |expr '/' expr    {
                            $$.lex=(char *)malloc(5*sizeof(char));
                            temp($$.lex);
                            gen(buff,$$.lex,$1.lex,'/',$3.lex);
                            printf("%s\n",buff);
                            //printf("%s,%s,%s\n",$$.lex,$1.lex,$3.lex); 
                           }

         |expr '+' expr    {
                            $$.lex=(char *)malloc(5*sizeof(char));
                            temp($$.lex);
                            gen(buff,$$.lex,$1.lex,'+',$3.lex);
                            printf("%s\n",buff);
                            //printf("%s,%s,%s\n",$$.lex,$1.lex,$3.lex); 
                           }

         |expr '-' expr    {
                            $$.lex=(char *)malloc(5*sizeof(char));
                            temp($$.lex);
                            gen(buff,$$.lex,$1.lex,'-',$3.lex);
                            printf("%s\n",buff);
                            //printf("%s,%s,%s\n",$$.lex,$1.lex,$3.lex); 
                           }

         |number          {$$.lex=(char *)malloc(5*sizeof(char));*($$.lex)=*($1.lex);}

         |'-' expr %prec UMINUS  { 
                                  $$.lex=(char *)malloc(5*sizeof(char));
                                  temp($$.lex);
                                  gen_uminus(buff,$$.lex,$2.lex);
                                  printf("%s\n",buff);      
                                 }
         ;

number:  DIGIT          {$$.lex=(char *)malloc(5*sizeof(char));*($$.lex) = *($1.lex); }

id: ID                   {$$.lex=(char *)malloc(5*sizeof(char));*($$.lex) = *($1.lex); }
%%

int main()
{
buff=(char *)malloc(20*sizeof(char));
//lex=(char *)malloc(5*sizeof(char));
//free(buff);
 return(yyparse());
}

void yyerror(char *s)
{
  fprintf(stderr, "%s\n",s);
}

int   yywrap()
{
  return(1);
}
