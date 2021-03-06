c-------------------------------------------------------------------
      integer function trreadl(itre,lux,ianex)
      include "dblib.h"
C     dimension ibuf(*)
      la=ibig(itre+OTRKO)
      ilev=ibig(itre+OTRLV)
      lkey=ibig(itre+OTRLK)
      linfo=ibig(itre+OTRLI)
      lres=ibig(itre+OTRNR)
      iptha=ibig(itre+OTRPA)+ilev
      ikeya=ibig(itre+OTRKY)+ilev
      istak=ibig(itre+OTRST)
      if(ibig(iptha).lt.0) pause 'trreadl: no current key'
      lux=ibig(itre+OTRUX)
      obotol=ibig(istak+OSTBM)
      call stakgt(istak,ibig(iptha),ibrec)
      obotnw=ibig(istak+OSTBM)
      if(obotnw.ne.obotol) pause 'trreadl: not working as expected'
      k=ibrec+2+ibig(ikeya)*la+lres+lkey+linfo
      if(lux.gt.0) then
        iend=lenlu(lux)
c ! get info from entry
        if(ibig(itre+OEXCH).lt.0) then
c ! nothing to read
          if(ibig(k+OEXAD).lt.0) then
            trreadl=0
            return
c ! find first record
          else
            ianex=ibig(k+OEXAD)
            nwnex=ibig(k+OEXLN)
          endif
c ! use info from last read
        else
c ! or write
          ianex=ibig(itre+OEXFP)
          nwnex=ibig(itre+OEXNW)
        endif
        trreadl=nwnex
      else
        pause 'trreadl: attempt to read from a non extendable entry'
        trreadl=0
      endif
      return
      end
