function retstr = wbfpwmpstatday(instr,outfile)

% Author(s): N. Zhu, 11-15-2003
% This is a WB (Web-Based) FPW-MP statistics program

wbfpwbasic;
cd(fpwserverplace);
retstr = char('');
fpwusername=instr.mlid{1}; %only need to know the username to initial MP

fpwCPAL=1;
fpwloginIP='192.168.2.8';
fpwcheckil; % output an interactive note if no passed

if fpwcheckilpass==1

  if isfield(instr,'WhereOrderFrom')   
    WhereOrderFrom=instr.WhereOrderFrom;
  else
    WhereOrderFrom='LINK'; 
  end
  
  fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
  fseek(fid1,-50,1); fprintf(fid1,[time,' MPST\n']); fclose(fid1); clear fid1
  cids=fpwloginstatus(fpwusername,clock);
    
  cd([Wherematlab,'stock']);
  global SInd KWIN RmSI RmKW
  KWIN='1'; RmSI=[]; RmKW='1';
    
  if ~strcmp(WhereOrderFrom,'MPST')
    if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbmpstat.mat'],'file')==2
      eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbmpstat']); % instruct
      SInd=str2num(instruct.statbxSG);
      outstruct.FDstatbxSG=instruct.statbxSG;
      rMrK=instruct.statbx312;
      if sum(isletter(instruct.statbx53))==0
        statname=str2num(instruct.statbx53);
      else
        statname=1;
      end
      linecond=instruct.statbx31;
    else
      SInd=-1;
      outstruct.FDstatbxSG='-500';
      rMrK='AllMrkts';
      statname=1;
      linecond=' ';      
    end
  else
    if (isfield(instr,'statbx31'))
      cd([Wherematlab,'pattern']);
      if fpwsecucheck(instr.statbx31)>0
        error(' Hei! Not allowed content found, are you seriously trying to .... Sorry, change it.');
      end
      cd([Wherematlab,'stock']);
    end
    SInd=str2num(instr.statbxSG);
    outstruct.FDstatbxSG=instr.statbxSG;
    rMrK=instr.statbx312;
    statname=str2num(instr.statbx53);
    linecond=instr.statbx31;
  end
  
  urbanwords='';
  [fpwscpass1,whereban1,whatban1]=wbcheckbanw('StatGF',linecond);
  if fpwscpass1~=1
    urbanwords=[urbanwords,whereban1,': ',whatban1,'; '];
  end    
  [fpwscpass3,whereban1,whatban1]=wbcheckbanw('StatName',statname);
  if fpwscpass3~=1
    urbanwords=[urbanwords,whereban1,': ',whatban1,'; '];
  end 
  if (fpwscpass1+fpwscpass3)~=2
    fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
    fseek(fid1,-50,1); fprintf(fid1,[time,' FAIL: ',urbanwords,'\n']); fclose(fid1);
    clear fid1    
    outstruct.mpgfoutput=['Banned word found: ',urbanwords];
    clear urbanwords fpwscpass1 whereban1 whatban1 fpwscpass2 fpwscpass3
    outputwindow=11;
  else
    LINKForm='wbstockqd';
    if strcmp(WhereOrderFrom,'MPST')
      instruct=instr;
      eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbmpstat instruct']);
    end
    
    if length(noempty(linecond))==0; linecond='  '; end
    linecond=linecond(find(linecond~=10));
    
    outstruct.fpwulvl=instr.fpwulvl;
    outstruct.fpwusernameid=fpwusername;
    outstruct.fpwusernameid4=fpwusername4;
    outstruct.FDstatbx31=linecond;
    outstruct.FDstatbx312=rMrK;
    outstruct.FDstatbx53=int2str(statname);
    
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
          
    [y2 y1]=stfilter(combcondi1,combcondi2,combcondi3,combcondi4,combcondi5,combcondi6,'D'); clear y2
    
    load nlt
    if (strcmp(rMrK,'AllMrkts')==0)  %&(strcmp(instruct.hdzsobx39,'Link'))
      rndx=zeros(length(namelist(:,1)),1);
      rndx(y1)=ones(size(y1));
      y1=rndx;
      rndx=ones(length(namelist(:,1)),1);
      smarket=rMrK; clear rMrK; % ano(123),4-all
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
    
    load tickfnum
    load dayfnum
    %!copy x:\stock\fpwnltlast.mat c:\matlab\stock
    load fpwnltlast
    ohlcvn=fpwnltlast(:,1:6);   % today
    ohlcvnDD=ohlcvn;
    ohlcvnT=fpwnltlast(:,7:12); % last 5minute
    ohlcvnT1=ohlcvnT;    
    
    if ~((tradinghours==1)|((timecal>=4)&(timecal<=20)&(tradingdays==1)))
      eval(['load ',tickdayplacesc,'D',sprintf('%07d',dailyfilenumber-1),' ohlcvn']);
      ohlcvn(:,4)=ohlcvnDD(:,4);
      ohlcvn(:,5)=ohlcvnDD(:,5)+ohlcvn(:,5); 
      ohlcvn(:,6)=ohlcvnDD(:,6)+ohlcvn(:,6);
    end
    ohlcvnDD=ohlcvn(:,1:6);
    
    stocknameph=checknow(namelist,'djia','$');
    if ohlcvn(stocknameph,6)>=0
      outstruct.downum=[num2str(ohlcvn(stocknameph,4)),', <font color="blue">+',num2str(ohlcvn(stocknameph,6)),'</font>']; 
    else
      outstruct.downum=[num2str(ohlcvn(stocknameph,4)),', <font color="red">',num2str(ohlcvn(stocknameph,6)),'</font>']; 
    end
    
    stocknameph=checknow(namelist,'spx','$');
    if ohlcvn(stocknameph,6)>=0
      outstruct.spxnum=[num2str(ohlcvn(stocknameph,4)),', <font color="blue">+',num2str(ohlcvn(stocknameph,6)),'</font>']; 
    else
      outstruct.spxnum=[num2str(ohlcvn(stocknameph,4)),', <font color="red">',num2str(ohlcvn(stocknameph,6)),'</font>']; 
    end
    
    stocknameph=checknow(namelist,'ncomp','$');
    if ohlcvn(stocknameph,6)>=0
      outstruct.nasnum=[num2str(ohlcvn(stocknameph,4)),', <font color="blue">+',num2str(ohlcvn(stocknameph,6)),'</font>']; 
    else
      outstruct.nasnum=[num2str(ohlcvn(stocknameph,4)),', <font color="red">',num2str(ohlcvn(stocknameph,6)),'</font>']; 
    end
    
    stocknameph=checknow(namelist,'ndx','$');
    if ohlcvn(stocknameph,6)>=0
      outstruct.ndxnum=[num2str(ohlcvn(stocknameph,4)),', <font color="blue">+',num2str(ohlcvn(stocknameph,6)),'</font>']; 
    else
      outstruct.ndxnum=[num2str(ohlcvn(stocknameph,4)),', <font color="red">',num2str(ohlcvn(stocknameph,6)),'</font>']; 
    end    
      
    istr='T5162'; jstr='AWL'; kstr='123456789';
    for i=1:5
      for j=1:3
        for k=1:9
           eval(['outstruct.',jstr(j),istr(i),'t',kstr(k),'=''N/A'';']);          
         end
      end
    end  
    
    if length(y1)>0
        
      namelist=namelist(y1,:);
      ohlcvnD=ohlcvn(y1,:); 
      ohlcvnT=ohlcvnT(y1,:);        
      
      if statname~=1
        load fpwmyvold
        Vaccu=volumeaccu(y1);
        eval(['load ',tickdayplacesc,'D',sprintf('%07d',dailyfilenumber-statname),' ohlcvn volumeaccu']);
        ohlcvnTv=ohlcvnD(:,5)+Vaccu-volumeaccu(y1);
        ohlcvnTn=ohlcvnD(:,4)-ohlcvn(y1,4);   
      else
        ohlcvnTv=ohlcvnD(:,5);
        ohlcvnTn=ohlcvnD(:,6);    
      end
      
      smacwilo=namelist(sortzhu(ohlcvnTv,9,-1,0),:); % most active
      for i=1:length(smacwilo(:,1))
        stringout=['<a href="javascript: onclickstockqd(''S',markfilt(smacwilo(i,:)),''');">',markfilt(smacwilo(i,:)),'</a>'];
        eval(['outstruct.ATt',kstr(i),'=stringout;']);
      end
      smacwilo=namelist(sortzhu(ohlcvnTn,9,1,0),:); % losers
      for i=1:length(smacwilo(:,1))
        stringout=['<a href="javascript: onclickstockqd(''S',markfilt(smacwilo(i,:)),''');">',markfilt(smacwilo(i,:)),'</a>'];
        eval(['outstruct.LTt',kstr(i),'=stringout;']);
      end      
      smacwilo=namelist(sortzhu(ohlcvnTn,9,-1,0),:); % winners
      for i=1:length(smacwilo(:,1))
        stringout=['<a href="javascript: onclickstockqd(''S',markfilt(smacwilo(i,:)),''');">',markfilt(smacwilo(i,:)),'</a>'];
        eval(['outstruct.WTt',kstr(i),'=stringout;']);
      end
      
      load fpwmyvolt
      Vaccu=volumeaccu(y1);
      Vaccu1=volumeaccu;
      numorder=[1 3 12 24]; %(5 15 60 120 mins.)/5
      for j=1:4
        eval(['load ',tickdayplacesc,'T',sprintf('%07d',tickfilenumber-statname*numorder(j)),' ohlcvn volumeaccu']);
        ohlcvnTv=Vaccu-volumeaccu(y1)+ohlcvnT(:,5)/100;
        ohlcvnTn=ohlcvnT(:,4)-ohlcvn(y1,4);
        if j==3
          ohlcvnTvs=Vaccu1-volumeaccu+ohlcvnT1(:,5)/100;
          ohlcvnTns=ohlcvnT1(:,4)-ohlcvn(:,4);          
        end
      
        smacwilo=namelist(sortzhu(ohlcvnTv,9,-1,0),:); % most active
        for i=1:length(smacwilo(:,1))
          stringout=['<a href="javascript: onclickstockqd(''S',markfilt(smacwilo(i,:)),''');">',markfilt(smacwilo(i,:)),'</a>'];
          eval(['outstruct.A',istr(j+1),'t',kstr(i),'=stringout;']);
        end
        smacwilo=namelist(sortzhu(ohlcvnTn,9,1,0),:); % losers
        for i=1:length(smacwilo(:,1))
          stringout=['<a href="javascript: onclickstockqd(''S',markfilt(smacwilo(i,:)),''');">',markfilt(smacwilo(i,:)),'</a>'];
          eval(['outstruct.L',istr(j+1),'t',kstr(i),'=stringout;']);
        end      
        smacwilo=namelist(sortzhu(ohlcvnTn,9,-1,0),:); % winners
        for i=1:length(smacwilo(:,1))
          stringout=['<a href="javascript: onclickstockqd(''S',markfilt(smacwilo(i,:)),''');">',markfilt(smacwilo(i,:)),'</a>'];
          eval(['outstruct.W',istr(j+1),'t',kstr(i),'=stringout;']);
        end  
      end
    else
      load fpwmyvolt
      Vaccu1=volumeaccu;
      eval(['load ',tickdayplacesc,'T',sprintf('%07d',tickfilenumber-statname*12),' ohlcvn volumeaccu']);
      ohlcvnTvs=Vaccu1-volumeaccu+ohlcvnT1(:,5)/100;
      ohlcvnTns=ohlcvnT1(:,4)-ohlcvn(:,4);           
    end
    
    ohlcvn(:,6)=ohlcvnDD(:,6);
    ohlcvn(:,5)=ohlcvnDD(:,5);          
    outstruct.AUnum=num2str(length(find(ohlcvn(1:market(1)-1,6)>0)));
    outstruct.ADnum=['<font color="red">',num2str(length(find(ohlcvn(1:market(1)-1,6)<0))),'</font>'];
    outstruct.AUVnum=['<font color="blue">',num2str(0.1*sum(ohlcvn(find(ohlcvn(1:market(1)-1,6)>0),5)),'%8.3f'),'M</font>'];
    outstruct.A0Vnum=['<font color="black">',num2str(0.1*sum(ohlcvn(find(ohlcvn(1:market(1)-1,6)==0),5)),'%8.3f'),'M</font>'];
    outstruct.ADVnum=['<font color="red">',num2str(0.1*sum(ohlcvn(find(ohlcvn(1:market(1)-1,6)<0),5)),'%8.3f'),'M</font>'];
    
    outstruct.NUnum=num2str(length(find(ohlcvn(market(2):length(ohlcvn(:,1)),6)>0)));
    outstruct.NDnum=['<font color="red">',num2str(length(find(ohlcvn(market(2):length(ohlcvn(:,1)),6)<0))),'</font>'];
    outstruct.NUVnum=['<font color="blue">',num2str(0.1*sum(ohlcvn(find(ohlcvn(market(2):length(ohlcvn(:,1)),6)>0),5)),'%8.3f'),'M</font>'];
    outstruct.N0Vnum=['<font color="black">',num2str(0.1*sum(ohlcvn(find(ohlcvn(market(2):length(ohlcvn(:,1)),6)==0),5)),'%8.3f'),'M</font>'];
    outstruct.NDVnum=['<font color="red">',num2str(0.1*sum(ohlcvn(find(ohlcvn(market(2):length(ohlcvn(:,1)),6)<0),5)),'%8.3f'),'M</font>'];
    
    outstruct.OUnum=num2str(length(find(ohlcvn(market(1):market(2)-1,6)>0)));
    outstruct.ODnum=['<font color="red">',num2str(length(find(ohlcvn(market(1):market(2)-1,6)<0))),'</font>'];
    outstruct.OUVnum=['<font color="blue">',num2str(0.1*sum(ohlcvn(find(ohlcvn(market(1):market(2)-1,6)>0),5)),'%8.3f'),'M</font>'];
    outstruct.O0Vnum=['<font color="black">',num2str(0.1*sum(ohlcvn(find(ohlcvn(market(1):market(2)-1,6)==0),5)),'%8.3f'),'M</font>'];
    outstruct.ODVnum=['<font color="red">',num2str(0.1*sum(ohlcvn(find(ohlcvn(market(1):market(2)-1,6)<0),5)),'%8.3f'),'M</font>'];    
    
    outstruct.Anum=[' ',num2str(length(find(ohlcvn(1:market(1)-1,6)==0)))];  %[' ',int2str(market(1)-1)];
    outstruct.Onum=[' ',num2str(length(find(ohlcvn(market(1):market(2)-1,6)==0)))]; %[' ',int2str(market(2)-market(1))];
    outstruct.Nnum=[' ',num2str(length(find(ohlcvn(market(2):length(ohlcvn(:,1)),6)==0)))]; %[' ',int2str(length(Vaccu1)-market(2)+1)];    
    
    outstruct.ST1=int2str(statname*5);
    outstruct.ST2=int2str(statname*15);
    outstruct.ST3=int2str(statname);
    outstruct.ST4=int2str(statname*2);
    if statname>1
      outstruct.ST5=' Hrs';
      outstruct.ST6=[int2str(statname),' '];
      outstruct.ST7='Days';
    else
      outstruct.ST5=' Hr';
      outstruct.ST6='To';
      outstruct.ST7='day';
    end
    outstruct.ST8='To';
    outstruct.ST9='day';    
    
    currenttimer=clock;
    wbmpstattime=time1(currenttimer);
    timecal=currenttimer(4)+currenttimer(5)/60;
    datetoday=[currenttimer(2:3) currenttimer(1)-2000];
    if (timecal>8.0)&(timecal<18.5)&(dn(datetoday)<=5)
      outstruct.updatedtime='STAT Updated Time';
      tseconds=str2num(wbmpstattime(7:8));
      if tseconds<15
        wbmpstattime(7:8)='00';
      elseif (tseconds>=15)&(tseconds<30)
        wbmpstattime(7:8)='15';
      elseif (tseconds>=30)&(tseconds<45)
        wbmpstattime(7:8)='30';
      elseif (tseconds>=45)
        wbmpstattime(7:8)='45';
      end
    else
      outstruct.updatedtime='Current Time';
    end
    outstruct.wbmpstattime=time1; %wbmpstattime; %sprintf('%02d',tseconds);
    outputwindow=21;
  end    
  
  if ~(strcmp(upper(fpwusername(1:4)),'USER'))
    if strcmp(upper(fpwusername),'NINGZHU')
      outstruct.mybarh21=int2str(20000);  
      outstruct.mybarh22=int2str(700);
    else
      outstruct.mybarh21=int2str(300000);
      outstruct.mybarh22=int2str(12);
    end
  else
    outstruct.mybarh21=int2str(9999999);
    outstruct.mybarh22=int2str(3);
  end
  
  if outputwindow==21
    if ~strcmp(WhereOrderFrom,'MPST')
      % output data to wbmpstatR.html first
      cd(fpwserverplace);
      templatefile = which('wbmpstatR.html');
      str = htmlrep(outstruct, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\twbmpstatR.html'],'noheader');
      outstruct.MPSTAToutput=[fpwclientdirectory,fpwusername,'\stock\twbmpstatR.html'];
    end
  end
  
  % time mark
  cd(fpwserverplace);
  cids=fpwloginstatus(fpwusername,clock);

  if outputwindow==21
    if strcmp(WhereOrderFrom,'MPST')
      templatefile = which('wbmpstatR.html');
    else
      templatefile = which('wbmpstat.html');
    end
    if (nargin == 1)
      retstr = htmlrep(outstruct, templatefile); 
    elseif (nargin == 2)
      retstr = htmlrep(outstruct, templatefile, outfile);
    end
  else
    templatefile = which('wbcheckbanw.html');   
    outstruct.mpgfoutput=' ';
    if (nargin == 1)
      retstr = htmlrep(outstruct, templatefile);     
    elseif (nargin == 2)
      retstr = htmlrep(outstruct, templatefile, outfile);
    end    
  end
end