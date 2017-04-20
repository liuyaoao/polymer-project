function retstr = wbdzhckout(instruct, outfile)

% Author(s): N. Zhu, 11-15-2003
% This is a WB (Web-Based) mirror program to <dzhckout.m> in desktop version

% Note: 0 for whole day, works for daily database only. and T/D button is meaningless now.
%        now were 4:30pm Wed, 1 would compare from 4:00pm Web. 0 from 4:00pm Tue.

wbfpwbasic;
cd(fpwserverplace);
retstr = char('');
fpwusername=instruct.mlid{1};
fpwCPAL=1;
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
wbdzhsid=5; eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbdzhsort wbdzhsid']); 

fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
fseek(fid1,-50,1); fprintf(fid1,[time,' MPQL\n']); fclose(fid1);
clear fid1

cd([Wherematlab,'stock']);

%if (strcmp(instruct.hdzsobx39,'Link'))
  ToD=instruct.hdzsobx311;
%else
%  ToD='D';
%end

global V250 v250 PE CAP SInd KWIN RmSI RmKW %SInd - Sector Index, KWIN - Key Words In company Names, RmSI - ReMoving Sector Index
KWIN='1'; RmSI=[]; RmKW='1';
SInd=str2num(instruct.zsobxSG); KWIN='1';

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
          
  [y2 y1]=stfilter(combcondi1,combcondi2,combcondi3,combcondi4,combcondi5,combcondi6,ToD); clear y2
  
  load nlt
  load stchour1 vol51 pvolume %vol51 pvolume sectorind EPS Divident outstandshare NDX100Ind SP500Ind SP100Ind DOW30Ind
  %!copy x:\stock\fpwnltlast.mat c:\matlab\stock
  load fpwnltlast
  ohlcvn=[fpwnltlast(:,1:6) pvolume/100000];
  ohlcvnT=[fpwnltlast(:,7:12) vol51/1000];
  ohlcvn(:,2)=(max((ohlcvn(:,1:4))'))';
  ohlcvn(:,3)=(min((ohlcvn(:,1:4))'))';
  ohlcvnT(:,2)=(max((ohlcvnT(:,1:4))'))';
  ohlcvnT(:,3)=(min((ohlcvnT(:,1:4))'))'; 
      
  NLTnow=namelist;
  OCnow=ohlcvn;
  rndx=0*OCnow(:,1);
  rndx(y1)=ones(length(y1),1);
  
  smarket=instruct.zsobx41; % ano(123),4-all
    if strcmp(smarket,'NYSE')==1; rMrK=2; end
    if strcmp(smarket,'AMEX')==1; rMrK=1; end
    if strcmp(smarket,'Nasdaq')==1; rMrK=3; end
    if strcmp(smarket,'AllMrkts')==1; rMrK=4; end
  smarket=instruct.hdzsobx42;
    if strcmp(smarket,'Price')==1; rPoV='P'; end
    if strcmp(smarket,'Volume')==1; rPoV='V'; end
  smarket=instruct.hdzsobx43;
    if strcmp(smarket,'Net Change')==1; rNoP='N'; end
    if strcmp(smarket,'Percentage')==1; rNoP='P'; end
  smarket=instruct.zsobx44; % WLA(123)
    if strcmp(smarket,'Ups')==1; rWoL=1; end
    if strcmp(smarket,'Downs')==1; rWoL=2'; end
    if strcmp(smarket,'All U+D')==1; rWoL=3; end
  rNuM=100*abs(str2num(instruct.zsobx451))+10*abs(str2num(instruct.zsobx452))+abs(str2num(instruct.zsobx453));
  smarket=instruct.hdzsobx46;
    if strcmp(smarket,'Daily')==1; rToD='D'; end
    if strcmp(smarket,'Tick')==1; rToD='T'; end  
     
  % rToD and rNuM
  if rNuM>0
    if rToD=='T'
      load tickfnum
      tickfilenumber=tickfilenumber-min([798 rNuM]);
      eval(['load ',tickdayplacesc,'t',sprintf('%07d',tickfilenumber),'.mat']);
    else
      load dayfnum
      dailyfilenumber=dailyfilenumber-min([798 rNuM]);
      eval(['load ',tickdayplacesc,'d',sprintf('%07d',dailyfilenumber),'.mat']);
    end
    OCref=ohlcvn;
    Volumeaccu=volumeaccu;
  end
    
  % rMrK
  if rMrK==1
    rndx(market(1):length(rndx))=zeros(length(rndx)-market(1)+1,1);
  elseif rMrK==2
    rndx(1:market(2)-1)=zeros(market(2)-1,1);
  elseif rMrK==3
    rndx(1:market(1)-1)=zeros(market(1)-1,1);
    rndx(market(2):length(rndx))=zeros(length(rndx)-market(2)+1,1);
  end
  
  % rule out bad link data
  y1=find(OCnow(:,4)==0.001);
  if length(y1)>0
    rndx(y1)=zeros(length(y1),1);   
  end
  
  % rWoL
  if rWoL==1
    rndxh=0*OCnow(:,1);
    if rNuM==0 % from today's open
      if rToD=='D'
        y1=find(OCnow(:,6)>=0);
      else
        y1=find(ohlcvnT(:,6)>=0);        
      end
    else
      y1=find(OCnow(:,4)-OCref(:,4)>=0);
    end
    rndxh(y1)=ones(length(y1),1);
    rndx=rndx.*rndxh;
  elseif rWoL==2
    rndxh=0*OCnow(:,1);
    if rNuM==0
      if rToD=='D'
        y1=find(OCnow(:,6)<0);
      else
        y1=find(ohlcvnT(:,6)<0);        
      end      
    else
      y1=find(OCnow(:,4)-OCref(:,4)<0);
    end
    rndxh(y1)=ones(length(y1),1);
    rndx=rndx.*rndxh;
  end
   
  % rPoV and rNoP
  if rNuM>0
    if rNoP=='N'
      if rPoV=='P'
        NPPV=OCnow(:,4)-OCref(:,4);
      else
        if rToD=='D'
          load fpwmyvold
          NPPV=volumeaccu+OCnow(:,5)-Volumeaccu;
        else
          load fpwmyvolt
          NPPV=volumeaccu+ohlcvnT(:,5)/100-Volumeaccu;
        end
      end
    else
      if rPoV=='P'
        ff=find(OCref(:,4)==0.001);
        if length(ff)>0
          OCref(ff,4)=OCref(ff,4)+0.001;
        end
        NPPV=(OCnow(:,4)-OCref(:,4))./OCref(:,4)*100;
        if length(ff)>0
          NPPVC=0*NPPV+1;
          NPPVC(ff)=zeros(length(ff),1);
          NPPV=NPPV.*NPPVC;
        end
      else
        if rToD=='D'
          load fpwmyvold
          ff=find(V250==0);
          if length(ff)>0
            V250(ff)=V250(ff)+0.1;
          end            
          NPPV=(volumeaccu+OCnow(:,5)-Volumeaccu)./V250/rNuM*10000; % percentage to its 250 bars volume average 
        else
          load fpwmyvolt
          ff=find(v250==0);
          if length(ff)>0
            v250(ff)=v250(ff)+0.1;
          end            
          NPPV=(volumeaccu+ohlcvnT(:,5)/100-Volumeaccu)./v250/rNuM*100; % daily percentage to its 250 bars volume average     
        end
        if length(ff)>0
          NPPVC=0*NPPV+1;
          NPPVC(ff)=zeros(length(ff),1);
          NPPV=NPPV.*NPPVC;
        end
      end
    end
  else % rNuM ==0
    if rNoP=='N'
      if rPoV=='P'
        if rToD=='D'
          NPPV=OCnow(:,6);
        else
          NPPV=ohlcvnT(:,6);
        end
      else
        if rToD=='D'
          NPPV=OCnow(:,5);
        else
          NPPV=ohlcvnT(:,5);
        end
      end
    else % percentage
      if rPoV=='P'
        if rToD=='D'          
          ff=find(OCnow(:,4)==0.001);
          if length(ff)>0
            OCnow(:,4)=OCnow(:,4)+0.001;
          end
          NPPV=OCnow(:,6)./OCnow(:,4)*100;
          if length(ff)>0
            NPPVC=0*NPPV+1;
            NPPVC(ff)=zeros(length(ff),1);
            NPPV=NPPV.*NPPVC;
          end
        else
          ff=find(ohlcvnT(:,4)==0.001);
          if length(ff)>0
            ohlcvnT(:,4)=ohlcvnT(:,4)+0.001;
          end
          NPPV=ohlcvnT(:,6)./ohlcvnT(:,4)*100;
          if length(ff)>0
            NPPVC=0*NPPV+1;
            NPPVC(ff)=zeros(length(ff),1);
            NPPV=NPPV.*NPPVC;
          end          
        end
      else
        if rToD=='D'
          NPPV=OCnow(:,5);
        else
          NPPV=ohlcvnT(:,5);
        end        
      end
    end
  end
     
  NPPV=NPPV.*rndx;
   
  % sort to give the results
  [Y y1]=sort(-abs(NPPV));
  GG=find(Y<0);
  if length(GG)>0
    y1=y1(1:min([38 length(GG)]));
    %if rNuM>0
      dzhmdlot=NPPV(y1);
    %end
  else
    y1=[];
    if rNuM>0
      dzhmdlot=[];
    end
  end
   
  ip=y1;
  clear y1
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
    
  % The next two lines are exclusively for column 13 and 14 only (index and company full name).
  load fpwnlt sectorind namelistd 
  namelistd=fpwnamelist(namelistd);
    
  if (tradinghours==1)|((timecal>=4)&(timecal<=20)&(tradingdays==1))
    load stchour1 pvolume % ohlcvn
    %!copy x:\stock\fpwnltlast.mat c:\matlab\stock
    load fpwnltlast
    ohlcvn=[fpwnltlast(:,1:6) pvolume/100000];
    ohlcvn(:,2)=(max((ohlcvn(:,1:4))'))';
    ohlcvn(:,3)=(min((ohlcvn(:,1:4))'))';
  else
    load dayfnum
    eval(['load ',tickdayplacesc,'D',sprintf('%07d',dailyfilenumber-1),' ohlcvn']);  
  end
  load nlt
     
  y={};i=0;
  if length(ip)>0
    if ohlcvn(ip(1),6)<0
      y{1,1}=sprintf('<font color="blue" size="2" face="Arial"><b>%5s</b></font>',['Q',num2str(length(ip))]); 
      y{1,2}=sprintf('<font color="blue" size="2" face="Arial"><b>%5s</b></font>','M'); 
      y{1,3}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''1''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="blue" size="2" face="Arial"><b>%5s</b></font></a>','SYMB');  
      y{1,4}=sprintf('<font color="blue" size="2" face="Arial"><b>%5s</b></font>','OPEN');  
      y{1,5}=sprintf('<font color="blue" size="2" face="Arial"><b>%5s</b></font>','HIGH');  
      y{1,6}=sprintf('<font color="blue" size="2" face="Arial"><b>%5s</b></font>','LOW');  
      y{1,7}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''2''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="blue" size="2" face="Arial"><b>%5s</b></font></a>','LAST');  
      y{1,8}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''3''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="blue" size="2" face="Arial"><b>%5s</b></font></a>','NET');  
      y{1,9}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''4''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="blue" size="2" face="Arial"><b>%5s</b></font></a>','Vol_K');  
      y{1,10}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''5''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="blue" size="2" face="Arial"><b>%5s</b></font></a>','QUIK'); 
    else
      y{1,1}=sprintf('<font color="red" size="2" face="Arial"><b>%5s</b></font>',['Q',num2str(length(ip))]); 
      y{1,2}=sprintf('<font color="red" size="2" face="Arial"><b>%5s</b></font>','M'); 
      y{1,3}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''1''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="red" size="2" face="Arial"><b>%5s</b></font></a>','SYMB');  
      y{1,4}=sprintf('<font color="red" size="2" face="Arial"><b>%5s</b></font>','OPEN');  
      y{1,5}=sprintf('<font color="red" size="2" face="Arial"><b>%5s</b></font>','HIGH');  
      y{1,6}=sprintf('<font color="red" size="2" face="Arial"><b>%5s</b></font>','LOW');  
      y{1,7}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''2''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="red" size="2" face="Arial"><b>%5s</b></font></a>','LAST');  
      y{1,8}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''3''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="red" size="2" face="Arial"><b>%5s</b></font></a>','NET');  
      y{1,9}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''4''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="red" size="2" face="Arial"><b>%5s</b></font></a>','Vol_K');  
      y{1,10}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''5''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="red" size="2" face="Arial"><b>%5s</b></font></a>','QUIK');   
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
    y{1,10}=sprintf('<font color="red" size="2" face="Arial"><b>%5s</b></font>','QUIK');       
  end
  y{1,11}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''6''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="blue" size="2" face="Arial"><b>%5s</b></font></a>','PE');  
  y{1,12}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''7''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="blue" size="2" face="Arial"><b>%5s</b></font></a>','CAP_B');
  
  y{1,13}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''8''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="blue" size="2" face="Arial"><b>%5s</b></font></a>','Sector');
  y{1,14}=[sprintf('<font color="blue" size="2" face="Arial"><b>%5s</b></font>',['[QL-',time1,']',blanks(20)]),...
          sprintf('<font color="black" size="2" face="Arial"><b>%5s</b></font>','COMPANY NAME + PROFILE LINK')];
  
  if length(ip)>0  
    ohlcvn(:,7)=ohlcvn(:,6);
    ohlcvn(ip,7)=dzhmdlot;
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
        y{i+1,10}=sprintf('<font color="red" size="2" face="Arial"><b>%8.2f</b></font>',ohlcvn(ip(i),7));
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
        y{i+1,10}=sprintf('<font color="blue" size="2" face="Arial"><b>%8.2f</b></font>',ohlcvn(ip(i),7));     
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

load TUcontroler TUcontrolid % to control Test Users output results 1 - no short, all others for short
outstruct.fpwusername=fpwusername;
outstruct.fpwusername4=fpwusername4;
outstruct.fpwclientdirectory=fpwclientdirectory;
outstruct.fpwulvl=instruct.fpwulvl;
cd(fpwserverplace);
cids=fpwloginstatus(fpwusername,clock);
templatefile = which('MarketpulseR.html');
eval(['!del ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\tMarketpulseR.html']);

wbfilter=ohlcvn(ip,7); wbscankind='QUIK';
PeCaSe=[PE(ip) CAP(ip) sectorind(ip)]; y11cell='Q';
eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\tMarketpulseRe ip LINKForm YLFN wbfilter wbscankind PeCaSe y11cell']);

newlength=length(ip)+1;
if (strcmp(fpwusername(1:4),'User')==1)&(length(ip)>1)&(TUcontrolid~=1)
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