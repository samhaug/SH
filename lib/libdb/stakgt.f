

c-------------------------------------------------------------------

      subroutine stakgt(istadr,ifadr,ibadr)
      include "dblib.h"
      ibot=ibig(istadr+OSTBM)
      ifila=ibig(istadr+OSTFT)
      ichna=ibig(istadr+OSTUF)
      ibufa=ibig(istadr+OSTBT)
      iabov=ibig(istadr+OSTAB)
      ibelo=ibig(istadr+OSTBL)
      lu=ibig(istadr+OSTLU)
      nbyts=ibig(istadr+OSTNB)
      ip=ibot
   10 continue
c ! a hit
      if(ibig(ifila+ip).eq.ifadr) then
        if(ip.ne.ibot) then
          ipa=ibig(iabov+ip)
          ipb=ibig(ibelo+ip)
c ! remove entry ip from chain
          ibig(ibelo+ipa)=ipb
          ibig(iabov+ipb)=ipa
c ! insert entry ip below bot
          ibig(iabov+ip)=ibot
          ibig(ibelo+ip)=ibig(ibelo+ibot)
          ibig(iabov+ibig(ibelo+ibot))=ip
          ibig(ibelo+ibot)=ip
          ibot=ip
        endif
      else
        ip1=ibig(iabov+ip)
        if(ip1.ne.ibot) then
          ip=ip1
          goto 10
c ! ifadr not found -- read it
        else
c ! first flush oldest entry
          ichn=ichna+ip
          if(ibig(ichn).gt.0) then
            call bffobs4(lu,1,ibig(ibig(ibufa+ip)),nbyts
     1        ,j,ibig(ifila+ip)+1)
            ibig(ichn)=0
          endif
c ! make ip bottom
          if(ip.ne.ibot) then
            ipa=ibig(iabov+ip)
            ipb=ibig(ibelo+ip)
c ! remove entry ip from chain
            ibig(ibelo+ipa)=ipb
            ibig(iabov+ipb)=ipa
c ! insert entry ip below bot
            ibig(iabov+ip)=ibot
            ibig(ibelo+ip)=ibig(ibelo+ibot)
            ibig(iabov+ibig(ibelo+ibot))=ip
            ibig(ibelo+ibot)=ip
            ibot=ip
          endif
          call bffibs4(lu,1,ibig(ibig(ibufa+ip)),nbyts,j,m,ifadr+1)
          ibig(ifila+ip)=ifadr
          ibig(ichna+ip)=0
        endif
      endif
      ibig(istadr+OSTBM)=ibot
      ibadr=ibig(ibufa+ibot)
      return
      end
