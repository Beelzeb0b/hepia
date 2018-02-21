#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>
int iteration = 5;
int main() {
	printf("Hello, I'll compute %d square roots.\n", iteration);
	for (int i=0; i<iteration; i++) {
		printf("Number to compute the square root of: ");
		double n, sr;
		scanf("%lf", &n);
		sr = sqrt(n);
		printf("The square root of %lf is %lf\n", n, sr);
	}
	printf("Finished, bye!\n");
}
