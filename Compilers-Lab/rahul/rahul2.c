#include <stdio.h>
#include <string.h>
struct CFG{
  char left_terminal;
  char right_terminals[100][100];
  int counter ;
} pro[100] ;
int f_c=0;
char first[100];
int fo_c=0;
char follow[100];
int temp_f[100];
int temp_n[100];//
int temp_fo[100];
int pro_counter = 0 ;


int Check_Nullable(char a)
{
  int i,j,l,r,q,n,k;
  char c,e;
  for(i=0;i<pro_counter;i++)
  {
	if(pro[i].left_terminal == a)
	{
  	for(k=0;k<=(pro[i].counter);k++)
  	{
    	n=1;
    	for(j=0;pro[i].right_terminals[k][j] != '\0';j++)
    	{
      	c=pro[i].right_terminals[k][j];
      	if(c == '0')
      	{
        	return 1;
      	}
      	else if ( c>= 'A' && c <= 'Z')
      	{
        	for(l=0;l<pro_counter;l++)
        	{
          	if(pro[l].left_terminal == c)
          	{
            	r=l;
          	}
        	}
        	if(temp_n[r]==0)
        	{
          	temp_n[r]=1;
          	q = Check_Nullable(c);
          	if ( q == 0 )
          	{
            	n=0;
            	break;
          	}
        	}}
        	else
        	{
          	n=0;
          	break;
        	}
      	}
      	if(n==1)
      	{
        	return 1;
      	}
    	}
  	}
	}
	return 0 ;
  }
  void First(char a)
  {
	int i,j,l,r,q,f;
	char c,e;
	for(i=0;i<pro_counter;i++)
	{
  	if(pro[i].left_terminal == a)
  	{
    	for(j=0;j<=(pro[i].counter);j++)
    	{
      	c=pro[i].right_terminals[j][0];
      	if(c >= 'A' && c <= 'Z')
      	{
        	for(l=0;l<pro_counter;l++)
        	{
          	if(pro[l].left_terminal == c)
          	{
            	r=l;
          	}
        	}
        	if(temp_f[r]==0)
        	{
          	temp_f[r]=1;
          	First(c);
          	f=0;
          	while(Check_Nullable(c)==1)//
          	{
            	c=pro[i].right_terminals[j][f+1];
            	f++;
            	if(c >= 'A' && c <= 'Z')
            	{
              	First(c);
            	}
            	else if(c=='\0')
            	{
              	break;
            	}
            	else if(c!='0')
            	{

              	l=0;
              	r=0;
              	for(l=0;l<f_c;l++)
              	{
                	if(first[l]==c)
                	{
                  	r=1;
                	}
              	}
              	if (r==0)
              	{
                	first[f_c]=c;
                	f_c++;
              	}
              	break;
            	}
          	}//
        	}
      	}
      	else if(c!='0')
      	{
        	l=0;
        	r=0;
        	for(l=0;l<f_c;l++)
        	{
          	if(first[l]==c)
          	{
            	r=1;
          	}
        	}
        	if (r==0)
        	{
          	first[f_c]=c;
          	f_c++;
        	}
      	}
    	}
  	}
	}
  }

  void Follow(char a)
  {
	int i,j,k,l,r,f;
	char c;
	for(i=0;i<pro_counter;i++)
	{
  	for(k=0;k<=pro[i].counter;k++)
  	{
    	for(j=0;pro[i].right_terminals[k][j] != '\0';j++)
    	{
      	if(pro[i].right_terminals[k][j] == a)
      	{
        	c=pro[i].right_terminals[k][j+1];
        	if (c == '\0')
        	{
          	c=pro[i].left_terminal;
          	for(l=0;l<pro_counter;l++)
          	{
            	if(pro[l].left_terminal == c)
            	{
              	if(temp_fo[l] == 0)
              	{
                	temp_fo[l] = 1;
                	Follow(c);
              	}

            	}
          	}
        	}
        	else if ( c >= 'A' && c <= 'Z')
        	{
          	f_c=0;
          	for(l=0;l<pro_counter;l++)
        	{
          	if(pro[l].left_terminal == c)
          	{
            	r=l;
          	}
        	}
        	if(temp_f[r]==0)
        	{
          	temp_f[r]=1;
          	First(c);
          	f=0;
          	while(Check_Nullable(c)==1)//
          	{
            	c=pro[i].right_terminals[k][j+1+f];
            	f++;
            	if(c >= 'A' && c <= 'Z')
            	{
              	First(c);
              	strcat(follow,first);
              	fo_c=fo_c+strlen(first);
              	f_c=0;
            	}
            	else if(c=='\0')
            	{
              	Follow(pro[i].left_terminal);
              	break;
            	}
            	else if(c!='0')
            	{
            	follow[fo_c]=c;
            	fo_c++;
             	break;
            	}
        	} }}
        	else if(c!='0')
        	{

            	follow[fo_c]=c;
            	fo_c++;
        	}
      	}
    	}
  	}
	}
  }

  int main()
  {
	FILE *fp ;
	int c ;
	char d;
	int i=0;
	int j=0;
	int k=0;
	int n=0;
	fp=fopen ("input.txt","r");
	if(fp==NULL)
	{
  	printf("cannot open Files");
  	return 1 ;
	}
	while(!feof(fp) )
	{
  	fscanf(fp,"%c",&d);
  	pro[pro_counter].left_terminal = d;
  	fscanf(fp,"%c",&d);
  	fscanf(fp,"%c",&d);
  	i=0;
  	j=0;
  	while(1)
  	{
    	fscanf(fp,"%c",&d);
    	if(d == '|')
    	{
      	pro[pro_counter].right_terminals[i][j] = '\0';
      	i++;
      	j=0;
    	}
    	else if(d == '\n')
    	{
      	pro[pro_counter].right_terminals[i][j] = '\0';
      	break;
    	}
    	else
    	{
      	pro[pro_counter].right_terminals[i][j] = d;
      	j++;
    	}
  	}
  	pro[pro_counter].counter=i;
  	pro_counter++;
	}
	pro_counter=pro_counter-1;
	i=0;
	j=0;
	k=0;
	fclose(fp);
	for(i=0;i<pro_counter;i++)
	{
  	printf("%c->",pro[i].left_terminal);
  	printf("%s",pro[i].right_terminals[0]);
  	for(k=1;k<=pro[i].counter;k++)
  	{
    	printf("|");
    	printf("%s",pro[i].right_terminals[k]);
  	}
  	printf("\n");
	}
	for(i=0;i<100;i++)
	{
  	temp_n[i]=0;
	}
	printf("Enter the Terminal");
	scanf("%c",&d);
	for(i=0;i<100;i++)
	{
  	temp_f[i]=0;
	}
	for(i=0;i<100;i++)
	{
  	temp_fo[i]=0;
	}

	First(d);
	printf("First of the terminal %c is {%c",d,first[0]);
	for(i=1;i<f_c;i++)
	{
  	printf(",%c",first[i]);
	}
	printf("}\n");
	for(i=0;i<100;i++)
	{
  	temp_f[i]=0;
	}
	for(i=0;i<100;i++)
	{
  	temp_fo[i]=0;
	}
	for(i=0;i<100;i++)
	{
  	temp_n[i]=0;
	}
	Follow(d);
	n=fo_c;
	for(i=0; i < n; i++)
	{
  	for(j=i+1; j < n; )
  	{
    	if(follow[j] == follow[i])
    	{
      	for(k=j; k < n;k++)
      	{
        	follow[k] = follow[k+1];
      	}
      	n--;
    	}
    	else {
      	j++;
    	}
  	}
	}
	fo_c=n;
	printf("Follow of the terminal %c is {%c",d,follow[0]);
	for(i=1;i<fo_c;i++)
	{
  	printf(",%c",follow[i]);
	}
	printf("}\n");
	return 0;
  }
