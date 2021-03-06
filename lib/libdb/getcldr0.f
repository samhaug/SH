c--------------------------------------------------------------------
      logical function getcldr0(itcldr,mscldr,mtcldr,itim,idir,iok,ioi,irank,iad)
c
c     Searches forward or backward in a calendar (idir=1 or -1).
c     Results are stored in an ephemeral space in ibig, so that
c     subsequent processing is possible if it is done immediately
c     (se e.g. mtextnd).
c        If irank is a positive integer the search
c           terminates when an entry for that stream is found.
c        If irank equals -1
c           the search terminates when the time interval mscldr has been
c           traversed -- thus ensuring that an entry is found for all streams
c           which are active.
c        If irank equals -2
c           the search continues until a START (idir=-1) or STOP (idir=1)
c           entry is found for all active streams.
c     The value of the function is true if and only if
c     at least one stream is found to be active at itim.
c
      integer*4 itim(2)
      include 'dblib.h'
      integer*4 START,STOP,CONTINUE,LARGE,SMALL
      parameter(STOP=z'00004000',START=z'00008000',CONTINUE=z'0000c000')
      parameter (LARGE=z'0000ffff',SMALL=z'00000000')
      integer*4 jtim(2),jtes(2)
      logical trfind,trnext,first,quit
      linfo=ibig(itcldr+OTRLI)

      if(itim(1).ge.mtcldr) then
        jtim(1)=mtcldr
        jtim(2)=0
      else
        jtim(1)=itim(1)
        jtim(2)=and(itim(2),z'ffff0000')
      endif
      jtes(2)=jtim(2)
      if(idir.lt.0) then
        jtim(2)=or(jtim(2),LARGE)
        ktest=STOP
        ltest=START
        jtes(1)=jtim(1)-mscldr
        iflag=-1
      else if(idir.gt.0) then
        jtim(2)=or(jtim(2),SMALL)
        ktest=START
        ltest=STOP
        jtes(1)=jtim(1)+mscldr
        iflag=1
      else
        pause 'getcldr0: idir invalid'
      endif
      if(trfind(itcldr,jtim,2,iok,ioi)) 
     1     pause 'getcldr0: key with extreme rank and status found'
      getcldr0=.FALSE.
      call balloc(1,iadnseen)
      ibig(iadnseen)=0
      nseen=0
      do while(trnext(itcldr,idir,iok,ioi))
        krank=and(ibig(iok+1),z'00000fff')
        first=.FALSE.
        do i=1,nseen
          iad=iadnseen+(i-1)*(linfo+2)+1
          lrank=and(ibig(iad+1),z'00000fff')
          if(lrank.eq.krank) then
            if(irank.eq.-2) then
              lstat=and(ibig(iad+1),CONTINUE)
              if(lstat.eq.CONTINUE) then
                if(icmpky(ibig(iad+2),ibig(ioi),linfo).eq.0) then
                  ibig(iad)=ibig(iok)
                  ibig(iad+1)=ibig(iok+1)
                endif
              endif
            endif
            goto 101
          endif
        enddo
        first=.TRUE.
        nseen=nseen+1
        call balloc(linfo+2,iad)
        ibig(iad)=ibig(iok)
        ibig(iad+1)=ibig(iok+1)
        do i=0,linfo-1
          ibig(iad+2+i)=ibig(ioi+i)
        enddo
  101   continue
        kstat=and(ibig(iok+1),CONTINUE)
        if(krank.eq.irank) then
          if(kstat.ne.ktest) then
            getcldr0=.TRUE.
          endif
          goto 99
        else if(irank.lt.0) then
          if(first.and.kstat.ne.ktest) getcldr0=.TRUE.
        endif
        quit=.FALSE.
        if(ibig(iok).ne.z'7fffffff'.and.itcmp(ibig(iok),jtes).eq.iflag) quit=.TRUE.
        if(quit.and.irank.eq.-2) then

          do i=1,nseen
            iad=iadnseen+(i-1)*(linfo+2)+1
            lstat=and(ibig(iad+1),CONTINUE)
            if(lstat.eq.CONTINUE) quit=.FALSE.
          enddo
        endif
        if(quit) goto 99
      enddo
   99 continue
      ibig(iadnseen)=nseen
      iad=iadnseen
      call dalloc(1+nseen*(linfo+2),iadnseen)
      return
      end
