#include <stdio.h>
#include <string.h>
struct CFG{
  char left_terminal;
  char right_terminals[100][100];
  int counter ;
} pro[100] ;
int f_c=0;
char first[100];

int pro_counter = 0 ;
void First(char a)
{
  int i,j;
  char c;
  for(i=0;i<pro_counter;i++)
  {
    if(pro[i].left_terminal == a)
    {
      for(j=0;j<=pro[i].counter;j++)
      {
        c=pro[i].right_terminals[j][0];
        if(c >= 'A' && c <= 'Z')
        {
          First(c);
        }
        else
        {
          first[f_c]=c;
          f_c++;
        }
      }
    }
  }
}

void Follow(char a)
{
}

int main()
{
  FILE *fp ;
  int c ;
  char d;
  int i=0;
  int j=0;
  int k=0;
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
        i++;
        j=0;
      }
      else if(d == '\n')
      {
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
  printf("Enter the Terminal");
  scanf("%c",&d);
  First(d);
  printf("First of the terminal %c is {%c",d,first[0]);
  for(i=1;i<f_c;i++)
  {
    printf(",%c",first[i]);
  }
  printf("}\n");
  return 0;
}
