

c-------------------------------------------------------------------------------
      subroutine sgchannel(isub,iagram,string,nbyts)
      character*(*) string
      include 'gramblock.h'
      include '../libdb/dblib.h'
      double precision dsmpin
      lenstr=len(string)
      iach=iagram+ibig(iagram+OGSTCHO+isub-1)
      k=0
      ica=4*(iach+OGCHLID)
      do i=ica,ica+1
        k=k+1
        string(k:k)=cbig(i)
      enddo
      ica=4*(iach+OGCHCID)
      do i=ica,ica+2
        k=k+1
        string(k:k)=cbig(i)
      enddo
      string(k+1:k+1)='('
      k=k+1
      write(string(k+1:k+4),"(i4)") ibig(iach+OGCHSUB)
      do i=k+1,k+4
        if(string(i:i).eq.' ') string(i:i)='0'
      enddo
      k=k+4
      string(k+1:k+3)=') ['
      k=k+3
      hz=1.d0/dsmpin(ibig(iach+OGCHKHZ))
      write(string(k+1:k+8),"(f8.4)") hz
      k=k+8
      string(k+1:k+3)='Hz '
      k=k+3
      write(string(k+1:k+3),"(i3)") ibig(iach+OGCHFMT)
      do i=k+1,k+3
        if(string(i:i).eq.' ') string(i:i)='0'
      enddo
      k=k+3
      string(k+1:k+3)='F] '
      k=k+3
      call timeint(ibig(iach+OGCHSGS),string(k+1:lenstr),ltim)
      ltim=ltim-1
      if(ltim.lt.22) then
        string(k+ltim+1:k+22)=' '
        ltim=22
      endif
      k=k+ltim
      write(string(k+1:k+7),"(i7)") ibig(iach+OGCHSGL)
      k=k+7
      write(string(k+1:k+2),"(i2)") ibig(iach+OGCHNPC)
      k=k+2
      write(string(k+1:k+6),"(i6)") ibig(iach+OGCHSGG)
      k=k+6
      write(string(k+1:k+6),"(i6)") ibig(iach+OGRSREF)
      k=k+6
      string(k+1:k+1)=' '
      k=k+1
      write(string(k+1:k+16),'(''['',f5.1,''A '',f5.1,''D] '')') rbig(iach+OGCHAZM),rbig(iach+OGCHDIP)
      k=k+16
      ica=4*(iach+OGCHINS)
      do i=ica,ica+4*LGCHINS-1
        k=k+1
        string(k:k)=cbig(i)
      enddo
      k=istlen(string(1:k))
      nbyts=k
      return
      end
