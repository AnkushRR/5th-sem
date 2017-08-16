digit [0-9] 
letter [A-Za-z] 
%{ 
    int count; 
%} 

%% 
    /* match identifier */ 
exit         {return 0;}
{letter}({letter}|{digit})*  {count++; printf("indentifier ");} 
{digit}({digit})*   {printf("number ");}
%% 

int main(void) { 
    yylex(); 
    printf("number of identifiers = %d\n", count); 
    return 0; 
} 
