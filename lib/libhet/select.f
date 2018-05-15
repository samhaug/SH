      SUBROUTINE SELECT(IFEXST,IFPSTR,NSTRSO,IFANI,ITRSTR,ITAPER,MXITER,
     1IFINV,IFOMIT,IFCCN,NHTMDL,MFIL,MFILAN)
      save
      DOUBLE PRECISION GAMMA,DDAMP
      CHARACTER*1 NHTMDL(12)
      DIMENSION MFIL(4),MFILAN(4)
      COMMON/INVPAR/ ICOL(12),GAMMA
      COMMON/DDAMP/ DDAMP
      COMMON/PARAM/ NOTRCE,NOM4M5,NODEP,NOEPIC
      COMMON/DBLEC/ EPLA,EPLON,DEP,TORG,DURT
      DO 1 I=1,12
    1 ICOL(I)=0
      WRITE(16,2100)
 2100 FORMAT(13X,' PARAMETERS SELECTED FOR INVERSION:'//)
      WRITE(6,5001)
 5001 FORMAT(' NAME OF MODE PARAMETER FILE'/16('*'))
      READ(15,5002) (MFIL(IM),IM=1,4)
 5002 FORMAT(4A4)
      WRITE(16,5003) (MFIL(IM),IM=1,4)
 5003 FORMAT(1X,4A4,14X,'MODE PARAMETER FILE')
      WRITE(6,5004)
 5004 FORMAT(' NAME OF KERNEL FILE'/16('*'))
      READ(15,5002) (MFILAN(IM),IM=1,4)
      WRITE(16,5005) (MFILAN(IM),IM=1,4)
 5005 FORMAT(1X,4A4,14X,'KERNEL FILE')
      WRITE(6,1000)
 1000 FORMAT(' DOES CMT SOLUTION EXIST? 1 - YES, 0 - NO'/'*')
      READ(15,1001) IFEXST
 1001 FORMAT(I1,I2)
      WRITE(16,2000) IFEXST
 2000 FORMAT(1X,I1,29X,'CMT SOLN. EXISTS? 1 - YES, 0 - NO')
      WRITE(6,1027)
 1027 FORMAT(' DOES .INV FILE EXIST? 1 - YES, 0 - NO'/'*')
      READ(15,1001) IFINV
      WRITE(16,2027) IFINV
 2027 FORMAT(1X,I1,29X,'.INV FILE EXISTS? 1 - YES, 0 - NO')
      WRITE(6,1014)
 1014 FORMAT(' USE PREVIOUS STRUCTURE PERTURBATIONS? -- IF NOT'/
     1   ' THEN TYPE NAME OF MODEL FILE AND 1 OR ZERO FOR'
     2  ,' CRUSTAL CORRECTION'/'* ************ *')
      READ(15,1028) IFPSTR,(NHTMDL(I),I=1,12),IFCCN
 1028 FORMAT(I1,1X,12A1,1X,I1)
      WRITE(16,2014) IFPSTR,(NHTMDL(I),I=1,12),IFCCN
 2014 FORMAT(1X,I1,1X,12A1,1X,I1,14X,'USE PREV STRUC?; HTM FILE;'
     1 ,' CRUST CORR?')
      WRITE(6,1002)
 1002 FORMAT(' NUMBER OF STRUCTURE - SOURCE ITERATIONS'/'*'
     1  ,' *','         TYPE 1 TO OMIT LAST SOURCE INVERSION')
      READ(15,1001) NSTRSO,IFOMIT
      WRITE(16,2002) NSTRSO,IFOMIT
 2002 FORMAT(1X,I1,1X,I1,27X,'NO. OF STRCT-SOURCE ITRATNS; LAST'
     1  ,'SRCE INV. OMITTED?')
      WRITE(6,1003)
 1003 FORMAT(' *** PARAMETERS FOR STRUCTURE INVERSION ***')
      WRITE(16,2003)
 2003 FORMAT(//13X,'*** PARAMETERS FOR STRUCTURE INVERSION ***')
      WRITE(6,1004)
 1004 FORMAT(' ISOTROPIC (0) OR ANISOTROPIC (1) VS PERTURBATION'/
     1  '*')
      READ(15,1001) IFANI
      WRITE(16,2004) IFANI
 2004 FORMAT(1X,I1,29X,'ISOTROPIC (0) OR ANISOTROPIC (1) VS PERTURBATION
     1')
      WRITE(6,1005)
 1005 FORMAT(' 1. PERTURB CRUSTAL THICKNESS? 0 - NO, 1 - YES'/'*')
      READ(15,1001) ICOL(1)
      WRITE(16,2005) ICOL(1)
 2005 FORMAT(1X,I1,29X,'1. PERTURB CRUSTAL THICKNESS? 0-NO, 1-YES')
      WRITE(6,1006)
 1006 FORMAT(' 2. PERTURB P-VEL MOHO-220KM? 0 - NO, 1 - YES'/'*')
      READ(15,1001) ICOL(2)
      WRITE(16,2006) ICOL(2)
 2006 FORMAT(1X,I1,29X,'2. PERTURB P-VEL MOHO-220KM? 0 - NO, 1 - YES')
      WRITE(6,1007)
 1007 FORMAT(' 3.-6. & 8.-11. NUMBER OF RADIAL FUNCTIONS FOR VS'/'*')
      READ(15,1001) NRS
      WRITE(16,2007) NRS
 2007 FORMAT(1X,I1,29X,'3.-6. & 8.-11. NUMBER OF RADIAL FUNCTIONS FOR VS
     1')
      DO 2 I=1,NRS
      IF(IFANI.NE.0) ICOL(I+7)=1
    2 ICOL(I+2)=1
      WRITE(6,1008)
 1008 FORMAT(' 7. & 12. PERTURB VS 670-1100KM? 0 - NO, 1 - YES'/'*')
      READ(15,1001) ICOL(7)
      WRITE(16,2008) ICOL(7)
 2008 FORMAT(1X,I1,29X,'7. & 12. PERTURB VS 670-1100? 0 - NO, 1 - YES')
      IF(IFANI.NE.0) ICOL(12)=ICOL(7)
      WRITE(6,1009)
 1009 FORMAT(' NUMBER OF ITERATIONS FOR STRUCTURE IN EACH PASS'/'*')
      READ(15,1001) ITRSTR
      WRITE(16,2009) ITRSTR
 2009 FORMAT(1X,I1,29X,'NUMBER OF ITERATIONS FOR STRUCTURE IN EACH PASS'
     1)
      WRITE(6,1010)
 1010 FORMAT(' EIGENVALUE CUT-OFF RATIO'/'*.******')
      READ(15,1011) GAMMA
      WRITE(16,2010) GAMMA
 2010 FORMAT(1X,F8.6,22X,'EIGENVALUE CUT-OFF RATIO')
 1011 FORMAT(F8.6)
      WRITE(6,1012)
 1012 FORMAT(' *** CMT INVERSION PARAMETERS ***')
      WRITE(16,2012)
 2012 FORMAT(//13X,' *** CMT INVERSION PARAMETERS ***')
      WRITE(6,1013)
 1013 FORMAT(' TAPER: 1 - (45, 60), 2 - (32, 40)'/'*')
      READ(15,1001) ITAPER
      WRITE(16,2013) ITAPER
 2013 FORMAT(1X,I1,29X,' TAPER: 1 - (45,60), 2 - (32,40)')
      WRITE(6,1015)
 1015 FORMAT(' NUMBER OF CMT ITERATIONS'/'*')
      READ(15,1001) MXITER
      WRITE(16,2015) MXITER
 2015 FORMAT(1X,I1,29X,' NUMBER OF CMT ITERATIONS')
      WRITE(6,1016)
 1016 FORMAT(' CONSTRAIN ISOTROPIC COMPONENT = 0; 0 - NO, 1 - YES'/
     1'*')
      READ(15,1001) NOTRCE
      WRITE(16,2016) NOTRCE
 2016 FORMAT(1X,I1,29X,'CONSTRAIN ISOTROPIC COMPONENT = 0; 0 - NO, 1 - YE
     1S')
      WRITE(6,1017)
 1017 FORMAT(' DEPTH DAMPING'/'*.***')
      READ(15,1018) DDAMP
      WRITE(16,2018) DDAMP
 2018 FORMAT(1X,F5.3,25X,' DEPTH DAMPING')
 1018 FORMAT(F5.3)
      IF(DDAMP.EQ.0.D0) DDAMP=1.D0
      IF(IFEXST.NE.0) GO TO 3
      WRITE(6,1019)
 1019 FORMAT(' SOURCE COORDINATES: LAT, LON, DEPTH, ORIGIN TIME'/
     1'***.** ****.** ***.* ****.*')
      READ(15,1020) EPLA,EPLON,DEP,TORG
      WRITE(16,2019) EPLA,EPLON,DEP,TORG
 2019 FORMAT(1X,F6.2,F8.2,F6.1,F7.1,3X,'SOURCE COORDINATES: LAT, LON, DE
     1PTH, ORIGIN TIME')
 1020 FORMAT(F6.2,F8.2,F6.1,F7.1)
      WRITE(6,1021)
 1021 FORMAT(' SOURCE DURATION'/'***.*')
      READ(15,1022) DURT
      WRITE(16,2021) DURT
 2021 FORMAT(1X,F5.1,25X,' SOURCE DURATION')
 1022 FORMAT(F5.1)
      GO TO 4
    3 LU=2
      IF(IFINV.NE.0) LU=7
      CALL RDSOUR(LU)
      WRITE(6,1026) EPLA,EPLON,DEP,TORG,DURT
 1026 FORMAT(' ACCEPT EXISTING COORDINATES:'/5F10.3/
     1' 0 - NO, 1 - YES'/'*')
      READ(15,1001) IFACCP
      WRITE(16,2026) IFACCP
 2026 FORMAT(1X,I1,29X,' ACCEPT EXISTING COORDINATES? 1-YES, 0-NO')
      IF(IFACCP.EQ.1) GO TO 4
      WRITE(6,1019)
      READ(15,1020) EPLA,EPLON,DEP,TORG
      WRITE(16,2019) EPLA,EPLON,DEP,TORG
      WRITE(6,1021)
      READ(15,1022) DURT
      WRITE(16,2021) DURT
    4 WRITE(6,1023)
 1023 FORMAT(' CONSTRAIN M4=M5=0; 0 - NO, 1 - YES'/'*')
      READ(15,1001) NOM4M5
      WRITE(16,2023) NOM4M5
 2023 FORMAT(1X,I1,29X,' CONSTRAIN M4=M5=0; 0 - NO, 1 - YES')
      WRITE(6,1024)
 1024 FORMAT(' CONSTRAIN DEPTH; 0 - NO, 1 - YES'/'*')
      READ(15,1001) NODEP
      WRITE(16,2024) NODEP
 2024 FORMAT(1X,I1,29X,' CONSTRAIN DEPTH; 0 - NO, 1 - YES')
      WRITE(6,1025)
 1025 FORMAT(' CONSTRAIN EPICENTER, 0 - NO, 1 - YES'/'*')
      READ(15,1001) NOEPIC
      WRITE(16,2025) NOEPIC
 2025 FORMAT(1X,I1,29X,' CONSTRAIN EPICENTER, 0 - NO, 1 - YES')
      RETURN
      END