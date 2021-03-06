c ---------------------------------------------------------

       subroutine getselfcder(mdtp,nord,lord,ommd,coveru,ndim,numt,lmax,itypd,rkern,maxnrparcall)

c      reads derivative of splitting function for self coupled modes

       parameter(MAXNRPAR=45)           ! largest dimension of derivative
       parameter(MXL=12)                ! largest angular order for derivatives
       parameter(MXSTORE=MXL/2+1)       ! maximum number of angular orders to be stored
       parameter(MXPARTYP=7)            ! number of derivative types

       dimension rkern(MAXNRPAR,MXPARTYP,MXSTORE)
       dimension itypd(MXPARTYP)
       character*1 mdtp,mdtpk
       character*20 chartyp(MXPARTYP)
       character*40 ifl
       character*120 fl

       data chartyp/'dVp = dVs*.5','dVs','dVp','d_eta','d_rho','dZs','dZp'/

       if(maxnrparcall.ne.MAXNRPAR) stop 'getselfcder: MAXNRPAR different in calling routine!'

       tpi=8.*atan(1.)

c- Jeroen fix: Arwen has splitting data with nord > 10
c- The name of the kernels are always in the form: i2Si2s.
c- For example 03s10 or 12s02
       if(nord .le. 9 ) then
         if(lord.le.9) then
          write(ifl,'(a1,i1,a1,a1,i1,a11)') '0',nord,mdtp,'0',lord,'.sph.ker.nw'
         else
          write(ifl,'(a1,i1,a1,i2,a11)')    '0',nord,mdtp,lord,'.sph.ker.nw'
         endif
       endif
       if(nord .gt. 9 ) then
         if(lord.le.9) then
          write(ifl,'(i2,a1,a1,i1,a11)') nord,mdtp,'0',lord,'.sph.ker.nw'
         else
          write(ifl,'(i2,a1,i2,a11)') nord,mdtp,lord,'.sph.ker.nw'
         endif
       endif

       li=istlen(ifl)
       fl='/geo/home/jritsema/dta/splitting/kernels/'//ifl(1:li)

       write(6,*) 'in getselfcder lord= ifl= fl=', lord,ifl,fl
       open(10,file=fl,status='old')

c      read header: nord - branch 
c                   mdtp - s=spheroidals t=toroidal
c                   lord - angular order of mode, 
c                   ommd - eigenfrequency for reference model
c                   ndim - dimension of derivatives 
c                   numt - number of different types of derivatives
c                   lmax - maximum angular order for which derivative is present
c                   itypd - array to store what type of derivative is in each record:
c                           relates to array chartyp

       read(10,51) mdn,mdtpk,mds,ommd,ndim,numt,lmax,coveru
51     format(i4,x,a1,x,i4,x,f12.9,x,3i4,x,f7.4)
       read(10,*) (itypd(j),j=1,numt)
c      write(6,*) 'reading derivatives for ',mdn,mdtpk,mds,' for parameters:'
c      write(6,*) (chartyp(itypd(i)),i=1,numt)
c      write(6,*) lmax,coveru

c      ommd is read as frequency, convert to angular frequency
       ommd=ommd*tpi
       ff=1./ommd

       do l=0,lmax,2
        read(10,*,end=1000) lker
        if(lker.ne.l) stop 'rsplitc: imcompatible l,lker'
        lstore=l/2+1
        do i=1,ndim
         read (10,*,end=1000) (rkern(i,itypd(j),lstore),j=1,numt)

c        normalise w.r.t. omega
         do j=1,numt
          rkern(i,itypd(j),lstore)=rkern(i,itypd(j),lstore)*ff
         enddo

        enddo
       enddo

       close(10)

       return

1000   continue
       stop 'rsplitc: record missing'

       end


