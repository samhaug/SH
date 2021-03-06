
      subroutine sacgram(gramsrc,gram,ifstat,iflap,ierr)
      character*(*) gramsrc,gram
      include 'dbdocm.h'
      include 'sacfile.h'
      include 'seeddefs.h'
      include 'seedtrees.h'
      include '../libdb/dblib.h'
      integer opengram
      double precision dsmpin

      character*80 name
      character*5 station
      character*2 locid
      character*3 chn
      character*4 sub

      character*20 ckey
      integer*2 jkey(10)
      integer key(5)
      equivalence (key,jkey,ckey)
      dimension key1(1),ktim(2),itimrsp(2)
      logical getcldr,ifdir
      character*200 gramsrci
      gramsrci=gramsrc

      
      lgram=istlen(gram)
      iadgtr=opengram(gram(1:lgram),ifstat,iflap,ierr)
      if(ierr.ne.0) then
        write(6,*) 'sacgram: cannot open destination file'
        return
      endif


      lgramsrc=istlen(gramsrc)
      call copendir(gramsrci(1:lgramsrc)//'\0',ichan)



      lname=1
      do while(lname.gt.0)
        call creaddir(ichan,name,lname,idno)
        lusac=-1
c       write(6,'(''try file: '',a)') gramsrci(1:lgramsrc)//'/'//name(1:lname)
        call openfl(lusac,gramsrci(1:lgramsrc)//'/'//name(1:lname),1,0,0,istat,-1)
        issac=0
        if(ifdir(lusac)) goto 22
        nbyts=lenlu(lusac)
        call bffi(lusac,1,sacheader,SACHEADBYTES,j,m,0)
        if(j.ne.2) goto 22
        if(m.ne.SACHEADBYTES) goto 22
        if(sacnzyear.lt.1950.or.sacnzyear.gt.2050) goto 22
        if(sacnzjday.lt.1.or.sacnzjday.gt.366) goto 22
        if(sacnzhour.lt.0.or.sacnzhour.gt.59) goto 22
        if(sacnzmin.lt.0.or.sacnzmin.gt.59) goto 22
        if(sacnzmsec.lt.0.or.sacnzmsec.gt.999) goto 22
        if(SACHEADBYTES/4+sacnpts.gt.nbyts/4) goto 22
        if(SACHEADBYTES+sacnpts*4+100.lt.nbyts) goto 22
        if(sacdelta.lt..001.or.sacdelta.gt.2000.) goto 22
        if(abs(sacdelta*(sacnpts-1)-sace+sacb).gt.3.*sacdelta) goto 22
        issac=1
        write(6,'(''sac file: '',a)') gramsrci(1:lgramsrc)//'/'//name(1:lname)
   22   continue
        if(issac.eq.1) then
          nwords=sacnpts   
          call balloc(nwords+2,ia)
          nsamp=sacnpts
          fs=sacnzsec+.001*sacnzmsec
          call tadd(sacnzyear,sacnzjday,sacnzhour,sacnzmin,fs
     1             ,jys,jds,jhs,jms,fss,dble(sacb))

          call timsec(jys,jds,jhs,jms,fss,itimrsp(1))
c         write(6,'(''Response time:'',i5,i4,i3,i3,f7.3)') jys,jds,jhs,jms,fss
          it=10000*amod(fss,1.0)
          itimrsp(2)=ishft(it,16)

          call bffi(lusac,1,ibig(ia),4*sacnpts,j,m,0)

c find suitable channel info, etc.
          station=sackstnm
          locid='  '
          chn=sackcmpnm
          khertz=icrate(1./sacdelta)
          stpatt=station
          lstpatt=5
          chpatt=chn
          lchpatt=3
          call findstn(stpatt,lstpatt,-1,ierr)
          if(ierr.ne.0) then
            write(6,'(''sacgram: Station: '',a,'' not found'')') stpatt(1:lstpatt)
            ierr=0
            goto 100
          endif
          call findchn(chpatt,lchpatt,knt,-1,ierr)
          if(ierr.ne.0) then
            write(6,'(''sacgram: '',a,'' channel: '',a,'' not found'')') stpatt(1:lstpatt),chpatt(1:lchpatt)
            ierr=0
            goto 100
          endif
c         call lsstn(2,-1)
c Find versions of the station and channel which are defined at this time
          is=0
          ic=0
          do istno=1,kntstno
c           write(6,'(''Opening:'',a,2i12)') stnopnd(istno),inetopnd(istno),kntchno(istno)
            call openstn(stnopnd(istno),inetopnd(istno),4)
            irank=-1
            if(getcldr(itsticl,mssticl,mtsticl,itimrsp,-1,ktim,key1,1,irank)) then
c             write(6,'(''Station info ok: kntcnho='',i12)') kntchno(istno)
              do ichno=1,kntchno(istno)
                iach=ichno+iofchno(istno)
c               write(6,'(''Opening:'',a)') chnopnd(iach)
                call openchnk(chnopnd(iach),4)
                irank=-1
                if(getcldr(itchrcl,mschrcl,mtchrcl,itimrsp,-1,ktim,key1,1,irank)) then
c                 write(6,'(''Channel response ok'')')
                  is=istno
                  ic=ichno
                else
c                 write(6,'(''Channel response NOT ok'')')
                endif
                call closechn()
              enddo
            else
c             write(6,'(''Station info NOT ok'')')
            endif
            call closestn()
          enddo

c         last='80000000'x
c         is=0
c         ic=0
c         do istno=1,kntstno
c           do ichno=1,kntchno(istno)
c             iach=ichno+iofchno(istno)
c             if(latest(iach).gt.last) then
c               is=istno
c               ic=ichno
c               last=latest(iach)
c             endif
c           enddo
c         enddo
          if(is.ne.0.and.ic.ne.0) then
            iach=ic+iofchno(is)
            if(station.ne.stnopnd(is)) pause 'sacgram: unexpected 1'
            netukey=inetopnd(is)
            ckey=chnopnd(iach)
            if(khertz.ne.key(3)) pause 'sacgram: unexpected 2'
            write(sub,"(i4)") jkey(8)
            do i=1,4
              if(sub(i:i).eq.' ') sub(i:i)='0'
            enddo
            lfmt=jkey(7)
            call tadd(jys,jds,jhs,jms,fss,jye,jde,jhe,jme,fse,(nsamp-1)*dsmpin(khertz))


            call savegram(iadgtr,station,netukey,locid,chn,sub,khertz,lfmt
     1     ,jys,jds,jhs,jms,fss,jye,jde,jhe,jme,fse
     1     ,ivol,ifil,irec,nrec,ibig(ia),nsamp)
          else
            write(6,'(''sacgram: not found: '',a,2i8)') stpatt(1:lstpatt)//' '//chpatt(1:lchpatt),is,ic
          endif
  100     continue
          call closestn()
          call dalloc(nwords+2,ia)
        endif
        call closfl(lusac,istat)
      enddo
      call cclosedir(ichan)

      call closegram(iadgtr)

      return
      end
