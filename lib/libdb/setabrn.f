
      subroutine setabrn(itrabr,itrhash,lastuid,id,txt,tmp,ifound)
      include 'dblib.h'
      logical trfind,trnext,getabr
      character*(*) txt,tmp
      common/perfmce/nhash
      integer*4 hash(2)
      character*1 temp(4)
      integer*4 itemp
      equivalence (temp,itemp)
      hash(1)=0
c      hash(2)=z'80000000'
      hash(2)=z'7fffffff'
      ltxt=len(txt)
c      do i=1,ltxt
c        hash(1)=hash(1)+ichar(txt(i:i))
c      enddo
      ihash=0
      i2=0
      j1=0
      do while(i2.lt.ltxt)
        i1=i2+1
        i2=min0(i2+4,ltxt)
        itemp=0
        j1=1+mod(j1,4)
        do i=i1,i2
          temp(j1)=txt(i:i)
          j1=1+mod(j1,4)
        enddo
        call byswap4(itemp,1)
        ihash=xor(itemp,ihash)
      enddo
      hash(1)=ihash
c      if(trfind(itrhash,hash,2,iok,ioi)) pause 'setabr: small found'
      if(trfind(itrhash,hash,2,iok,ioi)) pause 'setabr: large found'
      ifound=0
      nhash=0
c      do while(trnext(itrhash,1,iok,ioi))
      do while(trnext(itrhash,-1,iok,ioi))
        if(ibig(iok).ne.hash(1)) goto 101
        nhash=nhash+1
        id=ibig(iok+1)
        if(getabr(itrabr,id,tmp,ltmp)) then
          if(ltmp.eq.ltxt.and.tmp(1:ltmp).eq.txt(1:ltxt)) then
            ifound=1
            goto 101
          endif
        else
          pause 'setabr: abbreviation not found'
        endif
      enddo
  101 continue
      if(ifound.eq.0) then
        lastuid=1+lastuid
        id=lastuid
        hash(2)=id
        if(trfind(itrhash,hash,2,iok,ioi)) pause 'setabr: new key found'
c       write(6,'(''setabrn: hash= '',2z9.8)') (hash(ih),ih=1,2)
        call traddk(itrhash,hash,2,indummy,0)
        if(trfind(itrabr,id,1,iok,ioi)) pause 'setabr: new key found'
        call traddk(itrabr,id,1,ltxt,1)
        lw=(ltxt+3)/4
        call balloc(lw,io)
        do i=1,ltxt
          cbig(io*4+i-1)=txt(i:i)
        enddo
        do i=ltxt+1,4*(ltxt+3)/4
          cbig(io*4+i-1)=' '
        enddo
        if(trfind(itrabr,id,1,iok,ioi)) then
          call trwrit(itrabr,ibig(io),lw)
        else
          pause 'setabr: new key not found'
        endif
        call dalloc(lw,io)
      endif
      return
      end 
