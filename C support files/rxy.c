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
 * ./[nombre].out//
//*/

#include <stdio.h>

/* Uncomment for different tests */
//#define N 	5	// length of sequence x 
//#define M 	4	// length of sequence y
#define N 	7	// length of sequence x 
#define M 	7	// length of sequence y
//#define N 	4	// length of sequence x 
//#define M 	3	// length of sequence y
//#define N 	5	// length of sequence x 
//#define M 	7	// length of sequence y

#define	rxy_length	N+M-1	// length of sequence rxy
#define	rxx_length	2*N-1	// length of sequence rxx    

/* Uncomment for different tests */
//float x[N] = {2,2,2,2,2};
//float y[M] = {2,2,2,2};
float x[N] = {0,1,2,3,2,1,0};
float y[M] = {0,1,2,3,2,1,0};
//float x[N] = {3,3,3,3};
//float y[M] = {3,3,3};
//float x[N] = {1,1,1,1,1};
//float y[M] = {1,1,1,1,1,1,1};

float rxy[rxy_length];
float rxx[rxx_length];
float *ap_x, *ap_y, *ap_r;
int n, i, j;

void cross_r_xy(void);
void auto_cross_r_xy(void);


int main(void){

	cross_r_xy();

	for(i=0;i<rxy_length;i++)
		printf("%.2f\n", rxy[i]);

	printf("------------------------\n");

	auto_cross_r_xy();
	
	for(i=0;i<rxy_length;i++)
		printf("%.2f\n", rxx[i]);
	
	return 0;
}

void cross_r_xy(){
	ap_r = &rxy[0];

	// for l<=0
	int cont = 1;
	ap_x = &x[0];
	ap_y = &y[M-1];

	for(i=0; i<M; i++){

		for(n=0; n<cont; n++){
			// movable sequence is y
			*ap_r += *(ap_x+n) * *(ap_y+n);
		}
		ap_r++;
		ap_y--;
		cont++;
	}
	
	// for l>0
	cont = N-1;
	ap_x = &x[1];
	ap_y = &y[0];
	
	for(i=0; i<N-1; i++){
		for(n=0; n<cont; n++){
			// movable sequence is x
			*ap_r += *(ap_x+n) * *(ap_y+n);
		}
		ap_r++;
		ap_x++;
		cont--;
	}	

}

void auto_cross_r_xy(void){
	ap_r = &rxx[0];

	// for l<=0
	int cont = 1;
	ap_x = &x[0];
	ap_y = &x[M-1];

	for(i=0; i<M; i++){

		for(n=0; n<cont; n++){
			// movable sequence is y
			*ap_r += *(ap_x+n) * *(ap_y+n);
		}
		ap_r++;
		ap_y--;
		cont++;
	}
	
	// for l>0
	cont = N-1;
	ap_x = &x[1];
	ap_y = &x[0];
	
	for(i=0; i<N-1; i++){
		for(n=0; n<cont; n++){
			// movable sequence is x
			*ap_r += *(ap_x+n) * *(ap_y+n);
		}
		ap_r++;
		ap_x++;
		cont--;
	}	

}