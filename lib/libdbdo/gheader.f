      subroutine gheader(jbuf,iy,id,ih,im,fs,nsamp,smpin,ibytdta)
      include 'seedparam.h'
      character*4 tpfmt
      common/vlprm/idvol,tpfmt,itpfmt
      integer*2 jbuf(*)
      double precision smpin

      if(itpfmt.eq.TPFIDAF) then
        pause 'ida format not implemented'
      else
        call gheader0(jbuf,iy,id,ih,im,fs,nsamp,smpin,ibytdta)
      endif
      return
      end
