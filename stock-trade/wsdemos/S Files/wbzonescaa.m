function retstr = wbdzhzonescan(instruct, outfile)

% Author(s): N. Zhu, 11-15-2003
% This is a WB (Web-Based) mirror program to <zonescaa.m> in desktop version
% only daily zone database is available and meaningful.

wbfpwbasic;
cd(fpwserverplace);
retstr = char('');
fpwusername=instruct.mlid{1};
fpwCPAL=1.2; %Optional, special order needed.
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
wbdzhsid=0; eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbdzhsort wbdzhsid']); 

fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
fseek(fid1,-50,1); fprintf(fid1,[time,' MPZS\n']); fclose(fid1);
clear fid1

cd([Wherematlab,'stock']);

%if (strcmp(instruct.hdzsobx39,'Link'))
  ToD=instruct.hdzsobx311;
%else
%  ToD='D';
%end

global SInd KWIN RmSI RmKW
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
  
  findi=2; 
  y={};
  if length(y1)>0  
    y{1,1}=sprintf('<font color="blue" size="2" face="Arial"><b>%5s</b></font>',['Z',num2str(length(y1(:,1)))]); 
  else
    y{1,1}=sprintf('<font color="blue" size="2" face="Arial"><b>%5s</b></font>',0);     
  end
  y{1,2}=sprintf('<font color="blue" size="2" face="Arial"><b>%5s</b></font>','M'); 
  y{1,3}=sprintf('<font color="blue" size="2" face="Arial"><b>%5s</b></font>','SYMB');  
  y{1,4}=sprintf('<font color="blue" size="2" face="Arial"><b>%5s</b></font>','ZONE');  
  y{1,5}=sprintf('<font color="blue" size="2" face="Arial"><b>%5s</b></font>','LAST');  
  y{1,6}=sprintf('<font color="blue" size="2" face="Arial"><b>%5s</b></font>','ZLOW');  
  y{1,7}=sprintf('<font color="blue" size="2" face="Arial"><b>%5s</b></font>','ZHIGH');  
  y{1,8}=sprintf('<font color="blue" size="2" face="Arial"><b>%5s</b></font>','PRCT');  
  y{1,9}=sprintf('<font color="blue" size="2" face="Arial"><b>%5s</b></font>','SMPLS');  
  y{1,10}=sprintf('<font color="blue" size="2" face="Arial"><b>%5s</b></font>','ZONE');  
  if length(y1)>0  
    for i=1:length(y1(:,1))
      %disp(num2str(i));
      ohlcvn=stgetdaa(markfilt(namelist(y1(i),:)),'D',2);
      Ohlcvn=ohlcvn(1,4:8);    ohlcvn=ohlcvn(2,4:8);
      zonet=zone(ohlcvn(2:4));zonet=[0 zonet(6:-1:2) 99 9];
      ly2=stfpz62(markfilt(namelist(y1(i),:)),[Ohlcvn(1:5);ohlcvn(1:5)]);
      ly2p=ly2(1:2:13);
      ly2s=ly2(2:2:14);
      downp=find((ly2p<25)&(ly2s>40));
      if length(downp)>0
        for j=1:length(downp)
          dp=find(namelist(y1(i),:)=='$');
          if (y1(i)<market(1))
            datadmar='AMX ';
          elseif ((y1(i)>=market(1))&(y1(i)<market(2)))
            datadmar='OTC ';
          else
            datadmar='NYS ';
          end
          if (length(dp)>0)
            namet=namelist(y1(i),1:max([1 dp(1)-1]));
          else
            namet=namelist(y1(i),:);
          end
          y{findi,1}=sprintf('<font color="red" size="2" face="Arial"><b>%4s</b></font>',num2str(findi-1));
          y{findi,2}=sprintf('<font color="red" size="2" face="Arial"><b>%1s</b></font>',datadmar(1));
          y{findi,3}=sprintf(['<font color="red" size="2" face="Arial"><b><a href="javascript: stockRForm.mlmfvar.value=''',YLFN,'%6s''; stockRForm.mlmfile.value=''',LINKForm,'''; stockRForm.submit();">%6s</a></b></font>'],namet,namet);
          y{findi,4}=sprintf('<font color="red" size="2" face="Arial"><b>%4s</b></font>',['- ',num2str(downp(j))]);
          y{findi,5}=sprintf('<font color="red" size="2" face="Arial"><b>%8.2f</b></font>',ohlcvn(4));
          y{findi,6}=sprintf('<font color="red" size="2" face="Arial"><b>%8.2f</b></font>',zonet(downp(j)));
          y{findi,7}=sprintf('<font color="red" size="2" face="Arial"><b>%8.2f</b></font>',zonet(downp(j)+1));        
          y{findi,8}=sprintf('<font color="red" size="2" face="Arial"><b>%6d</b></font>',100-ly2p(round(downp(j))));        
          y{findi,9}=sprintf('<font color="red" size="2" face="Arial"><b>%4d</b></font>',ly2s(downp(j)));  
          y{findi,10}=sprintf('<font color="red" size="2" face="Arial"><b>%2s</b></font>','NA');
          findi=findi+1;
        end
      end
      upp=find((ly2p>75)&(ly2s>40));
      if length(upp)>0
        for j=1:length(upp)
          dp=find(namelist(y1(i),:)=='$');
          if (y1(i)<market(1))
            datadmar='AMX ';
          elseif ((y1(i)>=market(1))&(y1(i)<market(2)))
            datadmar='OTC ';
          else
            datadmar='NYS ';
          end
          if (length(dp)>0)
            namet=namelist(y1(i),1:max([1 dp(1)-1]));
          else
            namet=namelist(y1(i),:);
          end
          y{findi,1}=sprintf('<font color="red" size="2" face="Arial"><b>%4s</b></font>',num2str(findi));
          y{findi,2}=sprintf('<font color="red" size="2" face="Arial"><b>%1s</b></font>',datadmar(1));
          y{findi,3}=sprintf(['<font color="red" size="2" face="Arial"><b><a href="javascript: stockRForm.mlmfvar.value=''',YLFN,'%6s''; stockRForm.mlmfile.value=''',LINKForm,'''; stockRForm.submit();">%6s</a></b></font>'],namet,namet);
          y{findi,4}=sprintf('<font color="red" size="2" face="Arial"><b>%4s</b></font>',['+ ',num2str(upp(j))]);
          y{findi,5}=sprintf('<font color="red" size="2" face="Arial"><b>%8.2f</b></font>',ohlcvn(4));
          y{findi,6}=sprintf('<font color="red" size="2" face="Arial"><b>%8.2f</b></font>',zonet(upp(j)));
          y{findi,7}=sprintf('<font color="red" size="2" face="Arial"><b>%8.2f</b></font>',zonet(upp(j)+1));        
          y{findi,8}=sprintf('<font color="red" size="2" face="Arial"><b>%6d</b></font>',ly2p(round(upp(j))));        
          y{findi,9}=sprintf('<font color="red" size="2" face="Arial"><b>%4d</b></font>',ly2s(upp(j)));  
          y{findi,10}=sprintf('<font color="red" size="2" face="Arial"><b>%2s</b></font>','NA');
          findi=findi+1;          
        end
      end
    end 
  end
  y{1,1}=sprintf('<font color="blue" size="2" face="Arial"><b>%5s</b></font>',['Z-',num2str(findi-2)]); 
  outstruct.mpgfoutput = y;
end

outstruct.fpwclientdirectory=fpwclientdirectory;
outstruct.fpwusername=fpwusername;
outstruct.fpwusername4=fpwusername4;
outstruct.fpwulvl=instruct.fpwulvl;
cd(fpwserverplace);
cids=fpwloginstatus(fpwusername,clock);
templatefile = which('MarketpulseR2.html');
if (nargin == 1)
  retstr = htmlrep(outstruct, templatefile);
  str = htmlrep(outstruct, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\tMarketpulseR.html'],'noheader');  
elseif (nargin == 2)
  retstr = htmlrep(outstruct, templatefile, outfile);
end
end