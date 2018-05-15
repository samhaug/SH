      function splhint(i,j)
c
c   caclulates \int_{-1}^{1} splh(i,x) splh(j,x) dx
c
c
      parameter (MXKNT=21)
      common/splhprm/spknt(MXKNT),qq0(MXKNT,MXKNT),qq(3,MXKNT,MXKNT)
      ans=0.
      do ii=1,MXKNT-1
c in this interval the i'th  spline is 
c qq0(ii,MXKNT-i) + t qq(1,ii,MXKNT-i) + 
c          + t**2 qq(2,ii,MXKNT-i) + 
c          + t**3 qq(3,ii,MXKNT-i)

        ans=ans+cubint(spknt(ii+1)-spknt(ii),
     1     qq0(ii,MXKNT-i),qq(1,ii,MXKNT-i),qq(2,ii,MXKNT-i),qq(3,ii,MXKNT-i),
     1     qq0(ii,MXKNT-j),qq(1,ii,MXKNT-j),qq(2,ii,MXKNT-j),qq(3,ii,MXKNT-j))

      enddo
      splhint=ans
      return
      end


      function cubint(b,a0,a1,a2,a3,b0,b1,b2,b3)
      cubint=         (b*(35*a0*
     -       (12*b0 + 
     -         b*
     -          (6*b1 + 
     -           b*
     -           (4*b2 + 
     -           3*b*b3))) + 
     -      b*
     -       (7*a1*
     -          (30*b0 + 
     -           b*
     -           (20*b1 + 
     -           3*b*
     -           (5*b2 + 
     -           4*b*b3))) + 
     -         b*
     -          (7*a2*
     -           (20*b0 + 
     -           b*
     -           (15*b1 + 
     -           2*b*
     -           (6*b2 + 
     -           5*b*b3))) + 
     -           a3*b*
     -           (105*b0 + 
     -           2*b*
     -           (42*b1 + 
     -           5*b*
     -           (7*b2 + 
     -           6*b*b3)))))))
     -   /420.  
      end
