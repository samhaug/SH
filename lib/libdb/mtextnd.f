      subroutine mtextnd(itcldr,mscldr,mtcldr,itim)
c
c     Extends maximum time for a calendar tree
c     by adding CONTINUE entries for all active streams
c
      dimension itim(2),jtim(2),ktim(2)
      include 'dblib.h'
      integer*4 START,STOP,CONTINUE
      parameter(STOP=z'00004000',START=z'00008000',CONTINUE=z'0000c000')
      logical getcldr0,trfind
      if(mscldr.eq.0) return
      linfo=ibig(itcldr+OTRLI)
      ktim(1)=itim(1)+1
      ktim(2)=0
      if(ktim(1).le.mtcldr) pause 'mtextnd: invalid time'
      jtim(1)=mtcldr
      jtim(2)=0
      if(getcldr0(itcldr,mscldr,mtcldr,jtim,-1,iok,ioi,-1,iad)) then
        nseen=ibig(iad)
        call balloc(1+nseen*(linfo+2),iadnseen)
        if(iadnseen.ne.iad) pause 'mtextnd: wrong address'
        do i=1,nseen
          jtim(2)=ibig(iad+(i-1)*(linfo+2)+2)
          lstat=and(jtim(2),CONTINUE)
          if(lstat.ne.STOP) then
            jtim(1)=ibig(iad+(i-1)*(linfo+2)+1)+mscldr
            jtim(2)=or(jtim(2),CONTINUE)
            do while(itcmp(jtim,ktim).lt.0)
              if(trfind(itcldr,jtim,2,iok,ioi)) then
                do j=0,linfo-1
                  ibig(ioi+j)=ibig(iad+(i-1)*(linfo+2)+3+j)
                enddo
                call trtuch(itcldr)
              else
                call traddk(itcldr,jtim,2,ibig(iad+(i-1)*(linfo+2)+3),linfo)
              endif
              jtim(1)=jtim(1)+mscldr
            enddo

          endif
        enddo
        call dalloc(1+nseen*(linfo+2),iadnseen)
      endif
      mtcldr=ktim(1)
      return
      end
