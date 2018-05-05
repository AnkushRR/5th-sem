#include<stdio.h>
int main(int argc, char const *argv[])
{
	
	if(__builtin_types_compatible_p(typeof(7.6),double)){
		printf("float");
	}else if(__builtin_types_compatible_p(typeof(7.6),int)){
		printf("int");
	}
	return 0;
}