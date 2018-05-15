#include <stdio.h>
#include <math.h>

/* TTable has 160 indices.
   It contains travel times betwen 21 and 180 degrees */


extractTTime(TTable, gcarc, ttime)

    float *TTable;
    float  gcarc;
    float *ttime;
{

int   i;
float dist, f1, f2;


*ttime = -999.;
if (gcarc < 1. || gcarc > 180.) 
  fprintf(stderr,"IN extractTTime:   GCARC is %f\n", gcarc);

for(i=0; i<180; ++i) {
   dist = 1. + i*1.;
   if (gcarc < dist) {
     f1 = dist - gcarc;
     f2 = TTable[i] - TTable[i-1];
     *ttime = TTable[i-1] + f1*f2;
/*
fprintf(stdout,"IN extractTTime: dist= %f gcarc= %f t1= %f t2= %f\n",dist,gcarc,TTable[i-1],TTable[i]);
*/
     goto cont;
   }
}

cont:
/*
fprintf(stdout,"IN extractTTime: ttime = %f\n", *ttime);
*/
return;

}
