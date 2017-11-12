%{
#include<stdio.h>
#include<string.h>

float regs[26];
struct table_unit {
  char type;
  char string_arr[100];
  struct node* ptr;
};
struct table_unit table_arr[200];
int table_size=0;

struct node {
char type;
float value;
char string_arr[100];
struct node *left;
struct node *right;
};

struct node* check_in_table(struct node* given_node){
  int i=0;
  for(i=0;i<table_size;i++){
    if(strcmp(given_node->string_arr,table_arr[i].string_arr)==0){
      return table_arr[i].ptr;
    }    
  }
  strcpy(table_arr[i].string_arr,given_node->string_arr);
  table_arr[i].ptr=given_node;
  table_size++;
  return table_arr[i].ptr;
}

struct node* join_node(char a,float v,struct node* left,struct node* right){
struct node *tmp;
int i=0;
int j=0;
tmp=(struct node*)malloc(sizeof(struct node));
tmp->type=a;
tmp->value=v;
tmp->left=check_in_table(left);
tmp->right=check_in_table(right);
tmp->string_arr[i++]=a;
tmp->string_arr[i]=' ';
for(i=2;i<strlen(left->string_arr)+2;i++){
  tmp->string_arr[i]=left->string_arr[i-2];
}
tmp->string_arr[i++]=' ';
for(j=i;j<strlen(right->string_arr)+i;j++){
  tmp->string_arr[j]=right->string_arr[j-i];
}
tmp->string_arr[j]='\0';
return tmp; 
}

void preorder(struct node *a)
{
if (a != NULL)
{
if(a->type=='f')
{
printf("%.2f(%c)",a->value,a->type);
}
else
{
printf("%c",a->type);
}
preorder(a->left);
preorder(a->right);
}
}

void inorder(struct node *a)
{
if (a != NULL)
{
inorder(a->left);
if(a->type=='f')
{
printf("%.2f(%c)",a->value,a->type);
}
else
{
printf("%c",a->type);
}
inorder(a->right);
}
}

%}

%start list

%union { struct node *c ;}


%token DIGIT LETTER

%right '+' '-'
%right '*' '/' 
%right UMI  /*supplies precedence for unary minus */

%%                   /* beginning of rules section */

list:                       /*empty */
         |
       list stat '\n'
         |
       list error '\n'
         {
           yyerrok;
         }
         ;
stat:    expr
         {
           printf("%.2f\n",$1.c->value);
	   printf("PRE_ORDER\n");
	   preorder($1.c);
           printf("\n");
	   printf("IN_ORDER\n");
	   inorder($1.c);
           printf("\n\n");
    printf("The table has these entries\n");
    for(int i=0;i<table_size;i++){
      printf("%s\n",table_arr[i].string_arr);
    }
         }

         ;

expr:    
         expr '*' expr
         {
	   $$.c = join_node('*',$1.c->value*$3.c->value,$1.c,$3.c);
         }
         |
         expr '/' expr
         {
	   $$.c = join_node('/',$1.c->value/$3.c->value,$1.c,$3.c);
         }
         |
         expr '+' expr
         {
	   $$.c = join_node('+',$1.c->value+$3.c->value,$1.c,$3.c);
         }
         |
         expr '-' expr
         {
	   $$.c = join_node('-',$1.c->value-$3.c->value,$1.c,$3.c);
         }
         |
         number
         ;

number:  DIGIT
         {
           $$.c = $1.c;
         }        
%%
main()
{
 return(yyparse());
}



yyerror(s)
char *s;
{
  fprintf(stderr, "%s\n",s);
}

yywrap()
{
  return(1);
}
