c---------------------------------------------------------------------

      subroutine drcpolyline()

      parameter (nbuf=20000)
      parameter (nind=2000)
      parameter (nout2=nbuf*2)
      common/cbuf/ip,is,xc,yc,ind(nind),xy(2,2,nind),buf(2,nbuf)
      dimension xny(nout2)
      equivalence (xny(1),buf(1,1))
      logical segop
      common/clog/segop

      do i=1,is
        call movea(buf(1,ind(i)),buf(2,ind(i)))
        do j=ind(i)+1,ind(i+1)-1
          call drawa(buf(1,j),buf(2,j))
        enddo
c        call tsend
      enddo
      call tsend()
      return
      end
