digit [0-9] 
letter [A-Za-z] 
%{ 
    int count,digit,line_counter; 
%} 

%% 
    /* match identifier */ 
exit         {return 0;}
{letter}({letter}|{digit})*  {count++;} 
{digit}({digit})*   {digit++;}
\n   {line_counter++;}
%% 

int main(void) { 
    yylex(); 
    printf("number of identifiers = %d, numbers=%d and Line counters=%d \n", count, digit, line_counter); 
    return 0; 
} 
