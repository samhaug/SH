      subroutine fetch(nord,iq,lord,kbuf,ifexst)
      character*1 iq,it,is
      integer*2 nrec,maxn,maxl
      common/eig1/n1,jcom1,l1,om1,q1,cgp1,avert1,ahor1,phis1
     1        ,u1(222),up1(222),v1(222),vp1(222),ph1(222),php1(222)
      common/eig2/n2,jcom2,l2,om2,q2,cgp2,avert2,ahor2,phis2
     1        ,u2(222),up2(222),v2(222),vp2(222),ph2(222),php2(222)
      common/get/nrec(500,2),maxn(500,2),maxl(2),llu
      data it,is/'t','s'/
      if(kbuf.ne.1.and.kbuf.ne.2) stop 'error 7 in fetch'
      ifexst=0
      itors=0
      if(iq.eq.it) itors=1
      if(iq.eq.is) itors=2
      if(itors.ne.1.and.itors.ne.2) pause 'error 5 in fetch'
      itemp=maxl(itors)
      if(lord.gt.itemp) goto 99
      ind=lord+1
      itemp=maxn(ind,itors)
      if(nord.gt.itemp) goto 99
      nr=nrec(ind,itors)+nord
c     call sysio(ipblk,92,llu,n,532,nr)
c     call ioerr(ipblk,ier)
      if(kbuf.eq.1) then
        call bffi(llu,1,n1,1341*4,jstat,nread,nr)
        call byswap4(n1,1341)
        jcom=jcom1
        l=l1
        n=n1
      else
        call bffi(llu,1,n2,1341*4,jstat,nread,nr)
        call byswap4(n2,1341)
        jcom=jcom2
        l=l2
        n=n2
      endif
      if(n.ne.nord) pause 'error 1 in fetch'
      if(iq.eq.it.and.jcom.ne.2) pause 'error 2 in fetch'
      if(iq.eq.is.and.l.eq.0.and.jcom.ne.1) pause 'error 3 in fetch'
      if(iq.eq.is.and.l.ne.0.and.jcom.ne.3) pause 'error 4 in fetch'
      if(lord.ne.l) pause 'error 6 in fetch'
      ifexst=1
c     write(6,1234)n1,jcom1,l1,om1,q1,cgp1,avert1,ahor1,phis1
c    1            ,n2,jcom2,l2,om2,q2,cgp2,avert2,ahor2,phis2
 1234 format(3i3,6e10.3)
c     write(6,1233)
 1233 format('?')
c     read(5,1232)ijk
 1232 format(i2)
c     if(ijk.eq.0)goto 99

c     write(6,1235)(u1(i),up1(i),v1(i),vp1(i),ph1(i),php1(i),
c    1              u2(i),up2(i),v2(i),vp2(i),ph2(i),php2(i),i=1,222)
c1235 format(6e12.5)

   99 return
      end
