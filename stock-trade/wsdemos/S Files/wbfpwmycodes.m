function retstr = wbstsea(instruct, outfile)

% Author(s): N. Zhu, 11-15-2003
% This is used to show user's historical using information.

wbfpwbasic;
cd(fpwserverplace);
retstr = char('');
fpwusername=instruct.mlid{1};
fpwCPAL=3; % User level required for this program
fpwloginIP='192.168.2.8';
fpwcheckil;

if fpwcheckilpass==1
  if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwfrontout.mat'])==2
    eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwfrontout']);
  else
    error(' - You haven''t run any simulation yet.');    
  end
  Mynet='';
  Mynet=[Mynet,sprintf(' \n')];
  Mynet=[Mynet,'Pattern Codes:',sprintf(['\n',fpwout.fpwptfilef,'\n\n'])];
  
  if isfield(fpwout,'fpwexfilef')
    Mynet=[Mynet,'Special Any-Exit:',sprintf(['\n',fpwout.fpwexfilef,'\n\n'])];
    Mynet=[Mynet,'Special Any-Stop:',sprintf(['\n',fpwout.fpwstfilef,'\n\n'])];
    Mynet=[Mynet,'Special Any-Objective:',sprintf(['\n',fpwout.fpwobfilef,'\n\n'])];
  else
    Mynet=[Mynet,'Special Any-Exit: Not Assigned for this pattern.',sprintf(' \n')];
    Mynet=[Mynet,'Special Any-Stop: Not Assigned for this pattern.',sprintf(' \n')];
    Mynet=[Mynet,'Special Any-Objective: Not Assigned for this pattern.',sprintf(' \n\n')];
  end
  
  mymodelshere=[];
  if isfield(fpwout,'pdzhu')==1
    mymodelshere=fpwout.pdzhu;
    Mynet=[Mynet,sprintf(['     Simulation ResultFile Source:'])];
    for i=1:length(mymodelshere)
      if (i~=1)&(rem(i-1,10)==0)
        Mynet=[Mynet,sprintf(' \n                                  %4d',mymodelshere(i))];
      else
        Mynet=[Mynet,sprintf('%4d',mymodelshere(i))];
      end
    end
    if rem(length(mymodelshere),10)<=5
      Mynet=[Mynet,sprintf(', saved in your PM database.\n')];
    else
      Mynet=[Mynet,sprintf(' \n                                    saved in your PM database.\n\n')];
    end
  else
    Mynet=[Mynet,sprintf(['     Simulation ResultFile Source: Current \n'])];
  end
  
  if isfield(fpwout,'fpwfilesource')==1
    Mynet=[Mynet,sprintf(['           The PatternFile Source: ',fpwout.fpwfilesource,' \n\n\n'])];
  else
    if length(mymodelshere)>1
      lastMIS=int2str(mymodelshere(length(mymodelshere)));
      Mynet=[Mynet,sprintf(['           The PatternFile Source: N/A, Showing rules attached to the last(',lastMIS,')\n\n\n'])];
    else
      Mynet=[Mynet,sprintf(['           The PatternFile Source: N/A, Showing saved rules \n\n\n'])];
    end
  end
  
  seosetup=fpwout.ESOchosen;
  seosetupstar=blanks(length(seosetup));
  for jk=1:length(seosetup)
    if strcmp(seosetup(jk),'1')
      seosetupstar(jk)='*';
    end
  end
  
  tradeh=fpwout.tradeh;
  BSONi=0; % model's Buy-Sell indicator
  BSstring='';
  if abs(sum(tradeh(:,2)))==length(tradeh(:,1))
    if tradeh(1,2)==1
      BSONi=1;
    else
      BSONi=-1;
    end
  end
  if seosetup(6)=='1' % for zigzag case
    BSONi=2;
    BSstring='ZigZag-';
  end
  
  if BSONi~=0 % show possible personalized rules if used, but not for long-short combined outputs.
    if (BSONi==1)|(BSONi==2) % for buy models
      %stop: seosetup(16:17)
      if seosetup(16)=='1'
        Mynet=[Mynet,sprintf([' Source codes attached with Stop Any 1 at ',BSstring,'BUY side:\n'])];
        Mynet=[Mynet,sprintf([fpwout.hdfpwpstopa1b,'\n\n'])];
      end
      if seosetup(17)=='1'
        Mynet=[Mynet,sprintf([' Source codes attached with Stop Any 2 at ',BSstring,'BUY side:\n'])];
        Mynet=[Mynet,sprintf([fpwout.hdfpwpstopa2b,'\n\n'])];
      end
      
      %exit: seosetup(7:8)
      if seosetup(7)=='1'
        Mynet=[Mynet,sprintf([' Source codes attached with Exit Any 1 at ',BSstring,'BUY side:\n'])];
        Mynet=[Mynet,sprintf([fpwout.hdfpwpexita1b,'\n\n'])];
      end
      if seosetup(8)=='1'
        Mynet=[Mynet,sprintf([' Source codes attached with Exit Any 2 at ',BSstring,'BUY side:\n'])];
        Mynet=[Mynet,sprintf([fpwout.hdfpwpexita2b,'\n\n'])];
      end
      
      %obje: seosetup(25:26)
      if seosetup(25)=='1'
        Mynet=[Mynet,sprintf([' Source codes attached with OBJE. Any 1 at ',BSstring,'BUY side:\n'])];
        Mynet=[Mynet,sprintf([fpwout.hdfpwpobjea1b,'\n\n'])];
      end
      if seosetup(26)=='1'
        Mynet=[Mynet,sprintf([' Source codes attached with OBJE. Any 2 at ',BSstring,'BUY side:\n'])];
        Mynet=[Mynet,sprintf([fpwout.hdfpwpobjea2b,'\n\n'])];
      end
    end
    
    if (BSONi==-1)|(BSONi==2)
      %stop: seosetup(16:17)
      if seosetup(16)=='1'
        Mynet=[Mynet,sprintf([' Source codes attached with Stop Any 1 at ',BSstring,'SELL side:\n'])];
        Mynet=[Mynet,sprintf([fpwout.hdfpwpstopa1s,'\n\n'])];
      end
      if seosetup(17)=='1'
        Mynet=[Mynet,sprintf([' Source codes attached with Stop Any 2 at ',BSstring,'SELL side:\n'])];
        Mynet=[Mynet,sprintf([fpwout.hdfpwpstopa2s,'\n\n'])];
      end
      
      %exit: seosetup(7:8)
      if seosetup(7)=='1'
        Mynet=[Mynet,sprintf([' Source codes attached with Exit Any 1 at ',BSstring,'SELL side:\n'])];
        Mynet=[Mynet,sprintf([fpwout.hdfpwpexita1s,'\n\n'])];
      end
      if seosetup(8)=='1'
        Mynet=[Mynet,sprintf([' Source codes attached with Exit Any 2 at ',BSstring,'SELL side:\n'])];
        Mynet=[Mynet,sprintf([fpwout.hdfpwpexita2s,'\n\n'])];
      end
      
      %obje: seosetup(25:26)
      if seosetup(25)=='1'
        Mynet=[Mynet,sprintf([' Source codes attached with OBJE. Any 1 at ',BSstring,'SELL side:\n'])];
        Mynet=[Mynet,sprintf([fpwout.hdfpwpobjea1s,'\n\n'])];
      end
      if seosetup(26)=='1'
        Mynet=[Mynet,sprintf([' Source codes attached with OBJE. Any 2 at ',BSstring,'SELL side:\n'])];
        Mynet=[Mynet,sprintf([fpwout.hdfpwpobjea2s,'\n\n'])];
      end
    end
  end  
  
  Mynet=[Mynet,sprintf(['       The Money Management rules: \n\n'])];
  Mynet=[Mynet,sprintf(['                     Entry: \n'])];
  Mynet=[Mynet,sprintf(['                The Market: ',fpwout.mname,'-',upper(fpwout.name),'\n'])];
  Mynet=[Mynet,sprintf(['             Second FSName: ',fpwout.zhu101,'\n'])];
  Mynet=[Mynet,sprintf(['              Third FSName: ',fpwout.zhu1013,'\n'])];
  Mynet=[Mynet,sprintf(['             Fourth FSName: ',fpwout.zhu1014,'\n'])];
  Mynet=[Mynet,sprintf(['              Fifth FSName: ',fpwout.zhu1015,'\n'])];
  Mynet=[Mynet,sprintf(['                 From Date: ',fpwout.zhu52,', ',fpwout1.outFdate,'\n'])];
  Mynet=[Mynet,sprintf(['                   To Date: ',fpwout.zhu54,', ',fpwout1.outTdate,'\n'])];
  Mynet=[Mynet,sprintf(['                       S+C: ',fpwout.zhu75,'\n'])];
  Mynet=[Mynet,sprintf(['          PBKE(Next Scale): ',fpwout.PBKE,'\n'])];
  Mynet=[Mynet,sprintf(['                      Tic$: ',fpwout.ent01,'\n'])];
  Mynet=[Mynet,sprintf(['                     Scale: ',fpwout.ent02,'\n'])];
  Mynet=[Mynet,sprintf(['                      Lots: ',fpwout.ent03,'\n'])];
  Mynet=[Mynet,sprintf(['         MMS Managing Rule: ',fpwout.marent03,'\n'])];
  Mynet=[Mynet,sprintf(['           Add Noise Level: ',fpwout.fpwaddnoise,'\n\n'])];
  
  Mynet=[Mynet,sprintf(['                     STOPs: ',seosetup(9:17),'\n'])];
  Mynet=[Mynet,sprintf(['                            123456789\n'])];
  Mynet=[Mynet,sprintf(['              ',seosetupstar(9),' Stop 1 - 1: ',fpwout.zhu81,'\n'])];
  Mynet=[Mynet,sprintf(['                         2: ',fpwout.tkdv,'\n'])];
  Mynet=[Mynet,sprintf(['              ',seosetupstar(10),' Stop 2 - 1: ',fpwout.zhu17l,'\n'])];
  Mynet=[Mynet,sprintf(['                         2: ',fpwout.zhu82,'\n'])];
  Mynet=[Mynet,sprintf(['              ',seosetupstar(11),' Stop 3 - 1: ',fpwout.zhu59,'\n'])];
  Mynet=[Mynet,sprintf(['                         2: ',fpwout.zhu83,'\n'])];
  Mynet=[Mynet,sprintf(['                         3: ',fpwout.zhu84,'\n'])];
  Mynet=[Mynet,sprintf(['              ',seosetupstar(12),' Stop 4 - 1: ',fpwout.zhu85,'\n'])];
  Mynet=[Mynet,sprintf(['              ',seosetupstar(13),' Stop 5 - 1: ',fpwout.zhu86,'\n'])];
  Mynet=[Mynet,sprintf(['                         2: ',fpwout.zhu87,'\n'])];
  Mynet=[Mynet,sprintf(['              ',seosetupstar(14),' Stop 6 - 1: ',fpwout.zhu88,'\n'])];
  Mynet=[Mynet,sprintf(['                         2: ',fpwout.zhu89,'\n'])];
  Mynet=[Mynet,sprintf(['              ',seosetupstar(15),' Stop 7 - 1: ',fpwout.new401,'\n'])];
  Mynet=[Mynet,sprintf(['                         2: ',fpwout.new402,'\n'])];
  Mynet=[Mynet,sprintf(['              ',seosetupstar(16),' Stop 8 - 1: ',fpwout.new303,'\n'])];
  Mynet=[Mynet,sprintf(['                         2: ',fpwout.new304,'\n'])];
  Mynet=[Mynet,sprintf(['              ',seosetupstar(17),' Stop 9 - 1: ',fpwout.zhu732,'\n'])];
  Mynet=[Mynet,sprintf(['                         2: ',fpwout.zhu733,'\n\n'])];
  
  Mynet=[Mynet,sprintf(['                     EXITs: ',seosetup(1:8),'\n'])];
  Mynet=[Mynet,sprintf(['                            12345678\n'])];
  Mynet=[Mynet,sprintf(['              ',seosetupstar(1),' Exit 1 - 1: ',fpwout.zhu04s,'\n'])];
  Mynet=[Mynet,sprintf(['                         2: ',fpwout.zhu200,'\n'])];
  Mynet=[Mynet,sprintf(['                         3: ',fpwout.zhu61,'\n'])];
  Mynet=[Mynet,sprintf(['                         4: ',fpwout.zhu62,'\n'])];
  Mynet=[Mynet,sprintf(['              ',seosetupstar(2),' Exit 2 - 1: ',fpwout.zhu63,'\n'])];
  Mynet=[Mynet,sprintf(['              ',seosetupstar(3),' Exit 3 - 1: ',fpwout.zhu64,'\n'])];
  Mynet=[Mynet,sprintf(['              ',seosetupstar(4),' Exit 4 - 1: ',fpwout.zhu65new,'\n'])];
  Mynet=[Mynet,sprintf(['                         2: ',fpwout.zhu65,'\n'])];
  Mynet=[Mynet,sprintf(['                         3: ',fpwout.zhu66,'\n'])];
  Mynet=[Mynet,sprintf(['              ',seosetupstar(5),' Exit 5 - 1: ',fpwout.zhu67new,'\n'])];
  Mynet=[Mynet,sprintf(['                         2: ',fpwout.zhu67,'\n'])];
  Mynet=[Mynet,sprintf(['                         3: ',fpwout.zhu68,'\n'])];
  Mynet=[Mynet,sprintf(['              ',seosetupstar(6),' Exit 6 - 1: ZigZag\n'])];
  Mynet=[Mynet,sprintf(['              ',seosetupstar(7),' Exit 7 - 1: ',fpwout.new301,'\n'])];
  Mynet=[Mynet,sprintf(['                         2: ',fpwout.new302,'\n'])];
  Mynet=[Mynet,sprintf(['              ',seosetupstar(8),' Exit 8 - 1: ',fpwout.zhu722,'\n'])];
  Mynet=[Mynet,sprintf(['                         2: ',fpwout.zhu723,'\n\n'])];
  
  Mynet=[Mynet,sprintf(['                OBJECTIVEs: ',seosetup(18:26),'\n'])];
  Mynet=[Mynet,sprintf(['                            123456789\n'])];
  Mynet=[Mynet,sprintf(['            ',seosetupstar(18),' Object 1 - 1: ',fpwout.zhu91,'\n'])];
  Mynet=[Mynet,sprintf(['                         2: ',fpwout.obje2nd,'\n'])];
  Mynet=[Mynet,sprintf(['            ',seosetupstar(19),' Object 2 - 1: ',fpwout.zhu98,'\n'])];
  Mynet=[Mynet,sprintf(['            ',seosetupstar(20),' Object 3 - 1: ',fpwout.zhu92,'\n'])];
  Mynet=[Mynet,sprintf(['                         2: ',fpwout.zhu93,'\n'])];
  Mynet=[Mynet,sprintf(['            ',seosetupstar(21),' Object 4 - 1: ',fpwout.zhu22l,'\n'])];
  Mynet=[Mynet,sprintf(['                         2: ',fpwout.zhu94,'\n'])];
  Mynet=[Mynet,sprintf(['            ',seosetupstar(22),' Object 5 - 1: ',fpwout.zhu24l,'\n'])];
  Mynet=[Mynet,sprintf(['                         2: ',fpwout.zhu95,'\n'])];
  Mynet=[Mynet,sprintf(['            ',seosetupstar(23),' Object 6 - 1: ',fpwout.zhu96,'\n'])];
  Mynet=[Mynet,sprintf(['                         2: ',fpwout.zhu97,'\n'])];
  Mynet=[Mynet,sprintf(['            ',seosetupstar(24),' Object 7 - 1: ',fpwout.new403,'\n'])];
  Mynet=[Mynet,sprintf(['                         2: ',fpwout.new404,'\n'])];
  Mynet=[Mynet,sprintf(['            ',seosetupstar(25),' Object 8 - 1: ',fpwout.new305,'\n'])];
  Mynet=[Mynet,sprintf(['                         2: ',fpwout.new306,'\n'])];
  Mynet=[Mynet,sprintf(['            ',seosetupstar(26),' Object 9 - 1: ',fpwout.zhu742,'\n'])];
  Mynet=[Mynet,sprintf(['                         2: ',fpwout.zhu743,'\n'])];
  s.mywbfpwhistrec=Mynet;
  if ~(strcmp(upper(fpwusername),'NINGZHU')|strcmp(upper(fpwusername),'AARONZHU')|...
          strcmp(upper(fpwusername),'DIANEXU'))
    s.mywbfpwhistrec='Model Details are not Available.';
  end
else
  s.mywbfpwhistrec='wrong user information.';  
end
s.fpwusername=fpwusername;
s.fpwusername4=instruct.mlid4;
s.fpwulvl=instruct.fpwulvl;
s.fpwshowtitle='Below are the setup details for the latest showing model.';
s.myShowingTitle='Simulation Setup';

cids=fpwloginstatus(fpwusername,clock);
templatefile = which('wbfpwhistrec.html');
if (nargin == 1)
  retstr = htmlrep(s, templatefile);
elseif (nargin == 2)
  retstr = htmlrep(s, templatefile, outfile);
end