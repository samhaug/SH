c -------------------------------------------------------
                                                                         
      DOUBLE PRECISION FUNCTION DOT(A,J,B,K,N)
      IMPLICIT DOUBLE PRECISION(A-H,O-Z)
      DOUBLE PRECISION A,B
      DIMENSION A(J,N),B(K,N)
      DOT=0.D0
      DO 1 I=1,N
    1 DOT=DOT+A(1,I)*B(1,I)
      RETURN
      END
