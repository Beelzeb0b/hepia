#include <stdio.h>
#include <stdlib.h>
#include <time.h>
int main(){
	char op;
	int n1, n2, r;
	printf("Which operation? (+ or *) ");
	scanf("%c", &op);
	printf("Please enter 2 integers : ");
	scanf("%d %d", &n1, &n2);
	if(op =='+')
	{
		r = n1+n2;
		printf("Their sum is %d\n",r);
	}
	else if (op == '*')
	{
		r = n1*n2;
		printf("Their product is %d\n",r);
	}
}	
