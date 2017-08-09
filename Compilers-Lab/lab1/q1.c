/*
* Author : SaiKumar Immadi
* Lexical Parser Program
* 5th Semester Compilers Lab 1
*/

#include <stdio.h>
#include <string.h>
int main(void){
	struct symbol_table{
		int lexeme_index;
		char lexeme_name[30];
		char lexeme_type[15];
	};
	struct symbol_table s_table[30];
	char input_string[150];
	char output_string[150]="";
	printf("Please enter the string without spaces :\n");
	fgets(input_string,sizeof(input_string),stdin);
	// gets(input_string);
	char *front_pointer=input_string;
	char *back_pointer=input_string;
	char scanning_char;
	int token_no=0;//also lexeme_index and also index for struct array
	int state=0;
	int increment_no;
	char buff[30];
	int flag;
	int dont_add;
	while(*front_pointer!='\n'){
		state=1;
		increment_no=0;
		flag=0;
		dont_add=0;
		while(*back_pointer){
			scanning_char=*back_pointer;
			switch(state){
				case 1:
				if((scanning_char>='a' && scanning_char<='z') || (scanning_char>='A' && scanning_char<='Z')){
					state=2;
					increment_no++;
					*back_pointer++;
				}else if(scanning_char>='0' && scanning_char<'9'){
					state=4;
					increment_no++;
					*back_pointer++;
				}else{
					switch (scanning_char) {
						case '+':
						state=8;
						increment_no++;
						*back_pointer++;
						break;
						case '-':
						state=9;
						increment_no++;
						*back_pointer++;
						break;
						case '*':
						state=10;
						increment_no++;
						*back_pointer++;
						break;
						case '/':
						state=11;
						increment_no++;
						*back_pointer++;
						break;
						case '=':
						state=12;
						increment_no++;
						*back_pointer++;
						break;
						default:
						printf("Wrong Input Character\n");
						return 0;
					}//end of scanning character switch statement
				}//end of if else of state 1 case
				break;//case 1 break statement
				case 2:
				if((scanning_char>='a' && scanning_char<='z') || (scanning_char>='A' && scanning_char<='Z') || (scanning_char>='0' && scanning_char<'9') || scanning_char=='_'){
					state=2;
					increment_no++;
					*back_pointer++;
				}else{
					state=3;
				}//end of if else of state 2 case
				break;//case 2 break statement
				case 3:
				token_no++;
				memcpy(buff,&front_pointer[0],increment_no);
				buff[increment_no]='\0';
				for(int index=0;index<token_no;index++){
					if(strcmp(buff,s_table[index].lexeme_name)==0){
						dont_add=1;
						break;
					}
				}
				if(dont_add==0){
					s_table[token_no-1].lexeme_index=token_no;
					memcpy(s_table[token_no-1].lexeme_name,&front_pointer[0],increment_no);
					s_table[token_no-1].lexeme_name[increment_no] = '\0';
					strcpy(s_table[token_no-1].lexeme_type,"identifier");
				}else if(dont_add==1){
					token_no--;
				}
				snprintf(buff, sizeof buff,"<id,%d> ",token_no);
				strcat(output_string,buff);
				front_pointer=back_pointer;
				flag=1;
				break;//case 3 break statement
				case 4:
				if(scanning_char>='0' && scanning_char<'9'){
					state=4;
					increment_no++;
					*back_pointer++;
				}else if(scanning_char=='.'){
					state=5;
					increment_no++;
					*back_pointer++;
				}else{
					printf("Wrong Input Character\n");
					return 0;
				}//end of if else of state 4 case
				break;//case 4 break statement
				case 5:
				if(scanning_char>='0' && scanning_char<'9'){
					state=6;
					increment_no++;
					*back_pointer++;
				}else{
					printf("Wrong Input Character\n");
					return 0;
				}//end of if else of state 5 case
				break;//case 5 break statement
				case 6:
				if(scanning_char>='0' && scanning_char<'9'){
					state=6;
					increment_no++;
					*back_pointer++;
				}else{
					state=7;
				}//end of if else of state 5 case
				break;//case 6 break statement
				case 7:
				token_no++;
				memcpy(buff,&front_pointer[0],increment_no);
				buff[increment_no]='\0';
				for(int index=0;index<token_no;index++){
					if(strcmp(buff,s_table[index].lexeme_name)==0){
						dont_add=1;
						break;
					}
				}
				if(dont_add==0){
					s_table[token_no-1].lexeme_index=token_no;
					memcpy(s_table[token_no-1].lexeme_name,&front_pointer[0],increment_no);
					s_table[token_no-1].lexeme_name[increment_no] = '\0';
					strcpy(s_table[token_no-1].lexeme_type,"number");
				}else if(dont_add==1){
					token_no--;
				}
				snprintf(buff, sizeof buff,"<num,%d> ",token_no);
				strcat(output_string,buff);
				front_pointer=back_pointer;
				flag=1;
				break;//case 7 break statement
				case 8:
				snprintf(buff, sizeof buff,"<+> ");
				strcat(output_string,buff);
				front_pointer=back_pointer;
				flag=1;
				break;//case 8 break statement
				case 9:
				snprintf(buff, sizeof buff,"<-> ");
				strcat(output_string,buff);
				front_pointer=back_pointer;
				flag=1;
				break;//case 9 break statement
				case 10:
				snprintf(buff, sizeof buff,"<*> ");
				strcat(output_string,buff);
				front_pointer=back_pointer;
				flag=1;
				break;//case 10 break statement
				case 11:
				snprintf(buff, sizeof buff,"</> ");
				strcat(output_string,buff);
				front_pointer=back_pointer;
				flag=1;
				break;//case 11 break statement
				case 12:
				snprintf(buff, sizeof buff,"<=> ");
				strcat(output_string,buff);
				front_pointer=back_pointer;
				flag=1;
				break;//case 12 break statement
			}//end of state switch statement
			if(flag==1){
				break;//breaks the inner while loop
			}
		}//end of back poiner or inner while loop
	}//end of front poiter or outer loop
	printf("\nToken Stream :\n");
	printf("%s\n",output_string);
	printf("\nSymbol Table :\n");
	for(int index=0;index<token_no;index++){//token_no came from the above while loop
		printf("%d  %s  %s\n",s_table[index].lexeme_index,s_table[index].lexeme_name,s_table[index].lexeme_type);
	}
	printf("\n");
	return 0;
}
