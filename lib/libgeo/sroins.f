

C$PROG SROINS
C$XREF
      COMPLEX FUNCTION SROINS(OMEGA)
      COMPLEX S,F,POLE,ZERO
      S=CMPLX(0.0,OMEGA)
      ZERO=(S**5)*(S+(0.1256,0.0))*(S+(50.10,0.0))*(S+(0.,1.053))*
     1(S+(0.,-1.053))
      POLE=(S+(4.648,3.463))*(S+(4.648,-3.463))*(S+(0.1179,0.0))*
     1(S+(40.73,0.0))*(S+(100.,0.0))*(S+(0.1500,0.0))*(S+(264.,0.0))
     2*(S+(3.928,0.0))*(S+(0.2820,0.0))*(S+(0.2010,0.2410))*(S+(0.2010,
     3-0.2410))*(S+(0.1337,0.1001))*(S+(0.1337,-0.1001))*(S+(0.0251,0.0
     4))*(S+(0.00924,0.0))*(S+(0.3334,0.2358))*(S+(0.3334,-0.2358))*
     5(S+(0.1378,0.5873))*(S+(0.1378,-0.5873))
      SROINS=CMPLX(9.237E+03,0.0)*(ZERO/POLE)
      RETURN
      END
