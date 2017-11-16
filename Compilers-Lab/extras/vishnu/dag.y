%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>

void yyerror(char *s);
int yylex();

char *buff;

struct node{
char type;
char *val;
int left;
int right;
}table[100];

int table_index=0;

int add(char type, char *val, int left, int right){
  int i;
  for(i=0;i<table_index;i++){
    //printf("before:%s",table[i].val);
    if(table[i].type==type){
      if(type=='n' && atof(table[i].val)==atof(val))
        return i;
      else if(type=='i' && strcmp(table[i].val,val)==0)
        return i;
      else if (type=='o' && table[i].left==left && table[i].right==right)
        return i;
    }
    //printf("after:%s",table[i].val);
  }
  table[table_index].type=type;
  table[table_index].val=(char *)malloc(5*sizeof(char));
  *(table[table_index].val)=*(val);
  table[table_index].left=left;
  table[table_index].right=right;
  table_index++;
  //printf("---%s---",table[i].val);
  return table_index-1;
}

void show(){
  int i;
  printf("\ntable:\n");
  for(i=0;i<table_index;i++){
    if(table[i].type=='n')
      printf("num: %s\n",table[i].val);
    else if (table[i].type=='o')
      printf("op: %s %d %d\n",table[i].val,table[i].left,table[i].right);
    else if (table[i].type=='i')
      printf("id: %s\n",table[i].val);
  }
}

%}

%start list

%union { char *val; 
         float b;
         int index;
         struct node *c ;}


%token DIGIT LETTER

%left '+' '-'
%left '*' '/' 
%right UMI  /*supplies precedence for unary minus */

%%                   
list:                       //empty
         |
         list stat '\n'   
         |
         list error '\n'  {yyerror("format: id = expr");}
         ;

stat:    id '=' expr
         {
            $$.index=add('o',"=",$1.index,$3.index);
            show();
            printf("\n");
            table_index=0;
         }
         ;

expr:    expr '+' ter         {$$.index=add('o',"+",$1.index,$3.index);}
         |
         expr '-' ter         {$$.index=add('o',"-",$1.index,$3.index);}
         |
         expr '/' ter         {$$.index=add('o',"/",$1.index,$3.index);}
         |
         expr '*' ter         {$$.index=add('o',"*",$1.index,$3.index);}
         |
         ter                  {$$.index=$1.index;}
ter:
         '(' expr ')'         {$$.index=$2.index;}
         |
         number               {$$.index=$1.index;}
         |
         id                   {$$.index=$1.index;}

id:     LETTER                {
                              $$.index=add('i',$1.val,-1,-1);
                              //printf("%s",$1.val);
                              }

number:  DIGIT                {
                              //$1.val=(char *)malloc(3*sizeof(char));
                              snprintf(buff,4,"%.2f",$1.b);
                              $$.index=add('n',buff,-1,-1);
                              //printf("> %d %f %s\n",$$.index,$1.b,buff);
                              }

%%
int main()
{
  buff=(char *)malloc(10*sizeof(char));

  return(yyparse());
}



void yyerror(char *s)
{
  fprintf(stderr, "%s\n",s);
}

int yywrap()
{
  return(1);
}
