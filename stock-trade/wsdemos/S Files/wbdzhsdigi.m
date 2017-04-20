function retstr = wbdzhsdigi(instruct, outfile)

% Author(s): N. Zhu, 11-15-2003
% This is a WB (Web-Based) mirror program to <dzhsdigi.m> in desktop version
%save c:\matlab\stock\mybugfind12
wbfpwbasic;
cd(fpwserverplace);
retstr = char('');
fpwusername=instruct.mlid{1};
fpwCPAL=1.3;
fpwloginIP='192.168.2.8';
fpwcheckil;

if (isfield(instruct,'zsobx31'))
  cd([Wherematlab,'pattern']);
  if fpwsecucheck([instruct.zsobx31,instruct.zsobx53,instruct.zsobx57])>0
    error(' Hei! Not allowed content found, are you seriously trying to .... Sorry, change it.');
  end
  cd(fpwserverplace);
end

if fpwcheckilpass==1

eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbdzhinput instruct']); 
wbdzhsid=1; eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbdzhsort wbdzhsid']); 

fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
fseek(fid1,-50,1); fprintf(fid1,[time,' MPDS\n']); fclose(fid1);
clear fid1

cd([Wherematlab,'stock']);

%if (strcmp(instruct.hdzsobx39,'Link'))
  ToD=instruct.hdzsobx311;
%else
%  ToD='D';
%end

global SInd PE CAP KWIN RmSI RmKW
SInd=str2num(instruct.zsobxSG); KWIN='1'; RmSI=[]; RmKW='1';

urbanwords='';
[fpwscpass1,whereban1,whatban1]=wbcheckbanw('MPGF',instruct.zsobx31);
if fpwscpass1~=1
  urbanwords=[urbanwords,whereban1,': ',whatban1,'; '];
end    
[fpwscpass2,whereban1,whatban1]=wbcheckbanw('MPDS',instruct.zsobx57);
if fpwscpass2~=1
  urbanwords=[urbanwords,whereban1,': ',whatban1,'; '];
end 
[fpwscpass3,whereban1,whatban1]=wbcheckbanw('DZHSave',instruct.zsobx53);
if fpwscpass3~=1
  urbanwords=[urbanwords,whereban1,': ',whatban1,'; '];
end 
if (fpwscpass1+fpwscpass2+fpwscpass3)~=3
  fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
  fseek(fid1,-50,1); fprintf(fid1,[time,' FAIL: ',urbanwords,'\n']); fclose(fid1);
  clear fid1    
  outstruct.mpgfoutput=['Banned word found: ',urbanwords];
  clear urbanwords fpwscpass1 whereban1 whatban1 fpwscpass2 fpwscpass3
else
  if (instruct.zsobx71=='V')
    LINKForm='wbstockqdv';
  end
  if (instruct.zsobx71=='P')
	LINKForm='wbstockqd';			
  end 		
  if (instruct.zsobx71=='Z')
	LINKForm='wbstfpz691';
  end		
  if (instruct.zsobx71=='W')
	LINKForm='wbstswing';
  end		
  if (instruct.zsobx71=='S')
	LINKForm='wbstsea';
  end		
  if (instruct.zsobx71=='N')
	LINKForm='wbstsnr';			
  end		
  if (instruct.zsobx71=='D')
	LINKForm='wbstchart';
  end		
  if (instruct.zsobx71=='L')
	LINKForm='wbstleadi';
  end		
  if (instruct.zsobx71=='R')
	LINKForm='wbstrdata';	
  end		
  if (instruct.zsobx71=='F')
	LINKForm='wbsttoyahoo';
  end		
  if (instruct.zsobx71=='E')
	LINKForm='wbsttoyahoo';							
  end
  if (instruct.zsobx71=='A')
	LINKForm='wbstanalog';	
  end    
  if (instruct.zsobx71=='F')
    YLFN='F';
  elseif (instruct.zsobx71=='E')
    YLFN='E'; 
  else
    YLFN='S';
  end
    
  linecond=instruct.zsobx31;
  if length(noempty(linecond))>0
    if length(find(linecond>=32))>0
      linecond=linecond(find(linecond>=32));
    end
  end
  if length(noempty(linecond))<4; linecond='C0>0;'; end
  
  % reduce case sensitive barrier for PE CAP YD and others, one can even use Cap, cAp, Pe or other anyways
  if length(noempty(linecond))>0
    SIndplaceh1=strfind(upper(linecond),'PE');
    if length(SIndplaceh1)>0
      for ijkl=1:length(SIndplaceh1)
        linecond(SIndplaceh1(ijkl):SIndplaceh1(ijkl)+1)='PE';
      end
    end
    SIndplaceh1=strfind(upper(linecond),'YD');
    if length(SIndplaceh1)>0
      for ijkl=1:length(SIndplaceh1)
        linecond(SIndplaceh1(ijkl):SIndplaceh1(ijkl)+1)='YD';
      end
    end
    SIndplaceh1=strfind(upper(linecond),'CAP');
    if length(SIndplaceh1)>0
      for ijkl=1:length(SIndplaceh1)
        linecond(SIndplaceh1(ijkl):SIndplaceh1(ijkl)+2)='CAP';
      end
    end
    SIndplaceh1=strfind(upper(linecond),'PTB');
    if length(SIndplaceh1)>0
      for ijkl=1:length(SIndplaceh1)
        linecond(SIndplaceh1(ijkl):SIndplaceh1(ijkl)+2)='PTB';
      end
    end
    SIndplaceh1=strfind(upper(linecond),'PTCF');
    if length(SIndplaceh1)>0
      for ijkl=1:length(SIndplaceh1)
        linecond(SIndplaceh1(ijkl):SIndplaceh1(ijkl)+3)='PTCF';
      end
    end
    SIndplaceh1=strfind(upper(linecond),'PTS');
    if length(SIndplaceh1)>0
      for ijkl=1:length(SIndplaceh1)
        linecond(SIndplaceh1(ijkl):SIndplaceh1(ijkl)+2)='PTS';
      end
    end
    SIndplaceh1=strfind(upper(linecond),'BPS');
    if length(SIndplaceh1)>0
      for ijkl=1:length(SIndplaceh1)
        linecond(SIndplaceh1(ijkl):SIndplaceh1(ijkl)+2)='BPS';
      end
    end
    SIndplaceh1=strfind(upper(linecond),'CPS');
    if length(SIndplaceh1)>0
      for ijkl=1:length(SIndplaceh1)
        linecond(SIndplaceh1(ijkl):SIndplaceh1(ijkl)+2)='CPS';
      end
    end
    SIndplaceh1=strfind(upper(linecond),'SPS');
    if length(SIndplaceh1)>0
      for ijkl=1:length(SIndplaceh1)
        linecond(SIndplaceh1(ijkl):SIndplaceh1(ijkl)+2)='SPS';
      end
    end
    SIndplaceh1=strfind(upper(linecond),'EPS');
    if length(SIndplaceh1)>0
      for ijkl=1:length(SIndplaceh1)
        linecond(SIndplaceh1(ijkl):SIndplaceh1(ijkl)+2)='EPS';
      end
    end
    SIndplaceh1=strfind(upper(linecond),'TSO');
    if length(SIndplaceh1)>0
      for ijkl=1:length(SIndplaceh1)
        linecond(SIndplaceh1(ijkl):SIndplaceh1(ijkl)+2)='TSO';
      end
    end
    SIndplaceh1=strfind(upper(linecond),'SFL');
    if length(SIndplaceh1)>0
      for ijkl=1:length(SIndplaceh1)
        linecond(SIndplaceh1(ijkl):SIndplaceh1(ijkl)+2)='SFL';
      end
    end
    SIndplaceh1=strfind(upper(linecond),'SSH');
    if length(SIndplaceh1)>0
      for ijkl=1:length(SIndplaceh1)
        linecond(SIndplaceh1(ijkl):SIndplaceh1(ijkl)+2)='SSH';
      end
    end
    SIndplaceh1=strfind(upper(linecond),'CCODE');
    if length(SIndplaceh1)>0
      for ijkl=1:length(SIndplaceh1)
        linecond(SIndplaceh1(ijkl):SIndplaceh1(ijkl)+4)='CCODE';
      end
    end
    SIndplaceh1=strfind(upper(linecond),'BETA');
    if length(SIndplaceh1)>0
      for ijkl=1:length(SIndplaceh1)
        linecond(SIndplaceh1(ijkl):SIndplaceh1(ijkl)+3)='BETA';
      end
    end
    SIndplaceh1=strfind(upper(linecond),'NOE');
    if length(SIndplaceh1)>0
      for ijkl=1:length(SIndplaceh1)
        linecond(SIndplaceh1(ijkl):SIndplaceh1(ijkl)+2)='NOE';
      end
    end
  end
  
  % Extra Sector Index:
  if length(noempty(linecond))>0
    SIndplaceh1=strfind(upper(linecond),'SIND');
    if length(SIndplaceh1)>0
      linecondne=linecond(SIndplaceh1(1)+4:length(linecond));
      SIndplaceh=strfind(linecondne,';');
      if length(SIndplaceh)>0
        if SIndplaceh(1)>1
          sectorindexstring=linecondne(1:SIndplaceh(1)-1);
          sectorindexstring=sectorindexstring(find(sectorindexstring~='='));
          eval(['SIndextra=',sectorindexstring,';']); % can input more than one sector in a vector format [3.14 5.06]
          SInd=[SInd SIndextra];
          linecond(SIndplaceh1(1):SIndplaceh1(1)+4+SIndplaceh(1)-1)=['1;',blanks(2+SIndplaceh(1))];
          clear sectorindexstring
        else
          error('  Empty Sector filter condition, plese enter in the form of ''SInd=x;''.1'); 
        end
      else
        error('  missing '';'', Sector filter condition must be in the format of ''SInd=x;''.2'); 
      end
    end
    clear SIndplaceh SIndplaceh1
  end 
  
  % RoMoving Sector Index:
  if length(noempty(linecond))>0
    SIndplaceh1=strfind(upper(linecond),'RMSI');
    if length(SIndplaceh1)>0
      linecondne=linecond(SIndplaceh1(1)+4:length(linecond));
      SIndplaceh=strfind(linecondne,';');
      if length(SIndplaceh)>0
        if SIndplaceh(1)>1
          sectorindexstring=linecondne(1:SIndplaceh(1)-1);
          sectorindexstring=sectorindexstring(find(sectorindexstring~='='));
          eval(['SIndextra=',sectorindexstring,';']); % can input more than one sector in a vector format [3.14 5.06]
          RmSI=SIndextra;
          linecond(SIndplaceh1(1):SIndplaceh1(1)+4+SIndplaceh(1)-1)=['1;',blanks(2+SIndplaceh(1))];
          clear sectorindexstring
        else
          error('  Empty Sector filter condition, plese enter in the form of ''RmSI=x;''.1'); 
        end
      else
        error('  missing '';'', Sector filter condition must be in the format of ''RmSI=x;''.2'); 
      end
    end
    clear SIndplaceh SIndplaceh1
  end   
  
  % Kew Word in company Names
  if length(noempty(linecond))>0
    SIndplaceh1=strfind(upper(linecond),'KWIN');
    if length(SIndplaceh1)>0
      linecondne=linecond(SIndplaceh1(1)+4:length(linecond));
      SIndplaceh=strfind(linecondne,';');
      if length(SIndplaceh)>0
        if SIndplaceh(1)>1
          KWIN=noempty(linecondne(1:SIndplaceh(1)-1));
          if length(KWIN)>0
            KWIN=KWIN(find(KWIN~='='));
            if length(KWIN)>0
              KWIN=KWIN(find(KWIN~='''')); %char(39)));
            else
              KWIN='1'; 
            end
          else
            KWIN='1'; 
          end
          linecond(SIndplaceh1(1):SIndplaceh1(1)+4+SIndplaceh(1)-1)=['1;',blanks(2+SIndplaceh(1))];
        else
          error('  empty key words, please enter in the form of ''KWIN=strings;''.1'); 
        end
      else
        error('  missing '';'', key works condition must be in the form of ''KWIN=strings;''.2'); 
      end
    end
    clear SIndplaceh SIndplaceh1
  end
  
  % Remove Kew Word in company Names
  if length(noempty(linecond))>0
    SIndplaceh1=strfind(upper(linecond),'RMKW');
    if length(SIndplaceh1)>0
      linecondne=linecond(SIndplaceh1(1)+4:length(linecond));
      SIndplaceh=strfind(linecondne,';');
      if length(SIndplaceh)>0
        if SIndplaceh(1)>1
          RmKW=noempty(linecondne(1:SIndplaceh(1)-1));
          if length(RmKW)>0
            RmKW=RmKW(find(RmKW~='='));
            if length(RmKW)>0
              RmKW=RmKW(find(RmKW~='''')); %char(39)));
            else
              RmKW='1';
            end
          else
            RmKW='1';    
          end
          linecond(SIndplaceh1(1):SIndplaceh1(1)+4+SIndplaceh(1)-1)=['1;',blanks(2+SIndplaceh(1))];
        else
          error('  empty key words, please enter in the form of ''RmKW=strings;''.1'); 
        end
      else
        error('  missing '';'', key works condition must be in the form of ''RmKW=strings;''.2'); 
      end
    end
    clear SIndplaceh SIndplaceh1
  end
  
  if length(noempty(linecond))<4; linecond='C0>0;'; end
  
  i=1; condi={};
  while(i<19)
    [condii linecond]=strtok(linecond,';');
    if (~length(condii)), break; end
    if (length(noempty(condii))>0)
      condi{i}=condii;i=i+1; 
    end
  end      
   
  while (i<19)
    condi{i}='1';i=i+1;  
  end
  
  combcondi1=['(',condi{1},')&(',condi{2},')&(',condi{3},')'];
  combcondi2=['(',condi{4},')&(',condi{5},')&(',condi{6},')'];
  combcondi3=['(',condi{7},')&(',condi{8},')&(',condi{9},')'];
  combcondi4=['(',condi{10},')&(',condi{11},')&(',condi{12},')'];
  combcondi5=['(',condi{13},')&(',condi{14},')&(',condi{15},')'];
  combcondi6=['(',condi{16},')&(',condi{17},')&(',condi{18},')'];
  
  OoM=1;
  TSFN=upper(noempty(instruct.zsobx53));
  if (strcmp(upper(fpwusername),'NINGZHU'))&(strcmp(TSFN,'PSPX')|strcmp(TSFN,'PNSPX'))
    OoM=0;
  end
  
  [y2 y1]=stfilter(combcondi1,combcondi2,combcondi3,combcondi4,combcondi5,combcondi6,ToD,OoM); clear y2
  load nlt
  if (strcmp(instruct.zsobx312,'AllMrkts')==0)  %&(strcmp(instruct.hdzsobx39,'Link'))
    rndx=zeros(length(namelist(:,1)),1);
    rndx(y1)=ones(size(y1));
    y1=rndx;
    rndx=ones(length(namelist(:,1)),1);
    smarket=instruct.zsobx312; % ano(123),4-all
      if (strcmp(smarket,'NYSE')==1)
        rMrK=2; 
      end
      if (strcmp(smarket,'AMEX')==1)
        rMrK=1;
      end
      if (strcmp(smarket,'Nasdaq')==1)
        rMrK=3;
      end
      if (strcmp(smarket,'AllMrkts')==1)
        rMrK=4; 
      end
    if (rMrK==1)
      rndx(market(1):length(rndx))=zeros(length(rndx)-market(1)+1,1);
    elseif (rMrK==2)
      rndx(1:market(2)-1)=zeros(market(2)-1,1);
    elseif (rMrK==3)
      rndx(1:market(1)-1)=zeros(market(1)-1,1);
      rndx(market(2):length(rndx))=zeros(length(rndx)-market(2)+1,1);
    end
    y1=y1.*rndx;
    y1=find(y1==1);
  end
  
  load stchour1 pvolume vol51% ohlcvn
  %!copy x:\stock\fpwnltlast.mat c:\matlab\stock
  load fpwnltlast
  ohlcvn=[fpwnltlast(:,1:6) pvolume/100000];
  ohlcvnT=[fpwnltlast(:,7:12) vol51/1000];
  ohlcvn(:,2)=(max((ohlcvn(:,1:4))'))';
  ohlcvn(:,3)=(min((ohlcvn(:,1:4))'))';
  ohlcvnT(:,2)=(max((ohlcvnT(:,1:4))'))';
  ohlcvnT(:,3)=(min((ohlcvnT(:,1:4))'))'; 
  NPPV=0*ohlcvn(:,1);
  rToD=instruct.hdzsobx55;
  cuslenf=length(y1);
    
  % The next two lines are exclusively for column 13 and 14 only (index and company full name).
  load fpwnlt sectorind namelistd NOE CCODE outstandshare
  namelistd=fpwnamelist(namelistd);
  
  tradinghours=0;
  timevalue=clock;
  markethourst;
  timecal=timevalue(4)+timevalue(5)/60;
  datetoday=[timevalue(2:3) timevalue(1)-2000];
  tradingdays=0;
  if (closehourt>openhourt)&(dn(datetoday)<=5)
    tradingdays=1; 
  end  
  if (timecal>openhourt+1/12)&(timecal<closehourt+1/12)&(dn(datetoday)<=5)
    if closehourt>openhourt
      tradinghours=1;
    end
  end
  
  if cuslenf > 0
    linecond=instruct.zsobx57;
    linecond=linecond(find(linecond>=32));  
    
    linecondne=noempty(linecond);
    datalengthb=strfind(linecondne,'i>');
    if length(datalengthb)==0
      error(' Codes format is wrong,  without ''if (i>??);'' or ''if i>??;'' command in the first line.');
    else
      linecondne=linecondne(datalengthb(1):length(linecondne));
      datalengthb=3;
    end
    
    datalengthe=strfind(linecondne,';');
    if length(datalengthe)==0
      error(' Codes format is wrong,  should end each command by '';''. ');
    else
      datalengthe=datalengthe(1)-1;
      while (strcmp(linecondne(datalengthe),')'))|(strcmp(linecondne(datalengthe),' '))
        datalengthe=datalengthe(1)-1; 
      end
    end
    
    if datalengthb>datalengthe
      error(' Codes format is wrong,  without ''if (i>??);'' or ''if i>??;'' command in the first line.');
    else  
      if sum(isletter(linecondne(datalengthb:datalengthe)))==0
        datalength=fix(1.2*str2num(linecondne(datalengthb:datalengthe)));
      else
        error(' Codes format is wrong,  without ''if (i>??);'' or ''if i>??;'' command in the first line.');
      end
    end
    
    % find the other D/T data length requirement
    linecondne=noempty(linecond);
    datalengthb=strfind(linecondne,'k>');
    if length(datalengthb)>0
      linecondne=linecondne(datalengthb(1):length(linecondne));
      datalengthb=3;
      
      datalengthe=strfind(linecondne,';');
      if length(datalengthe)==0
        error(' Codes format is wrong,  should end each command by '';''. ');
      else
        datalengthe=datalengthe(1)-1;
        while (strcmp(linecondne(datalengthe),')'))|(strcmp(linecond(datalengthe),' '))
          datalengthe=datalengthe(1)-1; 
        end
      end
      
      if datalengthb>datalengthe
        error(' Codes format is wrong,  without ''if (k>??);'' or ''if k>??;'' command in the first line.');
      else  
        if sum(isletter(linecondne(datalengthb:datalengthe)))==0
          datalengthtd=fix(1.2*str2num(linecondne(datalengthb:datalengthe)));
        else
          error(' Codes format is wrong,  without ''if (k>??);'' or ''if k>??;'' command in the first line.');
       end
      end
    else
      datalengthtd=20;
    end
    
    myvh=['ac3  =       ma(c,  3);';
          'ac6  =       ma(c,  6);';
          'ac12 =       ma(c, 12);';
          'ac25 =       ma(c, 25);';
          'ac75 =       ma(c, 75);';
          'ac250=       ma(c,250);';
          'av3  =       ma(v,  3);';
          'av6  =       ma(v,  6);';
          'av12 =       ma(v, 12);';
          'av25 =       ma(v, 25);';
          'av75 =       ma(v, 75);';
          'av250=       ma(v,250);';
          'h250=      maxv(h,250);';
          'l250=      minv(l,250);';
          'h25 =       maxv(h,25);';
          'l25 =       minv(l,25);';
          'h75 =       maxv(h,75);';
          'l75 =       minv(l,75);';
          'h3  =       maxv(h, 3);';
          'l3  =       minv(l, 3);';
          'h6  =       maxv(h, 6);';
          'l6  =       minv(l, 6);';
          'h12 =       maxv(h,12);';
          'l12 =       minv(l,12);';
          'c3m  =mtm(ma(c,  3),1);';
          'c6m  =mtm(ma(c,  6),1);';
          'c12m =mtm(ma(c, 12),1);';
          'c25m =mtm(ma(c, 25),1);';
          'c75m =mtm(ma(c, 75),1);';
          'c250m=mtm(ma(c,250),1);';
          'h500=      maxv(h,500);';
          'l500=      minv(l,500);';
          'rsi7=      rsiall(c,7);';
          'rsi14=    rsiall(c,14);';
          'rsi30=    rsiall(c,30);'];
      
    myvhi=zeros(1,35);
    
    mympptlines=[];
    if (strcmp(upper(fpwusername),'NINGZHU')==1)|(strcmp(upper(fpwusername),'DIANEXU')==1)
      fidmppt=-1;
      if 1
        if length(strfind(lower(linecond),'mymppt'))>0
          mympptind=strfind(lower(linecond),'mymppt');
          mympptindi=0;
          while linecond(mympptind(1)+6+mympptindi)~=';'
            mympptindi=mympptindi+1;
          end
          filenametop=linecond(mympptind(1):mympptind(1)+5+mympptindi);
          fidmppt=fopen([filenametop,'.m'],'r');
        end
        clear mympptindi mympptind
      else
        if length(strfind(lower(linecond),'mympptspx'))>0
          fidmppt=fopen('mympptspx.m','r');
        elseif length(strfind(lower(linecond),'mympptwtspx'))>0
          fidmppt=fopen('mympptwtspx.m','r');
        end
      end
      if ~(fidmppt==-1)
        while 1
          mymppttline = fgetl(fidmppt);
          if ~ischar(mymppttline), break, end
          mympptlines=[mympptlines,mymppttline];
        end
        fclose(fidmppt);
      end
    end
    mympptlines=[mympptlines,linecond];
    
    if length(strfind([linecond,mympptlines],'ac3'))>0;   myvhi(1)=1;  end
    if length(strfind([linecond,mympptlines],'ac6'))>0;   myvhi(2)=1;  end
    if length(strfind([linecond,mympptlines],'ac12'))>0;  myvhi(3)=1;  end
    if length(strfind([linecond,mympptlines],'ac25'))>0;  myvhi(4)=1;  end
    if length(strfind([linecond,mympptlines],'ac75'))>0;  myvhi(5)=1;  end
    if length(strfind([linecond,mympptlines],'ac250'))>0; myvhi(6)=1;  end
    if length(strfind([linecond,mympptlines],'av3'))>0;   myvhi(7)=1;  end
    if length(strfind([linecond,mympptlines],'av6'))>0;   myvhi(8)=1;  end
    if length(strfind([linecond,mympptlines],'av12'))>0;  myvhi(9)=1;  end
    if length(strfind([linecond,mympptlines],'av25'))>0;  myvhi(10)=1; end
    if length(strfind([linecond,mympptlines],'av75'))>0;  myvhi(11)=1; end
    if length(strfind([linecond,mympptlines],'av250'))>0; myvhi(12)=1; end
    if length(strfind([linecond,mympptlines],'h250'))>0;  myvhi(13)=1; end
    if length(strfind([linecond,mympptlines],'l250'))>0;  myvhi(14)=1; end
    if length(strfind([linecond,mympptlines],'h25'))>0;   myvhi(15)=1; end
    if length(strfind([linecond,mympptlines],'l25'))>0;   myvhi(16)=1; end
    if length(strfind([linecond,mympptlines],'h75'))>0;   myvhi(17)=1; end
    if length(strfind([linecond,mympptlines],'l75'))>0;   myvhi(18)=1; end
    if length(strfind([linecond,mympptlines],'h3'))>0;    myvhi(19)=1; end
    if length(strfind([linecond,mympptlines],'l3'))>0;    myvhi(20)=1; end
    if length(strfind([linecond,mympptlines],'h6'))>0;    myvhi(21)=1; end
    if length(strfind([linecond,mympptlines],'l6'))>0;    myvhi(22)=1; end 
    if length(strfind([linecond,mympptlines],'h12'))>0;   myvhi(23)=1; end
    if length(strfind([linecond,mympptlines],'l12'))>0;   myvhi(24)=1; end
    if length(strfind([linecond,mympptlines],'c3m'))>0;   myvhi(25)=1; end
    if length(strfind([linecond,mympptlines],'c6m'))>0;   myvhi(26)=1; end
    if length(strfind([linecond,mympptlines],'c12m'))>0;  myvhi(27)=1; end
    if length(strfind([linecond,mympptlines],'c25m'))>0;  myvhi(28)=1; end
    if length(strfind([linecond,mympptlines],'c75m'))>0;  myvhi(29)=1; end
    if length(strfind([linecond,mympptlines],'c250m'))>0; myvhi(30)=1; end
    if length(strfind([linecond,mympptlines],'h500'))>0;  myvhi(31)=1; end
    if length(strfind([linecond,mympptlines],'l500'))>0;  myvhi(32)=1; end
    if length(strfind([linecond,mympptlines],'rsi7'))>0;  myvhi(33)=1; end
    if length(strfind([linecond,mympptlines],'rsi14'))>0; myvhi(34)=1; end
    if length(strfind([linecond,mympptlines],'rsi30'))>0; myvhi(35)=1; end
    
    SPXexistedh=1;
    if 0
      if length(strfind([linecond,mympptlines],'Xii1'))>0; SPXexistedh=1; end
      if length(strfind([linecond,mympptlines],'Xi6i1'))>0; SPXexistedh=1; end
      if length(strfind([linecond,mympptlines],'Xi12i1'))>0; SPXexistedh=1; end
      if length(strfind([linecond,mympptlines],'Xi25i1'))>0; SPXexistedh=1; end
      if length(strfind([linecond,mympptlines],'Xi75i1'))>0; SPXexistedh=1; end
      if length(strfind([linecond,mympptlines],'Xi250i1'))>0; SPXexistedh=1; end
      if length(strfind([linecond,mympptlines],'Xi25mi1'))>0; SPXexistedh=1; end
      if length(strfind([linecond,mympptlines],'Xi75mi1'))>0; SPXexistedh=1; end
      if length(strfind([linecond,mympptlines],'Xi250mi1'))>0; SPXexistedh=1; end
      if length(strfind([linecond,mympptlines],'Xsi1'))>0; SPXexistedh=1; end
      if length(strfind([linecond,mympptlines],'Xh0'))>0; SPXexistedh=1; end
      if length(strfind([linecond,mympptlines],'Xh3'))>0; SPXexistedh=1; end
      if length(strfind([linecond,mympptlines],'Xh6'))>0; SPXexistedh=1; end
      if length(strfind([linecond,mympptlines],'Xh12'))>0; SPXexistedh=1; end
      if length(strfind([linecond,mympptlines],'Xh25'))>0; SPXexistedh=1; end
      if length(strfind([linecond,mympptlines],'Xh75'))>0; SPXexistedh=1; end
      if length(strfind([linecond,mympptlines],'Xh250'))>0; SPXexistedh=1; end
      if length(strfind([linecond,mympptlines],'Xh500'))>0; SPXexistedh=1; end
      if length(strfind([linecond,mympptlines],'Xl0'))>0; SPXexistedh=1; end
      if length(strfind([linecond,mympptlines],'Xl3'))>0; SPXexistedh=1; end
      if length(strfind([linecond,mympptlines],'Xl6'))>0; SPXexistedh=1; end
      if length(strfind([linecond,mympptlines],'Xl12'))>0; SPXexistedh=1; end
      if length(strfind([linecond,mympptlines],'Xl25'))>0; SPXexistedh=1; end
      if length(strfind([linecond,mympptlines],'Xl75'))>0; SPXexistedh=1; end
      if length(strfind([linecond,mympptlines],'Xl250'))>0; SPXexistedh=1; end
      if length(strfind([linecond,mympptlines],'Xl500'))>0; SPXexistedh=1; end
    end
    
    if SPXexistedh==1
      XI=stgetdaa('spx',rToD,250+2*max([150 datalength]));
      if rToD=='D'
        XHI0=XI(:,5);  XLI0=XI(:,6); XI=XI(:,7); 
      else
        XHI0=XI(:,7);  XLI0=XI(:,8); XI=XI(:,9);
      end
      
      XHI250=maxv(XHI0,250);
      XLI250=minv(XLI0,250);
      XHI25=maxv(XHI0,25);
      XLI25=minv(XLI0,25);
      XHI75=maxv(XHI0,75);
      XLI75=minv(XLI0,75);
      XHI3=maxv(XHI0,3);
      XLI3=minv(XLI0,3);
      XHI6=maxv(XHI0,6);
      XLI6=minv(XLI0,6);
      XHI12=maxv(XHI0,12);
      XLI12=minv(XLI0,12); 
      XR7=rsiall(XI,7);
      XR14=rsiall(XI,14);
      XR30=rsiall(XI,30);
      XR100=rsiall(XI,100);
      XI6=ma(XI,6);
      XI12=ma(XI,12);
      XI25=ma(XI,25); XI25m=mtm(ma(XI25,2),1);
      XI75=ma(XI,75); XI75m=mtm(ma(XI75,6),2);
      XI250=ma(XI,250); XI250m=mtm(ma(XI250,15),5);
      XHI500=XHI250;
      XLI500=XLI250;
      
      Xs=mtm(XI,250)./(stdm(XI,250)+0.1);
      Xs=ma(ma(Xs,100),100)*100+1000; %either above 1200 or up 100 from low(250)
      XS=0*Xs;
      XHH=XS+100;
      for j=1:length(Xs)
        if (Xs(j)>1150)|(Xs(j)-70>min(Xs(max([1 j-150]):j-1)))
          XS(j)=1;
        end
        if j>250
          XHH(j)=max([XHH(j-1) XI(j)]);
          XHI500(j)=max([XHI250(j-250) XHI250(j)]);
          XLI500(j)=min([XLI250(j-250) XLI250(j)]);
        end 
      end
      %plot(XI);hold on; plot(Xs,'-g');plot(XS*100+1000,'-r'); grid; hold off;
    end
    
    for ii=1:cuslenf
      stock=[0 0 0 0 0];
      if rToD=='D'
        stock=stgetdaa(markfilt(namelist(y1(ii),:)),'D',400+max([19 datalength]));
        if length(stock)>0
          if tradinghours==1
            stock=[stock(:,4:8);ohlcvn(y1(ii),1:5)];
          else
            stock=stock(:,4:8);
          end
        end
        stockd=stgetdaa(markfilt(namelist(y1(ii),:)),'T',max([22 datalengthtd]));
        if length(stockd)>0
          if tradinghours==1
            stockd=[stockd(:,6:10);ohlcvnT(y1(ii),1:5)];
          else
            stockd=stockd(:,6:10);
          end
          [O H L C V]=wsov(stockd);k=length(O);   
        else
          O=[];
        end         
      else
        stock=stgetdaa(markfilt(namelist(y1(ii),:)),'T',max([19 datalength]));
        if length(stock)>0
          if tradinghours==1            
            stock=[stock(:,6:10);ohlcvnT(y1(ii),1:5)];
          else
            stock=stock(:,6:10);
          end
        end
        stockd=stgetdaa(markfilt(namelist(y1(ii),:)),'D',max([22 datalengthtd]));
        if length(stockd)>0
          if tradinghours==1
            stockd=[stockd(:,4:8);ohlcvn(y1(ii),1:5)];
          else
            stockd=stockd(:,4:8);
          end
          [O H L C V]=wsov(stockd);k=length(O);
        else
          O=[];
        end        
      end
      
      if SPXexistedh==1
        Xi=XI(length(XI)-length(stock(:,1))+1:length(XI));
        Xhi0=XHI0(length(XI)-length(stock(:,1))+1:length(XI));
        Xli0=XLI0(length(XI)-length(stock(:,1))+1:length(XI));
        Xhi3=XHI3(length(XI)-length(stock(:,1))+1:length(XI));
        Xli3=XLI3(length(XI)-length(stock(:,1))+1:length(XI));
        Xhi6=XHI6(length(XI)-length(stock(:,1))+1:length(XI));
        Xli6=XLI6(length(XI)-length(stock(:,1))+1:length(XI));
        Xhi12=XHI12(length(XI)-length(stock(:,1))+1:length(XI));
        Xli12=XLI12(length(XI)-length(stock(:,1))+1:length(XI));
        Xhi25=XHI25(length(XI)-length(stock(:,1))+1:length(XI));
        Xli25=XLI25(length(XI)-length(stock(:,1))+1:length(XI));
        Xhi75=XHI75(length(XI)-length(stock(:,1))+1:length(XI));
        Xli75=XLI75(length(XI)-length(stock(:,1))+1:length(XI));
        Xhi250=XHI250(length(XI)-length(stock(:,1))+1:length(XI));
        Xli250=XLI250(length(XI)-length(stock(:,1))+1:length(XI));
        Xhi500=XHI500(length(XI)-length(stock(:,1))+1:length(XI));
        Xli500=XLI500(length(XI)-length(stock(:,1))+1:length(XI));
        Xi6=XI6(length(XI)-length(stock(:,1))+1:length(XI));
        Xi12=XI12(length(XI)-length(stock(:,1))+1:length(XI));
        Xi25=XI25(length(XI)-length(stock(:,1))+1:length(XI));
        Xi75=XI75(length(XI)-length(stock(:,1))+1:length(XI));
        Xi250=XI250(length(XI)-length(stock(:,1))+1:length(XI));
        Xi25m=XI25m(length(XI)-length(stock(:,1))+1:length(XI));
        Xi75m=XI75m(length(XI)-length(stock(:,1))+1:length(XI));
        Xi250m=XI250m(length(XI)-length(stock(:,1))+1:length(XI));
        Xs=XS(length(XI)-length(stock(:,1))+1:length(XI));
        Xhh=XHH(length(XI)-length(stock(:,1))+1:length(XI));
        Xr7=XR7(length(XI)-length(stock(:,1))+1:length(XI));
        Xr14=XR14(length(XI)-length(stock(:,1))+1:length(XI));
        Xr30=XR30(length(XI)-length(stock(:,1))+1:length(XI));
        Xr100=XR100(length(XI)-length(stock(:,1))+1:length(XI));
      end
      
      % it's danger here but not need to reset!
      % do not use <ii y1 rToD cuslenf mn1 mn2 ftc NPPV l1 l2 l3 l4 l5 l6>
      % and one must use <i y o h l c v> as variables
      
      [o h l c v]=wsov(stock); i=length(o); j=y1(ii); k=length(O); y=0;
      sct=sectorind(j); noe=NOE(j); ccode=CCODE(j); cap=outstandshare(j)*c(i);
      lastshw=-1000; lastlow=-1000; lastshp=1000000; lastlop=0; % most recent last signal
      lastshw2=-1000; lastlow2=-1000; lastshp2=1000000; lastlop2=0; % second most recent signal
      lastshw3=-1000; lastlow3=-1000; lastshp3=1000000; lastlop3=0; % third most recent signal
      
      if myvhi(1)==1;  eval(myvh(1,:));  end
      if myvhi(2)==1;  eval(myvh(2,:));  end
      if myvhi(3)==1;  eval(myvh(3,:));  end
      if myvhi(4)==1;  eval(myvh(4,:));  end
      if myvhi(5)==1;  eval(myvh(5,:));  end
      if myvhi(6)==1;  eval(myvh(6,:));  end
      if myvhi(7)==1;  eval(myvh(7,:));  end
      if myvhi(8)==1;  eval(myvh(8,:));  end
      if myvhi(9)==1;  eval(myvh(9,:));  end
      if myvhi(10)==1; eval(myvh(10,:)); end
      if myvhi(11)==1; eval(myvh(11,:)); end
      if myvhi(12)==1; eval(myvh(12,:)); end
      if myvhi(13)==1; eval(myvh(13,:)); end
      if myvhi(14)==1; eval(myvh(14,:)); end
      if myvhi(15)==1; eval(myvh(15,:)); end
      if myvhi(16)==1; eval(myvh(16,:)); end
      if myvhi(17)==1; eval(myvh(17,:)); end
      if myvhi(18)==1; eval(myvh(18,:)); end
      if myvhi(19)==1; eval(myvh(19,:)); end
      if myvhi(20)==1; eval(myvh(20,:)); end
      if myvhi(21)==1; eval(myvh(21,:)); end
      if myvhi(22)==1; eval(myvh(22,:)); end
      if myvhi(23)==1; eval(myvh(23,:)); end
      if myvhi(24)==1; eval(myvh(24,:)); end
      if myvhi(25)==1; eval(myvh(25,:)); end
      if myvhi(26)==1; eval(myvh(26,:)); end
      if myvhi(27)==1; eval(myvh(27,:)); end
      if myvhi(28)==1; eval(myvh(28,:)); end
      if myvhi(29)==1; eval(myvh(29,:)); end
      if myvhi(30)==1; eval(myvh(30,:)); end
      if myvhi(31)==1; eval(myvh(31,:)); end
      if myvhi(32)==1; eval(myvh(32,:)); end
      if myvhi(33)==1; eval(myvh(33,:)); end
      if myvhi(34)==1; eval(myvh(34,:)); end
      if myvhi(35)==1; eval(myvh(35,:)); end
        
      if SPXexistedh==1
        Xii1=Xi(i-1);
        Xi6i1=Xi6(i-1);
        Xi12i1=Xi12(i-1);
        Xi25i1=Xi25(i-1);
        Xi75i1=Xi75(i-1);
        Xi250i1=Xi250(i-1);
        Xi25mi1=Xi25m(i-1);
        Xi75mi1=Xi75m(i-1);
        Xi250mi1=Xi250m(i-1);
        Xr7i1=Xr7(i-1);
        Xr14i1=Xr14(i-1);
        Xr30i1=Xr30(i-1);
        Xr100i1=Xr100(i-1);
        Xsi1=Xs(i-1);
        Xh0=Xhi0(i);
        Xh3=Xhi3(i-1);
        Xh6=Xhi6(i-1);
        Xh12=Xhi12(i-1);
        Xh25=Xhi25(i-1);
        Xh75=Xhi75(i-1);
        Xh250=Xhi250(i-1);
        Xh500=Xhi500(i-1);
        Xl0=Xli0(i);
        Xl3=Xli3(i-1);
        Xl6=Xli6(i-1);
        Xl12=Xli12(i-1);
        Xl25=Xli25(i-1);
        Xl75=Xli75(i-1);
        Xl250=Xli250(i-1);
        Xl500=Xli500(i-1);
        Xih6=Xhi6(max([1 i-4]));
        Xih12=Xhi12(max([1 i-10]));
        Xih25=Xhi25(max([1 i-22]));
        Xih75=Xhi75(max([1 i-47]));
        Xih250=Xhi250(max([1 i-122]));
        Xil6=Xli6(max([1 i-4]));
        Xil12=Xli12(max([1 i-10]));
        Xil25=Xli25(max([1 i-22]));
        Xil75=Xli75(max([1 i-47]));
        Xil250=Xli250(max([1 i-122]));
      end
      
      if myvhi(1)==1; ac3i1=ac3(i-1); end
      if myvhi(2)==1; ac6i1=ac6(i-1); end
      if myvhi(3)==1; ac12i1=ac12(i-1); end
      if myvhi(4)==1; ac25i1=ac25(i-1); end
      if myvhi(5)==1; ac75i1=ac75(i-1); end
      if myvhi(6)==1; ac250i1=ac250(i-1); end
      if myvhi(7)==1; av3i1=av3(i-1); end
      if myvhi(8)==1; av6i1=av6(i-1); end
      if myvhi(9)==1; av12i1=av12(i-1); end
      if myvhi(10)==1; av25i1=av25(i-1); end
      if myvhi(11)==1; av75i1=av75(i-1); end
      if myvhi(12)==1; av250i1=av250(i-1); end
      if myvhi(13)==1; h250i1=h250(i-1); end
      if myvhi(14)==1; l250i1=l250(i-1); end
      if myvhi(15)==1; h25i1=h25(i-1); end
      if myvhi(16)==1; l25i1=l25(i-1); end
      if myvhi(17)==1; h75i1=h75(i-1); end
      if myvhi(18)==1; l75i1=l75(i-1); end
      if myvhi(19)==1; h3i1=h3(i-1); end
      if myvhi(20)==1; l3i1=l3(i-1); end
      if myvhi(21)==1; h6i1=h6(i-1); end
      if myvhi(22)==1; l6i1=l6(i-1); end
      if myvhi(23)==1; h12i1=h12(i-1); end
      if myvhi(24)==1; l12i1=l12(i-1); end
      if myvhi(25)==1; c3mi1=c3m(i-1); end
      if myvhi(26)==1; c6mi1=c6m(i-1); end
      if myvhi(27)==1; c12mi1=c12m(i-1); end
      if myvhi(28)==1; c25mi1=c25m(i-1); end
      if myvhi(29)==1; c75mi1=c75m(i-1); end
      if myvhi(30)==1; c250mi1=c250m(i-1); end
      if myvhi(31)==1; h500i1=h500(i-1); end
      if myvhi(32)==1; l500i1=l500(i-1); end
      if myvhi(33)==1; rsi7i1=rsi7(i-1); end
      if myvhi(34)==1; rsi14i1=rsi14(i-1); end
      if myvhi(35)==1; rsi30i1=rsi30(i-1); end
      
      %linecond=instruct.zsobx57;
      %linecond=linecond(find(linecond>=32));
      if (length(stock)>0)&(length(stockd)>0)
        eval(linecond);
        NPPV(y1(ii))=y; %zsoinuse(stock);
      end
    end
  
    % sort to give the results
    ip=find(NPPV==1);
    clear y1
    if ~((tradinghours==1)|((timecal>=4)&(timecal<=20)&(tradingdays==1)))
      load dayfnum
      eval(['load ',tickdayplacesc,'D',sprintf('%07d',dailyfilenumber-1),' ohlcvn']);  
    end
  else
    ip=[];
  end
  y={};i=0;
  if (length(ip)>0)  
    if ohlcvn(ip(1),6)<0
      y{1,1}=sprintf('<font color="blue" size="2" face="Arial"><b>%5s</b></font>',['D',num2str(length(ip))]); 
      y{1,2}=sprintf('<font color="blue" size="2" face="Arial"><b>%5s</b></font>','M'); 
      y{1,3}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''1''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="blue" size="2" face="Arial"><b>%5s</b></font></a>','SYMB');  
      y{1,4}=sprintf('<font color="blue" size="2" face="Arial"><b>%5s</b></font>','OPEN');  
      y{1,5}=sprintf('<font color="blue" size="2" face="Arial"><b>%5s</b></font>','HIGH');  
      y{1,6}=sprintf('<font color="blue" size="2" face="Arial"><b>%5s</b></font>','LOW');  
      y{1,7}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''2''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="blue" size="2" face="Arial"><b>%5s</b></font></a>','LAST');  
      y{1,8}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''3''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="blue" size="2" face="Arial"><b>%5s</b></font></a>','NET');  
      y{1,9}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''4''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="blue" size="2" face="Arial"><b>%5s</b></font></a>','Vol_K');  
      y{1,10}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''5''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="blue" size="2" face="Arial"><b>%5s</b></font></a>','DIGI'); 
    else
      y{1,1}=sprintf('<font color="red" size="2" face="Arial"><b>%5s</b></font>',['D',num2str(length(ip))]); 
      y{1,2}=sprintf('<font color="red" size="2" face="Arial"><b>%5s</b></font>','M'); 
      y{1,3}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''1''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="red" size="2" face="Arial"><b>%5s</b></font></a>','SYMB');  
      y{1,4}=sprintf('<font color="red" size="2" face="Arial"><b>%5s</b></font>','OPEN');  
      y{1,5}=sprintf('<font color="red" size="2" face="Arial"><b>%5s</b></font>','HIGH');  
      y{1,6}=sprintf('<font color="red" size="2" face="Arial"><b>%5s</b></font>','LOW');  
      y{1,7}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''2''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="red" size="2" face="Arial"><b>%5s</b></font></a>','LAST');  
      y{1,8}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''3''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="red" size="2" face="Arial"><b>%5s</b></font></a>','NET');  
      y{1,9}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''4''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="red" size="2" face="Arial"><b>%5s</b></font></a>','Vol_K');  
      y{1,10}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''5''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="red" size="2" face="Arial"><b>%5s</b></font></a>','DIGI');   
    end
  else
    y{1,1}=sprintf('<font color="red" size="2" face="Arial"><b>%5s</b></font>',num2str(length(ip))); 
    y{1,2}=sprintf('<font color="red" size="2" face="Arial"><b>%5s</b></font>','M'); 
    y{1,3}=sprintf('<font color="red" size="2" face="Arial"><b>%5s</b></font>','SYMB');  
    y{1,4}=sprintf('<font color="red" size="2" face="Arial"><b>%5s</b></font>','OPEN');  
    y{1,5}=sprintf('<font color="red" size="2" face="Arial"><b>%5s</b></font>','HIGH');  
    y{1,6}=sprintf('<font color="red" size="2" face="Arial"><b>%5s</b></font>','LOW');  
    y{1,7}=sprintf('<font color="red" size="2" face="Arial"><b>%5s</b></font>','LAST');  
    y{1,8}=sprintf('<font color="red" size="2" face="Arial"><b>%5s</b></font>','NET');  
    y{1,9}=sprintf('<font color="red" size="2" face="Arial"><b>%5s</b></font>','Vol_K');  
    y{1,10}=sprintf('<font color="red" size="2" face="Arial"><b>%5s</b></font>','DIGI');       
  end
  y{1,11}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''6''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="blue" size="2" face="Arial"><b>%5s</b></font></a>','PE');  
  y{1,12}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''7''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="blue" size="2" face="Arial"><b>%5s</b></font></a>','CAP_B');
  
  y{1,13}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''8''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="blue" size="2" face="Arial"><b>%5s</b></font></a>','Sector');
  y{1,14}=[sprintf('<font color="blue" size="2" face="Arial"><b>%5s</b></font>',['[DS-',time1,']',blanks(20)]),...
          sprintf('<font color="black" size="2" face="Arial"><b>%5s</b></font>','COMPANY NAME + PROFILE LINK')];
  
  if (length(ip)>0)    
    y1=ohlcvn(ip,:);
    for i=1:length(ip)
      dp=find(namelist(ip(i),:)=='$');
      if (ip(i)<market(1))
        datadmar='AMX ';
      elseif ((ip(i)>=market(1))&(ip(i)<market(2)))
        datadmar='OTC ';
      else
        datadmar='NYS ';
      end
      if (length(dp)>0)
        namet=namelist(ip(i),1:max([1 dp(1)-1]));
      else
        namet=namelist(ip(i),:);
      end
      if ohlcvn(ip(i),6)<0
        y{i+1,1}=sprintf('<font color="red" size="2" face="Arial"><b>%4s</b></font>',num2str(i));
        y{i+1,2}=sprintf('<font color="red" size="2" face="Arial"><b>%1s</b></font>',datadmar(1));
        y{i+1,3}=sprintf(['<font color="red" size="2" face="Arial"><b><a href="javascript: stockRForm.mlmfvar.value=''',YLFN,'%6s''; stockRForm.mlmfile.value=''',LINKForm,'''; stockRForm.submit();">%6s</a></b></font>'],namet,namet);
        y{i+1,4}=sprintf('<font color="red" size="2" face="Arial"><b>%8.2f</b></font>',ohlcvn(ip(i),1));
        y{i+1,5}=sprintf('<font color="red" size="2" face="Arial"><b>%8.2f</b></font>',ohlcvn(ip(i),2));
        y{i+1,6}=sprintf('<font color="red" size="2" face="Arial"><b>%8.2f</b></font>',ohlcvn(ip(i),3));
        y{i+1,7}=sprintf('<font color="red" size="2" face="Arial"><b>%8.2f</b></font>',ohlcvn(ip(i),4));
        y{i+1,8}=sprintf('<font color="red" size="2" face="Arial"><b>%8.2f</b></font>',ohlcvn(ip(i),6));
        y{i+1,9}=sprintf('<font color="red" size="2" face="Arial"><b>%7d</b></font>',round(ohlcvn(ip(i),5)*100));
        y{i+1,10}=sprintf('<font color="red" size="2" face="Arial"><b>%2s</b></font>','NA');
      else
        y{i+1,1}=sprintf('<font color="blue" size="2" face="Arial"><b>%4s</b></font>',num2str(i));
        y{i+1,2}=sprintf('<font color="blue" size="2" face="Arial"><b>%1s</b></font>',datadmar(1));
        y{i+1,3}=sprintf(['<font color="blue" size="2" face="Arial"><b><a href="javascript: stockRForm.mlmfvar.value=''',YLFN,'%6s''; stockRForm.mlmfile.value=''',LINKForm,'''; stockRForm.submit();">%6s</a></b></font>'],namet,namet);        
        y{i+1,4}=sprintf('<font color="blue" size="2" face="Arial"><b>%8.2f</b></font>',ohlcvn(ip(i),1));
        y{i+1,5}=sprintf('<font color="blue" size="2" face="Arial"><b>%8.2f</b></font>',ohlcvn(ip(i),2));
        y{i+1,6}=sprintf('<font color="blue" size="2" face="Arial"><b>%8.2f</b></font>',ohlcvn(ip(i),3));
        y{i+1,7}=sprintf('<font color="blue" size="2" face="Arial"><b>%8.2f</b></font>',ohlcvn(ip(i),4));
        y{i+1,8}=sprintf('<font color="blue" size="2" face="Arial"><b>%8.2f</b></font>',ohlcvn(ip(i),6));
        y{i+1,9}=sprintf('<font color="blue" size="2" face="Arial"><b>%7d</b></font>',round(ohlcvn(ip(i),5)*100));
        y{i+1,10}=sprintf('<font color="blue" size="2" face="Arial"><b>%2s</b></font>','NA');     
      end
      if ~(PE(ip(i))==0)
        if PE(ip(i))>0
          y{i+1,11}=sprintf('<font color="black" size="2" face="Arial"><b>%8.2f</b></font>',PE(ip(i)));
        else
          y{i+1,11}=sprintf('<font color="red" size="2" face="Arial"><b>(%8.2f)</b></font>',abs(PE(ip(i))));
        end
      else
        y{i+1,11}=sprintf('<font color="blue" size="2" face="Arial"><b>%5s</b></font>','NA');        
      end
      if ~(CAP(ip(i))==0)      
        y{i+1,12}=sprintf('<font color="black" size="2" face="Arial"><b>%8.3f</b></font>',CAP(ip(i))); 
      else
        y{i+1,12}=sprintf('<font color="blue" size="2" face="Arial"><b>%5s</b></font>','NA');         
      end  
      
      if sectorind(ip(i))>0
        y{i+1,13}=sprintf('<font color="black" size="2" face="Arial"><b>%5.2f</b></font>',sectorind(ip(i)));
      else
        y{i+1,13}=sprintf('<font color="black" size="2" face="Arial"><b>%8d</b></font>',sectorind(ip(i)));
      end
      yc14=sprintf('<font color="blue" size="2" face="Arial"><b>%50s</b></font>',namelistd{ip(i)});
      y{i+1,14}=sprintf(['<a href="http://finance.yahoo.com/q/pr?s=',strrep(namet,'_','-'),'" target="_blank">',yc14,'</a>']);    
      
    end
  end
end

outstruct.fpwusername=fpwusername;
outstruct.fpwusername4=fpwusername4;
outstruct.fpwclientdirectory=fpwclientdirectory;
outstruct.fpwulvl=instruct.fpwulvl;
cd(fpwserverplace);
cids=fpwloginstatus(fpwusername,clock);
templatefile = which('MarketpulseR.html');
eval(['!del ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\tMarketpulseR.html']);

wbfilter='NA'; wbscankind='DIGI';
PeCaSe=[PE(ip) CAP(ip) sectorind(ip)]; y11cell='D';
eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\tMarketpulseRe ip LINKForm YLFN wbfilter wbscankind PeCaSe y11cell']);

newlength=length(ip)+1;
if (strcmp(fpwusername(1:4),'User')==1)&(length(ip)>1) %&(0)
  newlength=min([6 max([0 fix((length(ip))/2)])])+1;
  y=y(1:newlength,:); 
  y{1,1}=[y{1,1},'*'];
end

if (nargin == 1)
  if (rem(newlength-1,100)~=0)|(newlength==1)
    pagesnum=fix((newlength-1)/100)+1;
  else
    pagesnum=fix((newlength-1)/100);
  end
  totaloutnum=y{1,1};
  
  yyyy={};yyyy{1,1}=' ';
  outstruct.mpgfoutputlinkstat=' ';
  if pagesnum>1
    for i=1:pagesnum
      if i==1
        linknameh=[fpwclientdirectory,fpwusername,'\stock\tMarketpulseR.html']; 
      else   
        linknameh=[fpwclientdirectory,fpwusername,'\stock\tMarketpulseR',sprintf('%02d',i),'.html'];  
      end
      yyyy{1,i}=['<a href="',linknameh,'" target="_self">',sprintf('%2d',i),'</a>'];
    end
    outstruct.mpgfoutputlinkstat='Clicking below links for more outputs - 100 per page';
  end
  outstruct.mpgfoutputlink =yyyy;
  
  if (strcmp(fpwusername(1:4),'User')==1)
    if newlength<length(ip)+1
      outstruct.mpgfoutputlinkstat=['*: There are actually ',num2str(length(ip)),' outputs, test users are limited to partial results.'];
    end
  end
  
  for i=pagesnum:-1:1
    y{1,1}=' ';
    if i==1
      y{1,1} = totaloutnum; 
      if newlength<=101
        outstruct.mpgfoutput = y;
        retstr = htmlrep(outstruct, templatefile);
        str = htmlrep(outstruct, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\tMarketpulseR.html'],'noheader');
      else      
        outstruct.mpgfoutput = [y(1:51,:); y(1,:); y(52:101,:)];
        retstr = htmlrep(outstruct, templatefile);
        str = htmlrep(outstruct, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\tMarketpulseR.html'],'noheader');  
      end
    elseif i<pagesnum
      eval(['outstruct.mpgfoutput = [y(1,:); y(',num2str(100*(i-1)+2),':',num2str(100*(i-1)+51),',:); y(1,:); y(',num2str(100*(i-1)+52),':',num2str(100*(i-1)+101),',:)];']);
      str = htmlrep(outstruct, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\tMarketpulseR',sprintf('%02d',i),'.html'],'noheader');  
    elseif (i==pagesnum)&(i~=1)
      eval(['outstruct.mpgfoutput = [y(1,:); y(',num2str(100*(i-1)+2),':length(y),:)];']);    
      str = htmlrep(outstruct, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\tMarketpulseR',sprintf('%02d',i),'.html'],'noheader');  
    end
  end 
elseif (nargin == 2)
  retstr = htmlrep(outstruct, templatefile, outfile);
end
end