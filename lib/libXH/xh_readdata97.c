#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <sys/param.h>

#include <math.h>
#include "xhhead97m.h"	/* XH format structures */

/* Reads the DATA of an XH file */

int xh_readdata97(ifl,h,seism)
FILE *ifl;
xhhed97 h;
float *seism;
{

if (fread(seism,sizeof(float),h.ndata,ifl) != h.ndata) {
    fprintf(stderr,"ERROR reading XH data stat=%s chan=%s\n",h.stnm,h.chan);
    fprintf(stderr,"h.ndata= %d\n", h.ndata);
    return(0);
} else {
    return(1);
}

} /* end */
