c------------------------------------------------------------------------
      integer function srespsetup(cbuf,iopt,knts,m,mps,mpsps,nmps,ibig,rbig,maxsp)

c     cbuf                A character string containing
c                         SEED blockettes 052, 053, 054, 058, 061
c
c     iopt                Integer switch determining how the response
c                         is to be evaluated:
c                         iopt=0  Complete response, including all stages
c                               and applied delays from the decimation 
c                               blockettes. [Although this is the way
c                               SEED responses should (I think) be evaluated
c                               it will usually give incorrect group delays
c                               because the 'Correction applied' fields in
c                               blockettes 057 are usually incorrect or absent]
c                         iopt=1  Response will be evaluated using only stage 1
c                               and the overall sensitivity. If an overall
c                               sensitivity (i.e. 058 stage 0) is not given
c                               the stage sensitivities of all stages are used
c                               to determine the overall sensitivity
c                         iopt=2  The same as iopt=0, except that the given
c                               applied corrections in FIR stages are ignored
c                               and are replaced by delays equivalent to the
c                               centroid time of the FIR coefficients.
c                               This seems to be the most reliable way of
c                               calculating the response if it is needed near the
c                               Nyquist frequency. The amplitude response should
c                               agree with the iopt=0 case, and the whole response
c                               should approximate the iopt=1 case at frequencies
c                               far below the Nyquist frequency
c      knts,m,mps,mpsps,  Integers specifying the abbreviation codes used in
c      nmps               cbuf to indicate 'counts', 'metres', 'metres per second',
c                         'metres per second per second' and 'nanometres per second,
c                         respectively.
c      ibig,rbig          An array which will be used to
c                         store numerical results, later used in the
c                         evaluation of the response. ibig and rbig can occupy
c                         the same storage in the calling program.
c      maxsp              Available space in ibig,rbig in (4-byte) words.
c                         If this space is exceeded the program will stop
c                         with an error message.
c      srespsetup         Returned value indicates the number of words used in
c                         ibig,rbig
c      common/plevel/iprtlv
c                         If  iprtlv.gt.1 srespsetup prints a short response table
c                         on logical unit 6 (stdout).
c                                                          
c                         Please report problems, suggestions etc. to 
c                         john@earth.ox.ac.uk (John Woodhouse).      
c
c
c

      dimension ibig(0:*),rbig(0:*)
      character*(*) cbuf
      include 'seedparam.h'
      common/plevel/iprtlv
      parameter (LENFLT=1)
      include 'rspaddrs.h'
      character*1 str1,symc
      character*3 cod,codl
      complex stgres
      common/rspsgs/stgres(20),stgdly(20)


      dimension ftest(13)
      data ftest
     1               /00.002
     1               ,00.004
     1               ,00.010
     1               ,00.020
     1               ,00.040
     1               ,00.100
     1               ,00.200
     1               ,00.500
     1               ,01.000
     1               ,02.000
     1               ,05.000
     1               ,10.000
     1               ,20.000/
      data ntest/13/
      data tpi/6.2831853/
      complex cratio,crat,resp(0:2),sresp
      character*1 star
      character*32 str32

      lencbuf=len(cbuf)
      codl='xxx'
      io=0
      ibig(IRSNCS)=0                      !  number in cascade
      rbig(FRSOSN)=0.                     !  overall sensitivity
      rbig(FRSFOV)=0.                     !  frequency
      cod=cbuf(io+1:io+3)
      io=io+3
      if(cod.ne.'052') pause 'srespsetup: expected code 052'
      read(cbuf(io+1:io+4),'(i4)') inum



      io=io+4
      call loadchr(ibig(IRSLID),1,cbuf(io+1:io+2))
      io=io+2
      call loadchr(ibig(IRSCID),1,cbuf(io+1:io+3))
      io=io+3
      read(cbuf(io+1:io+4),"(i4)") ibig(IRSSUB)
      io=io+4
      read(cbuf(io+1:io+3),"(i3)") inst
      io=io+3
      call getstr(cbuf,io,str32,lstr32)
      call loadchr(ibig(IRSOCM),8,str32(1:lstr32))
      read(cbuf(io+1:io+3),"(i3)") iunsig
      io=io+3
      read(cbuf(io+1:io+3),"(i3)") iuncal
      io=io+3
      read(cbuf(io+1:io+10),"(f10.6)") rbig(FRSLAT)
      io=io+10
      read(cbuf(io+1:io+11),"(f11.6)") rbig(FRSLON)
      io=io+11
      read(cbuf(io+1:io+7),"(f7.1)") rbig(FRSELV)
      io=io+7
      read(cbuf(io+1:io+5),"(f5.1)") rbig(FRSDEP)
      io=io+5
      read(cbuf(io+1:io+5),"(f5.1)") rbig(FRSAZM)
      io=io+5
      read(cbuf(io+1:io+5),"(f5.1)") rbig(FRSDIP)
      io=io+5
      read(cbuf(io+1:io+4),"(i4)") iform
      io=io+4
      io=io+2
      read(cbuf(io+1:io+10),"(e10.4)") rbig(FRSSRT)
      io=io+10
      read(cbuf(io+1:io+10),"(e10.4)") rbig(FRSDRF)


      io=inum
      if(io.eq.lencbuf) then
        write(6,*) 'srespsetup: Warning: No response'
        srespsetup=ILENRS
        return
      endif

      do while(io.lt.lencbuf)
        cod=cbuf(io+1:io+3)
        io=io+3
        read(cbuf(io+1:io+4),'(i4)') inum
        io=io+4
        if(cod.eq.'053') then
          read(cbuf(io+1:io+36),'(a1,i2,2i3,2e12.5,i3)')
     1       str1,icas,irui,iruo,aonorm,fnorm,nz
          io=io+36
          if(icas.eq.1.and.irui.ne.iunsig) then
            write(6,*) 'srespsetup: Warning: units in stage 1 inconsistent'
          endif
          if(irui.eq.knts) then
            irui=SUNCNT
          else if(irui.eq.m) then
            irui=SUNM
          else if(irui.eq.mps) then
            irui=SUNMPS
          else if(irui.eq.mpsps) then
            irui=SUNMPS2
          else if(irui.eq.nmps) then
            irui=SUNNMPS
          endif
          if(iruo.eq.knts) then
            iruo=SUNCNT
          else if(iruo.eq.m) then
            iruo=SUNM
          else if(iruo.eq.mps) then
            iruo=SUNMPS
          else if(iruo.eq.mpsps) then
            iruo=SUNMPS2
          else if(iruo.eq.nmps) then
            iruo=SUNNMPS
          endif


          if(aonorm.eq.0.) aonorm=1.
          if(icas.eq.1+ibig(IRSNCS)) then
             ibig(IRSNCS)=icas
          else
            pause 'Cascade response out of sequence'
          endif

          if(icas.eq.1) then
            ipil=0
            ipi=ILENRS
            ipf=FLENRS
          else
            ipil=ipi
            ipi=ibig(ipi+ISGADN)
            ipf=ipi/LENFLT
          endif

          ibig(ipi+ISGADL)=ipil
          rbig(ipf+FSGGAI)=0.
          rbig(ipf+FSGFGA)=0.
          ibig(ipi+ISGDCF)=1
          ibig(ipi+ISGDCO)=0
          rbig(ipf+FSGEDL)=0.
          rbig(ipf+FSGCAP)=0.
          rbig(ipf+FSGINR)=0.
          ibig(ipi+ISGPZC)=STRPZS  
          ibig(ipi+ISGABD)=locltft(str1)
          ibig(ipi+ISGINU)=irui
          ibig(ipi+ISGOUU)=iruo
          rbig(ipf+FSGAZE)=aonorm
          rbig(ipf+FSGFAZ)=fnorm
          ibig(ipi+ISGNTP)=nz
          ibig(ipi+ISGLNT)=2*nz
          ipf1=ipf+FLENSG
          do i=1,nz
            read(cbuf(io+1:io+24),'(2e12.5)') rbig(ipf1),rbig(ipf1+1)
            io=io+48
            ipf1=ipf1+2
          enddo
          read(cbuf(io+1:io+3),'(i3)') np
          io=io+3
          ibig(ipi+ISGNBT)=np
          do i=1,np
            read(cbuf(io+1:io+24),'(2e12.5)') rbig(ipf1),rbig(ipf1+1)
            io=io+48
            ipf1=ipf1+2
          enddo
          ibig(ipi+ISGADN)=ipf1*LENFLT

        else if(cod.eq.'054') then

          read(cbuf(io+1:io+13),'(a1,i2,2i3,i4)') str1,icas,irui,iruo,nnum
          io=io+13
          if(icas.eq.1.and.irui.ne.iunsig) then
            write(6,*)  'srespsetup: Warning: inconsistent units'
          endif
          if(irui.eq.knts) then
            irui=SUNCNT
          else if(irui.eq.m) then
            irui=SUNM
          else if(irui.eq.mps) then
            irui=SUNMPS
          else if(irui.eq.mpsps) then
            irui=SUNMPS2
          else if(irui.eq.nmps) then
            irui=SUNNMPS
          endif
          if(iruo.eq.knts) then
            iruo=SUNCNT
          else if(iruo.eq.m) then
            iruo=SUNM
          else if(iruo.eq.mps) then
            iruo=SUNMPS
          else if(iruo.eq.mpsps) then
            iruo=SUNMPS2
          else if(iruo.eq.nmps) then
            iruo=SUNNMPS
          endif

          if(icas.eq.1+ibig(IRSNCS)) then
            ibig(IRSNCS)=icas
            if(icas.eq.1) then
              ipil=0
              ipi=ILENRS
              ipf=FLENRS
            else
              ipil=ipi
              ipi=ibig(ipi+ISGADN)
              ipf=ipi/LENFLT
            endif

            ibig(ipi+ISGADL)=ipil
            rbig(ipf+FSGGAI)=0.
            rbig(ipf+FSGFGA)=0.
            ibig(ipi+ISGDCF)=1
            ibig(ipi+ISGDCO)=0
            rbig(ipf+FSGEDL)=0.
            rbig(ipf+FSGCAP)=0.
            rbig(ipf+FSGINR)=0.
            ibig(ipi+ISGPZC)=STRCOF  
            ibig(ipi+ISGABD)=locltft(str1)
            ibig(ipi+ISGINU)=irui
            ibig(ipi+ISGOUU)=iruo
            rbig(ipf+FSGAZE)=1.0
            rbig(ipf+FSGFAZ)=0.0
            ibig(ipi+ISGNTP)=nnum
            ibig(ipi+ISGLNT)=nnum
            ipf1=ipf+FLENSG
            do i=1,nnum
              read(cbuf(io+1:io+12),'(e12.5)') rbig(ipf1)
              io=io+24
              ipf1=ipf1+1
            enddo
            read(cbuf(io+1:io+4),'(i4)') nden
            io=io+4
            ibig(ipi+ISGNBT)=nden
            do i=1,nden
              read(cbuf(io+1:io+12),'(e12.5)') rbig(ipf1)
              io=io+24
              ipf1=ipf1+1
            enddo
            ibig(ipi+ISGADN)=ipf1*LENFLT

          else if(icas.eq.ibig(IRSNCS).and.cod.eq.codl) then ! a continuation -- ho hum
            ip0=ibig(ipi+ISGADN)
            if(ibig(ipi+ISGPZC).ne.STRCOF) pause 'srespsetup: invalid continuation coefficients'
            if(ibig(ipi+ISGABD).ne.locltft(str1)) pause 'srespsetup: invalid continuation type'
            if(ibig(ipi+ISGINU).ne.irui) pause 'srespsetup: invalid continuation in-units'
            if(ibig(ipi+ISGOUU).ne.iruo) pause 'srespsetup: invalid continuation out-units'
            nnum0=ibig(ipi+ISGNTP)
            ibig(ipi+ISGNTP)=nnum0+nnum
            ibig(ipi+ISGLNT)=nnum0+nnum
            nden0=ibig(ipi+ISGNBT)
            ipf1=ipf+FLENSG+nnum0
            do i=nden0-1,0,-1               ! move previous denominator coefficients
              rbig(ipf1+i+nnum) = rbig(ipf1+i)
            enddo
            do i=1,nnum
              read(cbuf(io+1:io+12),'(e12.5)') rbig(ipf1)
              io=io+24
              ipf1=ipf1+1
            enddo
            read(cbuf(io+1:io+4),'(i4)') nden
            io=io+4
            ibig(ipi+ISGNBT)=nden0+nden
            ipf1=ipf1+nden0                  ! skip previous denominator coefficients
            do i=1,nden
              read(cbuf(io+1:io+12),'(e12.5)') rbig(ipf1)
              io=io+24
              ipf1=ipf1+1
            enddo
            ibig(ipi+ISGADN)=ipf1*LENFLT
            if(ibig(ipi+ISGADN).ne.ip0+(nden+nnum)*LENFLT)
     1              pause 'srespsetup: continuation -- invalid address'
          else
            pause 'Cascade response out of sequence'
          endif









        else if(cod.eq.'061') then

          read(cbuf(io+1:io+2),'(i2)') icas
          io=io+2
          call getstr(cbuf,io,str32,lstr32)
          read(cbuf(io+1:io+1),'(a1)') symc  ! symmetry code
          io=io+1
          read(cbuf(io+1:io+10),'(2i3,i4)') irui,iruo,nnumsy
          io=io+10
          str1='D'
          if(icas.eq.1.and.irui.ne.iunsig) then
            write(6,*)  'srespsetup: Warning: inconsistent units'
          endif
          if(irui.eq.knts) then
            irui=SUNCNT
          else if(irui.eq.m) then
            irui=SUNM
          else if(irui.eq.mps) then
            irui=SUNMPS
          else if(irui.eq.mpsps) then
            irui=SUNMPS2
          else if(irui.eq.nmps) then
            irui=SUNNMPS
          endif
          if(iruo.eq.knts) then
            iruo=SUNCNT
          else if(iruo.eq.m) then
            iruo=SUNM
          else if(iruo.eq.mps) then
            iruo=SUNMPS
          else if(iruo.eq.mpsps) then
            iruo=SUNMPS2
          else if(iruo.eq.nmps) then
            iruo=SUNNMPS
          endif

          if(icas.eq.1+ibig(IRSNCS)) then
            ibig(IRSNCS)=icas
            if(icas.eq.1) then
              ipil=0
              ipi=ILENRS
              ipf=FLENRS
            else
              ipil=ipi
              ipi=ibig(ipi+ISGADN)
              ipf=ipi/LENFLT
            endif
            if(symc.eq.'A') then
              nnum=nnumsy
              ibbias=0
            else if(symc.eq.'B') then
              nnum=2*nnumsy-1
              ibbias=2
            else if(symc.eq.'C') then
              nnum=2*nnumsy-1
              ibbias=1
            else
              stop 'srespsetup: invalid symmetry code'
            endif

            ibig(ipi+ISGADL)=ipil
            rbig(ipf+FSGGAI)=0.
            rbig(ipf+FSGFGA)=0.
            ibig(ipi+ISGDCF)=1
            ibig(ipi+ISGDCO)=0
            rbig(ipf+FSGEDL)=0.
            rbig(ipf+FSGCAP)=0.
            rbig(ipf+FSGINR)=0.
            ibig(ipi+ISGPZC)=STRCOF  
            ibig(ipi+ISGABD)=locltft(str1)
            ibig(ipi+ISGINU)=irui
            ibig(ipi+ISGOUU)=iruo
            rbig(ipf+FSGAZE)=1.0
            rbig(ipf+FSGFAZ)=0.0
            ibig(ipi+ISGNTP)=nnum
            ibig(ipi+ISGLNT)=nnum
            ipf1=ipf+FLENSG
            do i=1,nnumsy
              read(cbuf(io+1:io+14),'(e14.7)') rbig(ipf1)
              io=io+14
              ipf1=ipf1+1
            enddo
            ipf2=ipf1-ibbias
            do i=nnumsy+1,nnum
              rbig(ipf1)=rbig(ipf2)
              ipf1=ipf1+1
              ipf2=ipf2-1
            enddo
            nden=0
            ibig(ipi+ISGNBT)=nden
            ibig(ipi+ISGADN)=ipf1*LENFLT

          else if(icas.eq.ibig(IRSNCS).and.cod.eq.codl) then ! a continuation -- ho hum
            stop 'srespsetup: continuation of blockette 061 not implemented'
          else
            pause 'Cascade response out of sequence'
          endif








        else if(cod.eq.'057') then
          read(cbuf(io+1:io+44),'(i2,e10.3,2i5,2e11.4)')
     1         icas,spsin,idecfac,idecoff,estdly,apldly
          io=io+44
          if(icas.eq.0) then
            write(6,*) 'srespsetup: Warning: Decimation at stage 0 ignored'
          else
            if(icas.ne.ibig(IRSNCS)) then
              if(icas.eq.ibig(IRSNCS)+1) then
                ibig(IRSNCS)=icas

                if(icas.eq.1) then
                  ipil=0
                  ipi=ILENRS
                  ipf=FLENRS
                else
                  ipil=ipi
                  ipi=ibig(ipi+ISGADN)
                  ipf=ipi/LENFLT
                endif

                ibig(ipi+ISGADL)=ipil
                rbig(ipf+FSGGAI)=0.
                rbig(ipf+FSGFGA)=0.
                ibig(ipi+ISGDCF)=1
                ibig(ipi+ISGDCO)=0
                rbig(ipf+FSGEDL)=0.
                rbig(ipf+FSGCAP)=0.
                rbig(ipf+FSGINR)=0.
                ibig(ipi+ISGPZC)=STRPZS  
                ibig(ipi+ISGABD)=locltft('A')
                ibig(ipi+ISGINU)=iruo
                ibig(ipi+ISGOUU)=iruo
                rbig(ipf+FSGAZE)=1.0
                rbig(ipf+FSGFAZ)=0.0
                ibig(ipi+ISGNTP)=0
                ibig(ipi+ISGLNT)=0
                ibig(ipi+ISGNBT)=0
                ipf1=ipf+FLENSG
              else
                write(6,*) 'icas',icas,ibig(IRSNCS),sens,fsens
                pause 'gain out of sequence'
              endif

            endif
            ibig(ipi+ISGDCF)=idecfac
            ibig(ipi+ISGDCO)=idecoff
            rbig(ipf+FSGEDL)=estdly    
            rbig(ipf+FSGCAP)=apldly
            rbig(ipf+FSGINR)=spsin
            ibig(ipi+ISGADN)=ipf1*LENFLT
          endif


        else if(cod.eq.'058') then

          read(cbuf(io+1:io+28),'(i2,2e12.5,i2)') icas,sens,fsens,ncal
          io=io+28
          ignore=0
          if(icas.eq.0) then
            rbig(FRSOSN)=sens
            rbig(FRSFOV)=fsens
          else
            if(icas.ne.ibig(IRSNCS)) then
              if(icas.eq.ibig(IRSNCS)+1) then
                ibig(IRSNCS)=icas



                if(icas.eq.1) then
                  ipil=0
                  ipi=ILENRS
                  ipf=FLENRS
                else
                  ipil=ipi
                  ipi=ibig(ipi+ISGADN)
                  ipf=ipi/LENFLT
                endif

                ibig(ipi+ISGADL)=ipil
                rbig(ipf+FSGGAI)=0.
                rbig(ipf+FSGFGA)=0.
                ibig(ipi+ISGDCF)=1
                ibig(ipi+ISGDCO)=0
                rbig(ipf+FSGEDL)=0.
                rbig(ipf+FSGCAP)=0.
                rbig(ipf+FSGINR)=0.
                ibig(ipi+ISGPZC)=STRPZS  
                ibig(ipi+ISGABD)=locltft('A')
                ibig(ipi+ISGINU)=iruo
                ibig(ipi+ISGOUU)=iruo
                rbig(ipf+FSGAZE)=1.0
                rbig(ipf+FSGFAZ)=0.0
                ibig(ipi+ISGNTP)=0
                ibig(ipi+ISGLNT)=0
                ibig(ipi+ISGNBT)=0
                ipf1=ipf+FLENSG

              else
                write(6,*) '*** Warning *** Gain out of sequence: Ignored'
                write(6,*) 'icas',icas,ibig(IRSNCS),sens,fsens
                ignore=1
              endif
            endif
            if(ignore.eq.0) then
              rbig(ipf+FSGGAI)=sens
              rbig(ipf+FSGFGA)=fsens
            endif
          endif
          do i=1,ncal
            io=io+24
            call gettim(cbuf,io,iyear,jday,ihr,min,fsec)
          enddo
          ibig(ipi+ISGADN)=ipf1*LENFLT
        else
          ierr=5
          write(6,*) 'srespsetup: error',ierr,' code: "'//cod//'"'
          pause
        endif
        codl=cod
      enddo
      srespsetup=ibig(ipi+ISGADN)
      srespsetup=srespsetup+mod(srespsetup,2)
  
      ncas=ibig(IRSNCS)
      over=rbig(FRSOSN)
      fover=rbig(FRSFOV)
      srate=rbig(FRSSRT)

      ipi=ILENRS
      do i=1,ncas
        ifac=ifac*ibig(ipi+ISGDCF)
        ipi=ibig(ipi+ISGADN)
      enddo
      ifac=1
      ipi=ILENRS
      ipf=ipi/LENFLT
      do i=1,ncas
        ifac=ifac*ibig(ipi+ISGDCF)
        ipi=ibig(ipi+ISGADN)
        ipf=ipi/LENFLT
      enddo
      ipi=ILENRS
      ipf=ipi/LENFLT
      do i=1,ncas
        spsin=rbig(ipf+FSGINR)
        trate=srate*ifac
        if(spsin.ne.0..and.abs(spsin-trate).gt..001*trate) then
          write(6,*) 'srespsetup: Warning: stage ',i,' sampling rates inconsistent',spsin,trate
        endif
        rbig(ipf+FSGINR)=trate
        ifac=ifac/ibig(ipi+ISGDCF)
        ipi=ibig(ipi+ISGADN)
        ipf=ipi/LENFLT
      enddo
      ifnstag1=0
      if(ncas.gt.1) ifnstag1=1
      ipi=ILENRS
      ipf=ipi/LENFLT
      do i=1,ncas
        if(rbig(ipf+FSGCAP).lt.0.) then
          write(6,*) 'srespsetup: Warning: applied delay should be positive sign reversed'
          rbig(ipf+FSGCAP)=-rbig(ipf+FSGCAP)
        endif
        iui=ibig(ipi+ISGINU)
        iuo=ibig(ipi+ISGOUU)
        if(i.eq.1) then
          if(iui.eq.SUNM) then
            ipow=0
            zfac=1.
          else if(iui.eq.SUNMPS) then
            ipow=1
            zfac=1.
          else if(iui.eq.SUNMPS2) then
            ipow=2
            zfac=1.
          else if(iui.eq.SUNNMPS) then
            ipow=1
            zfac=1.0e+09
          else
            write(6,*) 'srespsetup: Warning: unknown earth units:',iui
            ipow=0
            zfac=1.
          endif
          ibig(IRSPOW)=ipow
          rbig(FRSOSN)=rbig(FRSOSN)*zfac
          rbig(ipf+FSGGAI)=rbig(ipf+FSGGAI)*zfac
          over=over*zfac
        endif
        if(i.gt.1) then 
          if(iui.ne.iuol) then
            write(6,*)  'srespsetup: Warning: units in cascade do not match'
          endif
        endif
        iuol=iuo
        if(i.eq.ncas) then
          if(iuo.ne.SUNCNT) then
            write(6,*) 'srespsetup: Warning: final units are not counts'
          endif
        endif


        if(ibig(ipi+ISGPZC).eq.STRPZS) then      
          if(rbig(ipf+FSGFAZ).ne.rbig(ipf+FSGFGA).and.rbig(ipf+FSGFGA).ne.0.) then
            write(6,*) 'srespsetup: Warning: cascade',i,' fgain replaced by fnorm'
            rbig(ipf+FSGFGA)=rbig(ipf+FSGFAZ)
            if(i.eq.1) ifnstag1=1
          endif
          if(ibig(ipi+ISGABD).eq.STRFTA) then      
          else if(ibig(ipi+ISGABD).eq.STRFTB) then   
          else if(ibig(ipi+ISGABD).eq.STRFTD) then   
          else
            write(0,*) 'srespsetup: icas,ipzco,iandi',i,ibig(ipi+ISGPZC),ibig(ipi+ISGABD)
            pause 'unknown response type'
          endif
          if(ibig(ipi+ISGABD).eq.STRFTA.or.ibig(ipi+ISGABD).eq.STRFTB) then
            ipf1=ipf+FLENSG+ibig(ipi+ISGLNT)
            do j=1,ibig(ipi+ISGNBT)
              if(rbig(ipf1).gt.0.0) then
                write(6,*) 'srespsetup: Warning pole',j,' in right halfplane -- sign changed'
                rbig(ipf1)=-rbig(ipf1)
              endif
              ipf1=ipf1+2
            enddo
          endif
        else if(ibig(ipi+ISGPZC).eq.STRCOF) then 
          if(ibig(ipi+ISGABD).eq.STRFTA) then      
          else if(ibig(ipi+ISGABD).eq.STRFTB) then 
          else if(ibig(ipi+ISGABD).eq.STRFTD) then 
          else
            write(0,*) 'srespsetup: icas,ipzco,iandi',i,ibig(ipi+ISGPZC),ibig(ipi+ISGABD)
            pause 'unknown response type'
          endif
        else
          write(6,*) 'Stage:',i,' ipzco=',ibig(ipi+ISGPZC)
          pause 'unknown response format'
        endif

        ipi=ibig(ipi+ISGADN)
        ipf=ipi/LENFLT
      enddo

      if(over.ne.0.) then
        ipi=ILENRS
        ipf=ipi/LENFLT
        do i=1,ncas
          if(i.eq.1) then
            rbig(ipf+FSGGAI)=over
          else
            rbig(ipf+FSGGAI)=1.0
          endif
          rbig(ipf+FSGFGA)=fover
          ipi=ibig(ipi+ISGADN)
          ipf=ipi/LENFLT
        enddo
      endif

      ipi=ILENRS
      ipf=ipi/LENFLT
      do i=1,ncas
        om=rbig(ipf+FSGFGA)*tpi
        ktop=ipf+FLENSG
        kbot=ktop+ibig(ipi+ISGLNT)
        crat=cratio(om,ibig(ipi+ISGNTP),ibig(ipi+ISGNBT)
     1     ,rbig(ktop),rbig(kbot)
     1     ,rbig(ipf+FSGAZE),ibig(ipi+ISGPZC),ibig(ipi+ISGABD),rbig(ipf+FSGINR))
        arat=cabs(crat)
        if(arat.eq.0.) then
          write(6,*) 'srespsetup: Warning: Infinite xnorm set to 1 in stage',i
          rbig(ipf+FSGXNM)=1.0
        else
          rbig(ipf+FSGXNM)=1./arat
        endif
        if(i.eq.1.and.ifnstag1.eq.0) then
          if(abs(rbig(ipf+FSGXNM)-1.).gt..055) then
            write(6,*) 'srespsetup: Warning: xnorm=',rbig(ipf+FSGXNM),' Set to 1.00000 in stage 1'
            rbig(ipf+FSGXNM)=1.
          endif
        endif
        ipi=ibig(ipi+ISGADN)
        ipf=ipi/LENFLT
      enddo


      if(iopt.eq.1) then
        ipi=ILENRS
        ipf=ipi/LENFLT
        ipi0=ipi
        ipf0=ipf
        om=rbig(ipf+FSGFGA)*tpi
        ipi=ibig(ipi+ISGADN)
        ipf=ipi/LENFLT
        do i=2,ncas
          ktop=ipf+FLENSG
          kbot=ktop+ibig(ipi+ISGLNT)
          rbig(ipf0+FSGGAI)=rbig(ipf0+FSGGAI)*cabs(cratio(om,ibig(ipi+ISGNTP),ibig(ipi+ISGNBT)
     1     ,rbig(ktop),rbig(kbot)
     1     ,rbig(ipf+FSGAZE),ibig(ipi+ISGPZC),ibig(ipi+ISGABD)
     1     ,rbig(ipf+FSGINR)) )*(rbig(ipf+FSGXNM)*rbig(ipf+FSGGAI))
          ipi=ibig(ipi+ISGADN)
          ipf=ipi/LENFLT
        enddo
        ibig(IRSNCS)=1
        ncas=1
        ipi=ILENRS
        srespsetup=ibig(ipi+ISGADN)
        srespsetup=srespsetup+mod(srespsetup,2)
      else if(iopt.eq.2) then
        dummy=srespd(0.,ibig,rbig)
        ipi=ILENRS
        ipf=ipi/LENFLT
        do i=1,ncas
          if(ibig(ipi+ISGABD).eq.STRFTD.and.ibig(ipi+ISGNBT).eq.0) then
            rbig(ipf+FSGCAP)=rbig(ipf+FSGCAP)+stgdly(i)
          endif
          ipi=ibig(ipi+ISGADN)
          ipf=ipi/LENFLT
        enddo
      endif



      if(iprtlv.gt.1) then
        write(6,'(''Channel:'',a2,a3,1x,f8.4,''Hz'',f6.1,''A'',f7.1,''D (''
     1     ,f9.4,f10.4,'')'',f8.1,''mE'',f8.1,''mD'')')
     1      ibig(IRSLID),ibig(IRSCID),rbig(FRSSRT)
     1     ,rbig(FRSAZM),rbig(FRSDIP),rbig(FRSLAT),rbig(FRSLON),rbig(FRSELV),rbig(FRSDEP)
        write(6,"('Stage    ntop nbot    rate      norm        xnorm       gain     frequency  dof   edelay   -adelay')")
        ipi=ILENRS
        ipf=ipi/LENFLT
        do i=1,ncas
          write(6,"(i2,'.',1x,a2,1x,a1,2i5,f10.4,1p3e12.4,0pf10.4,i4,2f10.4)")
     1     i,pzco(ibig(ipi+ISGPZC)),andi(ibig(ipi+ISGABD)),ibig(ipi+ISGNTP),ibig(ipi+ISGNBT)
     1      ,rbig(ipf+FSGINR),rbig(ipf+FSGAZE),rbig(ipf+FSGXNM)
     1      ,rbig(ipf+FSGGAI),rbig(ipf+FSGFGA),ibig(ipi+ISGDCO),rbig(ipf+FSGEDL),-rbig(ipf+FSGCAP)
          ipi=ibig(ipi+ISGADN)
          ipf=ipi/LENFLT
        enddo
      endif
      ipi=ILENRS
      ipf=ipi/LENFLT
      do i=1,ncas
        rbig(ipf+FSGGAI)=rbig(ipf+FSGGAI)*rbig(ipf+FSGXNM)
        ipi=ibig(ipi+ISGADN)
        ipf=ipi/LENFLT
      enddo

      if(iprtlv.gt.1) then
        write(6,"('Signal response units: counts per ',a5)") utext(ibig(IRSPOW))


        write(6,"('   Freq. Period  ',3('  Amplitude    Phase  per '),'    Gdly')")
        fnyq=.5*rbig(FRSSRT)
        do i=1,ntest
          if(ftest(i).ge.fnyq) then
            freq=fnyq
            star='*'
          else
            freq=ftest(i)
          star=' '
          endif
          om=freq*tpi
          resp(0)=sresp(om,ibig,rbig)
          resp(1)=resp(0)/cmplx(0.0,om)
          resp(2)=resp(1)/cmplx(0.0,om)
          gd=srespd(om,ibig,rbig)
          write(6,"(a1,f7.4,f7.2,3x,3(1pe10.4,0pf9.2,2x,a5),f7.2)") 
     1         star,freq,1./freq
     1       ,(cabs(resp(j)),360.*atan2(aimag(resp(j)),real(resp(j)))/tpi,utext(j)
     1       ,j=0,2),gd
          if(freq.eq.fnyq) goto 20

        enddo
   20   continue
      endif



      return
      end
