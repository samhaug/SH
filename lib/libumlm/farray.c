#define U (unsigned)

#include <stdlib.h>

#define STOP(x) {printf("\n x \n"); exit(-1);}
#define stop(x) {printf("\n" x "\n"); exit(-1);}

/*******1-D*******/
float *farray1(n11,n12)
int n11,n12;
{
float *m;
	m=(float *)malloc( U (n12-n11+1)*sizeof(float) );
	if(!m) STOP(allocation error in farray1);
	return(m-n11);
}
void free_farray1(a,n11)
float *a;
int n11;
{
	free(&a[n11]);
}

/*******2-D*******/
float **farray2(n11,n12,n21,n22)
int n11,n12,n21,n22;
{
int i;
float **m;
	m=(float **)malloc( U (n12-n11+1)*sizeof(float*) );
	if(!m) STOP(allocation error 1 in farray2);
	m-=n11;
	
	for(i=n11;i<=n12;i++)
	{ m[i]=(float *)malloc( U (n22-n21+1)*sizeof(float) );
	  if(!m[i]) STOP(allocation error 2 in farray2);
	  m[i]-=n21;
	}
	return(m);
}
void free_farray2(a,n11,n12,n21)
float **a;
int n11,n12,n21;
{
int i;	
	free(&(a[n11]));
	for(i=n11;i<=n12;i++)
	  free(&(a[i][n21]));
}

