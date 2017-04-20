function retstr = wbdzhptern(instruct, outfile)

% Author(s): N. Zhu, 11-15-2003
% This is a WB (Web-Based) mirror program to <dzhptern.m> in desktop version

wbfpwbasic;
cd(fpwserverplace);
retstr = char('');
fpwusername=instruct.mlid{1};
fpwCPAL=1.1;
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
fseek(fid1,-50,1); fprintf(fid1,[time,' MPAS\n']); fclose(fid1);
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
          
  [y2 y1]=stfilter(combcondi1,combcondi2,combcondi3,combcondi4,combcondi5,combcondi6,ToD); clear y2
  
  load nlt
    
  % The next two lines are exclusively for column 13 and 14 only (index and company full name).
  load fpwnlt sectorind namelistd 
  namelistd=fpwnamelist(namelistd);
  
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
  rToD=instruct.hdzsobx64;
  
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
   
  %load stcusdzh %this the basic pattern to scan in variable (dzhline)
  if isfield(instruct,'zsobx622')
    dzhline=zeros(52,1);
    for i=1:20
      eval(['mybarhx=instruct.mybarh',int2str(i),';']);
      if length(strfind(mybarhx,'px'))>0
        dzhline(i,1)=str2num(mybarhx(1:length(mybarhx)-2));
      else
        dzhline(i,1)=str2num(mybarhx);
      end
    end
    for i=23:52
      eval(['mybarhx=instruct.mybarh',int2str(i),';']);
      if length(strfind(mybarhx,'px'))>0
        dzhline(i,1)=str2num(mybarhx(1:length(mybarhx)-2));
      else
        dzhline(i,1)=str2num(mybarhx);
      end
    end
    dzhline(21)=dzhline(51);
    dzhline(22)=dzhline(52);
    dzhline=dzhline(1:50);
    amplifynum=str2num(instruct.zsobx62); %1-D interplate factore
    cus=interp1(1:50,modelnor(1,0.01,dzhline),1:(1/(amplifynum+1)):50);
    %cusweight=interp1(1:50,modelnor(1,0.4,41:60),1:(1/(amplifynum+1)):50);
  else
    dzhline=zeros(20,1);
    for i=1:20
      eval(['mybarhx=instruct.mybarh',int2str(i),';']);
      dzhline(i,1)=str2num(mybarhx(1:length(mybarhx)-2));
    end
    amplifynum=str2num(instruct.zsobx62); %1-D interplate factore
    cus=interp1(1:20,modelnor(1,0.01,dzhline),1:(1/(amplifynum+1)):20);
    %cusweight=interp1(1:20,modelnor(1,0.4,41:60),1:(1/(amplifynum+1)):20);
  end
  nums=length(cus);
  cuslenf=length(y1);
  if cuslenf > 0
    for i=1:cuslenf
      stock=[0 0 0 0 0];
      if rToD=='D'
        stock=stgetdaa(markfilt(namelist(y1(i),:)),'D',25*(amplifynum+1));
        if (length(stock)>0)
          if (tradinghours==1)
            stock=[stock(:,4:8);ohlcvn(y1(i),1:5)];
          else
            stock=stock(:,4:8);
          end
        end
      else
        stock=stgetdaa(markfilt(namelist(y1(i),:)),'T',25*(amplifynum+1));
        if (length(stock)>0)
          if (tradinghours==1)
            stock=[stock(:,6:10);ohlcvnT(y1(i),1:5)];
          else
            stock=stock(:,6:10);
          end
        end
      end
     
      if length(stock(:,1))>=nums
        Y=stock(length(stock(:,1))-nums+1:length(stock(:,1)),4);
        Y=modelnor(1,.01,Y'); 
        conumb=coeff(cus,Y); %1-sum(abs((cus-Y).*cusweight))/length(Y);
        NPPV(y1(i))=conumb;
      end
    end
    
    % sort to give the results
    [Y y1]=sort((-NPPV));
    GG=find(Y<-0.80);
    if length(GG)>0
      y1=y1(1:min([38 length(GG)]));
      dzhmdlot=NPPV(y1);
    else
      y1=[];
      dzhmdlot=[];
    end
  else
    y1=[];    
  end
  ip=y1;
  clear y1
      
  if ~((tradinghours==1)|((timecal>=4)&(timecal<=20)&(tradingdays==1)))
    load dayfnum
    eval(['load ',tickdayplacesc,'D',sprintf('%07d',dailyfilenumber-1),' ohlcvn']);  
  end
  
  cd(fpwserverplace);
  y={};i=0;
  if length(ip)>0  
    if ohlcvn(ip(1),6)<0
      y{1,1}=sprintf('<font color="blue" size="2" face="Arial"><b>%5s</b></font>',['A',num2str(length(ip))]); 
      y{1,2}=sprintf('<font color="blue" size="2" face="Arial"><b>%5s</b></font>','M'); 
      y{1,3}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''1''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="blue" size="2" face="Arial"><b>%5s</b></font></a>','SYMB');  
      y{1,4}=sprintf('<font color="blue" size="2" face="Arial"><b>%5s</b></font>','OPEN');  
      y{1,5}=sprintf('<font color="blue" size="2" face="Arial"><b>%5s</b></font>','HIGH');  
      y{1,6}=sprintf('<font color="blue" size="2" face="Arial"><b>%5s</b></font>','LOW');  
      y{1,7}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''2''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="blue" size="2" face="Arial"><b>%5s</b></font></a>','LAST');  
      y{1,8}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''3''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="blue" size="2" face="Arial"><b>%5s</b></font></a>','NET');  
      y{1,9}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''4''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="blue" size="2" face="Arial"><b>%5s</b></font></a>','Vol_K');  
      y{1,10}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''5''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="blue" size="2" face="Arial"><b>%5s</b></font></a>','PATN'); 
    else
      y{1,1}=sprintf('<font color="red" size="2" face="Arial"><b>%5s</b></font>',['A',num2str(length(ip))]);
      y{1,2}=sprintf('<font color="red" size="2" face="Arial"><b>%5s</b></font>','M'); 
      y{1,3}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''1''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="red" size="2" face="Arial"><b>%5s</b></font></a>','SYMB');  
      y{1,4}=sprintf('<font color="red" size="2" face="Arial"><b>%5s</b></font>','OPEN');  
      y{1,5}=sprintf('<font color="red" size="2" face="Arial"><b>%5s</b></font>','HIGH');  
      y{1,6}=sprintf('<font color="red" size="2" face="Arial"><b>%5s</b></font>','LOW');  
      y{1,7}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''2''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="red" size="2" face="Arial"><b>%5s</b></font></a>','LAST');  
      y{1,8}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''3''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="red" size="2" face="Arial"><b>%5s</b></font></a>','NET');  
      y{1,9}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''4''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="red" size="2" face="Arial"><b>%5s</b></font></a>','Vol_K');  
      y{1,10}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''5''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="red" size="2" face="Arial"><b>%5s</b></font></a>','PATN');   
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
    y{1,10}=sprintf('<font color="red" size="2" face="Arial"><b>%5s</b></font>','PATN');       
  end
  y{1,11}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''6''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="blue" size="2" face="Arial"><b>%5s</b></font></a>','PE');  
  y{1,12}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''7''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="blue" size="2" face="Arial"><b>%5s</b></font></a>','CAP_B');
  
  y{1,13}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''8''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="blue" size="2" face="Arial"><b>%5s</b></font></a>','Sector');
  y{1,14}=[sprintf('<font color="blue" size="2" face="Arial"><b>%5s</b></font>',['[AS-',time1,']',blanks(20)]),...
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
        %y{i+1,11}=sprintf('<font color="black" size="2" face="Arial"><b>%8.2f</b></font>',PE(ip(i)));
        %y{i+1,12}=sprintf('<font color="black" size="2" face="Arial"><b>%8.3f</b></font>',CAP(ip(i)));        
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
        %y{i+1,11}=sprintf('<font color="black" size="2" face="Arial"><b>%8.2f</b></font>',PE(ip(i)));
        %y{i+1,12}=sprintf('<font color="black" size="2" face="Arial"><b>%8.3f</b></font>',CAP(ip(i)));        
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
  %outstruct.mpgfoutput = y;
end

cd([Wherematlab,'stock']);
load TUcontroler TUcontrolid % to control Test Users output results 1 - no short, all others for short
outstruct.fpwusername=fpwusername;
outstruct.fpwusername4=fpwusername4;
outstruct.fpwclientdirectory=fpwclientdirectory;
outstruct.fpwulvl=instruct.fpwulvl;
cd(fpwserverplace);
cids=fpwloginstatus(fpwusername,clock);
templatefile = which('MarketpulseR.html');
eval(['!del ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\tMarketpulseR.html']);

wbfilter=ohlcvn(ip,7); wbscankind='PATN';
PeCaSe=[PE(ip) CAP(ip) sectorind(ip)]; y11cell='A';
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