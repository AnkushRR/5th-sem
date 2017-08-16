digit [0-9] 
letter [A-Za-z] 
%{ 
    int count,digit,line_counter; 
%} 

%% 
    /* match identifier */ 
exit         {return 0;}
{letter}({letter}|{digit})*  {count++;
call_f();} 
{digit}({digit})*   {digit++;}
\n   {line_counter++;}
%% 
void call_f(void){
	printf("Calling from my ass %d",count);
}
int main(void) { 
    yyin=fopen("input.txt", "r");
    yylex(); 
    printf("number of identifiers = %d, numbers=%d and Line counters=%d \n", count, digit, line_counter); 
    return 0; 
} 
