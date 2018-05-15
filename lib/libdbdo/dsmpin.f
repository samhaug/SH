

c-------------------------------------------------------------
      double precision function dsmpin(irate)
      integer*2 jrate(2),is1,is2
      integer*4 krate
      equivalence (jrate(1),is1,krate),(jrate(2),is2)
      krate=irate
      if(is1.gt.0) then
        dsmpin=1.d0/float(is1)
      else
        dsmpin=float(-is1)
      endif
      if(is2.gt.0) then
        dsmpin=dsmpin/float(is2)
      else
        dsmpin=dsmpin*float(-is2)
      endif
      return
      end
