/*
* Author : SaiKumar Immadi
* Lexical Parser Program for Mini Java made using Lex for  Compilers Lab 3
* 5th Semester @ IIIT Guwahati
*/

/* You can use this code for free. Just don't plagiarize it for your lab assignments */

digit [0-9]
letter [A-Za-z]

%{

struct symbol_table{
int lexeme_index;
char lexeme_name[100];
char lexeme_type[15];
};
struct symbol_table s_table[200];
char output_stream[500][10];
int s_index;
int output_index;
%}

%%

<<EOF>> {
return 0;
}
[/][\*](.*['\n']?)*[\*][/] {}

[/][/].* {}

  if {
  strcpy(output_stream[output_index],"<if>");
  output_index++;
  }

  else {
  strcpy(output_stream[output_index],"<else>");
  output_index++;
  }

  main {
  strcpy(output_stream[output_index],"<main>");
  output_index++;
  }

length {
  strcpy(output_stream[output_index],"<length>");
  output_index++;
  }

  System {
  strcpy(output_stream[output_index],"<System>");
  output_index++;
  }

  out {
  strcpy(output_stream[output_index],"<out>");
  output_index++;
  }

  println {
  strcpy(output_stream[output_index],"<println>");
  output_index++;
  }

  assert {
  strcpy(output_stream[output_index],"<assert>");
  output_index++;
  }

  return {
  strcpy(output_stream[output_index],"<return>");
  output_index++;
  }

  void {
  strcpy(output_stream[output_index],"<void>");
  output_index++;
  }

  new {
  strcpy(output_stream[output_index],"<new>");
  output_index++;
  }

  this {
  strcpy(output_stream[output_index],"<this>");
  output_index++;
  }

  true {
  strcpy(output_stream[output_index],"<true>");
  output_index++;
  }

  false {
  strcpy(output_stream[output_index],"<false>");
  output_index++;
  }

  int {
  strcpy(output_stream[output_index],"<int>");
  output_index++;
  }

  boolean {
  strcpy(output_stream[output_index],"<boolean>");
  output_index++;
  }

  double {
  strcpy(output_stream[output_index],"<double>");
  output_index++;
  }

  class {
  strcpy(output_stream[output_index],"<public>");
  output_index++;
  }

  public {
  strcpy(output_stream[output_index],"<if>");
  output_index++;
  }

  static {
  strcpy(output_stream[output_index],"<static>");
  output_index++;
  }

  extends {
  strcpy(output_stream[output_index],"<extends>");
  output_index++;
  }

  private {
  strcpy(output_stream[output_index],"<private>");
  output_index++;
  }

  while {
  strcpy(output_stream[output_index],"<while>");
  output_index++;
  }

  char {
  strcpy(output_stream[output_index],"<char>");
  output_index++;
  }


({letter}|[_])({letter}|{digit}|[_])* {
int dont_add=0;
int index;
for(index=0;index<s_index;index++){
if(strcmp(s_table[index].lexeme_name,yytext)==0){
dont_add=1;
break;
}
}
if(dont_add==0){
s_table[s_index].lexeme_index=s_index+1;
strcpy(s_table[s_index].lexeme_name,yytext);
strcpy(s_table[s_index].lexeme_type,"identifier");
snprintf(output_stream[output_index],sizeof output_stream[output_index],"<id,%d>",s_table[s_index].lexeme_index);
s_index++;
output_index++;
}else if(dont_add==1){
snprintf(output_stream[output_index],sizeof output_stream[output_index],"<id,%d>",s_table[index].lexeme_index);
output_index++;
}
}

{digit}{digit}*[.]{digit}{digit}* {
/* float */
int dont_add=0;
int index;
for(index=0;index<s_index;index++){
if(strcmp(s_table[index].lexeme_name,yytext)==0){
dont_add=1;
break;
}
}
if(dont_add==0){
s_table[s_index].lexeme_index=s_index+1;
strcpy(s_table[s_index].lexeme_name,yytext);
strcpy(s_table[s_index].lexeme_type,"float");
snprintf(output_stream[output_index],sizeof output_stream[output_index],"<num,%d>",s_table[s_index].lexeme_index);
s_index++;
output_index++;
}else if(dont_add==1){
snprintf(output_stream[output_index],sizeof output_stream[output_index],"<num,%d>",s_table[index].lexeme_index);
output_index++;
}
}

{digit}{digit}* {
/* int */
int dont_add=0;
int index;
for(index=0;index<s_index;index++){
if(strcmp(s_table[index].lexeme_name,yytext)==0){
dont_add=1;
break;
}
}
if(dont_add==0){
s_table[s_index].lexeme_index=s_index+1;
strcpy(s_table[s_index].lexeme_name,yytext);
strcpy(s_table[s_index].lexeme_type,"integer");
snprintf(output_stream[output_index],sizeof output_stream[output_index],"<num,%d>",s_table[s_index].lexeme_index);
s_index++;
output_index++;
}else if(dont_add==1){
snprintf(output_stream[output_index],sizeof output_stream[output_index],"<num,%d>",s_table[index].lexeme_index);
output_index++;
}
}

[=][=] {
  /* relational operator */
  /* equals : EQ */
  strcpy(output_stream[output_index],"<RO,EQ>");
  output_index++;
}

[!][=] {
  /* relational operator */
  /* not equals : NE */
  strcpy(output_stream[output_index],"<RO,NE>");
  output_index++;
}

[<][=] {
  /* relational operator */
  /* less than or equals : LE */
  strcpy(output_stream[output_index],"<RO,LE>");
  output_index++;
}

[>][=] {
  /* relational operator */
  /* greater than or equals : GE */
  strcpy(output_stream[output_index],"<RO,GE>");
  output_index++;
}

[<] {
  /* relational operator */
  /* less than : LT */
  strcpy(output_stream[output_index],"<RO,LT>");
  output_index++;
}

[>] {
  /* relational operator */
  /* greater than : GT */
  strcpy(output_stream[output_index],"<RO,GT>");
  output_index++;
}

[+\-*/=^?(){}\[\];.] {
  /* All kinds of valid single characters */
  snprintf(output_stream[output_index],sizeof output_stream[output_index],"<%s>",yytext);
  output_index++;
}

[\n\t' '] {
/* ignore all next line and white space and tab characters */
}
. {
/* any character that did not match the above rules */
/* exits the program */
/* return 1; */
}
%%

int main(int argc, char *argv[]){
  if( argc == 2 ) {
     printf("The argument supplied is %s\n", argv[1]);
  }
  else if( argc > 2 ) {
     printf("Too many arguments supplied.\n./a.out <filename>\n");
     return 0;
  }
  else {
     printf("One argument expected.\n./a.out <filename>\n");
     return 0;
  }
s_index=0;
output_index=0;
s_table[s_index].lexeme_index=s_index+1;
strcpy(s_table[s_index].lexeme_name,"if");
strcpy(s_table[s_index].lexeme_type,"keyword");
s_index++;
s_table[s_index].lexeme_index=s_index+1;
strcpy(s_table[s_index].lexeme_name,"else");
strcpy(s_table[s_index].lexeme_type,"keyword");
s_index++;
s_table[s_index].lexeme_index=s_index+1;
strcpy(s_table[s_index].lexeme_name,"main");
strcpy(s_table[s_index].lexeme_type,"keyword");
s_index++;
s_table[s_index].lexeme_index=s_index+1;
strcpy(s_table[s_index].lexeme_name,"length");
strcpy(s_table[s_index].lexeme_type,"keyword");
s_index++;
s_table[s_index].lexeme_index=s_index+1;
strcpy(s_table[s_index].lexeme_name,"System");
strcpy(s_table[s_index].lexeme_type,"keyword");
s_index++;
s_table[s_index].lexeme_index=s_index+1;
strcpy(s_table[s_index].lexeme_name,"out");
strcpy(s_table[s_index].lexeme_type,"keyword");
s_index++;
s_table[s_index].lexeme_index=s_index+1;
strcpy(s_table[s_index].lexeme_name,"println");
strcpy(s_table[s_index].lexeme_type,"keyword");
s_index++;
s_table[s_index].lexeme_index=s_index+1;
strcpy(s_table[s_index].lexeme_name,"assert");
strcpy(s_table[s_index].lexeme_type,"keyword");
s_index++;
s_table[s_index].lexeme_index=s_index+1;
strcpy(s_table[s_index].lexeme_name,"return");
strcpy(s_table[s_index].lexeme_type,"keyword");
s_index++;
s_table[s_index].lexeme_index=s_index+1;
strcpy(s_table[s_index].lexeme_name,"void");
strcpy(s_table[s_index].lexeme_type,"keyword");
s_index++;
s_table[s_index].lexeme_index=s_index+1;
strcpy(s_table[s_index].lexeme_name,"new");
strcpy(s_table[s_index].lexeme_type,"keyword");
s_index++;
s_table[s_index].lexeme_index=s_index+1;
strcpy(s_table[s_index].lexeme_name,"this");
strcpy(s_table[s_index].lexeme_type,"keyword");
s_index++;
s_table[s_index].lexeme_index=s_index+1;
strcpy(s_table[s_index].lexeme_name,"true");
strcpy(s_table[s_index].lexeme_type,"keyword");
s_index++;
s_table[s_index].lexeme_index=s_index+1;
strcpy(s_table[s_index].lexeme_name,"false");
strcpy(s_table[s_index].lexeme_type,"keyword");
s_index++;
s_table[s_index].lexeme_index=s_index+1;
strcpy(s_table[s_index].lexeme_name,"int");
strcpy(s_table[s_index].lexeme_type,"keyword");
s_index++;
s_table[s_index].lexeme_index=s_index+1;
strcpy(s_table[s_index].lexeme_name,"boolean");
strcpy(s_table[s_index].lexeme_type,"keyword");
s_index++;
s_table[s_index].lexeme_index=s_index+1;
strcpy(s_table[s_index].lexeme_name,"double");
strcpy(s_table[s_index].lexeme_type,"keyword");
s_index++;
s_table[s_index].lexeme_index=s_index+1;
strcpy(s_table[s_index].lexeme_name,"class");
strcpy(s_table[s_index].lexeme_type,"keyword");
s_index++;
s_table[s_index].lexeme_index=s_index+1;
strcpy(s_table[s_index].lexeme_name,"public");
strcpy(s_table[s_index].lexeme_type,"keyword");
s_index++;
s_table[s_index].lexeme_index=s_index+1;
strcpy(s_table[s_index].lexeme_name,"static");
strcpy(s_table[s_index].lexeme_type,"keyword");
s_index++;
s_table[s_index].lexeme_index=s_index+1;
strcpy(s_table[s_index].lexeme_name,"extends");
strcpy(s_table[s_index].lexeme_type,"keyword");
s_index++;
s_table[s_index].lexeme_index=s_index+1;
strcpy(s_table[s_index].lexeme_name,"private");
strcpy(s_table[s_index].lexeme_type,"keyword");
s_index++;
s_table[s_index].lexeme_index=s_index+1;
strcpy(s_table[s_index].lexeme_name,"while");
strcpy(s_table[s_index].lexeme_type,"keyword");
s_index++;
s_table[s_index].lexeme_index=s_index+1;
strcpy(s_table[s_index].lexeme_name,"char");
strcpy(s_table[s_index].lexeme_type,"keyword");
s_index++;

yyin=fopen(argv[1],"r");
if(yylex()==0){
printf("\nToken Stream :\n");
for(int index=0;index<output_index;index++){
if(index==0){
  printf("%s",output_stream[index]);
  }else{
    printf(", %s",output_stream[index]);
  }
}
printf("\n\nSymbol Table :\n");
for(int index=0;index<s_index;index++){
  printf("%d %s %s\n",s_table[index].lexeme_index,s_table[index].lexeme_name,s_table[index].lexeme_type);
}
printf("\n");
return 0;
}else{
  printf("\nWrong input character\n\n");
  return 0;
}
}
