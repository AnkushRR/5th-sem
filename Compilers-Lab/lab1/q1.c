#include <stdio.h>
int main(void){
	struct symbol_table{
	 	int lexeme_index;
	 	char lexeme_name[30];
	 	char lexeme_type[30];
	};
	struct symbol_table s_table[30];
	char input_string[150];
	char output_string[200];
	printf("Please enter your string\n");
	gets(input_string);
	char *front_pointer=input_string;
	char *back_pointer=input_string;
	while(*front_pointer)
		while(1){
			
		}
	}


}