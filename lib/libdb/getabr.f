
c-------------------------------------------------------------------

      logical function getabr(itrabr,id,buf,nbgot)
      include 'dblib.h'
      character*(*) buf
      logical trfind
      integer trread
      lbuf=len(buf)
      if(trfind(itrabr,id,1,iok,ioi)) then
        nbgot=ibig(ioi)
        if(nbgot.gt.lbuf) pause 'getabr: buffer too small'
        nw=(nbgot+3)/4
        call balloc(nw,io)
        kw=trread(itrabr,ibig(io),nw)
        if(kw.ne.nw) pause 'getabr: wrong length'
        do i=1,nbgot
          buf(i:i)=cbig(io*4+i-1)
        enddo
        call dalloc(nw,io)
        getabr=.TRUE.
      else
        getabr=.FALSE.
      endif
      return
      end
