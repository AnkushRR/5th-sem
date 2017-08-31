#include <stdio.h>
#include <string.h>

struct Context_Free_Grammar{
	int counter ;
	char head;
	char body[100][100];
} cfg[100] ;
int production_counter = 0 ;//no of productions for the grammar is kept track using this variable

int main(){
	FILE *file_des ;
	int c ;
	char d;
	int i=0;
	int j=0;
	int k=0;
	file_des=fopen ("input.txt","r");
	if(file_des==NULL){
		printf("Unable to open the file input.txt");
		return 1 ;
	}
	while(!feof(file_des) ){
		fscanf(file_des,"%c",&d);//for left hand side of the production or head
		cfg[production_counter].head = d;
		fscanf(file_des,"%c",&d);//for ignoring ->
		fscanf(file_des,"%c",&d);//for ignoring ->
		i=0;
		j=0;
		while(1)//for right hand side of the production or body
		{
			fscanf(file_des,"%c",&d);
			if(d == '|'){//whenever the | is found it increments to a new row
				i++;
				j=0;
			}
			else if(d == '\n'){//when found new line character, the while starts over again for next production
				break;
			}
			else{
				cfg[production_counter].body[i][j] = d;
				j++;
			}
		}
		cfg[production_counter].counter=i;
		production_counter++;
	}
	production_counter=production_counter-1;
	i=0;
	j=0;
	k=0;

	fclose(file_des);//done reading file and the CFG is stored in cfg variable

	for(i=0;i<production_counter;i++){//printing the stored cfg
		printf("%c->",cfg[i].head);
		printf("%s",cfg[i].body[0]);
		for(k=1;k<=cfg[i].counter;k++){
			printf("|");
			printf("%s",cfg[i].body[k]);
		}
		printf("\n");
	}
	return 0;
}
