%{
int cs;
int ec;
int year[8];
%}

%%
<<EOF>> {
return 0;
}

[C][S][-][2][0][1][0-7][-][0-9][0-9][0-9][0-9][\n] {
  printf("Correct : %s",yytext);
  cs++;
  switch(yytext[6]){
    case '0':
    year[0]++;
    break;
    case '1':
    year[1]++;
    break;
    case '2':
    year[2]++;
    break;
    case '3':
    year[3]++;
    break;
    case '4':
    year[4]++;
    break;
    case '5':
    year[5]++;
    break;
    case '6':
    year[6]++;
    break;
    case '7':
    year[7]++;
    break;
  }
}

[E][C][-][2][0][1][0-7][-][0-9][0-9][0-9][0-9][\n] {
  printf("Correct : %s",yytext);
  ec++;
  switch(yytext[6]){
    case '0':
    year[0]++;
    break;
    case '1':
    year[1]++;
    break;
    case '2':
    year[2]++;
    break;
    case '3':
    year[3]++;
    break;
    case '4':
    year[4]++;
    break;
    case '5':
    year[5]++;
    break;
    case '6':
    year[6]++;
    break;
    case '7':
    year[7]++;
    break;
  }
}

%%

int main(int argc, char *argv[]){
  if( argc == 2 ) {
     printf("\nThe argument supplied is %s\n\n", argv[1]);
  }
  else if( argc > 2 ) {
     printf("Too many arguments supplied.\n./a.out <filename>\n");
     return 0;
  }
  else {
     printf("One argument expected.\n./a.out <filename>\n");
     return 0;
  }
  cs=0;
  ec=0;
  for(int year_index=0;year_index<=8;year_index++){
    year[year_index]=0;
  }
  yyin=fopen(argv[1],"r");
  yylex();
  printf("\nThe number of students in CS department is %d\n",cs);
  printf("The number of students in EC department is %d\n",ec);
  for(int year_index=0;year_index<=7;year_index++){
    printf("The number of students in year %d is %d\n",year_index+2010,year[year_index]);
  }
  return 0;
}
