


c-------------------------------------------------------------
      subroutine kyread(iform,lkey,string,key)
      include "dblib.h"
      dimension key(*)
      character*(*) string
      character*4 alph
      double precision dub
      integer*4 idub(2)
      character*40 gtawrd,str40
      equivalence (dub,idub)
      equivalence (sng,isng)
      integer*4 space/'    '/
      integer*2 itemp2(2)
      equivalence (itemp,itemp2)
c     if(itre.lt.0) then
c       lkey=-1
c       return
c     endif

c     iform=and(ibig(itre+OTRTP),MTRKT)
c     lkey=ibig(itre+OTRLK)
      lstr=len(string)
      if     (iform.eq.VTRAK) then
        k=0
        do i=1,lstr,4
          alph=string(i:min(i+3,lstr))
          k=k+1
          if(k.gt.lkey) goto 10
          read(alph,"(a4)") key(k)
        enddo
   10   continue
        do i=k+1,lkey
          key(i)=space
        enddo
        call byswap4(key,k)
        return
      else if(iform.eq.VTRIK) then
        k=0
        do i=1,lkey
          str40=gtawrd(string,k)
          read(str40,*) key(i)
        enddo
        return 
      else if(iform.eq.VTRHK) then
        k=0
        do i=1,lkey
          str40=gtawrd(string,k)
          read(str40,"(z4)") itemp2(1)
          str40=gtawrd(string,k)
          read(str40,"(z4)") itemp2(2)
          key(i)=itemp
        enddo
        return 
      else if(iform.eq.VTRFK) then
        k=0
        do i=1,lkey
          str40=gtawrd(string,k)
          read(str40,*) sng
          key(i)=isng
        enddo
        return 
      else if(iform.eq.VTRDK) then
        k=0
        do i=1,lkey,2
          str40=gtawrd(string,k)
          read(str40,*) dub
          key(i)=idub(1)
          key(i+1)=idub(2)
        enddo
        return 
      else
        pause 'kyread: unknown format'
      endif
      return
      end
