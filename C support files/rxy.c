/**
 * Author: 	Oscar Harun
 * Brief:	This code is used to generate sine signals in float format.
 * 			Allows to calculate correlation of the signal at l. Also
 * 			forms the correlation function for all possible l values.
 */

/**	
 * Compile command on linux terminal
 * gcc [name].c -lm -o [name].out
 * 
 * Run command on linux terminal
 * ./[nombre].out
*/

#include <stdio.h>

#define N 	7

float x[N] = {0,1,2,3,2,1,0};
float y[N] = {0,1,2,3,2,1,0};
float rxy[N];
float *ap_x, *apy;

int n, i, j;

void cross_r_xy(void);

int main(void){

	return 0;
}

void cross_r_xy(){
	int cont = 0;
	int desp = 0;

	for(i=0; i<N; i++){
		for(n=0; n<cont; n++){
			//E += signal[n] * signal[n];
		}
	}
}