
c-------------------------------------------------------------------

      subroutine traddk(itre,key,lkey,info,linfo)
      dimension key(*),info(*)
      include "dblib.h"
      logical trfind

      ilev=ibig(itre+OTRLV)
      la=ibig(itre+OTRKO)
      nwds=2+ibig(itre+OTROR)*la
      istak=ibig(itre+OTRST)
      lu=ibig(ibig(itre+OTRST)+OSTLU)
      nbyts=ibig(ibig(itre+OTRST)+OSTNB)
      call balloc(la,jb)
      k=jb
      do i=1,lkey
        ibig(k)=key(i)
        k=k+1
      enddo
      do i=1,linfo
        ibig(k)=info(i)
        k=k+1
      enddo
c ! key is created without extension
      if(ibig(itre+OTRUX).ge.0) then
        ibig(k+OEXAD)=-1
        ibig(k+OEXLN)=0
        ibig(k+OEXAP)=-1
        k=k+LEXPK
      endif
      ibig(k)=-1
      k=k+1
      if(4*(nwds-la).ne.nbyts) pause 'traddk: wrong record length'
      if(lkey.ne.ibig(itre+OTRLK)) pause 'traddk: key wrong length'
      if(linfo.ne.ibig(itre+OTRLI)+ibig(itre+OTRNR))
     1    pause 'traddk: info wrong length'
  100 ilev=ilev-1
c ! create new root
      if(ilev.lt.0) then
c       call stakap(ibig(itre+OTRST),ifadr,ia)
        call stakap(istak,ifadr,ia)
CD        write(6,"('  root ',$)")
c ! nkey
        ibig(ia)=1
c ! pointer to old root
        ibig(ia+1)=ibig(itre+OTRFR)
        k=ia+2
        do i=0,la-1
          ibig(k)=ibig(jb+i)
          k=k+1
        enddo
        call staktc(istak)
c ! address of new root
        ibig(itre+OTRFR)=ifadr
        itref=ibig(itre+OTRFA)
c ! look for father
        if(itref.ge.0) then
          if(trfind(itref,ibig(itre+OTRNM)
     1      ,ibig(itre+OTRLN),iok,ioi)) then
            ibig(iok+ibig(itref+OTRLK))=ifadr
            call trtuch(itref)
          else
            pause 'addrotr: father not found'
          endif
        else
c ! update root file address
          call bffobs4(lu,1,ifadr,4,j,ODRFR*4+1)
        endif
        goto 99
      else
        call stakgt(istak,ibig(ibig(itre+OTRPA)+ilev),ia)
        ld=2+ibig(ibig(itre+OTRKY)+ilev)*la
c ! move keys
        do i=1+ibig(ia)*la,ld,-1
          ibig(ia+i+la)=ibig(ia+i)
        enddo
        k=ld+ia
c ! insert jbuf
        do i=0,la-1
          ibig(k)=ibig(jb+i)
          k=k+1
        enddo
        nkey=1+ibig(ia)
        ibig(ia)=nkey
c       call staktc(ia)
        call staktc(istak)
c ! split the node
        if(nkey.eq.ibig(itre+OTROR)) then
CD          write(6,"('  split',$)")
          nkey=nkey/2
          ibig(ia)=nkey
c         call staktc(ia)
          call staktc(istak)
          ld=nkey*la+2
          do i=0,la-2
            ibig(jb+i)=ibig(ia+ld+i)
          enddo
          call balloc(nwds,ic)
          do i=0,nwds-1
            ibig(ic+i)=ibig(ia+i)
          enddo
          call stakap(istak,ifadr,ib)
          ibig(jb+la-1)=ifadr

          ibig(ib)=ibig(itre+OTROR)-nkey-1
          ishf=(nkey+1)*la
          nmove=ibig(ib)*la+2
          do i=1,nmove-1
            ibig(ib+i)=ibig(ic+ishf+i)
          enddo
c         call staktc(ib)
          call staktc(istak)
          call dalloc(nwds,ic)
          goto 100
        endif
      endif
   99 call dalloc(la,jb)
      ibig(itre+OTRLV)=ilev
      return
      end
