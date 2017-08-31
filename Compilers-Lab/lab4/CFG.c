#include <stdio.h>
#include <string.h>
struct CFG{
char left_terminal;
char right_terminals[100][100];
} pro[100] ;
int pro_counter = 0 ; 
int main()
{
FILE *fp ;
int c ;
int i=0;
int j=0; 
int k=0;
fp=fopen ("input.txt","r");
if(fp==NULL)
{
printf("cannot open Files");
return 1 ;
}
c = fgetc(fp); 
while(!feof(fp) )
	{
         pro[pro_counter].left_terminal = (char) c ;
         printf("%c",pro[pro_counter].left_terminal);
         c = fgetc(fp);
         c = fgetc(fp);
         c = fgetc(fp);
         i=0;
       	 while ( (char)c != '\n' )
	  	{
                 j=0;
                 while ( (char) c != '|' )
	  	  	{
                         pro[pro_counter].right_terminals[i][j]=(char) c;
                         c = fgetc(fp);
		         j++;
		        }
                 pro[pro_counter].right_terminals[i][j]='\0';
                 i++;
                 }
	  pro_counter++;
 	 }
i=0;
j=0;	  
for(i=0;i<pro_counter;i++)
{
printf("%c->",pro[i].left_terminal);
for(j=0;pro[pro_counter].right_terminals[i][j]!= '\0';j++)
{
printf("%c",pro[pro_counter].right_terminals[i][j]);
}
printf("\n");
}
return 0;
}
