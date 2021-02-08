c-------------------------------------------------------------------

      subroutine trrenk(itre,key,lkey)
      dimension key(*)
      include "dblib.h"
      logical trfind
      if(lkey.ne.ibig(itre+OTRLK)) pause 'trrenk: key wrong length'
      ilev=ibig(itre+OTRLV)
      la=ibig(itre+OTRKO)
      lam1=la-1
      lam2=la-2
      mord=ibig(itre+OTROR)
      linfo=ibig(itre+OTRLI)
      istak=ibig(itre+OTRST)
      ilev=ibig(itre+OTRLV)
      iptha=ibig(itre+OTRPA)+ilev
      ikeya=ibig(itre+OTRKY)+ilev
      ipthd=ibig(iptha)
      ikeyd=ibig(ikeya)
      if(ipthd.lt.0) pause 'trrenk: no current key'
      call stakgt(istak,ipthd,ibrec)
c ! pointer to current key
      kd=ibrec+2+ikeyd*la
      nkey=ibig(ibrec)-1
      call balloc(lam1,isave)
c ! save current key and contents
      do i=0,lam2
        ibig(isave+i)=ibig(kd+i)
      enddo

      if(trfind(itre,key,lkey,iok,ioi)) then
        pause 'trrenk: destination key exists'
      else




        call traddk(itre,key,lkey,ibig(isave+lkey),lam1-lkey)
        if(.not.trfind(itre,ibig(isave),lkey,iok,ioi)) then
          pause 'trrenk: source key not found'
        else




          call trdelk(itre)
        endif
      endif

      call dalloc(lam1,isave)

      return
      end

