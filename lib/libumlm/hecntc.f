      subroutine hecntc(grid,igrid,ikx,iky,klin,ilin,nshd,z1,z2
     1    , i1,i2,j1,j2)
      dimension grid(igrid,1),ilin(nshd)
c      parameter (MXXYBUF=50000)
c      dimension xy(2,MXXYBUF),wk(MXXYBUF),ind(1000),ilev(1000)
c     1 ,cxy(2,3000)
c      external mapfun
c      gsave=grid(1,1)
c      call twindo(i1,i2,j1,j2)
c      call dwindo(0.,1.,0.,1.)
c      is=0
c      call joicntconfig(1000,100,1000)
c      call hecntconfig(100,2000,4000,1000,0)


      parameter (MXXYBUF=250000)
      dimension xy(2,MXXYBUF),wk(MXXYBUF),ind(5000),ilev(5000)
     1 ,cxy(2,15000)
      external mapfun
      gsave=grid(1,1)
      call twindo(i1,i2,j1,j2)
      call dwindo(0.,1.,0.,1.)
      is=0
      call joicntconfig(5000,500,5000)
      call hecntconfig(500,10000,20000,5000,0)


      call hecnti(grid,igrid,ikx,iky,nshd,z1,z2,0.,1.,1.,0.
     1      ,0,cxy(1,1),cxy(2,1),2,npts,0,mapfun
     1      ,xy(1,1),xy(2,1),2,MXXYBUF,is,ind,ilev,1000,wk,MXXYBUF)
      call linwdt(klin)
      if(is.eq.1) ilev(1)=1.+(gsave-z1)*float(nshd)/(z2-z1)
c     write(6,"('grid,z1,z2,nshd,ilev'
c    1  ,1p3e13.4,3i6)") grid(1,1),z1,z2,nshd,ilev(1)
      do i=1,is
      itex=min0(nshd,max0(1,ilev(i)))
      call filcol(ilin(itex))
      call polyfil(1,xy(1,ind(i)),xy(2,ind(i)),2,ind(i+1)-ind(i))
      enddo
      call tsend
      return
      end
