c----------------------------------
      function spln(n,x)
      parameter (MXKNT=21)
      common/splprm/spknt(MXKNT),qq0(MXKNT,MXKNT),qq(3,MXKNT,MXKNT)
      spln=rsple(1,MXKNT,spknt(1),qq0(1,n+1),qq(1,1,n+1),x)
c      do k=1,MXKNT
c          write(50,221) k
c          write(6,221) k
c          write(50,222) (((qq(i,j,k)),i=1,3),j=1,MXKNT)
c          write(50,223)
c      enddo
c 221  format('      data ((qq(i,j,',i2,'),i=1,3),j=1,MXKNT)/')
c 222  format(10('     1 ',6(e15.7,','),/,),'     1 ',2(e15.7,','),e15.7)
c 223  format('     1/')
      return
      end
c----------------------------------
      block data splparam
      parameter (MXKNT=21)
      common/splprm/spknt(MXKNT),qq0(MXKNT,MXKNT),qq(3,MXKNT,MXKNT)
      data spknt/
     1  -1.0000000E+00, -8.6256000E-01, -7.2996000E-01, -6.0201000E-01, -4.7854000E-01, -3.5940000E-01
     1, -2.4443000E-01, -1.3350000E-01, -2.6450000E-02,  7.6850000E-02,  1.7652000E-01,  2.7270000E-01
     1,  3.6552000E-01,  4.5508000E-01,  5.4150000E-01,  6.2489000E-01,  7.0536000E-01,  7.8300000E-01
     1,  8.5793000E-01,  9.3023000E-01,  1.0000000E+00
     1/
      data qq0/
     1   7.0710678E-01,  7.0710678E-01,  7.0710678E-01,  7.0710678E-01,  7.0710678E-01,  7.0710678E-01
     1,  7.0710678E-01,  7.0710678E-01,  7.0710678E-01,  7.0710678E-01,  7.0710678E-01,  7.0710678E-01
     1,  7.0710678E-01,  7.0710678E-01,  7.0710678E-01,  7.0710678E-01,  7.0710678E-01,  7.0710678E-01
     1,  7.0710678E-01,  7.0710678E-01,  7.0710678E-01, -9.9999899E-01, -9.7682935E-01, -9.1137549E-01
     1, -8.1087462E-01, -6.8287333E-01, -5.3503261E-01, -3.7458597E-01, -2.0816830E-01, -4.1535708E-02
     1,  1.2042275E-01,  2.7373785E-01,  4.1537636E-01,  5.4312795E-01,  6.5549553E-01,  7.5166762E-01
     1,  8.3137415E-01,  8.9479762E-01,  9.4246734E-01,  9.7520249E-01,  9.9400369E-01,  1.0000002E+00
     1,  9.9994051E-01,  9.0889666E-01,  6.6120108E-01,  3.1510950E-01, -6.7378511E-02, -4.2747499E-01
     1, -7.1939162E-01, -9.1335531E-01, -9.9658016E-01, -9.7102690E-01, -8.5016358E-01, -6.5494850E-01
     1, -4.1004174E-01, -1.4066192E-01,  1.3000392E-01,  3.8236859E-01,  6.0133115E-01,  7.7650375E-01
     1,  9.0205028E-01,  9.7613368E-01,  1.0000125E+00, -9.9941205E-01, -8.0083758E-01, -2.9396374E-01
     1,  2.9951585E-01,  7.7505379E-01,  9.9265742E-01,  9.1387587E-01,  5.8873367E-01,  1.2455104E-01
     1, -3.5419398E-01, -7.3921140E-01, -9.5960848E-01, -9.8872741E-01, -8.4010030E-01, -5.5639714E-01
     1, -1.9569761E-01,  1.8129683E-01,  5.2123361E-01,  7.8423023E-01,  9.4679494E-01,  1.0001257E+00
     1,  9.9731264E-01,  6.6034526E-01, -1.2445332E-01, -8.0052512E-01, -9.9271906E-01, -6.3644678E-01
     1,  3.3356566E-02,  6.6796454E-01,  9.8694751E-01,  8.8704956E-01,  4.4680537E-01, -1.4134449E-01
     1, -6.6371353E-01, -9.6102582E-01, -9.6712446E-01, -7.0846629E-01, -2.7740671E-01,  2.0583476E-01
     1,  6.2762973E-01,  9.0672680E-01,  1.0005914E+00, -9.9223777E-01, -4.9840885E-01,  5.1897413E-01
     1,  1.0016981E+00,  5.8753186E-01, -3.0801409E-01, -9.4025960E-01, -8.7225469E-01, -2.1208126E-01
     1,  5.6515040E-01,  9.8485536E-01,  8.4557364E-01,  2.7133830E-01, -4.1771092E-01, -8.9742657E-01
     1, -9.8360626E-01, -6.7943363E-01, -1.3428766E-01,  4.3972808E-01,  8.5688199E-01,  1.0017816E+00
     1,  9.8380231E-01,  3.2874800E-01, -8.2257233E-01, -8.3792895E-01,  1.7866028E-01,  9.7232243E-01
     1,  6.8777126E-01, -2.9273849E-01, -9.7135275E-01, -7.6299069E-01,  8.0670653E-02,  8.3999185E-01
     1,  9.6264700E-01,  4.2062433E-01, -3.7702864E-01, -9.2629940E-01, -9.4086496E-01, -4.6152383E-01
     1,  2.2890700E-01,  7.9814614E-01,  1.0039593E+00, -9.7396995E-01, -1.6523227E-01,  9.9400241E-01
     1,  3.8562275E-01, -8.3445961E-01, -7.6879340E-01,  4.0344463E-01,  1.0107745E+00,  3.2588735E-01
     1, -7.3424146E-01, -9.5330137E-01, -1.6998348E-01,  7.6285102E-01,  9.7334633E-01,  3.4154226E-01
     1, -5.4943482E-01, -1.0044572E+00, -7.3922255E-01,  4.2137531E-03,  7.3117744E-01,  1.0070544E+00
     1,  9.6720150E-01,  1.8106637E-02, -1.0262103E+00,  1.8482461E-01,  1.0096865E+00, -1.0061681E-01
     1, -1.0230397E+00, -1.9032957E-01,  9.3796352E-01,  6.3374409E-01, -5.6647828E-01, -9.9072607E-01
     1, -1.6544119E-01,  8.3879156E-01,  8.9719678E-01,  2.6737994E-02, -8.5093484E-01, -9.3454020E-01
     1, -2.2445011E-01,  6.5659735E-01,  1.0107318E+00, -9.6951588E-01,  1.0848513E-01,  9.4033570E-01
     1, -6.9175714E-01, -6.4013951E-01,  8.9080528E-01,  4.6882424E-01, -9.2760064E-01, -4.9654551E-01
     1,  8.5135843E-01,  7.0025589E-01, -6.0129689E-01, -9.5516953E-01,  8.7324181E-02,  9.9360467E-01
     1,  6.0733577E-01, -5.0549970E-01, -1.0220786E+00, -4.4645507E-01,  5.7534370E-01,  1.0147629E+00
     1, -9.8772360E-01,  2.1647607E-01,  7.7112528E-01, -1.0089483E+00,  4.9626731E-02,  9.8649139E-01
     1, -6.1517871E-01, -7.1941804E-01,  8.5228534E-01,  5.4525459E-01, -8.9921318E-01, -5.6455040E-01
     1,  8.1869410E-01,  7.5293394E-01, -5.5663635E-01, -9.8410665E-01,  3.5895191E-02,  9.8765039E-01
     1,  6.5132850E-01, -4.8878454E-01, -1.0194111E+00, -1.0299396E+00,  3.1251440E-01,  5.5294797E-01
     1, -1.0901066E+00,  7.1963200E-01,  3.5494497E-01, -1.0717313E+00,  5.0541868E-01,  7.4499782E-01
     1, -9.2358896E-01, -3.5567854E-01,  1.0356106E+00,  1.6394603E-01, -1.0448058E+00, -2.0772795E-01
     1,  1.0068624E+00,  4.5970024E-01, -8.3016662E-01, -8.2987353E-01,  3.9844859E-01,  1.0255561E+00
     1,  1.1086974E+00, -4.0745301E-01, -3.1031011E-01,  9.5584540E-01, -1.1013663E+00,  5.3286468E-01
     1,  4.7180433E-01, -1.0968441E+00,  6.3560502E-01,  5.5629943E-01, -1.0730737E+00,  1.1718708E-01
     1,  1.0242475E+00, -5.1074581E-01, -8.9365004E-01,  6.3942176E-01,  8.7079046E-01, -5.6092353E-01
     1, -9.7455543E-01,  3.0557871E-01,  1.0344678E+00,  1.2540443E+00, -5.2106527E-01, -5.0109260E-02
     1,  6.5864209E-01, -1.0905558E+00,  1.1187254E+00, -5.9238874E-01, -3.2202459E-01,  1.0538824E+00
     1, -9.4509740E-01, -6.2614127E-02,  1.0318805E+00, -7.9186036E-01, -4.9500055E-01,  1.0848615E+00
     1,  1.4665631E-02, -1.0927216E+00,  2.0219756E-01,  1.0785795E+00, -2.1084708E-01, -1.0471919E+00
     1, -1.5906007E+00,  7.1828168E-01, -2.6587640E-01, -2.2756722E-01,  7.0917038E-01, -1.0927360E+00
     1,  1.2060605E+00, -8.8943505E-01,  1.4264021E-01,  7.3128111E-01, -1.1649306E+00,  7.0856510E-01
     1,  4.0214632E-01, -1.1371890E+00,  5.9012897E-01,  7.1473104E-01, -1.0417265E+00, -2.0978438E-01
     1,  1.1297696E+00, -1.1435394E-01, -1.0595453E+00,  2.8693677E+00, -1.3703738E+00,  9.4144420E-01
     1, -5.6853584E-01,  2.0540213E-01,  2.0331795E-01, -6.2686026E-01,  9.7211837E-01, -1.0905947E+00
     1,  8.3788746E-01, -1.9616596E-01, -5.9352779E-01,  1.0421213E+00, -7.1815588E-01, -2.4998250E-01
     1,  9.9876998E-01, -6.4361797E-01, -5.2501164E-01,  9.9293793E-01, -2.1620717E-02, -9.4585571E-01
     1, -2.8903951E+00,  1.4150014E+00, -1.1688130E+00,  1.0694622E+00, -1.0591644E+00,  1.0544222E+00
     1, -9.9898271E-01,  8.3072890E-01, -5.0137464E-01,  1.7340130E-02,  5.1222094E-01, -8.6286785E-01
     1,  7.8359000E-01, -2.0530033E-01, -5.5376038E-01,  8.6746134E-01, -3.4059570E-01, -5.7873321E-01
     1,  8.0771750E-01,  1.7815937E-02, -7.9224329E-01,  5.5455847E-01, -2.8134460E-01,  2.8790493E-01
     1, -3.5361808E-01,  4.7659504E-01, -6.5464018E-01,  8.8292349E-01, -1.1374848E+00,  1.3619368E+00
     1, -1.4607400E+00,  1.3119948E+00, -8.2025626E-01,  1.3600755E-02,  8.5899219E-01, -1.3374479E+00
     1,  9.9786279E-01,  1.0166944E-01, -1.1619800E+00,  1.1149005E+00,  1.1709312E-01, -1.1956987E+00
     1, -9.4284199E-02,  4.9785282E-02, -6.1619709E-02,  9.0566337E-02, -1.4092817E-01,  2.2081603E-01
     1, -3.4125068E-01,  5.1390376E-01, -7.4634807E-01,  1.0337918E+00, -1.3457627E+00,  1.6109032E+00
     1, -1.7107108E+00,  1.4995432E+00, -8.7376952E-01, -1.0787891E-01,  1.1142363E+00, -1.5833756E+00
     1,  1.0394465E+00,  2.7911328E-01, -1.4100048E+00,  1.1997742E-02, -6.5851294E-03,  9.4556030E-03
     1, -1.5474730E-02,  2.6078740E-02, -4.4061230E-02,  7.3818197E-02, -1.2199254E-01,  1.9800857E-01
     1, -3.1442876E-01,  4.8619283E-01, -7.2741959E-01,  1.0445507E+00, -1.4239925E+00,  1.8134779E+00
     1, -2.1048265E+00,  2.1325925E+00, -1.7152282E+00,  7.3933030E-01,  5.6842369E-01, -1.8404742E+00
     1,  2.9907493E-04, -1.7291578E-04,  2.9150507E-04, -5.2348955E-04,  9.4412385E-04, -1.7046906E-03
     1,  3.0677667E-03, -5.4951746E-03,  9.7841524E-03, -1.7303987E-02,  3.0376023E-02, -5.2854524E-02
     1,  9.1035856E-02, -1.5503415E-01,  2.6052531E-01, -4.3107595E-01,  7.0064602E-01, -1.1183815E+00
     1,  1.8360947E+00, -2.9766824E+00,  6.3525420E+00
     1/
      data qq/
     1   0.0000000E+00, -1.8864666E-14,  7.3254472E-14, -1.9175964E-15,  1.9962440E-15, -3.5019020E-14
     1, -8.4488341E-15, -4.4367366E-14,  1.0612879E-13, -1.4182971E-14,  1.6112959E-14, -3.4659054E-13
     1, -2.8172086E-14, -1.3468744E-13,  7.7697655E-13, -2.7724440E-14,  1.4537371E-13, -7.3928652E-13
     1, -1.6217660E-14, -7.3633505E-14,  7.6222144E-13,  2.8349454E-15,  2.6517454E-13,  1.5388434E-13
     1,  6.2463375E-14,  2.9010719E-13, -1.2463320E-12,  8.1289083E-14, -3.2454752E-14,  5.0820893E-14
     1,  7.9151814E-14,  2.6316948E-14,  2.1038900E-13,  8.4730210E-14,  5.1270186E-14,  1.2880669E-13
     1,  9.2488083E-14,  1.0154030E-13, -4.1766590E-13,  1.0803728E-13,  1.2746748E-14, -1.4501733E-12
     1,  7.7904697E-14, -3.4078296E-13,  2.0499158E-12,  5.3436422E-14,  4.7295501E-14, -4.2987836E-13
     1,  4.9182880E-14, -5.1958438E-14,  4.9737992E-13,  5.3568261E-14,  2.0783375E-13, -3.5242920E-12
     1,  2.5979219E-14, -6.2527761E-13,  4.0927262E-12, -8.8817842E-16,  2.8421709E-13, -2.0179414E-12
     1,  1.0658141E-14,  0.0000000E+00,  0.0000000E+00,  3.1477884E-03,  1.1920208E+00,  8.4751108E-02
     1,  3.3561324E-01,  1.2269654E+00, -2.6674015E-01,  6.4693437E-01,  1.1208561E+00, -2.9796536E-01
     1,  9.1912730E-01,  1.0064821E+00, -4.3936742E-01,  1.1475737E+00,  8.4373604E-01, -5.0705906E-01
     1,  1.3270271E+00,  6.6250299E-01, -5.7820363E-01,  1.4564347E+00,  4.6307477E-01, -6.1755182E-01
     1,  1.5363747E+00,  2.5755970E-01, -6.4224613E-01,  1.5694384E+00,  5.1302357E-02, -6.4589130E-01
     1,  1.5593608E+00, -1.4885936E-01, -6.3385733E-01,  1.5107967E+00, -3.3838904E-01, -6.0650923E-01
     1,  1.4288725E+00, -5.1339121E-01, -5.6672147E-01,  1.3189187E+00, -6.7120047E-01, -5.1656006E-01
     1,  1.1862633E+00, -8.0998983E-01, -4.5775804E-01,  1.0360085E+00, -9.2866818E-01, -3.9379320E-01
     1,  8.7291000E-01, -1.0271834E+00, -3.2269639E-01,  7.0132631E-01, -1.1050856E+00, -2.5606080E-01
     1,  5.2509805E-01, -1.1647272E+00, -1.6894774E-01,  3.4770635E-01, -1.2027050E+00, -1.3517574E-01
     1,  1.7167540E-01, -1.2320246E+00,  4.7243560E-02,  4.4860799E-04,  0.0000000E+00,  0.0000000E+00
     1, -4.8840084E-02, -4.2856446E+00, -1.3005527E+00, -1.3005794E+00, -4.8218884E+00,  4.0932754E+00
     1, -2.3634310E+00, -3.1935835E+00,  4.1018911E+00, -2.9792103E+00, -1.6190726E+00,  5.3326790E+00
     1, -3.1351366E+00,  3.5620504E-01,  4.9479845E+00, -2.8395599E+00,  2.1247137E+00,  4.2527861E+00
     1, -2.1823620E+00,  3.5915421E+00,  2.8791249E+00, -1.2792556E+00,  4.5496861E+00,  1.2890880E+00
     1, -2.6085010E-01,  4.9636767E+00, -4.2435544E-01,  7.5106074E-01,  4.8321689E+00, -2.0181078E+00
     1,  1.6541610E+00,  4.2287345E+00, -3.3723168E+00,  2.3740126E+00,  3.2556862E+00, -4.3749406E+00
     1,  2.8653206E+00,  2.0374402E+00, -4.9843951E+00,  3.1103275E+00,  6.9823297E-01, -5.1801092E+00
     1,  3.1149484E+00, -6.4476214E-01, -5.0135258E+00,  2.9028244E+00, -1.8989959E+00, -4.4732925E+00
     1,  2.5103007E+00, -2.9788934E+00, -3.7829557E+00,  1.9793275E+00, -3.8600194E+00, -2.5965970E+00
     1,  1.3571291E+00, -4.4437085E+00, -2.1392381E+00,  6.8102165E-01, -4.9077092E+00,  7.4765800E-01
     1,  7.1183714E-03,  0.0000000E+00,  0.0000000E+00,  2.3461498E-01,  7.9630177E+00,  6.1279942E+00
     1,  2.7707582E+00,  1.0489712E+01, -1.9286852E+01,  4.5352816E+00,  2.8174024E+00, -1.5722550E+01
     1,  4.4840637E+00, -3.2176986E+00, -1.5436650E+01,  2.9834974E+00, -8.9355881E+00, -6.5137410E+00
     1,  5.7695071E-01, -1.1263729E+01,  2.4817946E+00, -1.9146174E+00, -1.0407734E+01,  1.1221827E+01
     1, -3.8094078E+00, -6.6732217E+00,  1.6374501E+01, -4.6752038E+00, -1.4145507E+00,  1.7507030E+01
     1, -4.4070032E+00,  4.0108777E+00,  1.4527437E+01, -3.1745234E+00,  8.3547268E+00,  8.5896602E+00
     1, -1.3290298E+00,  1.0833187E+01,  1.1350939E+00,  7.1138148E-01,  1.1149266E+01, -6.2815321E+00
     1,  2.5572856E+00,  9.4615436E+00, -1.2333366E+01,  3.9162866E+00,  6.2639952E+00, -1.6276939E+01
     1,  4.6214315E+00,  2.1919932E+00, -1.7437413E+01,  4.6354671E+00, -2.0175726E+00, -1.6664170E+01
     1,  4.0208251E+00, -5.8989911E+00, -1.2274672E+01,  2.9300537E+00, -8.6582146E+00, -1.0634611E+01
     1,  1.5113053E+00, -1.0964862E+01,  3.7167682E+00,  3.5546513E-02,  0.0000000E+00,  0.0000000E+00
     1, -6.8727371E-01, -1.0441834E+01, -1.7434970E+01, -4.5455520E+00, -1.7630621E+01,  5.4873698E+01
     1, -6.3266996E+00,  4.1981356E+00,  3.0887973E+01, -3.7353769E+00,  1.6054484E+01,  1.2891273E+01
     1,  8.1869364E-01,  2.0829541E+01, -2.1836770E+01,  4.8520810E+00,  1.3024642E+01, -3.9614423E+01
     1,  6.2760850E+00, -6.3876810E-01, -3.9367042E+01,  4.6810786E+00, -1.3739726E+01, -2.0112576E+01
     1,  1.0479509E+00, -2.0198880E+01,  6.7029955E+00, -2.9105568E+00, -1.8121621E+01,  3.0170873E+01
     1, -5.6237586E+00, -9.1002286E+00,  4.1502571E+01, -6.2225084E+00,  2.8749233E+00,  3.8058398E+01
     1, -4.7051253E+00,  1.3472665E+01,  2.2293238E+01, -1.7554598E+00,  1.9462412E+01,  3.9477936E-01
     1,  1.6172686E+00,  1.9564763E+01, -2.1137126E+01,  4.4393238E+00,  1.4276888E+01, -3.5736871E+01
     1,  6.0428123E+00,  5.6496498E+00, -4.2687832E+01,  6.1481271E+00, -4.2932001E+00, -3.5132346E+01
     1,  4.9129959E+00, -1.2190600E+01, -3.2780230E+01,  2.6361799E+00, -1.9300632E+01,  1.1456603E+01
     1,  1.1027685E-01,  0.0000000E+00,  0.0000000E+00,  1.5167315E+00,  1.0034357E+01,  3.6908766E+01
     1,  6.3665679E+00,  2.5252579E+01, -1.1616426E+02,  6.9360868E+00, -2.0957565E+01, -2.9430429E+01
     1,  1.2761137E-01, -3.2254435E+01,  3.2827891E+01, -6.3359309E+00, -2.0094656E+01,  8.5474579E+01
     1, -7.4843199E+00,  1.0455668E+01,  5.9237714E+01, -2.7311133E+00,  3.0887348E+01, -6.6780714E+00
     1,  3.8750234E+00,  2.8664953E+01, -6.7771669E+01,  7.6822603E+00,  6.9000811E+00, -8.1625324E+01
     1,  6.4947725E+00, -1.8395607E+01, -4.5332365E+01,  1.4767822E+00, -3.1950437E+01,  1.6007077E+01
     1, -4.2249791E+00, -2.7331755E+01,  6.6782147E+01, -7.5727509E+00, -8.7355989E+00,  8.2457990E+01
     1, -7.1532864E+00,  1.3419214E+01,  5.9265361E+01, -3.5060543E+00,  2.8784351E+01,  1.0393262E+01
     1,  1.5114207E+00,  3.1384434E+01, -3.9684742E+01,  5.7915053E+00,  2.1804140E+01, -7.6795536E+01
     1,  7.7884887E+00,  3.9169239E+00, -7.5036104E+01,  7.1116072E+00, -1.2950442E+01, -7.7578757E+01
     1,  4.0223933E+00, -2.9777274E+01,  2.7113568E+01,  2.6322708E-01,  0.0000000E+00,  0.0000000E+00
     1, -2.7727394E+00, -5.7537604E+00, -6.3662812E+01, -7.9620576E+00, -3.2003211E+01,  2.0036822E+02
     1, -5.8802303E+00,  4.7703266E+01, -2.0977260E+01,  5.2967664E+00,  3.9651144E+01, -1.2850258E+02
     1,  9.2112157E+00, -7.9474980E+00, -1.1291529E+02,  2.5092117E+00, -4.8305682E+01,  4.3084018E+01
     1, -6.8897302E+00, -3.3445574E+01,  1.4309515E+02, -9.0274083E+00,  1.4175060E+01,  1.0216156E+02
     1, -2.4803047E+00,  4.6984244E+01, -3.3372105E+01,  6.1583100E+00,  3.6642229E+01, -1.3548216E+02
     1,  9.4248884E+00, -3.8682908E+00, -1.2518583E+02,  5.2066547E+00, -3.9989411E+01, -2.0127244E+01
     1, -2.7372015E+00, -4.5594043E+01,  9.5816294E+01, -8.5983808E+00, -1.9850121E+01,  1.4512719E+02
     1, -8.7776647E+00,  1.7775555E+01,  1.0189848E+02, -3.6872845E+00,  4.3267498E+01,  3.7901478E+00
     1,  3.3498151E+00,  4.4182478E+01, -1.0057261E+02,  8.3917244E+00,  2.0757106E+01, -1.3050304E+02
     1,  9.3042544E+00, -8.5786725E+00, -1.5509425E+02,  5.6316105E+00, -4.2218616E+01,  5.4205027E+01
     1,  5.3201115E-01,  0.0000000E+00,  0.0000000E+00,  4.4296601E+00, -2.3057079E+00,  9.3782728E+01
     1,  9.1104650E+00,  3.6362786E+01, -2.9516569E+02,  3.1843934E+00, -8.1054126E+01,  1.4853267E+02
     1, -1.0262382E+01, -2.4039860E+01,  2.1967915E+02, -6.1518637E+00,  5.7331495E+01, -8.9783778E+00
     1,  7.1267585E+00,  5.4122443E+01, -2.3855029E+02,  1.0112128E+01, -2.8155938E+01, -1.2302635E+02
     1, -6.7623825E-01, -6.9097879E+01,  1.4619413E+02, -1.0444070E+01, -2.2147634E+01,  2.3140519E+02
     1, -7.6118734E+00,  4.9564836E+01,  4.7703756E+01,  3.6900639E+00,  6.3828736E+01, -1.8213113E+02
     1,  1.0913697E+01,  1.1276619E+01, -2.2174580E+02,  7.2757006E+00, -5.0470717E+01, -5.0519417E+01
     1, -2.9802621E+00, -6.4044274E+01,  1.6122743E+02, -1.0437334E+01, -2.2244452E+01,  2.3121426E+02
     1, -9.3237464E+00,  3.5598420E+01,  1.2425182E+02, -1.1807881E+00,  6.5594052E+01, -8.2237188E+01
     1,  7.5174865E+00,  4.6439366E+01, -1.9154742E+02,  1.1250558E+01,  3.3814210E+00, -2.7551793E+02
     1,  7.4188752E+00, -5.6378418E+01,  9.6292782E+01,  9.5804798E-01,  0.0000000E+00,  0.0000000E+00
     1, -6.4117412E+00,  1.3046847E+01, -1.2106769E+02, -9.6862404E+00, -3.6871783E+01,  3.8104061E+02
     1,  6.3459987E-01,  1.1470617E+02, -3.5711168E+02,  1.2448867E+01, -2.2371145E+01, -1.9718374E+02
     1, -2.0935680E+00, -9.5409975E+01,  2.9176391E+02, -1.2403669E+01,  8.8722828E+00,  2.5423171E+02
     1, -2.8219485E-01,  9.6559341E+01, -2.3749656E+02,  1.2372944E+01,  1.7522862E+01, -3.2364682E+02
     1,  4.9978999E+00, -8.6416315E+01,  9.2203782E+01, -9.9040214E+00, -5.7842362E+01,  3.6512660E+02
     1, -1.0552696E+01,  5.1334143E+01,  1.3019713E+02,  2.9351419E+00,  8.8901224E+01, -2.6646157E+02
     1,  1.2551624E+01,  1.4702335E+01, -3.3105683E+02,  7.2188924E+00, -7.4246013E+01, -1.6967723E+01
     1, -5.9939546E+00, -7.8645065E+01,  3.0396779E+02, -1.2769101E+01, -2.6014421E+00,  3.1991838E+02
     1, -6.9729585E+00,  7.4630054E+01,  1.6895819E+01,  4.9211387E+00,  7.8565428E+01, -2.3712391E+02
     1,  1.2700954E+01,  2.5262344E+01, -4.4792347E+02,  9.3296110E+00, -7.1892257E+01,  1.5654806E+02
     1,  1.5839242E+00,  0.0000000E+00,  0.0000000E+00,  8.6425237E+00, -2.4832509E+01,  1.3837588E+02
     1,  9.6582225E+00,  3.2222634E+01, -4.3551530E+02, -4.7690176E+00, -1.4102535E+02,  6.1434114E+02
     1, -1.0684895E+01,  9.4789495E+01, -3.9403864E+01,  1.0920306E+01,  8.0193910E+01, -5.3716085E+02
     1,  7.1549801E+00, -1.1179812E+02,  1.5343294E+02, -1.2467604E+01, -5.8877567E+01,  5.2095141E+02
     1, -6.2985329E+00,  1.1448985E+02, -1.6849781E+02,  1.2420940E+01,  6.0376781E+01, -5.2567507E+02
     1,  8.0665205E+00, -1.0252992E+02,  6.4083119E+01, -1.0461968E+01, -8.3368430E+01,  5.3487126E+02
     1, -1.1655092E+01,  7.0963323E+01,  1.4576140E+02,  5.2859845E+00,  1.1155204E+02, -4.5336211E+02
     1,  1.4357943E+01, -1.0257288E+01, -3.9962660E+02,  3.6313394E+00, -1.1386448E+02,  1.7712995E+02
     1, -1.1663751E+01, -6.9551881E+01,  5.2991059E+02, -1.2563248E+01,  5.8373835E+01,  2.2853289E+02
     1,  6.3380857E-01,  1.1160371E+02, -2.3405892E+02,  1.3416366E+01,  5.8989610E+01, -6.7885122E+02
     1,  1.1300607E+01, -8.8253219E+01,  2.3725669E+02,  2.4505452E+00,  0.0000000E+00,  0.0000000E+00
     1,  1.1092054E+01, -3.6035957E+01,  1.3882482E+02,  9.0535904E+00,  2.1204292E+01, -4.3692825E+02
     1, -8.3702453E+00, -1.5260577E+02,  8.5417634E+02, -5.4703799E+00,  1.7526982E+02, -4.9830918E+02
     1,  1.5020817E+01, -9.3088840E+00, -4.2609910E+02, -5.3418901E+00, -1.6160522E+02,  7.5581526E+02
     1, -1.2530068E+01,  9.9083017E+01,  4.8685967E+01,  1.1249800E+01,  1.1528522E+02, -7.7743094E+02
     1,  9.2049841E+00, -1.3438673E+02,  1.5977493E+02, -1.3444491E+01, -8.4872475E+01,  7.4603854E+02
     1, -8.1292864E+00,  1.3820051E+02, -1.8196585E+02,  1.3405088E+01,  8.5696081E+01, -7.4945370E+02
     1,  9.9428351E+00, -1.2299680E+02,  4.2201747E+01, -1.1072851E+01, -1.1165803E+02,  7.4564438E+02
     1, -1.3665477E+01,  8.1657731E+01,  2.4876449E+02,  5.1430433E+00,  1.4389114E+02, -6.2488749E+02
     1,  1.6161655E+01, -6.9629451E+00, -5.5781380E+02,  4.9929954E+00, -1.3688894E+02,  1.3814423E+02
     1, -1.3194346E+01, -1.0583549E+02,  9.7125927E+02, -1.3266997E+01,  1.0483064E+02, -3.3945252E+02
     1, -3.5961438E+00,  0.0000000E+00,  0.0000000E+00,  1.3816018E+01, -4.5483679E+01,  1.1661471E+02
     1,  7.9219336E+00,  2.5988967E+00, -3.6702558E+02, -1.0748807E+01, -1.4340388E+02,  9.9296030E+02
     1,  1.3220020E+00,  2.3774393E+02, -1.0507772E+03,  1.1973695E+01, -1.5147445E+02,  2.1219550E+02
     1, -1.5083712E+01, -7.5631533E+01,  8.6018039E+02,  1.6354275E+00,  2.2105329E+02, -9.7024733E+02
     1,  1.4860276E+01, -1.0183532E+02, -1.5016040E+02, -1.2105047E+01, -1.5005933E+02,  1.0733267E+03
     1, -8.7472515E+00,  1.8256461E+02, -3.7759360E+02,  1.6392010E+01,  6.9660350E+01, -9.3253169E+02
     1,  3.9124636E+00, -1.9941234E+02,  6.0426504E+02, -1.7488212E+01, -3.1148700E+01,  8.4544777E+02
     1, -2.7235741E+00,  1.9600621E+02, -6.0643695E+02,  1.7566768E+01,  3.8781363E+01, -8.9670148E+02
     1,  5.3280275E+00, -1.8554645E+02,  4.3291630E+02, -1.6123872E+01, -8.1036121E+01,  9.6252712E+02
     1, -1.1300908E+01,  1.4315570E+02,  1.0297671E+02,  1.1886894E+01,  1.6630383E+02, -1.3240934E+03
     1,  1.5170167E+01, -1.2089204E+02,  4.6276712E+02,  5.0589392E+00,  0.0000000E+00,  0.0000000E+00
     1, -1.7018769E+01,  5.2816171E+01, -6.7319482E+01, -6.3156047E+00,  2.5059002E+01,  2.1187698E+02
     1,  1.1506189E+01,  1.0934367E+02, -9.5295417E+02, -7.3157839E+00, -2.5644779E+02,  1.4639550E+03
     1, -3.6897202E+00,  2.8581577E+02, -1.1726839E+03,  1.4478039E+01, -1.3332492E+02,  2.4150949E+01
     1, -1.5221005E+01, -1.2499502E+02,  1.2145674E+03,  1.8850505E+00,  2.7920088E+02, -1.3604152E+03
     1,  1.4892099E+01, -1.5769646E+02,  5.9060123E+01, -1.5797317E+01, -1.3939372E+02,  1.3431512E+03
     1, -3.5550299E+00,  2.6222193E+02, -1.0042739E+03,  1.9015594E+01, -2.7551273E+01, -7.7604219E+02
     1, -6.1571213E+00, -2.4364798E+02,  1.3513240E+03, -1.7282465E+01,  1.1942574E+02,  3.3888786E+02
     1,  1.0951948E+01,  2.0728581E+02, -1.4169261E+03,  1.5963621E+01, -1.4718660E+02, -1.9215721E+02
     1, -1.1457486E+01, -1.9357527E+02,  1.3348198E+03, -1.7377095E+01,  1.1733096E+02,  5.4595047E+02
     1,  9.4018477E+00,  2.4005517E+02, -1.7316754E+03,  1.6957916E+01, -1.3554524E+02,  6.0521595E+02
     1,  6.8822397E+00,  0.0000000E+00,  0.0000000E+00, -2.1296711E+01,  5.9061596E+01,  1.3963217E+01
     1, -4.2705747E+00,  6.4818909E+01, -4.3946925E+01,  1.0601275E+01,  4.7336822E+01, -6.7916441E+02
     1, -1.0641446E+01, -2.1336044E+02,  1.4967734E+03,  5.1255431E+00,  3.4105938E+02, -1.9173689E+03
     1,  4.7458174E+00, -3.4424660E+02,  1.5092242E+03, -1.4563012E+01,  1.7629993E+02, -2.0776863E+02
     1,  1.6880822E+01,  1.0715661E+02, -1.3524783E+03, -6.6739446E+00, -3.2719179E+02,  1.9793708E+03
     1, -1.0906824E+01,  2.8621523E+02, -8.8243412E+02,  1.9848730E+01,  2.2358602E+01, -1.1479839E+03
     1, -7.7089640E+00, -3.0888068E+02,  1.9419676E+03, -1.4856202E+01,  2.3187962E+02, -3.2368672E+02
     1,  1.8889208E+01,  1.4491147E+02, -1.7582373E+03,  4.5419624E+00, -3.1092912E+02,  1.2299289E+03
     1, -2.1656417E+01, -3.2378011E+00,  1.2594504E+03,  2.2889056E+00,  3.0080612E+02, -1.4872317E+03
     1,  2.2103118E+01, -4.5599885E+01, -1.2450448E+03, -5.7014120E+00, -3.2547352E+02,  2.1806243E+03
     1, -1.8568616E+01,  1.4750388E+02, -7.6212236E+02, -9.1156229E+00,  0.0000000E+00,  0.0000000E+00
     1,  2.9126869E+01, -6.9411470E+01, -1.4758020E+02,  1.6837826E+00, -1.3026174E+02,  4.6448439E+02
     1, -8.3608783E+00,  5.4510150E+01,  1.0296812E+02,  1.0645405E+01,  9.4034463E+01, -9.6223223E+02
     1, -1.0140957E+01, -2.6238598E+02,  1.8512552E+03,  6.1697464E+00,  3.9928965E+02, -2.4270753E+03
     1,  1.7384296E+00, -4.3783289E+02,  2.2705458E+03, -1.1578810E+01,  3.1778205E+02, -1.1168441E+03
     1,  1.8062224E+01, -4.0892435E+01, -7.6279229E+02, -1.4805171E+01, -2.7728177E+02,  2.3572266E+03
     1,  1.7231842E-01,  4.2755255E+02, -2.3582561E+03,  1.6970529E+01, -2.5289867E+02,  3.7168957E+02
     1, -2.0370648E+01, -1.4939799E+02,  2.0649533E+03,  2.5581156E+00,  4.0541366E+02, -2.3574589E+03
     1,  1.9810358E+01, -2.0578114E+02, -1.6624649E+02, -1.7978001E+01, -2.4737103E+02,  2.4796016E+03
     1, -9.6205010E+00,  3.5122960E+02, -1.1502356E+03,  2.4117677E+01,  8.3316739E+01, -2.2233830E+03
     1, -8.4605988E-01, -4.1647751E+02,  2.6303475E+03, -1.9819941E+01,  1.5404486E+02, -9.1929943E+02
     1, -1.1749565E+01,  0.0000000E+00,  0.0000000E+00, -5.5421869E+01,  1.1189171E+02,  4.8679978E+02
     1,  2.9215079E+00,  3.1260900E+02, -1.5321221E+03,  5.0086061E+00, -2.9686919E+02,  1.2933978E+03
     1, -7.4367860E+00,  1.9960157E+02, -7.1760624E+02,  9.0334467E+00, -6.6206958E+01, -8.1937115E+01
     1, -1.0231477E+01, -9.5492922E+01,  1.0583573E+03,  9.7793009E+00,  2.6954509E+02, -2.0532044E+03
     1, -6.2163296E+00, -4.1374080E+02,  2.7259516E+03, -1.0824520E+00,  4.6169856E+02, -2.6185498E+03
     1,  1.0477701E+01, -3.4979001E+02,  1.4104032E+03, -1.7216144E+01,  7.1934647E+01,  6.6655514E+02
     1,  1.5119295E+01,  2.6426247E+02, -2.5565866E+03, -1.9022393E+00, -4.4764465E+02,  2.7850127E+03
     1, -1.5068641E+01,  3.0063257E+02, -7.3571234E+02,  2.0408874E+01,  1.0989179E+02, -2.0992421E+03
     1, -5.0570831E+00, -4.1527561E+02,  2.7896828E+03, -1.7698428E+01,  2.5818172E+02, -1.3589245E+02
     1,  1.9934562E+01,  2.2652965E+02, -2.9655675E+03,  3.9317151E+00, -4.4010027E+02,  2.6504961E+03
     1, -1.8142050E+01,  1.3479232E+02, -9.2634130E+02, -1.2861009E+01,  0.0000000E+00,  0.0000000E+00
     1,  5.7186709E+01, -1.0466462E+02, -6.0752303E+02, -6.0113818E+00, -3.5515851E+02,  1.9120787E+03
     1,  6.5944264E-01,  4.0546639E+02, -2.1406802E+03, -7.1823426E-01, -4.1623370E+02,  2.2873691E+03
     1,  1.1087490E+00,  4.3103068E+02, -2.4461429E+03, -3.4940922E-01, -4.4326971E+02,  2.5307549E+03
     1, -1.9195250E+00,  4.2961297E+02, -2.3764361E+03,  5.6649540E+00, -3.6124121E+02,  1.7943019E+03
     1, -9.9902895E+00,  2.1499886E+02, -6.7451286E+02,  1.2835517E+01,  5.9673242E+00, -8.5212346E+02
     1, -1.1370218E+01, -2.4882611E+02,  2.2706955E+03,  3.7814276E+00,  4.0636038E+02, -2.7579912E+03
     1,  7.9333142E+00, -3.6162986E+02,  1.6721874E+03, -1.6604014E+01,  8.7653445E+01,  6.6906203E+02
     1,  1.3536509E+01,  2.6111447E+02, -2.6269855E+03,  2.2818597E+00, -3.9607849E+02,  2.2512918E+03
     1, -1.7728827E+01,  1.4740586E+02,  5.3368454E+02,  1.4811458E+01,  2.7171167E+02, -2.9686561E+03
     1,  5.5275663E+00, -3.9561253E+02,  2.3243185E+03, -1.5228345E+01,  1.0853216E+02, -8.1234312E+02
     1, -1.1946868E+01,  0.0000000E+00,  0.0000000E+00, -1.1362391E+01,  1.7392870E+01,  1.5299121E+02
     1,  2.0884595E+00,  8.0474205E+01, -4.8151463E+02, -1.9688499E+00, -1.1107231E+02,  6.8209379E+02
     1,  3.1078314E+00,  1.5074939E+02, -9.8373288E+02, -4.6566691E+00, -2.1363511E+02,  1.4522795E+03
     1,  6.2808022E+00,  3.0543863E+02, -2.1200832E+03, -7.5570608E+00, -4.2579927E+02,  2.9724688E+03
     1,  7.7079461E+00,  5.6340864E+02, -3.8982399E+03, -5.6842747E+00, -6.8851112E+02,  4.6371419E+03
     1,  5.1662187E-01,  7.4853916E+02, -4.7618130E+03,  7.8173124E+00, -6.7529053E+02,  3.7795147E+03
     1, -1.7193324E+01,  4.1525065E+02, -1.4353866E+03,  2.2793859E+01,  1.5552882E+01, -1.8385988E+03
     1, -1.8662476E+01, -4.7844184E+02,  4.6319784E+03,  2.4242660E+00,  7.2244487E+02, -4.9848716E+03
     1,  1.8920844E+01, -5.2462046E+02,  1.8776197E+03, -2.9036440E+01, -7.1344289E+01,  3.0358246E+03
     1,  1.4784793E+01,  6.3575997E+02, -5.7058495E+03,  1.3953221E+01, -6.4685795E+02,  3.6373869E+03
     1, -2.2541409E+01,  1.4209127E+02, -1.2712570E+03, -2.1278870E+01,  0.0000000E+00,  0.0000000E+00
     1,  2.0093554E+00, -2.3383084E+00, -3.3867190E+01, -5.5262740E-01, -1.6302428E+01,  1.0659140E+02
     1,  7.4648185E-01,  2.6099632E+01, -1.7692724E+02, -1.2641573E+00, -4.1813889E+01,  2.9859369E+02
     1,  2.0663609E+00,  6.8788201E+01, -5.0904038E+02, -3.2192628E+00, -1.1315301E+02,  8.5788820E+02
     1,  4.7812917E+00,  1.8274121E+02, -1.4094403E+03, -6.7071988E+00, -2.8630643E+02,  2.2324968E+03
     1,  8.7458412E+00,  4.3065991E+02, -3.3736915E+03, -1.0280695E+01, -6.1484710E+02,  4.8004482E+03
     1,  1.0220209E+01,  8.2053491E+02, -6.3129246E+03, -7.1365738E+00, -1.0009964E+03,  7.4590127E+03
     1, -1.7099493E-01,  1.0760403E+03, -7.5245597E+03,  1.1506009E+01, -9.4565840E+02,  5.7248080E+03
     1, -2.3675838E+01,  5.3855534E+02, -1.7328209E+03,  2.9994873E+01,  1.0505554E+02, -3.5922726E+03
     1, -2.2881920E+01, -7.6215499E+02,  7.8484974E+03,  7.0216438E-01,  1.0659170E+03, -8.1160665E+03
     1,  2.3737404E+01, -7.5849357E+02,  3.9380474E+03, -2.4184819E+01,  9.5668913E+01, -1.3763371E+03
     1, -3.0934598E+01,  0.0000000E+00,  0.0000000E+00, -2.6559193E-01,  2.0947313E-01,  5.3783011E+00
     1,  9.6772394E-02,  2.4270542E+00, -1.6927317E+01, -1.5245968E-01, -4.3066324E+00,  3.1069737E+01
     1,  2.7141996E-01,  7.6194862E+00, -5.7439157E+01, -4.7397657E-01, -1.3656552E+01,  1.0654242E+02
     1,  8.0883804E-01,  2.4423839E+01, -1.9606000E+02, -1.3497670E+00, -4.3199216E+01,  3.5566978E+02
     1,  2.1961012E+00,  7.5164131E+01, -6.3292687E+02, -3.4707191E+00, -1.2810033E+02,  1.1004529E+03
     1,  5.2921889E+00,  2.1293003E+02, -1.8604790E+03, -7.7089423E+00, -3.4337180E+02,  3.0394059E+03
     1,  1.0588974E+01,  5.3361838E+02, -4.7622064E+03, -1.3437227E+01, -7.9246562E+02,  7.0873312E+03
     1,  1.5158645E+01,  1.1117585E+03, -9.8782342E+03, -1.4009311E+01, -1.4492725E+03,  1.2637016E+04
     1,  7.9103530E+00,  1.7121297E+03, -1.4366180E+04,  4.3793256E+00, -1.7560098E+03,  1.3669196E+04
     1, -2.1101370E+01,  1.4278194E+03, -9.4624763E+03,  3.3490291E+01, -6.9925062E+02,  2.8124850E+03
     1, -2.3516324E+01, -8.9222618E+01, -9.8295601E+02, -5.0321103E+01,  0.0000000E+00,  0.0000000E+00
     1, -6.9646103E-03,  1.9071403E-03,  1.7302156E-01,  3.3646285E-03,  7.3247391E-02, -5.4455688E-01
     1, -5.9346020E-03, -1.4337733E-01,  1.0940002E+00,  1.1105433E-02,  2.7655463E-01, -2.1886248E+00
     1, -2.0697877E-02, -5.3413388E-01,  4.3751101E+00,  3.8334096E-02,  1.0296180E+00, -8.7152319E+00
     1, -7.0511995E-02, -1.9763527E+00,  1.7273342E+01,  1.2868391E-01,  3.7720428E+00, -3.4010511E+01
     1, -2.3297274E-01, -7.1504328E+00,  6.6478483E+01,  4.1790156E-01,  1.3451249E+01, -1.2887002E+02
     1, -7.4135285E-01, -2.5082175E+01,  2.4737812E+02,  1.2990224E+00,  4.6296307E+01, -4.6962013E+02
     1, -2.2446416E+00, -8.4474113E+01,  8.8051430E+02,  3.8121540E+00,  1.5210247E+02, -1.6266161E+03
     1, -6.3431949E+00, -2.6961403E+02,  2.9526966E+03,  1.0288777E+01,  4.6906207E+02, -5.2460378E+03
     1, -1.6131282E+01, -7.9738391E+02,  9.0596292E+03,  2.3884452E+01,  1.3127849E+03, -1.4751365E+04
     1, -2.7846428E+01, -2.0031744E+03,  2.0299078E+04,  8.2206579E-01,  2.3996957E+03, -7.0944736E+03
     1,  2.3207104E+02,  0.0000000E+00,  0.0000000E+00
     1/
      end
