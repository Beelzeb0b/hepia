#include <stdio.h>
#include <stdlib.h>
#include <time.h>
int number, max, input, iteration = 0;
int main(){
	printf("Enter max value :");
	scanf("%d", &max);
	//// select secret number
	printf("Secret number, Start!\n");
	while (entre != number){
		printf("Enter your number :");
		scanf("%d", &input)
		if(input > number){
			printf("Too big!\n");
		else
			printf("Too small!\n");
		iteration++;
	}
	printf("Well done, you completed the game with %d attempt(s)", iteration);
	int opti_iter = calcul_optimized_iteration(number);
	printf("You can found the number with only %d attempt(s)",opti_iter);
}	

int calcul_optimized_iteration(number, iteration = 0){
	
}
