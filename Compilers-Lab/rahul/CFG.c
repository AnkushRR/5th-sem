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
int temp[100];

int pro_counter = 0 ;
void First(char a)
{
  int i,j,l,r,q;
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
          if(temp[r]==0)
          {
            temp[r]=1;
            First(c);

          }
        }
        else
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
  int i,j,k,l,r;
  char c;
  r=0;
  for(i=0;i<pro_counter;i++)
  {
    for(k=0;k<=pro[i].counter;k++)
    {
      for(j=0;pro[i].right_terminals[k][j] != '\0';j++)
      {
        if(pro[i].right_terminals[k][j] == a)
        {
          c=pro[i].right_terminals[k][j+1];
          if (c=='\0')
          {
            c=pro[i].left_terminal;
            for(l=0;l<pro_counter;l++)
            {
              if(pro[l].left_terminal == c)
              {
                if(temp[l] == 0)
                {
                  temp[l] = 1;
                  Follow(c);
                }

              }
            }
          }
          else if ( c >= 'A' && c <= 'Z')
          {
            f_c=0;
            First(c);
            strcat(follow,first);
            fo_c=fo_c+strlen(first);
            f_c=0;
          }
          else
          {
            for(l=0;l<fo_c;l++)
            {
              if(follow[l]==c)
              {
                r=1;
              }
            }
            if (r==0)
            {
              follow[fo_c]=c;
              fo_c++;
            }
            r=0;
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
  for(i=0;i<100;i++)
  {
    temp[i]==0;
  }
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
  for(i=0;i<100;i++)
  {
    temp[i]=0;
  }
  Follow(d);
  printf("Follow of the terminal %c is {%c",d,follow[0]);
  for(i=1;i<fo_c;i++)
  {
    printf(",%c",follow[i]);
  }
  printf("}\n");
  return 0;
}
