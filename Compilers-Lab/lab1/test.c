// *back_pointer=*front_pointer;
// *front_pointer++;
// printf("%c",*back_pointer);
#include <stdio.h>
#include <string.h>
int main(void){
  // char c;
  // scanf("%c",&c);
  // if (c>='a' && c<='z'){
  //   printf("lowercase\n");
  // }else if(c>='A' && c<='Z'){
  //   printf("uppercase\n");
  // }else if(c>='0' && c<='9'){
  //   printf("digit\n");
  // }
  	// char input_string[150];
    // printf("Please enter your string\n");
    // fgets(input_string,sizeof(input_string),stdin);
    // char *front_pointer=input_string;
    // char *back_pointer=input_string;
  // char *buff = "this is a test string";
  // *buff++;
  // *buff++;
  // char *fp;
  // fp=buff;
  //
  // char subbuff[5];
  // memcpy( subbuff, &fp[0], 4 );
  // subbuff[4] = '\0';
  char str[100]="";
  char buff[10];
  int n=100;
  snprintf(buff,sizeof buff,"num is %d",n);
  strcat(str,buff);
  printf("%s\n",str);
  return 0;
}
