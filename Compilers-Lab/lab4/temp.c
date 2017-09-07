/*
* Author : SaiKumar Immadi
* First and Follow Program for Context Free Grammar for  Compilers Lab 4
* 5th Semester @ IIIT Guwahati
*/

/* You can use this code for free. Just don't plagiarize it for your lab assignments */

#include <stdio.h>
#include <string.h>

struct Context_Free_Grammar{
  int counter ;
  char head;
  char body[100][100];
} pro[100] ;
int production_counter = 0 ;//no of productions for the grammar is kept track using this variable

char first_set[100];
int first_counter=0;//counter of the first set to keep track
char follow_set[100];
int follow_counter=0;//counter of the follow set to keep track
int temp_first[100];//set where corresponding heads have zeroes initialized. to remove segmentation fault
int temp_follow[100];//set where corresponding heads have zeroes initialized. to remove segmentation fault
int temp_nullable[100];//set where corresponding heads have zeroes initialized. to remove segmentation fault

int is_nullable(char a){
  int i,j,l,r,q,n,k;
  char c,e;
  for(i=0;i<production_counter;i++){
    if(pro[i].head == a){
      for(k=0;k<=(pro[i].counter);k++){
        n=1;
        for(j=0;pro[i].body[k][j] != '\0';j++){
          c=pro[i].body[k][j];
          if(c == '0'){
            return 1;
          }
          else if ( c>= 'A' && c <= 'Z'){
            for(l=0;l<production_counter;l++){
              if(pro[l].head == c){
                r=l;
              }
            }
            if(temp_nullable[r]==0){
              temp_nullable[r]=1;
              q = is_nullable(c);
              if ( q == 0 ){
                n=0;
                break;
              }
            }
          }
          else{
            n=0;
            break;
          }
        }
        if(n==1){
          return 1;
        }
      }
    }
  }
  return 0 ;
}
void first_of(char a){
  int i,j,l,r,q,f;
  char c,e;
  for(i=0;i<production_counter;i++){
    if(pro[i].head == a){
      for(j=0;j<=(pro[i].counter);j++){
        c=pro[i].body[j][0];
        if(c >= 'A' && c <= 'Z'){
          for(l=0;l<production_counter;l++){
            if(pro[l].head == c){
              r=l;
            }
          }
          if(temp_first[r]==0){
            temp_first[r]=1;
            first_of(c);
            f=0;
            while(is_nullable(c)==1){
              c=pro[i].body[j][f+1];
              f++;
              if(c >= 'A' && c <= 'Z'){
                first_of(c);
              }
              else if(c=='\0'){
                break;
              }
              else if(c!='0'){
                l=0;
                r=0;
                for(l=0;l<first_counter;l++){
                  if(first_set[l]==c){
                    r=1;
                  }
                }
                if (r==0){
                  first_set[first_counter]=c;
                  first_counter++;
                }
                break;
              }
            }
          }
        }
        else if(c!='0'){
          l=0;
          r=0;
          for(l=0;l<first_counter;l++){
            if(first_set[l]==c){
              r=1;
            }
          }
          if (r==0){
            first_set[first_counter]=c;
            first_counter++;
          }
        }
      }
    }
  }
}

void follow_of(char a){
  int i,j,k,l,r,f;
  char c;
  for(i=0;i<production_counter;i++){
    for(k=0;k<=pro[i].counter;k++){
      for(j=0;pro[i].body[k][j] != '\0';j++){
        if(pro[i].body[k][j] == a){
          c=pro[i].body[k][j+1];
          if (c == '\0'){
            c=pro[i].head;
            for(l=0;l<production_counter;l++){
              if(pro[l].head == c){
                if(temp_follow[l] == 0){
                  temp_follow[l] = 1;
                  follow_of(c);
                }
              }
            }
          }
          else if ( c >= 'A' && c <= 'Z'){
            first_counter=0;
            for(l=0;l<production_counter;l++){
              if(pro[l].head == c){
                r=l;
              }
            }
            if(temp_first[r]==0){
              temp_first[r]=1;
              first_of(c);
              f=0;
              while(is_nullable(c)==1){
                c=pro[i].body[k][j+1+f];
                f++;
                if(c >= 'A' && c <= 'Z'){
                  first_of(c);
                  strcat(follow_set,first_set);
                  follow_counter=follow_counter+strlen(first_set);
                  first_counter=0;
                }
                else if(c=='\0'){
                  follow_of(pro[i].head);
                  break;
                }
                else if(c!='0'){
                  follow_set[follow_counter]=c;
                  follow_counter++;
                  break;
                }
              }
            }
          }
          else if(c!='0'){
            follow_set[follow_counter]=c;
            follow_counter++;
          }
        }
      }
    }
  }
}

int main(int argc, char *argv[]){
  if( argc == 2 ) {
    printf("The argument supplied is %s\n", argv[1]);
  }
  else if( argc > 2 ) {
    printf("Too many arguments supplied.\n./a.out <filename>\n");
    return 0;
  }
  else {
    printf("One argument expected.\n./a.out <filename>\n");
    return 0;
  }
  FILE *file_des ;
  int c ;
  char d;
  int i=0;
  int j=0;
  int k=0;
  int n=0;
  file_des=fopen (argv[1],"r");
  if(file_des==NULL){
    printf("Unable to open the input file");
    return 1 ;
  }
  while(!feof(file_des) ){
    fscanf(file_des,"%c",&d);//for left hand side of the production or head
    pro[production_counter].head = d;
    fscanf(file_des,"%c",&d);//for ignoring '->'
    fscanf(file_des,"%c",&d);//for ignoring '->'
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
        pro[production_counter].body[i][j] = d;
        j++;
      }
    }
    pro[production_counter].counter=i;
    production_counter++;
  }
  production_counter=production_counter-1;
  i=0;
  j=0;
  k=0;

  fclose(file_des);//done reading file and the CFG is stored in pro variable

  printf("\nThe Grammar that has been given as input is :\n");
  for(i=0;i<production_counter;i++){//printing the stored pro variable
    printf("%c->",pro[i].head);
    printf("%s",pro[i].body[0]);
    for(k=1;k<=pro[i].counter;k++){
      printf("|");
      printf("%s",pro[i].body[k]);
    }
    printf("\n");
  }

  printf("\nNon-Terminal for which First and Follow sets needs to be calculated : ");
  scanf("%c",&d);//user input of a terminal
  for(i=0;i<100;i++){
    temp_first[i]=0;
  }
  for(i=0;i<100;i++){
    temp_follow[i]=0;
  }
  for(i=0;i<100;i++){
    temp_nullable[i]=0;
  }

  first_of(d);

  printf("\nFirst set of the Non-Terminal %c is { %c",d,first_set[0]);
  for(i=1;i<first_counter;i++){
    printf(", %c",first_set[i]);
  }
  printf(" }\n");
  for(i=0;i<100;i++){
    temp_first[i]=0;
  }
  for(i=0;i<100;i++){
    temp_follow[i]=0;
  }
  for(i=0;i<100;i++){
    temp_nullable[i]=0;
  }

  follow_of(d);

  n=follow_counter;//code start to remove the repeating in the follow set
  for(i=0; i < n; i++){
    for(j=i+1; j < n;){
      if(follow_set[j] == follow_set[i]){
        for(k=j; k < n;k++){
          follow_set[k] = follow_set[k+1];
        }
        n--;
      }
      else {
        j++;
      }
    }
  }
  follow_counter=n;//code end to remove the repeating in the follow set

  printf("\nFollow set of the Non-Terminal %c is { %c",d,follow_set[0]);
  for(i=1;i<follow_counter;i++){
    printf(", %c",follow_set[i]);
  }
  printf(" }\n\n");
  return 0;
}
