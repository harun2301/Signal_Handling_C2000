/*
*	Compile command on linux terminal
*	gcc [name].c -lm -o [name].out
*
*	Run command on linux terminal
*	./[nombre].out
*/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <stdbool.h>


/*
*	Sine signal parameters
*/
#define	M	1000		// no. of samples
#define f0	2 			// natural frequency
#define A 	2			// amplitude
#define pi 	3.141592	// pi constant

/*
*	Fixed point formats
*/
#define Q12 12
#define Q10 10
#define Q8  8
#define Q4 	4



/*
*	Function signatures
*/
void sine_to_Qi();
void create_sine();
void float_to_Qi();
void add_random_noise_to_sine();
void create_signal_data_file(FILE *escrib);


/* 
*	Main 
*/
int main(void){

	/*
	*	Signals arrays
	*/
	float 	sine[M];			// sine data array
	float 	rand_noise[M];		// random noise data array
	float 	noisy_sine[M];		// sine + random noise data array
	float 	min = -0.05;      	// lower bound for random noise
	float	max = 0.05;       	// higher bound for random noise
	int 	sine_Qi[M];         // sine in Qi format data array

	return 0;
}

/*
*	Function definitions
*/
