
C$PROG DDABS
      DOUBLE PRECISION FUNCTION DDABS(X)
      DOUBLE PRECISION X
      IF(X.GE.0.D0) DDABS=X
      IF(X.LT.0.D0) DDABS=-X
      RETURN
      END