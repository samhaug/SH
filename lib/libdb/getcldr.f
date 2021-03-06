c--------------------------------------------------------------------
      logical function getcldr(itre,mscldr,mtcldr,itim,idir,ktim,key,lkey,irank)
      dimension itim(2),ktim(2),key(*)
      include 'dblib.h'
      integer*4 START,STOP,CONTINUE
      parameter(STOP=z'00004000',START=z'00008000',CONTINUE=z'0000c000')
      logical getcldr0
      getcldr=.FALSE.
      linfo=ibig(itre+OTRLI)
      if(irank.gt.0) then
        if(getcldr0(itre,mscldr,mtcldr,itim,idir,iok,ioi,irank,iad)) then
          ktim(1)=ibig(iok)
          ktim(2)=ibig(iok+1)
          do i=1,lkey
            key(i)=ibig(ioi+i-1)
          enddo
          getcldr=.TRUE.
        endif
      else if(irank.eq.-1) then
        if(getcldr0(itre,mscldr,mtcldr,itim,idir,iok,ioi,irank,iad)) then
          nseen=ibig(iad)
          mrank=0
          if(idir.lt.0) then
            ktest=STOP
          else if(idir.gt.0) then
            ktest=START
          endif
          nseen=ibig(iad)
          mrank=0
          do i=1,nseen
            ll=ibig(iad+(i-1)*(linfo+2)+2)
            lrank=and(ll,z'00000fff')
            lstat=and(ll,CONTINUE)
            if(lrank.gt.mrank.and.lstat.ne.ktest) then
              mrank=lrank
              iok=iad+(i-1)*(linfo+2)+1
              ioi=iok+2
            endif
          enddo
          irank=mrank
          if(irank.ne.0) then
            getcldr=.TRUE.
            ktim(1)=ibig(iok)
            ktim(2)=ibig(iok+1)
            do i=1,lkey
              key(i)=ibig(ioi+i-1)
            enddo
          else
            getcldr=.FALSE.
          endif
        else
          getcldr=.FALSE.
          nseen=ibig(iad)
          if(nseen.gt.0) then
            ll=ibig(iad+2)
            irank=and(ll,z'00000fff')
            iok=iad+1
            ioi=iok+2
            ktim(1)=ibig(iok)
            ktim(2)=ibig(iok+1)
            do i=1,lkey
              key(i)=ibig(ioi+i-1)
            enddo
          else
            irank=0
          endif

        endif
      endif
      return
      end
