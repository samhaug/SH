
c-------------------------------------------------------------------

      subroutine stakcr(lu,nstak,lstakr,lstakw,istadr)
      include "dblib.h"
      lstakb=lstakr+lstakw
c ! assure double words align
      if(mod(lstakb,2).eq.0) lstakb=1+lstakb
      isize=nstak*(lstakb+1)+NSTTB*nstak+LSTPK
      call balloc(isize,istadr)
c ! leave space for LSTPK values
      ioff=istadr+LSTPK
c ! make this one point to previous
c     write(6,*) 'stakcr: ibig(',istadr+OSTPP,') set to ',ipstak,' new=',istadr
      ibig(istadr+OSTPP)=ipstak
c ! make ipstak point to this one
      ipstak=istadr
c ! stack pointer to bottom of stack
      ibig(istadr+OSTBM)=nstak-1
c ! pointer to file pointer table
      ibig(istadr+OSTFT)=ioff+ISTFT*nstak
c ! buffer pointer to usage flags
      ibig(istadr+OSTUF)=ioff+ISTUF*nstak
c ! ptr to buffer pointer table
      ibig(istadr+OSTBT)=ioff+ISTBT*nstak
c ! ptr to 'above' pointer table
      ibig(istadr+OSTAB)=ioff+ISTAB*nstak
c ! ptr to 'below' pointer table
      ibig(istadr+OSTBL)=ioff+ISTBL*nstak
      ibig(istadr+OSTLU)=lu
c ! number of bytes to read and write
      ibig(istadr+OSTNB)=lstakr*4
c ! space for stack tables
      ioff=ioff+NSTTB*nstak
c ! assure double words align
      if(mod(ioff,2).eq.0) then
        ioff=ioff+1
        isize=isize+1
        call balloc(1,iadd)
      endif
c ! used to deallocate memory on close
      ibig(istadr+OSTSZ)=isize
      do i=0,nstak-1
c ! file pointer to nothing
        ibig(ibig(istadr+OSTFT)+i)=-1
c ! no valid rec
        ibig(ibig(istadr+OSTUF)+i)=-1
c ! address of change flag (+1)
        ibig(ioff)=ibig(istadr+OSTUF)+i
c ! space for address of change flag
        ioff=ioff+1
c ! pointer to i-th buffer
        ibig(ibig(istadr+OSTBT)+i)=ioff
        if(i.ne.0) then
c ! previous stack entry
          ibig(ibig(istadr+OSTAB)+i)=i-1
c ! is above this one

c ! this stack entry
          ibig(ibig(istadr+OSTBL)+i-1)=i
c ! is below previous one

        endif
c ! space for i-th buffer
        ioff=ioff+lstakb
      enddo
c ! last stack entry is above first
      ibig(ibig(istadr+OSTAB))=nstak-1
c ! first stack entry is below last
      ibig(ibig(istadr+OSTBL)+nstak-1)=0
      if(ioff.ne.isize+istadr) pause 'stakcr: addresses dont check'
      if(mod(ioff,2).ne.1) pause 'stakcr: alignment didnt work'
      return
      end
c-------------------------
      block data stakinit
      include "dblib.h"
      data ipstak/-1/
      end
