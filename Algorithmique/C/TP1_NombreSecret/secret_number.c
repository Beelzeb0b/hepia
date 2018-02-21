#include <stdio.h>
#include <stdlib.h>
#include <time.h>
int number, max, input, iteration = 0;

int calcul_optimized_iteration(int number, int iteration){
	return number + iteration;
}

int rand_v2(int a, int b){
   return rand()%(b-a) +a;
}

}
int main(){
	printf("Enter max value :");
	scanf("%d", &max);
	srand(time(NULL)); // init random
	number = rand_v2(0, max);
	printf("Secret number, Start!\n");
	do {
		printf("Enter your number :");
		scanf("%d", &input);
		if(input > number)
			printf("Too big!\n");
		else if (input < number)
			printf("Too small!\n");
		iteration++;
	} while (input != number);
	printf("Well done, you completed the game with %d attempt(s)", iteration);
	int opti_iter = calcul_optimized_iteration(number, 0);
	printf("You can found the number with only %d attempt(s)",opti_iter);
}	

