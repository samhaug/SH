
C      SUBROUTINE COOL2
C$PROG COOL2
      SUBROUTINE COOL2 (DATA,NPREV,N,NREM,ISIGN)
C     DISCRETE FOURIER TRANSFORM OF LENGTH N.  IN-PLACE COOLEY-TUKEY
C     ALGORITHM, BIT-REVERSED TO NORMAL ORDER, SANDE-TUKEY PHASE SHIFTS.
C     DIMENSION DATA(NPREV,N,NREM)
C     COMPLEX DATA
C     DATA(J1,K4,J5) = SUM(DATA(J1,J4,J5)*EXP(ISIGN*2*PI*I*(J4-1)*
C     (K4-1)/N)), SUMMED OVER J4 = 1 TO N FOR ALL J1 FROM 1 TO NPREV,
C     K4 FROM 1 TO N AND J5 FROM 1 TO NREM.  N MUST BE A POWER OF TWO.
C     METHOD--LET IPREV TAKE THE VALUES 1, 2 OR 4, 4 OR 8, ..., N/16,
C     N/4, N.  THE CHOICE BETWEEN 2 OR 4, ETC., DEPENDS ON WHETHER N IS
C     A POWER OF FOUR.  DEFINE IFACT = 2 OR 4, THE NEXT FACTOR THAT
C     IPREV MUST TAKE, AND IREM = N/(IFACT*IPREV).  THEN--
C     DIMENSION DATA(NPREV,IPREV,IFACT,IREM,NREM)
C     COMPLEX DATA
C     DATA(J1,J2,K3,J4,J5) = SUM(DATA(J1,J2,J3,J4,J5)*EXP(ISIGN*2*PI*I*
C     (K3-1)*((J3-1)/IFACT+(J2-1)/(IFACT*IPREV)))), SUMMED OVER J3 = 1
C     TO IFACT FOR ALL J1 FROM 1 TO NPREV, J2 FROM 1 TO IPREV, K3 FROM
C     1 TO IFACT, J4 FROM 1 TO IREM AND J5 FROM 1 TO NREM.  THIS IS
C     A PHASE-SHIFTED DISCRETE FOURIER TRANSFORM OF LENGTH IFACT.
C     FACTORING N BY FOURS SAVES ABOUT TWENTY FIVE PERCENT OVER FACTOR-
C     ING BY TWOS.  DATA MUST BE BIT-REVERSED INITIALLY.
C     IT IS NOT NECESSARY TO REWRITE THIS SUBROUTINE INTO COMPLEX
C     NOTATION SO LONG AS THE FORTRAN COMPILER USED STORES REAL AND
C     IMAGINARY PARTS IN ADJACENT STORAGE LOCATIONS.  IT MUST ALSO
C     STORE ARRAYS WITH THE FIRST SUBSCRIPT INCREASING FASTEST.
      DIMENSION DATA(*)
      TWOPI=6.2831853072*FLOAT(ISIGN)
      IP0=2
      IP1=IP0*NPREV
      IP4=IP1*N
      IP5=IP4*NREM
      IP2=IP1
C     IP2=IP1*IPROD
      NPART=N
 10   IF (NPART-2) 60,30,20
 20   NPART=NPART/4
      GO TO 10
C     DO A FOURIER TRANSFORM OF LENGTH TWO
 30   IF (IP2-IP4) 40,160,160
 40   IP3=IP2*2
C     IP3=IP2*IFACT
      DO 50 I1=1,IP1,IP0
C     I1 = 1+(J1-1)*IP0
      DO 50 I5=I1,IP5,IP3
C     I5 = 1+(J1-1)*IP0+(J4-1)*IP3+(J5-1)*IP4
      I3A=I5
      I3B=I3A+IP2
C     I3 = 1+(J1-1)*IP0+(J2-1)*IP1+(J3-1)*IP2+(J4-1)*IP3+(J5-1)*IP4
      TEMPR=DATA(I3B)
      TEMPI=DATA(I3B+1)
      DATA(I3B)=DATA(I3A)-TEMPR
      DATA(I3B+1)=DATA(I3A+1)-TEMPI
      DATA(I3A)=DATA(I3A)+TEMPR
 50   DATA(I3A+1)=DATA(I3A+1)+TEMPI
      IP2=IP3
C     DO A FOURIER TRANSFORM OF LENGTH FOUR (FROM BIT REVERSED ORDER)
 60   IF (IP2-IP4) 70,160,160
 70   IP3=IP2*4
C     IP3=IP2*IFACT
C     COMPUTE TWOPI THRU WR AND WI IN DOUBLE PRECISION, IF AVAILABLE.
      THETA=TWOPI/FLOAT(IP3/IP1)
      SINTH=SIN(THETA/2.)
      WSTPR=-2.*SINTH*SINTH
      WSTPI=SIN(THETA)
      WR=1.
      WI=0.
      DO 150 I2=1,IP2,IP1
C     I2 = 1+(J2-1)*IP1
      IF (I2-1) 90,90,80
 80   W2R=WR*WR-WI*WI
      W2I=2.*WR*WI
      W3R=W2R*WR-W2I*WI
      W3I=W2R*WI+W2I*WR
 90   I1MAX=I2+IP1-IP0
      DO 140 I1=I2,I1MAX,IP0
C     I1 = 1+(J1-1)*IP0+(J2-1)*IP1
      DO 140 I5=I1,IP5,IP3
C     I5 = 1+(J1-1)*IP0+(J2-1)*IP1+(J4-1)*IP3+(J5-1)*IP4
      I3A=I5
      I3B=I3A+IP2
      I3C=I3B+IP2
      I3D=I3C+IP2
C     I3 = 1+(J1-1)*IP0+(J2-1)*IP1+(J3-1)*IP2+(J4-1)*IP3+(J5-1)*IP4
      IF (I2-1) 110,110,100
C     APPLY THE PHASE SHIFT FACTORS
 100  TEMPR=DATA(I3B)
      DATA(I3B)=W2R*DATA(I3B)-W2I*DATA(I3B+1)
      DATA(I3B+1)=W2R*DATA(I3B+1)+W2I*TEMPR
      TEMPR=DATA(I3C)
      DATA(I3C)=WR*DATA(I3C)-WI*DATA(I3C+1)
      DATA(I3C+1)=WR*DATA(I3C+1)+WI*TEMPR
      TEMPR=DATA(I3D)
      DATA(I3D)=W3R*DATA(I3D)-W3I*DATA(I3D+1)
      DATA(I3D+1)=W3R*DATA(I3D+1)+W3I*TEMPR
 110  T0R=DATA(I3A)+DATA(I3B)
      T0I=DATA(I3A+1)+DATA(I3B+1)
      T1R=DATA(I3A)-DATA(I3B)
      T1I=DATA(I3A+1)-DATA(I3B+1)
      T2R=DATA(I3C)+DATA(I3D)
      T2I=DATA(I3C+1)+DATA(I3D+1)
      T3R=DATA(I3C)-DATA(I3D)
      T3I=DATA(I3C+1)-DATA(I3D+1)
      DATA(I3A)=T0R+T2R
      DATA(I3A+1)=T0I+T2I
      DATA(I3C)=T0R-T2R
      DATA(I3C+1)=T0I-T2I
      IF (ISIGN) 120,120,130
 120  T3R=-T3R
      T3I=-T3I
 130  DATA(I3B)=T1R-T3I
      DATA(I3B+1)=T1I+T3R
      DATA(I3D)=T1R+T3I
 140  DATA(I3D+1)=T1I-T3R
      TEMPR=WR
      WR=WSTPR*TEMPR-WSTPI*WI+TEMPR
 150  WI=WSTPR*WI+WSTPI*TEMPR+WI
      IP2=IP3
      GO TO 60
 160  RETURN
      END
