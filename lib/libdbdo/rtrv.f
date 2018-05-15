c---------------------------------------------------------------
      subroutine rtrv(iadgtr,ivol,ifil,ireci,nrec,inet,stnwn,chnwn,hertz,lfmt
     1     ,jyrs,jds,ihs,ims,fss,   jyre,jde,ihe,ime,fse
     1     ,jyr1,jd1,ih1,im1,fs1,   jyr2,jd2,ih2,im2,fs2,   ierr)
      character*5 stnwn,chnwn
      double precision smpin,toff1,toff2,toffr,toffr1,toffe,terr,tofrec,tofbeg,tend
      double precision dsmpin,dhertz
      logical getabr
      integer trread
      character*60 name
      integer*4 iname(15)
      equivalence (name,iname)
      include 'seedparam.h'
      include 'seedtrees.h'
      include 'seedbuf.h'
      include '../libdb/dblib.h'
      include 'cbufcm.h'
      character*4 tpfmt
      common/vlprm/idvol,tpfmt,itpfmt
      character*4 sub
      dimension kkad(5),kkad0(5)

      parameter(MXDFVOL=15)
      character*80 dfvols
      character*60 dfnames
      common/cmdfvols/ndfvol,idfvols(MXDFVOL),dfvols(MXDFVOL),dfnames(MXDFVOL)

      data idvol/-1/
      nspac=0
      khertz=icrate(hertz)
      dhertz=dsmpin(khertz)
      if(ivol.ne.idvol) then
        do i=1,ndfvol
          if(ivol.eq.idfvols(i)) then
          lcbuf=istlen(dfvols(i))
          cbuf(1:lcbuf)=dfvols(i)(1:lcbuf)
          name=dfnames(i)
          goto 38
          endif
        enddo
        write(6,'(''ivol,idvol,ndfvol'',3i10)') ivol,idvol,ndfvol
        do i=1,ndfvol
          write(6,'(i5,''.'',i10,2x,a)') i,idfvols(i),dfnames(i)
        enddo
        pause 'rtrv: volume not found'
   38   continue
          
        read(cbuf(1:4),"(a4)") tpfmt
        if(tpfmt.eq.'NDTF') then
          itpfmt=TPFNDTF
        else if(tpfmt.eq.'SROF') then
          itpfmt=TPFSROF
        else if(tpfmt.eq.'IDAF') then
          itpfmt=TPFIDAF
        else if(tpfmt.eq.'HGLF') then
          itpfmt=TPFHGLF
        else if(tpfmt.eq.'GSPF') then
          itpfmt=TPFGSPF
        else
          itpfmt=TPFSEED
        endif
c  10   nw=trread(itvlabr,iname,15)
c       if(nw.le.0) then
c         write(6,*) 'rtrv: volume not found'
c         ierr=9
c         return
c       endif
c       lname=istlen(name(1:4*nw))
        lname=istlen(name)
        call closfl(5,iostat)
        call opnfil(5,name(1:lname),1,0,0,iostat,32768)
c       if(iostat.ne.0) goto 10
        if(iostat.ne.0) then
          write(6,'(a)') 'rtrv: unable to open volume'
          ierr=9
          return
        endif
        call gsetup1(5,6,ierr)
        idvol=ivol
      endif
      write(6,*) stnwn//chnwn
      call tdif(jyr1,jd1,ih1,im1,fs1,jyrs,jds,ihs,ims,fss,toff1)
      call tdif(jyr2,jd2,ih2,im2,fs2,jyrs,jds,ihs,ims,fss,toff2)
      call tdif(jyre,jde,ihe,ime,fse,jyrs,jds,ihs,ims,fss,toffe)
      if(lfmt.ne.SFMSTM.and.lfmt.ne.SFMST2.and.lfmt.ne.SFMUSN) then
        maxsmpr=(lrec-headln(itpfmt))/(mnsm(lfmt)*nmsm(lfmt))
      else if(lfmt.eq.SFMSTM) then    ! is this right?
        maxsmpr=((lrec-64)/64)*60-8
      else if(lfmt.eq.SFMST2) then    ! is this right?
        maxsmpr=((lrec-64)/64)*105-8
      else if(lfmt.eq.SFMUSN) then
        maxsmpr=(lrec-48)*2
      endif
      ioffr=0
      terr=0.d0
cxy   write(6,*) 'rtrv: looking for start'
 150  continue
      call ggetlrec(ifil,ireci+ioffr)
      if(ioffr.eq.0) then
        call gheader0(jbuf(1+i2bias+ibyte/2),iyrc,idrc,ihrc,imrc,fsrc,nsamp,smpin,ibytdta)
        iy=iyrc
        id=idrc
        ih=ihrc
        im=imrc
        fs=fsrc
      else
        call gheader(jbuf(1+i2bias+ibyte/2),iyrc,idrc,ihrc,imrc,fsrc,nsamp,smpin,ibytdta)
      endif
cxy   write(6,*) 'rtrv: header',iyrc,idrc,ihrc,imrc,fsrc,nsamp,smpin

      if(nsamp.gt.maxsmpr) then
        write(6,*) 'nsamp=',nsamp,'maxsmpr=',maxsmpr
        write(6,*) 'rtrv: too many samples? Maybe format is wrong?'
        goto 99
      endif
      if(dhertz.ne.smpin) then
        write(6,*) 'Wrong rate:',smpin,dhertz
        goto 99
      endif

      call tdif(iyrc,idrc,ihrc,imrc,fsrc,iy,id,ih,im,fs,toffr)
      tofrec=toffr
      toffr1=toffr+(nsamp-1)*smpin
      if(toff1.gt.toffr1) then
        iskip=(toff1-toffr1)/smpin
        ioffr=ioffr+1+iskip/maxsmpr
        if(ioffr.ge.nrec) then
cxy       write(6,*) 'rtrv: going to 160',ioffr,nrec
          goto 160  ! strange -- needs thought
        endif
cxy       write(6,*) 'rtrv: back  to 150'
        goto 150
      endif
c     write(6,*) 'start found'
      isskip=dmax1(toff1-toffr+smpin,0.d0)/smpin
      isskip=min0(nsamp-1,isskip)
      tofbeg=toffr+isskip*smpin
c add space for 10 samples for luck
      if(tofbeg.gt.toffe) then
        write(6,*) 'tofbeg=',tofbeg,'  toffe=',toffe
        write(6,*) 'rtrv: overshoot? Maybe format is wrong?'
        goto 99
      endif
      nspac=1+(toffe-tofbeg)/smpin+10
      nspacm2=nspac-2
      ngot=0
cxy   write(6,*) '       rtrv allocating space',nmsm(lfmt),lfmt,ntalloc()
      do imu=1,nmsm(lfmt)
         call balloc(nspac,kkad0(imu))
cxy      write(6,*) 'rtrv nspac=',nspac,' at ',kkad0(imu),' imu=',imu
         kkad(imu)=kkad0(imu)
      enddo
cxy   write(6,*) '       rtrv allocated space',ntalloc()
  180 continue
      i2dta=i2bias+ibytdta/2
      i4dta=i2dta/2
      if(toff2.ge.toffr1) then
        nend=nsamp
      else
        nend=(toff2-toffr+smpin)/smpin
      endif
      
      if(ngot+nend-isskip.gt.nspac) then
        write(6,*) 'buffer would be exceeded'
        nend=nspac+isskip-ngot
        if(nend.le.isskip) goto 160
      endif
      if(nend.le.isskip) goto 160
      do imu=1,nmsm(lfmt)
        call ndecod(jbuf(i2dta+1),ibuf(i4dta+1),ibig(kkad(imu))
     1               ,lfmt,imu,isskip+1,nend,nsamp,ifchk)
        kkad(imu)=kkad(imu)+nend-isskip
        tend=tofrec+(nend-1)*smpin
      enddo
      ngot=ngot+nend-isskip
      if(ngot.gt.nspacm2) pause 'rtrv: buffer unexpectedly exceeded'
      
      if(toffr1+smpin.le.toff2) then
        ioffr=ioffr+1
        if(ioffr.ge.nrec) then
          write(6,*) 'rtrv: data piece exhausted'
          goto 160
        endif
        call ggetlrec(ifil,ireci+ioffr)
        call gheader(jbuf(1+i2bias+ibyte/2),iyrc,idrc,ihrc,imrc,fsrc,nsamp,smpin,ibytdta)

        if(nsamp.gt.maxsmpr) then
          write(6,*) 'nsamp=',nsamp,'maxsmpr=',maxsmpr
          write(6,*) 'rtrv: too many samples? Maybe format is wrong?'
          goto 99
        endif
        if(dhertz.ne.smpin) then
          write(6,*) 'Wrong rate:',smpin,dhertz
          goto 99
        endif

        call tdif(iyrc,idrc,ihrc,imrc,fsrc,iy,id,ih,im,fs,tofrec)
        toffr=toffr1+smpin
        if(dabs(toffr-tofrec).gt..1*smpin) then
          write(6,*) 'Tear   at:',iyrc,idrc,ihrc,imrc,fsrc,tofrec-toffr
        endif
        terr=dmax1(dabs(toffr-tofrec),terr)
        toffr1=toffr+(nsamp-1)*smpin
        isskip=0
        goto 180
      endif




  160 continue
      call tadd(jyrs,jds,ihs,ims,fss,jyrbeg,jdbeg,ihbeg,imbeg,fsbeg,tofbeg)
      call tadd(jyrs,jds,ihs,ims,fss,jyrenp,jdenp,ihenp,imenp,fsenp,tofbeg+(ngot-1)*smpin)
      call tadd(jyrs,jds,ihs,ims,fss,jyrend,jdend,ihend,imend,fsend,tend)
      write(6,*) 'Starts at:',jyrbeg,jdbeg,ihbeg,imbeg,fsbeg
      write(6,*) '  Ends at:',jyrend,jdend,ihend,imend,fsend
      write(6,*) '         :',jyrenp,jdenp,ihenp,imenp,fsenp
      write(6,*) 'Max Time error:',terr

      do imu=1,nmsm(lfmt)
        if(nmsm(lfmt).eq.1) then
          sub='0000'
        else
          write(sub,"(i4)") imu
          do i=1,4
            if(sub(i:i).eq.' ') sub(i:i)='0'
          enddo
        endif
cxy     write(6,*) 'calling savegram ngot=',ngot,' imu=',imu,' kkad0(imu)=',kkad0(imu)
cxy     write(6,*) 'rtrv: before savegram::',ntalloc()
        call savegram(iadgtr,stnwn,inet,chnwn(1:2),chnwn(3:5),sub,khertz,lfmt
     1     ,jyrbeg,jdbeg,ihbeg,imbeg,fsbeg   ,jyrend,jdend,ihend,imend,fsend
     1     ,ivol,ifil,ireci,nrec,ibig(kkad0(imu)),ngot)
cxy     write(6,*) 'rtrv: after  savegram::',ntalloc()
      enddo
   99 continue
      if(nspac.ne.0) then
        do imu=nmsm(lfmt),1,-1
          call dalloc(nspac,kkad0(imu))
        enddo
        nspac=0
      endif
      return
      end
