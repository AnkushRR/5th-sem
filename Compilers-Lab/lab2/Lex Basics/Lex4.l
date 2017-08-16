digit [0-9]
letter [A-Za-z]
%{
    int count,digit,line_counter;
%}

%%
    /* match identifier */
<<EOF>> {return 0;}
{letter}({letter}|{digit})*  {count++;}
{digit}{digit}*[.]{digit}{digit}* {printf("float\n");digit++;}
{digit}{digit}* {printf("int\n");digit++;}
[+\-*^?/={}();\[\]] {printf("<%s> ",yytext);}
[\n\t' ']   {line_counter++;}
. {return 1;}
%%
int main(void) {
    yyin=fopen("input.txt", "r");
    if(yylex()==0){
    printf("number of identifiers = %d, numbers=%d and Line counters=%d \n", count, digit, line_counter);
    return 0;
  }else{
    printf("wrong character\n");
    return 0;
  }
}
