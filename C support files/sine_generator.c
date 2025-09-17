/**	
 * Compile command on linux terminal
 * gcc [name].c -lm -o [name].out
 * 
 * Run command on linux terminal
 * ./[nombre].out
*/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <stdbool.h>


/**
 * 	Sine signal parameters
*/
#define	M	1000				// no. of samples
#define f0	10 				// natural frequency
#define A 	2					// amplitude
#define pi 	3.141592	// pi constant


/**
 * 	Fixed point formats
*/
#define Q12 12
#define Q10 10
#define Q8  8
#define Q4 	4


/**
 * 	Signals arrays
*/
float 	sine[M];					// sine data array
float 	rand_noise[M];		// random noise data array
float 	noisy_sine[M];		// sine + random noise data array
float 	min = -0.05;      // lower bound for random noise
float	max = 0.05;       	// higher bound for random noise
int 	sine_Qi[M];         // sine in Qi format data array
int 	n;									// counter for loops


/**
 * 	Function signatures
*/
void create_sine();
void add_random_noise_to_sine();
void sine_to_Qi(int which, int qi);
int float_to_Qi(int Qi, float num);
void create_signal_data_file(int which, const char *filename);


/**
 * 	Main 
*/
int main(void){

	create_sine();
	create_signal_data_file(0,"pure_sine_f10.dat");

	sine_to_Qi(0,Q4);
	create_signal_data_file(2,"pure_sine_Q4.dat");
	sine_to_Qi(0,Q10);
	create_signal_data_file(2,"pure_sine_Q10.dat");

	add_random_noise_to_sine();
	sine_to_Qi(1,Q8);
	create_signal_data_file(2,"noisy_sine_Q8.dat");
	sine_to_Qi(1,Q12);
	create_signal_data_file(2,"noisy_sine_Q12.dat");

	system("gnuplot -p 'graf.gp'");
	
	return 0;
}


/**
 * Function definitions 	
*/

/**
 * @brief	Creates a sine signal from parameters specified in #defines
 * @param 	None
 * @retval 	None
*/
void create_sine(){
	for(n=0; n<M-1; n++){
        sine[n] = A*sin(2*pi*f0*n/M);
    }
}


/**
 * @brief	Converts a sine in float format to fixed point values
 * @param 	which selects either pure sine (0) or noisy_sine (1) to convert to Qi
 * @param 	qi specifies Qi format
 * @retval 	None
*/
void sine_to_Qi(int which, int qi){
	if(which == 0){					// converts pure sine
		for(n=0; n<M-1; n++)		
			sine_Qi[n] = float_to_Qi(qi, sine[n]);

	} else if(which == 1){	// converts noisy sine
		for(n=0; n<M-1; n++)		
			sine_Qi[n] = float_to_Qi(qi, noisy_sine[n]);
	}
}

/**
 * @brief	Creates random noise and adds it to sine signal
 * @param 	None
 * @retval 	None
*/
void add_random_noise_to_sine(){
	srand(time(NULL));

	for(n=0; n<M-1; n++){
    	rand_noise[n] = min + ((float)rand() / RAND_MAX) * (max - min);
		noisy_sine[n] = sine[n] + rand_noise[n];
	}
}


/**
  *	@brief	Creates a .dat file with a signal points
  *	@param 	filename name + extension of the file to be created
  * @param 	which elects either pure sine (0) or noisy_sine (1) or sine_Qi (2) to save into file
  * @retval None
*/
void create_signal_data_file(int which, const char *filename){
	FILE *write;
	write = fopen(filename,"w");
    if (write == NULL) {
        perror("Error opening file");
    }else{

		if(which == 0){										//	saves pure sine in float
			for(n=0; n<M-1; n++)
				fprintf(write, "%2.6f\n", sine[n]);

		} else if(which == 1){						//	saves noisy_sine in float
			for(n=0; n<M-1; n++)		
				fprintf(write, "%2.6f\n", noisy_sine[n]);
	
		} else if(which == 2){						// saves sine_Qi (either pure or noisy)
			for(n=0; n<M-1; n++)		
				fprintf(write, "%d\n", sine_Qi[n]);
		}
	
		fclose(write);
	}

}


/**
  *	@brief	Converts a float number to fixed point in the Qi given
  *	@param 	Qi given fixed point format
  * @param 	num floating point number to be converted
  * @retval number converted to Qi fixed point
*/
int float_to_Qi(int Qi, float num){
    int punto_fijo = 0;
    punto_fijo = (int)(num*pow(2,Qi));
    return punto_fijo;
}