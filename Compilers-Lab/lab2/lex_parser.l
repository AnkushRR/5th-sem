/*
* Author : SaiKumar Immadi
* Lexical Parser Program made using Lex for  Compilers Lab 2
* 5th Semester @ IIIT Guwahati
*/

/* You can use this code for free. Just don't plagiarize it for your lab assignments */

digit [0-9]
letter [A-Za-z]
%{

struct symbol_table{
int lexeme_index;
char lexeme_name[30];
char lexeme_type[15];
};
struct symbol_table s_table[50];
char output_stream[100][10];
int s_index;
int output_index;
%}

%%

<<EOF>> {
return 0;
}

if {
strcpy(output_stream[output_index],"<if>");
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

[+\-*/=^?(){}\[\];] {
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
return 1;
}
%%

int main(void){
s_index=0;
output_index=0;
s_table[s_index].lexeme_index=s_index+1;
strcpy(s_table[s_index].lexeme_name,"if");
strcpy(s_table[s_index].lexeme_type,"keyword");
s_index++;
yyin=fopen("lex_parser_input.txt","r");
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
