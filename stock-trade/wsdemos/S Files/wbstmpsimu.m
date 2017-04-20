function retstr = wbstmpsimu(instruct, outfile)

% Author(s): N. Zhu, 11-15-2003
% This is a WB (Web-Based) mirror program to <stsimulp>, <stsiedit>, <stsirun> and more in desktop version

wbfpwbasic;
cd(fpwserverplace);

retstr = char('');
fpwusername=instruct.mlid{1};
fpwCPAL=2;
fpwloginIP='192.168.2.8';
fpwcheckil;

if fpwcheckilpass==1
    
wbststopritm=0;
eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbststopritm.mat wbststopritm']);

WhereOrderFrom=instruct.WhereOrderFrom;
if ~(strcmp(WhereOrderFrom,'INDX'))
  urbanwords='';
  [fpwscpass1,whereban1,whatban1]=wbcheckbanw('MPEFEF',instruct.mpefef);
  if fpwscpass1~=1
    urbanwords=[urbanwords,whereban1,': ',whatban1,'; '];
  end            
  [fpwscpass2,whereban2,whatban2]=wbcheckbanw('MPPTNAME',instruct.mpptname);
  if fpwscpass2~=1
    urbanwords=[urbanwords,whereban2,': ',whatban2,'; '];
  end           
  [fpwscpass3,whereban3,whatban3]=wbcheckbanw('MPEFEF',instruct.mpptfilef);
  if fpwscpass3~=1
    urbanwords=[urbanwords,whereban3,': ',whatban3,'; '];
  end           
  if (fpwscpass1+fpwscpass2+fpwscpass3)~=3
    fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
    fseek(fid1,-50,1); fprintf(fid1,[time,' FAIL: ',urbanwords,'\n']); fclose(fid1);
    clear fid1    
    WhereOrderFrom='SCFL'
    smps.urbanwords=urbanwords;
    %smps.StatusReport=['Warning, banned words found: ',urbanwords];
  end
  clear urbanwords fpwscpass1 whereban1 whatban1 fpwscpass2 whereban2 whatban2 fpwscpass3 whereban3 whatban3
end

cd([Wherematlab,'stock']);
mpsimwindow=2;
mpmaxlength=199; % maximum holding length
if (strcmp(WhereOrderFrom,'SLFE'))
  if (isfield(instruct,'mpefef'))
    cd([Wherematlab,'pattern']);
    if fpwsecucheck([instruct.mpefef,instruct.mpptfilef])>0
      error(' Hei! Not allowed content found, are you seriously trying to .... Sorry, change it.');
    end
    cd([Wherematlab,'stock']);
  end
  eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbmpsinput instruct']);
  mprunindex=instruct.mprunindex; % in string format
  mpsrsindex=instruct.mpsrsindex; % in string format  
  filetypeid=instruct.filetypeid;
  
  % simulation parameters
  mpspsp=str2num(instruct.mpspsp); 
  mpsphl=max([1 min([mpmaxlength str2num(instruct.mpsphl)])]); % with maximum allowed as 199 bars
  mpspv=str2num(instruct.mpspv);
  mpspp=str2num(instruct.mpspp);
  mpspvp=str2num(instruct.mpspvp);
  mpmruon=str2num(instruct.mpmruon);  
  mpmrkind=str2num(instruct.mpmrkind); 
  mpmrvo=str2num(instruct.mpmrvo);
  mpmrstop=str2num(instruct.mpmrstop);  
  mpmrobje=str2num(instruct.mpmrobje);   

  % simulation pattern file  
  mpptname=upper(noempty(instruct.mpptname));
  mpptdt=instruct.hdmpptdt;
  mpptmrk=instruct.mpptmrk;
  mpptfilef=instruct.mpptfilef; 
  % filter ascii number 10 or 13, could not be both, don't know why! either ONE of the following two lines will work.
  mpptfilef=mpptfilef(find(mpptfilef~=10));
  %mpptfilef=mpptfilef(find(mpptfilef~=13));
  
  % Decomposition parameters
  mpefsp=str2num(instruct.mpefsp);  
  mpefvb=str2num(instruct.mpefvb);
  mpefhl=str2num(instruct.mpefhl);
  mpefhlqs=str2num(instruct.mpefhlqs);  
  mpefve=str2num(instruct.mpefve);  
  mpefpb=str2num(instruct.mpefpb);
  mpefpe=str2num(instruct.mpefpe);
  mpefvpb=str2num(instruct.mpefvpb);
  mpefvpe=str2num(instruct.mpefvpe);
  mpefls=instruct.hdmpefls;  
  mpefco=instruct.hdmpefco;  
  mpefcoqs=instruct.hdmpefcoqs;  
  mpefef=instruct.mpefef;
  if length(noempty(mpefef))==0
    mpefef='Enter any statement here.';
  end
  
  % Previous Statistics output
  mpswinno=str2num(instruct.mpswinno);
  mpslossno=str2num(instruct.mpslossno);	
  mpsdrawno=str2num(instruct.mpsdrawno);	
  mpswinper=str2num(instruct.mpswinper);	
  mpsevdd=str2num(instruct.mpsevdd);	
  mpsprfr=str2num(instruct.mpsprfr);	
  mpsequity=str2num(instruct.mpsequity);	
  mpsmaxfp=str2num(instruct.mpsmaxfp);	
  mpsmaxdd=str2num(instruct.mpsmaxdd);	
  mpsavet=str2num(instruct.mpsavet);	
  mpsavew=str2num(instruct.mpsavew);	
  mpsavel=str2num(instruct.mpsavel);  
  mpsmaxw=str2num(instruct.mpsmaxw);		
  mpsmaxl=str2num(instruct.mpsmaxl);
    
  fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
  fseek(fid1,-50,1); fprintf(fid1,[time,' FS',instruct.mprunindex,'\n']); fclose(fid1);
  clear fid1

  smps2.Runmemo='Running ......';
  templatefile = which('duringrun.html');      
  str = htmlrep(smps2, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\tduringrun.html'],'noheader');    
  
  if strcmp(mprunindex,'11')
    % first to find the market list, just use <wbstdzhjust>
    %templatefile = which('wbcheckbanw.html');    
    %smps.mpgfoutput=' ';
    %if (nargin == 1)
    %  retstr = htmlrep(smps, templatefile);     
    %elseif (nargin == 2)
    %  retstr = htmlrep(smps, templatefile, outfile);
    %end  
    %return;
    
    linecond=mpptfilef;
    simfilterb=strfind(linecond,'[General Filter]');
    if length(simfilterb)==0
      error(' Pattern file format not right, using [General Filter] to begin the general filter part.');
    else
      simfilterb=simfilterb+16;
    end
    
    simfiltere=strfind(linecond,'[MP Pattern]');
    if length(simfiltere)==0
      error(' Pattern file format not right, using [MP Pattern] to begin the pattern part.');
    else
      simfiltere=simfiltere-1;
    end
    linefilef=linecond(simfiltere+13:length(linecond));
    linefilef=linefilef(find(linefilef>=32));
    minumne=strfind(linefilef,'y=0;');
    eval([linefilef(1:minumne-1),';']); % find the nums setting
    
    if simfiltere>=simfilterb
      linecond=linecond(simfilterb:simfiltere);
      if length(noempty(linecond))>0
        if length(find(linecond>=32))>0
          linecond=linecond(find(linecond>=32));
        end
      end
      if length(noempty(linecond))<4; linecond='C0>0;'; end
    else
      linecond='C0>0;';
    end
    
    global PE CAP SInd KWIN  RmSI RmKW MoreDaysi %SInd - Sector Index, KWIN - Key Words In company Names
    SInd=-1; KWIN='1'; RmSI=[]; RmKW='1';
    
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
    
    % find the MoreDays indicator/Parameter
    MoreDaysi=0;
    if length(mpptfilef)>0
      if length(strfind(mpptfilef,'MoreDaysi'))==1
        Moredaysip=strfind(mpptfilef,'MoreDaysi');
        Moredaysipstr=mpptfilef(Moredaysip(1):length(mpptfilef));
        Moredaysipe=strfind(Moredaysipstr,'=');
        Moredaysipc=strfind(Moredaysipstr,';');
        MoreDaysi=str2num(Moredaysipstr(Moredaysipe(1)+1:Moredaysipc(1)-1));
        %mpptfilef=[mpptfilef(1:Moredaysip(1)-1),Moredaysipstr(Moredaysipc(1)+1:length(Moredaysipstr)];
        if length(MoreDaysi)==1
          MoreDaysi=round(MoreDaysi);
        else
          error(' The way to use MoreDaysi is wrong!');    
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
    
    y13=[];
    if length(noempty(linecond))>0
      SIndplaceh1=strfind(upper(linecond),'SLIST=');
      if length(SIndplaceh1)>0
        linecondne=linecond(SIndplaceh1(1)+6:length(linecond));
        SIndplaceh=strfind(linecondne,';');
        if length(SIndplaceh)>0
          if SIndplaceh(1)>1
            MySymb=['',noempty(linecondne(1:SIndplaceh(1)-1)),''];
            MySymb=upper(MySymb);
            if length(MySymb)>0
              if length(MySymb)<6
                MySymb1='$$$$$$';
                MySymb1(1:length(MySymb))=MySymb;
                MySymb=MySymb1; 
                clear MySymb1;
              else
                MySymb=MySymb(1:6);
              end
              load nlt namelist
              MySymbi=strfind(reshape(namelist',1,length(namelist(:,1))*6),MySymb);
              if length(MySymbi)>0
                y13=fix(MySymbi/6)+1;
              else
                error('  No such symbol, please enter in the form of ''SList=SYMBOL;'' .0');
              end
            else
              error('  empty symbol, please enter in the form of ''SList=SYMBOL;'' .1');
            end
            linecond(SIndplaceh1(1):SIndplaceh1(1)+6+SIndplaceh(1)-1)=['1;',blanks(4+SIndplaceh(1))];
          else
            error('  empty symbol, please enter in the form of ''SList=SYMBOL;'' .2');
          end
        end
      end
    end
    
    if (strcmp(mpptdt,'Tick'))
      ToD='T';
    else
      ToD='D';
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
    global forcetouseyd BETA
    forcetouseyd=1;
    
    [y2 y1]=stfilter(combcondi1,combcondi2,combcondi3,combcondi4,combcondi5,combcondi6,ToD); clear y2
    load nlt
    load fpwnlt sectorind NOE CCODE outstandshare SFL DOW30Ind NDX100Ind SP100Ind SP500Ind% couple relatively stable parameters for a period of time.
    if (~strcmp(mpptmrk,'AllMrkts'))
      rndx=zeros(length(namelist(:,1)),1);
      rndx(y1)=ones(size(y1));
      y1=rndx;
      rndx=ones(length(namelist(:,1)),1);
      smarket=mpptmrk; % ano(123),4-all
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
    
    if length(y13)>0; y1=y13; end
    
    namelist=namelist(y1,:);
    sectorind=sectorind(y1);
    NOE=NOE(y1);
    CCODE=CCODE(y1);
    outstandshare=outstandshare(y1);
    SFL=SFL(y1)/100;
    inoriginalorder=y1;
    DNSS=[DOW30Ind; NDX100Ind; SP100Ind(1:100,1); SP500Ind];
    clear y1 rndx i
    
    % begin to simulate like <stsimulp>
    wphdtu=mpspsp; hmdats=mpsphl; RunTickOrDay=ToD; marke=mpptmrk; market=marke;
    herestopp=mpmrstop; hereobjep=mpmrobje; herekindm=mpmrkind;
    hmsiaf=250; % how many signals in a temporary file
    cusresu=zeros(hmsiaf,2*hmdats);         % dire*([o(i+1) c(i+1) o(i+2) c(i+2) .... o(i+hmdats) c(i+hmdats)]-c(i)) Net matrix
    %cusresui=cusresu; % same size as cusresu to monitor open/close
    cusresuna=setstr(zeros(hmsiaf,6)+78);   % [$$$$$$]
    cusresupd=zeros(hmsiaf,15);             % [enw*dire c(i) v(i) c(i-1) v(i-1) exitplace-from-enw real-entry-price ostg SharesInFloating(B) MoreDaysi] 
                                            %        [MaxLost MaxWin LW-First FinalNet StoppedOutAtOpenValue stock_SN]; for win first: LW-First=1, otherwise -1;
    cusresurv=zeros(hmsiaf,96);             % [range(3 6 12) vol(3 6 12) ma(3 6 12 25 75 200) vol(25 75 250) spx(0 6 12 25 75 200) h250 l250 h25 l25
                                            %  h0 l0 SectInd NOE CCODE cap lastbuy/short c2 v2 mpindex h75 l75 h3 l3 h6 l6 h12 l12 c3m c6m c12m c25m c75m c250m
                                            %  Xh0 Xh3 Xh6 Xh12 Xh25 Xh75 Xh250 Xl0 Xl3 Xl6 Xl12 Xl25 Xl75 Xl250
                                            %  Xih6 Xih12 Xih25 Xih75 Xih250 Xil6 Xil12 Xil25 Xil75 Xil250 stopobje
                                            %  Xim Xi25a Xi75a Xi250a Xhh h500 l500 Xh500 Xl500 dayn weekn Xr7 Xr14 Xr30 rsi7 rsi14 rsi30 Xr100]
        % enw is defined as the distance from the end (the most recent), the last day as 1.
    global Stopnum Objenum StopfP ObjefP retreatstopi
    filetosave=1; signalnumb=1; Stopnum=0; Objenum=0; StopfP=[]; ObjefP=[]; 
    if (strcmp(upper(fpwusername),'NINGZHU')==1)|(strcmp(upper(fpwusername),'DIANEXU')==1)
      retreatstopi=1; % 1 means to use this stop, others mean not to use.
    else
      retreatstopi=0;
    end
    cuslenf=length(namelist(:,1));    
    mpsdl=[]; %MP simulation date last
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
    
    mympptlines=[]; mpindexi=0;
    if (strcmp(upper(fpwusername),'NINGZHU')==1)|(strcmp(upper(fpwusername),'DIANEXU')==1)
      fidmppt=-1;
      if 1
        if length(strfind(lower(linefilef),'mymppt'))>0
          mympptind=strfind(lower(linefilef),'mymppt');
          mympptindi=0;
          while linefilef(mympptind(1)+6+mympptindi)~=';'
            mympptindi=mympptindi+1;
          end
          filenametop=linefilef(mympptind(1):mympptind(1)+5+mympptindi);
          fidmppt=fopen([filenametop,'.m'],'r');
          if 1
            if length(mympptind)==2
              mympptindi=0;
              while linefilef(mympptind(2)+6+mympptindi)~=';'
                mympptindi=mympptindi+1;
              end
              filenametop2=linefilef(mympptind(2):mympptind(2)+5+mympptindi);
              fidmppt2=fopen([filenametop2,'.m'],'r');
            end
          end
        end
        %clear mympptindi mympptind
        if length(strfind(lower(linefilef),'mympptspx'))>0
          mpindexi=1; mpindexii=1;
        elseif length(strfind(lower(linefilef),'mympptwtspx'))>0
          mpindexi=1; mpindexii=0;
        end
      else
        if length(strfind(lower(linefilef),'mympptspx'))>0
          fidmppt=fopen('mympptspx.m','r');
          mpindexi=1; mpindexii=1;
        elseif length(strfind(lower(linefilef),'mympptwtspx'))>0
          fidmppt=fopen('mympptwtspx.m','r');
          mpindexi=1; mpindexii=0;
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
      if length(mympptind)==2
        if ~(fidmppt2==-1)
          mpindexi=0;
          while 1
            mymppttline = fgetl(fidmppt2);
            if ~ischar(mymppttline), break, end
            mympptlines=[mympptlines,mymppttline];
          end
          fclose(fidmppt2);
        end
      end
      clear mympptindi mympptind
    end
    mympptlines=[mympptlines,linefilef];
        
    if length(strfind([linefilef,mympptlines],'ac3'))>0;   myvhi(1)=1;  end
    if length(strfind([linefilef,mympptlines],'ac6'))>0;   myvhi(2)=1;  end
    if length(strfind([linefilef,mympptlines],'ac12'))>0;  myvhi(3)=1;  end
    if length(strfind([linefilef,mympptlines],'ac25'))>0;  myvhi(4)=1;  end
    if length(strfind([linefilef,mympptlines],'ac75'))>0;  myvhi(5)=1;  end
    if length(strfind([linefilef,mympptlines],'ac250'))>0; myvhi(6)=1;  end
    if length(strfind([linefilef,mympptlines],'av3'))>0;   myvhi(7)=1;  end
    if length(strfind([linefilef,mympptlines],'av6'))>0;   myvhi(8)=1;  end
    if length(strfind([linefilef,mympptlines],'av12'))>0;  myvhi(9)=1;  end
    if length(strfind([linefilef,mympptlines],'av25'))>0;  myvhi(10)=1; end
    if length(strfind([linefilef,mympptlines],'av75'))>0;  myvhi(11)=1; end
    if length(strfind([linefilef,mympptlines],'av250'))>0; myvhi(12)=1; end
    if length(strfind([linefilef,mympptlines],'h250'))>0;  myvhi(13)=1; end
    if length(strfind([linefilef,mympptlines],'l250'))>0;  myvhi(14)=1; end
    if length(strfind([linefilef,mympptlines],'h25'))>0;   myvhi(15)=1; end
    if length(strfind([linefilef,mympptlines],'l25'))>0;   myvhi(16)=1; end
    if length(strfind([linefilef,mympptlines],'h75'))>0;   myvhi(17)=1; end
    if length(strfind([linefilef,mympptlines],'l75'))>0;   myvhi(18)=1; end
    if length(strfind([linefilef,mympptlines],'h3'))>0;    myvhi(19)=1; end
    if length(strfind([linefilef,mympptlines],'l3'))>0;    myvhi(20)=1; end
    if length(strfind([linefilef,mympptlines],'h6'))>0;    myvhi(21)=1; end
    if length(strfind([linefilef,mympptlines],'l6'))>0;    myvhi(22)=1; end 
    if length(strfind([linefilef,mympptlines],'h12'))>0;   myvhi(23)=1; end
    if length(strfind([linefilef,mympptlines],'l12'))>0;   myvhi(24)=1; end
    if length(strfind([linefilef,mympptlines],'c3m'))>0;   myvhi(25)=1; end
    if length(strfind([linefilef,mympptlines],'c6m'))>0;   myvhi(26)=1; end
    if length(strfind([linefilef,mympptlines],'c12m'))>0;  myvhi(27)=1; end
    if length(strfind([linefilef,mympptlines],'c25m'))>0;  myvhi(28)=1; end
    if length(strfind([linefilef,mympptlines],'c75m'))>0;  myvhi(29)=1; end
    if length(strfind([linefilef,mympptlines],'c250m'))>0; myvhi(30)=1; end
    if length(strfind([linefilef,mympptlines],'h500'))>0;  myvhi(31)=1; end
    if length(strfind([linefilef,mympptlines],'l500'))>0;  myvhi(32)=1; end
    if length(strfind([linefilef,mympptlines],'l500'))>0;  myvhi(32)=1; end
    if length(strfind([linefilef,mympptlines],'rsi7'))>0;  myvhi(33)=1; end
    if length(strfind([linefilef,mympptlines],'rsi14'))>0; myvhi(34)=1; end
    if length(strfind([linefilef,mympptlines],'rsi30'))>0; myvhi(35)=1; end
    
    myXsi=1;
    if 0
      if length(strfind([linefilef,mympptlines],'Xii1'))>0; myXsi=1; end
      if length(strfind([linefilef,mympptlines],'Xi6i1'))>0; myXsi=1; end
      if length(strfind([linefilef,mympptlines],'Xi12i1'))>0; myXsi=1; end
      if length(strfind([linefilef,mympptlines],'Xi25i1'))>0; myXsi=1; end
      if length(strfind([linefilef,mympptlines],'Xi75i1'))>0; myXsi=1; end
      if length(strfind([linefilef,mympptlines],'Xi250i1'))>0; myXsi=1; end
      if length(strfind([linefilef,mympptlines],'Xi25mi1'))>0; myXsi=1; end
      if length(strfind([linefilef,mympptlines],'Xi75mi1'))>0; myXsi=1; end
      if length(strfind([linefilef,mympptlines],'Xi250mi1'))>0; myXsi=1; end
      if length(strfind([linefilef,mympptlines],'Xsi1'))>0; myXsi=1; end
      if length(strfind([linefilef,mympptlines],'Xh0'))>0; myXsi=1; end
      if length(strfind([linefilef,mympptlines],'Xh3'))>0; myXsi=1; end
      if length(strfind([linefilef,mympptlines],'Xh6'))>0; myXsi=1; end
      if length(strfind([linefilef,mympptlines],'Xh12'))>0; myXsi=1; end
      if length(strfind([linefilef,mympptlines],'Xh25'))>0; myXsi=1; end
      if length(strfind([linefilef,mympptlines],'Xh75'))>0; myXsi=1; end
      if length(strfind([linefilef,mympptlines],'Xh250'))>0; myXsi=1; end
      if length(strfind([linefilef,mympptlines],'Xh500'))>0; myXsi=1; end
      if length(strfind([linefilef,mympptlines],'Xl0'))>0; myXsi=1; end
      if length(strfind([linefilef,mympptlines],'Xl3'))>0; myXsi=1; end
      if length(strfind([linefilef,mympptlines],'Xl6'))>0; myXsi=1; end
      if length(strfind([linefilef,mympptlines],'Xl12'))>0; myXsi=1; end
      if length(strfind([linefilef,mympptlines],'Xl25'))>0; myXsi=1; end
      if length(strfind([linefilef,mympptlines],'Xl75'))>0; myXsi=1; end
      if length(strfind([linefilef,mympptlines],'Xl250'))>0; myXsi=1; end
      if length(strfind([linefilef,mympptlines],'Xl500'))>0; myXsi=1; end
    end
    
    % wphdtu=4000; RunTickOrDay='d';
    XI=stgetdaa('spx',lower(RunTickOrDay),max([500 round(1.5*wphdtu)]));
    mpsdl=XI(length(XI(:,1)),1:3); %MP simulation date last
    if lower(RunTickOrDay)=='d'
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
    XI25=ma(XI,25); XI25m=mtm(ma(XI25,2),1); XI25a=mtm(ma(XI25m,2),1);
    XI75=ma(XI,75); XI75m=mtm(ma(XI75,6),2); XI75a=mtm(ma(XI75m,6),2);
    XI250=ma(XI,250); XI250m=mtm(ma(XI250,15),5); XI250a=mtm(ma(XI250m,15),5);
    
    
    Xs=mtm(XI,250)./(stdm(XI,250)+0.1);
    Xs=ma(ma(Xs,100),100)*100+1000;     % either above 1150 or up 70 from low(150)
    XS=0*Xs;
    XHH=XS+100;
    XHI500=XHI250;
    XLI500=XLI250;
    
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
    %figure; plot(XI);hold on; plot(Xs,'-g');plot(XS*100+1000,'-r'); grid; hold off;
    
    NOWhms=now;
    for j=1:cuslenf
        
      if rem(j-1,min([10 max([3 round(0.005*cuslenf)])]))==0
        cd(fpwserverplace);
        templatefile = which('wbduringrun.html');
        smps2.fpwtime=[datestr(now-NOWhms,13),', ',time1];
        smps2.fpwusername=fpwusername;
        smps2.fpwrprogram = ['MPFS: ',upper(mpptname),' - ',upper(markfilt(namelist(j,:)))];
        smps2.percfinished=num2str(round(1000*j/cuslenf)/10);
        str = htmlrep(smps2, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\twbduringrun.html'],'noheader');
        cd([Wherematlab,'stock']);  
      end
      
      if rem(j,min([13 max([4 round(0.07*cuslenf)])]))==0
        cd(fpwserverplace);
        cidsmamamiya=fpwloginstatus(fpwusername,clock);
        smps2.Runmemo='Running ......';
        templatefile = which('duringrun.html');      
        str = htmlrep(smps2, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\tduringrun.html'],'noheader');           
        cd([Wherematlab,'stock']);
        % wbststopritm.mat file is issued by fpwwbststopritm.m in c:\matlab\stock.
        if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbststopritm.mat'])~=2
          wbststopritm=0;
          eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbststopritm.mat wbststopritm']);
        end
        eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbststopritm.mat']);        
        if wbststopritm==1
          wbststopritm=0;
          eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbststopritm.mat wbststopritm']);
          cd(fpwserverplace);
          cidsmamamiya=fpwloginstatus(fpwusername,clock);
          smps2.Runmemo='IRQ Stopped.';
          templatefile = which('duringrun.html');
          str = htmlrep(smps2, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\tduringrun.html'],'noheader');           
          cd([Wherematlab,'stock']);
          error(['  Stop-running has been requested. ',num2str(j),'-',num2str(cuslenf),'.']);
        end
      end  
        
      lastshw=-1000; lastlow=-1000; lastshp=1000000; lastlop=0; % most recent last signal
      lastshw2=-1000; lastlow2=-1000; lastshp2=1000000; lastlop2=0; % second most recent signal
      lastshw3=-1000; lastlow3=-1000; lastshp3=1000000; lastlop3=0; % third most recent signal
      stock=stgetdaa(lower(markfilt(namelist(j,:))),lower(RunTickOrDay),400+round(1.25*wphdtu));
      mpsdl2i=0;
      if length(stock)>0
        if lower(RunTickOrDay)=='d'
          if length(mpsdl)==0
            mpsdl=stock(length(stock(:,1)),1:3);
          end
          mpsdlhere=find((stock(:,1)==mpsdl(1))&(stock(:,2)==mpsdl(2))&(stock(:,3)==mpsdl(3)));
          if length(mpsdlhere)>0
            datem=stock(1:mpsdlhere(1),1:3);
            stock=stock(1:mpsdlhere(1),4:8);
          else
            mpsdl2i=1;
            datem=stock(:,1:3);
            stock=stock(:,4:8);
          end
        else
          if length(mpsdl)==0
            mpsdl=stock(length(stock(:,1)),1:5);
          end  
          mpsdlhere=find((stock(:,1)==mpsdl(1))&(stock(:,2)==mpsdl(2))&(stock(:,3)==mpsdl(3))&(stock(:,4)==mpsdl(4))&(stock(:,5)==mpsdl(5)));
          if length(mpsdlhere)>0
            datem=stock(1:mpsdlhere(1),1:5);
            stock=stock(1:mpsdlhere(1),6:10);
          else
            mpsdl2i=1;
            datem=stock(:,1:3);
            stock=stock(:,4:8);
          end
        end
        datem=datem(max([1 length(datem(:,1))-wphdtu-nums+1]):length(datem(:,1)),:);      
        stock=stock(max([1 length(stock(:,1))-wphdtu-nums+1]):length(stock(:,1)),:); 
        
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
        Xi25a=XI25a(length(XI)-length(stock(:,1))+1:length(XI));
        Xi75a=XI75a(length(XI)-length(stock(:,1))+1:length(XI));
        Xi250a=XI250a(length(XI)-length(stock(:,1))+1:length(XI));
        Xs=XS(length(XI)-length(stock(:,1))+1:length(XI));
        Xhh=XHH(length(XI)-length(stock(:,1))+1:length(XI));
        Xr7=XR7(length(XI)-length(stock(:,1))+1:length(XI));
        Xr14=XR14(length(XI)-length(stock(:,1))+1:length(XI));
        Xr30=XR30(length(XI)-length(stock(:,1))+1:length(XI));
        Xr100=XR100(length(XI)-length(stock(:,1))+1:length(XI));
      else
        stock=[0 0 0 0 0];
      end
      if mpsdl2i==1
        stock=[0 0 0 0 0];
      end
      %datem=datem(max([1 length(datem(:,1))-wphdtu-nums+1]):length(datem(:,1)),:);      
      %stock=stock(max([1 length(stock(:,1))-wphdtu-nums+1]):length(stock(:,1)),:);      
      
      % In order to get up to the last bar's simulation,
      % to add hmdats fake future data to simulate, by extending last moment for hmdats bars
      stockADDF=[zeros((1+MoreDaysi)*hmdats,4)+stock(length(stock(:,1)),4) zeros((1+MoreDaysi)*hmdats,1)];
      if rem(j,100)==1
        datemADDF=zeros((1+MoreDaysi)*hmdats,length(datem(1,:)));
        for i=1:(1+MoreDaysi)*hmdats
          datemADDF(i,:)=datem(length(datem(:,1)),:);
        end
      end
      stock=[stock;stockADDF];
      datem=[datem;datemADDF];
      clear stockADDF   
                
      %save c:\matlab\stock\tempMoreDaysi
      if length(stock(:,1))>(nums+(2+MoreDaysi)*hmdats)
        o=stock(:,1);h=stock(:,2);l=stock(:,3);c=stock(:,4);v=stock(:,5);
        if myvhi(1)==1; eval(myvh(1,:));   end
        if myvhi(2)==1; eval(myvh(2,:));   end
        if myvhi(3)==1; eval(myvh(3,:));   end
        if myvhi(4)==1; eval(myvh(4,:));   end
        if myvhi(5)==1; eval(myvh(5,:));   end
        if myvhi(6)==1; eval(myvh(6,:));   end
        if myvhi(7)==1; eval(myvh(7,:));   end
        if myvhi(8)==1; eval(myvh(8,:));   end
        if myvhi(9)==1; eval(myvh(9,:));   end
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
        
        if 1 % can add more indicators, using standard parameters
          if length(strfind(linefilef,'adxv'))>0; [adxv1 adxv2 adxv3 adxv4]=adx(stock); end
          if length(strfind(linefilef,'kdjv'))>0; [kdjv1 kdjv2 kdjv3]=kdj(stock); end          
          if length(strfind(linefilef,'macdv'))>0; [macdv1 macdv2 macdv3 macdv4 macdv5]=macd(c); end          
          if length(strfind(linefilef,'rsiv'))>0; rsiv1=rsiall(c); end          
          if length(strfind(linefilef,'rsiwv'))>0; rsiwv1=rsiwall(c); end
        end
        
        entryprice=[]; NoEntryPriceHere=0; lastbuy=-5000; lastshort=-5000;
        for i=nums+1:max([nums+1 length(stock(:,1))-(1+MoreDaysi)*hmdats])
          StopfP=[]; ObjefP=[];
          if myXsi==1
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
          
          eval(linefilef); % here is the key.
                           % all possible varible: o h l c v datem marke
                           %                       lastlow(2,3) lastshw(2,3) lastlop lastshp
                           %                       ac3, ac6, ac12, ac25, ac75, ac200
                           %                       av3, av6, av12, av25, av75, av200
                           %                       Xi,Xi6, Xi12, Xi25, Xi75, Xi250
          if y~=0
            if length(entryprice)==0; NoEntryPriceHere=1; end %if not find when runs in the first time
            if NoEntryPriceHere==1; entryprice=c(i); end
            if mpmruon==0
              [cusresus ewrfn stopobje ostg]=ststatis(stock,entryprice,y,i,hmdats);
            else
              [cusresus ewrfn stopobje ostg]=ststatis(stock,entryprice,y,i,hmdats,mpmrstop,mpmrobje,mpmrkind,mpmrvo);
            end
            if length(cusresus)>0
              cusresu(signalnumb,:)=cusresus;
              cusresuna(signalnumb,:)=lower(namelist(j,:));
              cusresupd(signalnumb,:)=[y*(length(stock(:,1))-i+1) c(i) v(i) c(i-1) v(i-1) ewrfn entryprice ostg outstandshare(j)*SFL(j) MoreDaysi j]; % can drop 7th one here, will auto add in '71' when needed
              
              %cusresurv: [range(3 6 12) vol(3 6 12) ma(3 6 12 25 75 200) vol(25 75 250) spx(0 6 12 25 75 200)]
              cusresurv(signalnumb,1)=mean(stock(max([1 i-3]):i-1,2)-stock(max([1 i-3]):i-1,3));
              cusresurv(signalnumb,2)=mean(stock(max([1 i-6]):i-1,2)-stock(max([1 i-6]):i-1,3));
              cusresurv(signalnumb,3)=mean(stock(max([1 i-12]):i-1,2)-stock(max([1 i-12]):i-1,3));
              cusresurv(signalnumb,4)=mean(stock(max([1 i-3]):i-1,5));
              cusresurv(signalnumb,5)=mean(stock(max([1 i-6]):i-1,5));
              cusresurv(signalnumb,6)=mean(stock(max([1 i-12]):i-1,5));
              cusresurv(signalnumb,7)=mean(stock(max([1 i-3]):i-1,4));
              cusresurv(signalnumb,8)=mean(stock(max([1 i-6]):i-1,4));
              cusresurv(signalnumb,9)=mean(stock(max([1 i-12]):i-1,4));
              cusresurv(signalnumb,10)=mean(stock(max([1 i-25]):i-1,4));
              cusresurv(signalnumb,11)=mean(stock(max([1 i-75]):i-1,4));
              cusresurv(signalnumb,12)=mean(stock(max([1 i-250]):i-1,4));
              cusresurv(signalnumb,13)=mean(stock(max([1 i-25]):i-1,5));
              cusresurv(signalnumb,14)=mean(stock(max([1 i-75]):i-1,5));
              cusresurv(signalnumb,15)=mean(stock(max([1 i-250]):i-1,5));
              cusresurv(signalnumb,16:21)=[Xi(i-1) Xi6(i-1) Xi12(i-1) Xi25(i-1) Xi75(i-1) Xi250(i-1)];
              cusresurv(signalnumb,22:25)=[Xi25m(i-1) Xi75m(i-1) Xi250m(i-1) Xs(i-1)];
              cusresurv(signalnumb,26)=max(stock(max([1 i-250]):i-1,2));
              cusresurv(signalnumb,27)=min(stock(max([1 i-250]):i-1,3));
              cusresurv(signalnumb,28)=max(stock(max([1 i-25]):i-1,2));
              cusresurv(signalnumb,29)=min(stock(max([1 i-25]):i-1,3));
              cusresurv(signalnumb,30)=h(i);
              cusresurv(signalnumb,31)=l(i);
              cusresurv(signalnumb,32)=sectorind(j);
              cusresurv(signalnumb,33)=NOE(j);
              cusresurv(signalnumb,34)=CCODE(j);
              cusresurv(signalnumb,35)=outstandshare(j)*c(i)/1000; % in billion dollars
              
              if y==1
                cusresurv(signalnumb,36)=i-lastbuy; % buy span between trades
                lastbuy=i;
              else
                cusresurv(signalnumb,36)=i-lastshort; % short span between trades
                lastshort=i;
              end
              cusresurv(signalnumb,37)=c(i-2);
              cusresurv(signalnumb,38)=v(i-2);
              if mpindexi==1;
                cusresurv(signalnumb,39)=mpindexii;
              else
                if length(find(DNSS==inoriginalorder(j)))>0
                  cusresurv(signalnumb,39)=1;
                else
                  cusresurv(signalnumb,39)=0;
                end
              end
              cusresurv(signalnumb,40)=max(stock(max([1 i-75]):i-1,2));
              cusresurv(signalnumb,41)=min(stock(max([1 i-75]):i-1,3));
              cusresurv(signalnumb,42)=max(stock(max([1 i-3]):i-1,2));
              cusresurv(signalnumb,43)=min(stock(max([1 i-3]):i-1,3));
              cusresurv(signalnumb,44)=max(stock(max([1 i-6]):i-1,2));
              cusresurv(signalnumb,45)=min(stock(max([1 i-6]):i-1,3));
              cusresurv(signalnumb,46)=max(stock(max([1 i-12]):i-1,2));
              cusresurv(signalnumb,47)=min(stock(max([1 i-12]):i-1,3));
              cusresurv(signalnumb,48)=(c(i-1)-c(max([1 i-4])))/3; %c3mi1
              cusresurv(signalnumb,49)=(c(i-1)-c(max([1 i-7])))/6;
              cusresurv(signalnumb,50)=(c(i-1)-c(max([1 i-13])))/12;
              cusresurv(signalnumb,51)=(c(i-1)-c(max([1 i-26])))/25;
              cusresurv(signalnumb,52)=(c(i-1)-c(max([1 i-76])))/75;
              cusresurv(signalnumb,53)=(c(i-1)-c(max([1 i-251])))/250;
              cusresurv(signalnumb,54:67)=[Xh0 Xh3 Xh6 Xh12 Xh25 Xh75 Xh250 Xl0 Xl3 Xl6 Xl12 Xl25 Xl75 Xl250];
              cusresurv(signalnumb,68:77)=[Xih6 Xih12 Xih25 Xih75 Xih250 Xil6 Xil12 Xil25 Xil75 Xil250];
              cusresurv(signalnumb,78)=stopobje;
              cusresurv(signalnumb,79)=Xi(i)-Xi(i-1);
              cusresurv(signalnumb,80)=Xi25a(i-1);
              cusresurv(signalnumb,81)=Xi75a(i-1);
              cusresurv(signalnumb,82)=Xi250a(i-1);
              cusresurv(signalnumb,83)=Xhh(max([1 i-249]));
              cusresurv(signalnumb,84)=max(stock(max([1 i-500]):i-1,2));
              cusresurv(signalnumb,85)=min(stock(max([1 i-500]):i-1,3));
              cusresurv(signalnumb,86)=Xh500;
              cusresurv(signalnumb,87)=Xl500;
              cusresurv(signalnumb,88:89)=dw(datem(i,:));
              cusresurv(signalnumb,89)=cusresurv(signalnumb,89)+0.1*dn(datem(i,:));
              cusresurv(signalnumb,90:92)=[Xr7(i-1) Xr14(i-1) Xr30(i-1)];
              cusresurv(signalnumb,93:95)=[rsi(c,i-1,7) rsi(c,i-1,14) rsi(c,i-1,30)];
              cusresurv(signalnumb,96)=Xr100(i-1);
              
              if signalnumb==hmsiaf
                cd([fpwserverplace,fpwclientdirectory,fpwusername,'\stock\']);  
                eval(['save -v4 middle',sprintf('%02d',filetosave),' cusresu cusresuna cusresupd cusresurv'])
                cd([Wherematlab,'stock']);
                signalnumb=1;
                filetosave=filetosave+1;
              else
                signalnumb=signalnumb+1;
              end
              if y==1
                lastlow3=lastlow2; lastlop3=lastlop2; 
                if lastlow3==-1000; lastlow3=i; lastlop3=entryprice; end;
                lastlow2=lastlow; lastlop2=lastlop;
                if lastlow2==-1000; lastlow2=i; lastlop2=entryprice; end;
                lastlow=i; lastlop=entryprice;
              else
                lastshw3=lastshw2; lastshp3=lastshp2; 
                if lastshw3==-1000; lastshw3=i; lastshp3=entryprice; end;
                lastshw2=lastshw; lastshp2=lastshp;
                if lastshw2==-1000; lastshw2=i; lastshp2=entryprice; end;
                lastshw=i; lastshp=entryprice;
              end
            end 
          end
        end
      end
    end
    
    if signalnumb>1
      cusresu=cusresu(1:signalnumb-1,:);
      cusresuna=cusresuna(1:signalnumb-1,:);
      cusresupd=cusresupd(1:signalnumb-1,:);
      cusresurv=cusresurv(1:signalnumb-1,:);
    else
      cusresu=[];
      cusresuna=[];
      cusresupd=[];
      cusresurv=[];
    end
    
    % recall saved data of middle??.mat    
    cd([fpwserverplace,fpwclientdirectory,fpwusername,'\stock\']);
    if filetosave>1
      C=cusresu; D=cusresupd; A=cusresuna; V=cusresurv;
      load middle01
      delete middle01.mat
      C1=cusresu; D1=cusresupd; A1=cusresuna; V1=cusresurv;
      if filetosave>2
        for i=2:filetosave-1
          eval(['load middle',sprintf('%02d',i)]);
          C1=[C1;cusresu];
          A1=[A1;cusresuna];
          D1=[D1;cusresupd];
          V1=[V1;cusresurv];
          clear cusresu cusresuna cusresupd cusresurv
          eval(['delete middle',sprintf('%02d',i),'.mat']);      
        end
      end
      cusresurv=[V1;V]; clear V V1
      cusresupd=[D1;D]; clear D D1
      cusresuna=[A1;A]; clear A A1
      cusresu=[C1;C]; clear C1 C
    end
    
    cd(fpwserverplace);
    templatefile = which('wbduringrun.html');
    smps2.fpwtime=[datestr(now-NOWhms,13),', ',time1];    
    smps2.fpwrprogram = ['MPFS: ',upper(mpptname(1:min([10 length(mpptname)])))];
    smps2.percfinished='100';
    str = htmlrep(smps2, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\twbduringrun.html'],'noheader');
    cd([Wherematlab,'stock']);
    
    if length(cusresu)>0
      if strcmp(RunTickOrDay,'D')
        eval(['load ',Wherematlab,'pattern\sdate.txt -ascii']);
        mpsdlhere=find((sdate(:,1)==mpsdl(1))&(sdate(:,2)==mpsdl(2))&(sdate(:,3)==mpsdl(3)));
        sdate=sdate(1:mpsdlhere(1),1:3);
      else
        eval(['load ',Wherematlab,'pattern\stime.txt -ascii']); %[MM DD YY hh mm]
        sdate=stime;
        mpsdlhere=find((sdate(:,1)==mpsdl(1))&(sdate(:,2)==mpsdl(2))&(sdate(:,3)==mpsdl(3))&(sdate(:,4)==mpsdl(4))&(sdate(:,5)==mpsdl(5)));
        sdate=sdate(1:mpsdlhere(1),1:5);
        %sdate=sdate(:,[4 5 2]);  % not sure yet how to use this.
      end
      sdate=sdate(length(sdate(:,1))-wphdtu+1:length(sdate(:,1)),:);

      if 1
        datemADDF=zeros((1+MoreDaysi)*hmdats,length(sdate(1,:)));
        for i=1:(1+MoreDaysi)*hmdats
          datemADDF(i,:)=sdate(length(sdate(:,1)),:);
        end      
      else
        datemADDF=wsfddate(sdate(length(sdate(:,1)),:),(1+MoreDaysi)*hmdats);
      end
    
      sdate=[sdate;datemADDF];
      %sdate=sdate(length(sdate(:,1))-wphdtu+1:length(sdate(:,1)),:);
      
      % first save previous last simulation into the simu2 before the the current one.
      % lastsimu - Simu1, lastsim2 - Simu2, lastrun1 - Dcom1, lastrun2 - Dcom2   lastrun3 - Dcom1+Dcom2
      % lastrun - the current showing one in the monitor window
      cd([fpwserverplace,fpwclientdirectory,fpwusername,'\stock\']);
      if exist('lastsimu.mat')==2
        cd([Wherematlab,'stock']);
        wbstsimu12(fpwusername);
        cd([fpwserverplace,fpwclientdirectory,fpwusername,'\stock\']);
      end
      cusresui=0*cusresu+1;
      for i=1:length(cusresui(:,1))
        if cusresupd(i,6)<hmdats
          cusresui(i,2*cusresupd(i,6)+1:2*hmdats)=0*cusresui(i,2*cusresupd(i,6)+1:2*hmdats);
        end
      end
      stopnum=Stopnum; objenum=Objenum;
      eval(['save lastsimu mpptname mpmruon mpmrvo cusresu cusresui cusresuna cusresupd cusresurv wphdtu hmdats nums ',...
          'marke stopnum objenum herestopp hereobjep herekindm RunTickOrDay sdate instruct']); 
      
      % reset the filter edit part
      mpsrsindex='1';
      
      % graphic output
      cd([Wherematlab,'stock']);
      [mpsimFig mpsimsta]=wbstsimuchart(fpwusername,91);
      set(mpsimFig,'inverthardcopy','off'); hold off
      set(mpsimFig,'PaperPosition',[.25 .25 5.92 3.15]);
      cd([fpwserverplace,fpwclientdirectory,fpwusername,'\stock']);
      drawnow;
      wsprintjpeg(mpsimFig,'Mpsimujpeg.jpeg');
      close(mpsimFig);
      
      mpefsp=wphdtu;
      mpefhl=hmdats;  
      mpefhlqs=0;
      mpefvb=0;
      mpefve=999;  
      mpefpb=0;
      mpefpe=999;
      mpefvpb=0;
      mpefvpe=999;
      mpefls='+/-';  
      mpefco='Close'; 
      mpefcoqs='Close';
      mpefef='Enter any statement here.';
        
      mpswinno=mpsimsta(1);
      mpslossno=mpsimsta(2);	
      mpsdrawno=mpsimsta(3);	
      mpswinper=mpsimsta(4);	
      mpsevdd=mpsimsta(5);	
      mpsprfr=mpsimsta(6);	
      mpsequity=mpsimsta(7);	
      mpsmaxfp=mpsimsta(8);
      mpsmaxdd=mpsimsta(9);	
      mpsavet=mpsimsta(10);	
      mpsavew=mpsimsta(11);	
      mpsavel=mpsimsta(12);  
      mpsmaxw=mpsimsta(13);		
      mpsmaxl=mpsimsta(14);
      
      cd(fpwserverplace);
      templatefile = which('MPsimulationR1.html');
      smps.StatusReport = ['New Simulation (Simu1) finished at: ',time1];
      str = htmlrep(smps, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\tMPsimulationR1.html'],'noheader');
      cd([Wherematlab,'stock']);      
      mpsimwindow=2;
    else
      cd(fpwserverplace);
      templatefile = which('MPsimulationR1.html');
      smps.StatusReport = ['No signal for this setting. ',time1];        
      str = htmlrep(smps, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\tMPsimulationR1.html'],'noheader');      
      mpsimwindow=2;   
    end  
    smps2.Runmemo='Completed.';
    templatefile = which('duringrun.html');      
    str = htmlrep(smps2, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\tduringrun.html'],'noheader');    
    VLI=0; VLImax=1000;
    eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\myVLI.mat VLI VLImax']);
  end

  if strcmp(mprunindex(1),'2')
    VPefs.mpefsp=mpefsp;
    VPefs.mpefls=mpefls;
    VPefs.mpefhl=mpefhl;
    VPefs.mpefco=mpefco;
    VPefs.mpefhlqs=mpefhlqs;
    VPefs.mpefcoqs=mpefcoqs;    
    VPefs.mpefvb=mpefvb;
    VPefs.mpefve=mpefve;
    VPefs.mpefpb=mpefpb;
    VPefs.mpefpe=mpefpe;
    VPefs.mpefvpb=mpefvpb;
    VPefs.mpefvpe=mpefvpe;
    if strcmp(mprunindex,'21')  
      smps.fpwzoneoutput=wbstsimustat(fpwusername,'V',mpspv,VPefs);  
    elseif strcmp(mprunindex,'22') 
      smps.fpwzoneoutput=wbstsimustat(fpwusername,'P',mpspp,VPefs);
    elseif strcmp(mprunindex,'23')
      smps.fpwzoneoutput=wbstsimustat(fpwusername,'VP',mpspvp,VPefs);        
    elseif strcmp(mprunindex,'24')
      smps.fpwzoneoutput=wbstsimustat(fpwusername,'A');     
      smps.wbstsimustatchart=[];
    end
    mpsimwindow=3;  
  end    
      
  if strcmp(mprunindex,'31')
    TLi=[-99999 99999];
    TLis=upper(mpefef);
    if length(TLis)>3
      if length(strfind(TLis,'TLR'))>0
        comaplace=strfind(TLis,'TLR');
        if length(comaplace)>1; disp('only one tlr can be used.'); end
        TLih=str2num(['[',TLis(comaplace(1)+3:length(TLis)),']']);
        if length(TLih)==1
          TLi(1)=TLih;
        else
          TLi=TLih;
        end
        if TLi(2)<TLi(1)
          TLi=[TLi(2) TLi(1)];
        end
      end
    end
    
    global hpdn %hpdn=[60 60 53 53]; [SPX(L) WTSPX(L) SPX(S) WTSPX(S)]
    if length(TLis)>6
      if strcmp('HPDN',TLis(1:4))==1
        eval(['hpdn=abs(fix(',TLis(5:length(TLis)),'));']);
      end
    end
    
    smps.TLoutput=wbstsimulist(fpwusername,1,0,TLi); 
    smps.wbstsimulist=[fpwclientdirectory,fpwusername,'/stock/twbstsimulist.html'];
    %smps.fpwzoneoutput=wbstsimulist(fpwusername);
    smps.fpwusername=fpwusername;
    smps.fpwusername4=fpwusername4;
    smps.fpwulvl=instruct.fpwulvl;
    smps.mpplistnet='L';
    smps.thousandnum='0';
    smps.addminus='-1';    
    mpsimwindow=311;    
    cd([fpwserverplace,fpwclientdirectory,fpwusername,'\stock']);
    templatefile = which('wbstsimulist.html');
    str = htmlrep(smps, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\twbstsimulist.html'],'noheader');
  end
  
  if (strcmp(mprunindex(1),'4'))|(strcmp(mprunindex(1),'9'))
    cd([Wherematlab,'stock']);
    global spychk spyfilter
    spychk=0; spyfilter=0;
    spychks=upper(noempty(mpefef));
    if (length(strfind(spychks,'SPYCHK'))>0)|(length(strfind(spychks,'SPYCHECK'))>0)
      spychk=1;
    end
    spyfilters=upper(noempty(mpefef));
    if (length(strfind(spyfilters,'SPYFILTER'))>0)
      spyfilter=1;
    end
    
    global VEM % trading volume based on capacity index
    VEMs=upper(noempty(mpefef));
    if length(VEMs)>3
      VEMbp=strfind(VEMs,'VEM');
      if length(VEMbp)>0   %strcmp('VEM',VEMs(1:3))==1
        VEMs=VEMs(VEMbp(1):length(VEMs));
        comaplace=strfind(VEMs,',');
        if length(comaplace)>0
          comaplacei=comaplace(1)-1;
        else
          comaplacei=length(VEMs);
        end
        VEM=abs(fix(str2num(VEMs(4:comaplacei)))); % in MM dollars, only positive integer accepted
      end
    end
    
    %global VLI VLImax
    newVLI=upper(noempty(mpefef)); %VLI always put in the end following by [percentage maxKS] 
    VLI=0; VLImax=1000;
    if length(newVLI)>3
      if length(strfind(newVLI,'VLI'))>0
        comaplace=strfind(newVLI,'VLI');
        if newVLI(comaplace(1)+3)~='['; newVLI1='['; else; newVLI1=''; end
        if newVLI(length(newVLI))~=']'; newVLI2=']'; else; newVLI2=''; end
        eval(['VLI=',newVLI1,newVLI(comaplace(1)+3:length(newVLI)),newVLI2,';']);
        if length(VLI)==2
          VLImax=VLI(2); VLI=VLI(1);
        elseif length(VLI)==1
          VLImax=1000; VLI=VLI(1);
        end
      end
    end
    eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\myVLI.mat VLI VLImax']);
    
    if (strcmp(mprunindex,'41'))|(strcmp(mprunindex,'91')) %91 - reset
      if (strcmp(mprunindex,'41'))
        [mpsimFig mpsimsta simupara mpptnamest errormsg mpptfilef]=wbstsimuchart(fpwusername,41);
        SRmsg='Simu 2, ';
      else
        [mpsimFig mpsimsta simupara mpptnamest errormsg mpptfilef]=wbstsimuchart(fpwusername,91);
        SRmsg='Simu 1, ';
      end
      mpptfilef=mpptfilef(find(mpptfilef~=10));
      %mpptfilef=mpptfilef(find(mpptfilef~=13));
      %SRmsg='Simu 1, ';
    elseif strcmp(mprunindex,'42')
      global newqzi
      %newqzi=1;
      newqzis=upper(noempty(mpefef));
      if length(newqzis)>3
        if strcmp('QZI',newqzis(1:3))==1
          comaplace=strfind(newqzis,',');
          if length(comaplace)>0
            comaplacei=comaplace(1)-1;
          else
            comaplacei=length(newqzis);
          end
          newqzi=str2num(['[',newqzis(4:comaplacei),']']);
          if newqzi(1)<=0; newqzi(1)=1; end
        end
      end
      [mpsimFig mpsimsta simupara mpptnamest errormsg]=wbstsimuchart(fpwusername,42);
      SRmsg='Dcom 1, ';      
    elseif strcmp(mprunindex,'43')
      global DCR
      DCR=1;
      DCRs=upper(noempty(mpefef));
      if length(DCRs)>3
        if strcmp('DCR',DCRs(1:3))==1
          comaplace=strfind(DCRs,',');
          if length(comaplace)>0
            comaplacei=comaplace(1)-1;
          else
            comaplacei=length(DCRs);
          end
          DCR=str2num(DCRs(4:comaplacei));
          if DCR<=0; DCR=1; end
        end
      end
      [mpsimFig mpsimsta simupara mpptnamest errormsg]=wbstsimuchart(fpwusername,43);
      SRmsg='Dcom 2+1, ';      
    elseif strcmp(mprunindex,'44')
      global newqzi
      newqzis=upper(noempty(mpefef));
      if length(newqzis)>3
        if strcmp('QZI',newqzis(1:3))==1
          comaplace=strfind(newqzis,',');
          if length(comaplace)>0
            comaplacei=comaplace(1)-1;
          else
            comaplacei=length(newqzis);
          end
          newqzi=str2num(['[',newqzis(4:comaplacei),']']);
          if newqzi(1)<=0; newqzi(1)=1; end
        end
      end
      [mpsimFig mpsimsta simupara mpptnamest errormsg]=wbstsimuchart(fpwusername,44); 
      SRmsg='Dcom 2, ';      
    end
    if strcmp(errormsg,'No')
      set(mpsimFig,'inverthardcopy','off'); hold off
      set(mpsimFig,'PaperPosition',[.25 .25 5.92 3.15]);
      cd([fpwserverplace,fpwclientdirectory,fpwusername,'\stock']);
      drawnow;
      wsprintjpeg(mpsimFig,'Mpsimujpeg.jpeg');
      close(mpsimFig);
      
      mpefsp=simupara(1);
      mpefhl=simupara(2); 
      mpefhlqs=simupara(10); 
      mpspsp=mpefsp;
      mpsphl=mpefhl;
      mpefvb=0;
      mpefve=999;  
      mpefpb=0;
      mpefpe=999;
      mpefvpb=0;
      mpefvpe=999;
      if simupara(3)==0
        mpefls='+/-';
      elseif simupara(3)==1
        mpefls='++';
      elseif simupara(3)==-1
        mpefls='- -';
      end
      if simupara(4)==1
        mpefco='Close';  
      else
        mpefco='Open'; 
      end
      if simupara(11)==1
        mpefcoqs='Close';  
      else
        mpefcoqs='Open'; 
      end      
      if ~(strcmp(mprunindex,'43'))
        if exist('newqzi')~=1
          mpefef='Enter any statement here.';
        else
          if (newqzi(1)==1)&(length(newqzi)==1)
            mpefef='Enter any statement here.';
          end
        end
      else
        if DCR==1;
          mpefef='Enter any statement here.';
        end
      end
      mpmruon=simupara(5);
      mpmrstop=simupara(6); 
      mpmrobje=simupara(7); 
      mpmrkind=simupara(8);
      mpmrvo=simupara(9);
      mpptname=noempty(mpptnamest(1,:));
      mpptmrk=noempty(mpptnamest(2,:));
      RunTickOrDay=upper(noempty(mpptnamest(3,:)));
      if RunTickOrDay=='D'
        mpptdt='Daily';
      else
        mpptdt='Tick';        
      end
      
      mpswinno=mpsimsta(1);
      mpslossno=mpsimsta(2);	
      mpsdrawno=mpsimsta(3);	
      mpswinper=mpsimsta(4);	
      mpsevdd=mpsimsta(5);	
      mpsprfr=mpsimsta(6);	
      mpsequity=mpsimsta(7);	
      mpsmaxfp=mpsimsta(8);
      mpsmaxdd=mpsimsta(9);	
      mpsavet=mpsimsta(10);	
      mpsavew=mpsimsta(11);	
      mpsavel=mpsimsta(12);  
      mpsmaxw=mpsimsta(13);		
      mpsmaxl=mpsimsta(14);
      mpsimwindow=2;
      
      cd(fpwserverplace);
      templatefile = which('MPsimulationR1.html');
      smps.StatusReport = ['Front Simulation is: ',SRmsg,time1];
      str = htmlrep(smps, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\tMPsimulationR1.html'],'noheader');
      cd([Wherematlab,'stock']);
            
    else
      cd(fpwserverplace);
      templatefile = which('MPsimulationR1.html');
      smps.StatusReport = [errormsg,' ',time1];
      str = htmlrep(smps, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\tMPsimulationR1.html'],'noheader');      
      mpsimwindow=2; 
    end
  end
  
  if strcmp(mprunindex(1),'5')
      MpefhL=mpefhl;  MpefcO=mpefco; MpptnamE=mpptname;
    if strcmp(mprunindex,'51')
      cd([fpwserverplace,fpwclientdirectory,fpwusername,'\stock\']);
      if (exist('lastsimu.mat')==2)&(exist('lastsim2.mat')==2)
        INSTRUCT= instruct;
        load lastsim2
        cd([Wherematlab,'stock']);
        wbstsimu12(fpwusername);
        cd([fpwserverplace,fpwclientdirectory,fpwusername,'\stock\']);
        if exist('cusresui')~=1
          cusresui=0*cusresu+1;
        end      
        eval(['save lastsimu mpptname mpmruon mpmrvo cusresu cusresui cusresuna cusresupd cusresurv wphdtu hmdats nums ',...
            'marke stopnum objenum herestopp hereobjep herekindm RunTickOrDay sdate instruct']) 
        smps.StatusReport = ['Simu1 <-> Simu2 data exchanged successfully. ',time1];
        clear instruct
        instruct=INSTRUCT;
        clear INSTRUCT
      else
        smps.StatusReport = ['Simu1/Simu2 at least one not existed. ',time1];        
      end
      mpsimwindow=1;
    end
    if strcmp(mprunindex,'52')
      cd([fpwserverplace,fpwclientdirectory,fpwusername,'\stock\']);
      if (exist('lastrun1.mat')==2)&(exist('lastrun2.mat')==2)
        load lastrun2
        if ~(exist('mpefhlqs')==1)
          mpefhlqs=0;
          mpefcoqs='Close';
        end
        cd([Wherematlab,'stock']);
        wbstsimud12(fpwusername);
        cd([fpwserverplace,fpwclientdirectory,fpwusername,'\stock\']);
        if exist('cusresui')~=1
          cusresui=0*cusresu+1;
        end   
        if ~(exist('qzi')==1)
          qzi=ones(length(cusresu(:,1)),1);
        end
        eval(['save -v4 lastrun1 mpptname mpmruon mpmrvo cusresu cusresui cusresuna cusresupd cusresurv wphdtu hmdats nums ',...
              'marke stopnum objenum herestopp hereobjep herekindm RunTickOrDay sdate mpefls mpefco mpefcoqs mpefhlqs qzi'])       
        smps.StatusReport = ['Dcom1 <-> Dcom2 data exchanged successfully. ',time1];
      else
        smps.StatusReport = ['Dcom1/Dcom2 at least one not existed. ',time1];           
      end
      mpsimwindow=1;    
    end
    if strcmp(mprunindex,'53')
      cd([fpwserverplace,fpwclientdirectory,fpwusername,'\stock\']); 
      if (exist('lastrun3.mat')==2)
        load lastrun3
        if ~(exist('mpefhlqs')==1)
          mpefhlqs=0;
          mpefcoqs='Close';
        end        
        if exist('cusresui')~=1
          cusresui=0*cusresu+1;
        end           
        if ~(exist('qzi')==1)
          qzi=ones(length(cusresu(:,1)),1);
        end
        eval(['save -v4 lastrun2 mpptname mpmruon mpmrvo cusresu cusresui cusresuna cusresupd cusresurv wphdtu hmdats nums ',...
              'marke stopnum objenum herestopp hereobjep herekindm RunTickOrDay sdate mpefls mpefco mpefcoqs mpefhlqs qzi']) 
        smps.StatusReport = ['Dcom2+1 -> Dcom2 data transfered successfully. ',time1];
      else
        smps.StatusReport = ['Dcom2+1 not existed yet. ',time1];         
      end
      mpsimwindow=1;     
    end  
    mpefhl=MpefhL;  mpefco=MpefcO; mpptname=MpptnamE;
    clear MpefhL MpefcO MpptnamE
  end
    
  if strcmp(mprunindex,'61')
    if(~length(mpptname))
      mpptname = 'input'; % default name
      eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\mpsim',mpptname,' instruct']);
    else
      mpptnamehere=mpptname;
      INSTRUCT= instruct;
      eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\lastsimu.mat']);
      mpptname=mpptnamehere; clear mpptnamehere;
      if exist('cusresui')~=1
        cusresui=0*cusresu+1;
      end        
      eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\usermpsim\mpsim',mpptname,' instruct ',...
              'mpptname mpmruon mpmrvo cusresu cusresui cusresuna cusresupd cusresurv wphdtu hmdats nums ',...
          'marke stopnum objenum herestopp hereobjep herekindm RunTickOrDay sdate']);      
      clear instruct
      instruct=INSTRUCT;
      clear INSTRUCT
    end
    smps.StatusReport = ['Data saved to file MPSIM',upper(mpptname),'.MAT. ',time1];
    mpsimwindow=1;
  end
  
  if (strcmp(mprunindex,'62'))|(strcmp(mprunindex,'63'))
    FPWMPfiletoopen = [fpwserverplace,fpwclientdirectory,fpwusername,'\stock\usermpsim\mpsim*.mat'];
    a=dir(FPWMPfiletoopen);
    outputtext={};
    filesinaline=4;
    if length(a)>0
      for i=1:length(a)
        outputtext{fix((i-1)/filesinaline)+1,rem(i-1,filesinaline)+1}=a(i).name(6:length(a(i).name)-4);
      end
      if ((rem(i-1,filesinaline)+1)~=filesinaline)&(fix((i-1)/filesinaline)>0)
        for j=rem(i-1,filesinaline)+2:filesinaline
          outputtext{fix((i-1)/filesinaline)+1,j}='';
        end
      end
    else
      outputtext{1}='No available file.';
    end    
    outstruct.MPfiletoshow=outputtext;
    outstruct.FDfpwusername=fpwusername;
    outstruct.FDfpwusername4=fpwusername4;
    cd(fpwserverplace);
    templatefile = which('MPopenfile1R.html');
    str = htmlrep(outstruct, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\tMPopenfile1R.html'],'noheader');
    outstruct.MPloadreport=[fpwclientdirectory,fpwusername,'\pattern\tMPopenfile1R.html'];        
    if (strcmp(mprunindex,'62'))
      outstruct.FDfiletypeid=['mpsimL'];
      mpsimwindow=5;
    elseif (strcmp(mprunindex,'63'))
      outstruct.FDfiletypeid=['mpsimD'];
      mpsimwindow=6;          
    end      
  end
  
  if strcmp(mprunindex,'71')
    qzistrtestOriginal=mpefef;
    qzistrtest=upper(noempty(mpefef));
    if length(qzistrtest)>=3
      if (strcmp(qzistrtest(1:3),'QZI')==1)|(strcmp(qzistrtest(1:3),'DCR')==1)|...
        (strcmp(qzistrtest(1:3),'TLR')==1)|(strcmp(qzistrtest(1:3),'NDN')==1)|...
        (strcmp(qzistrtest(1:3),'SPY')==1)
        mpefef='Enter any statement here.';
      end
    end
    stcommand=mpefef; % variables: i enw enp endi o h l c v c0 c1 v0 v1 r-c-v-(3 6 12) c(25 75 200)
    resethere=0; norunhere=0;
  
    global nud12
    nud12=0;
    nud12s=upper(noempty(mpefef));
    if (length(nud12s)>=3)
      if (strcmp(nud12s(1:3),'NDU')==1)
        nud12=1;
        nud12sii=strfind(upper(mpefef),'NDU');
        if length(mpefef)>=nud12sii+3
          mpefef=mpefef(nud12sii+3:length(mpefef));
        else
          mpefef=[];
        end
        stcommand=mpefef;
      end
    end
    
    if length(noempty(mpefef))==0
      norunhere=1; mpefef='Enter any statement here.'; stcommand=mpefef;
    end
    
    if (strcmp('NO',upper(noempty(mpefef)))==1)
      norunhere=1;  mpefef='Enter any statement here.'; stcommand=mpefef;
    end
    
    if (strcmp(mpefef,'Enter any statement here.'))
      norunhere=1; 
    end
        
    if (norunhere==0)&(length(stcommand)>0)
      if (strcmp('0',stcommand(1))) % do nothing or reset
        norunhere=1; 
      end
      
      if (length(stcommand)>1)&(strcmp('NO',upper(stcommand(1:2))))&(length(mpefef)==2)
        norunhere=1;  mpefef='Enter any statement here.'; stcommand=mpefef;
      end
    end
    
    if (length(noempty(stcommand))<=1)  
      norunhere=1;
    end
    
    cd([fpwserverplace,fpwclientdirectory,fpwusername,'\stock\']);
    mpefls8=mpefls;
    mpefco8=mpefco;
    mpefhlqs8=mpefhlqs;
    mpefcoqs8=mpefcoqs;    
    
    load lastrun
    
    if exist('VLI')~=1
      VLI=0; VLImax=1000;
    end
    eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\myVLI.mat VLI VLImax']);
    
    if exist('cusresui')~=1
      cusresui=0*cusresu+1;
    end  
    if ~(exist('qzi')==1)
      qzi=ones(length(cusresu(:,1)),1);
    end
    if length(qzi)~=length(cusresu(:,1))
      save c:\matlab\stock\wbstsimuqzierror.mat
      qzi=ones(length(cusresu(:,1)),1);
      disp(' Someting wrong with weighted index, check it out');
    end
    if length(cusresupd(1,:))==6
      cusresupd(:,7)=cusresupd(:,2);    
    end
        
    endfakeplace=0;
    while sum(abs(sdate(length(sdate(:,1)),:)-sdate(length(sdate(:,1))-endfakeplace-1,:)))==0
      endfakeplace=endfakeplace+1;  
    end    
    
    % run other number filters first
    cd([Wherematlab,'stock']);
    wphdtu=min([mpefsp wphdtu mpspsp]); mpefsp=min([mpefsp wphdtu]);
    wphdtu=wphdtu+endfakeplace;
    mpefsp=mpefsp+endfakeplace;
    mpefhl=min([mpefhl length(cusresu(1,:))/2 hmdats]);
    mpefls=mpefls8;
    mpefco=mpefco8;
    mpefhlqs=mpefhlqs8;
    mpefcoqs=mpefcoqs8;    
    clear mpefco8 mpefls8 mpefcoqs8 mpefhlqs8
    sdate=sdate(length(sdate(:,1))-wphdtu+1:length(sdate(:,1)),:);
          
    if (length(cusresu)>0)
      if strcmp(mpefls,'- -')
        placeweneedh=find(cusresupd(:,1)<0);
        cusresu=cusresu(placeweneedh,:);
        cusresui=cusresui(placeweneedh,:);
        cusresuna=cusresuna(placeweneedh,:);
        cusresurv=cusresurv(placeweneedh,:);
        cusresupd=cusresupd(placeweneedh,:);
        qzi=qzi(placeweneedh);
      elseif strcmp(mpefls,'++')
        placeweneedh=find(cusresupd(:,1)>0);  
        cusresu=cusresu(placeweneedh,:);
        cusresui=cusresui(placeweneedh,:);
        cusresuna=cusresuna(placeweneedh,:);
        cusresurv=cusresurv(placeweneedh,:);
        cusresupd=cusresupd(placeweneedh,:);
        qzi=qzi(placeweneedh);
      end
    end
         
    if (length(cusresu)>0)
      placeweneedh=find(abs(cusresupd(:,1))<=mpefsp);
      cusresu=cusresu(placeweneedh,:);
      cusresui=cusresui(placeweneedh,:);
      cusresuna=cusresuna(placeweneedh,:);
      cusresurv=cusresurv(placeweneedh,:);
      cusresupd=cusresupd(placeweneedh,:);
      qzi=qzi(placeweneedh);
    end
           
    if (mpefvb~=0)&(length(cusresu)>0)
      placeweneedh=find(cusresupd(:,3)>=mpefvb);
      cusresu=cusresu(placeweneedh,:);
      cusresui=cusresui(placeweneedh,:);
      cusresuna=cusresuna(placeweneedh,:);
      cusresurv=cusresurv(placeweneedh,:);
      cusresupd=cusresupd(placeweneedh,:);
      qzi=qzi(placeweneedh);
    end
             
    if (mpefve~=999)&(length(cusresu)>0)
      placeweneedh=find(cusresupd(:,3)<=mpefve);
      cusresu=cusresu(placeweneedh,:);
      cusresui=cusresui(placeweneedh,:);
      cusresuna=cusresuna(placeweneedh,:);
      cusresurv=cusresurv(placeweneedh,:);
      cusresupd=cusresupd(placeweneedh,:);
      qzi=qzi(placeweneedh);
    end
               
    if (mpefpb~=0)&(length(cusresu)>0)
      placeweneedh=find(cusresupd(:,2)>=mpefpb);
      cusresu=cusresu(placeweneedh,:);
      cusresui=cusresui(placeweneedh,:);
      cusresuna=cusresuna(placeweneedh,:);
      cusresurv=cusresurv(placeweneedh,:);
      cusresupd=cusresupd(placeweneedh,:);
      qzi=qzi(placeweneedh);
    end
                
    if (mpefpe~=999)&(length(cusresu)>0)
      placeweneedh=find(cusresupd(:,2)<=mpefpe);
      cusresu=cusresu(placeweneedh,:);
      cusresui=cusresui(placeweneedh,:);
      cusresuna=cusresuna(placeweneedh,:);
      cusresurv=cusresurv(placeweneedh,:);
      cusresupd=cusresupd(placeweneedh,:);
      qzi=qzi(placeweneedh);
    end
            
    if (mpefvpb~=0)&(length(cusresu)>0)
      placeweneedh=find((cusresupd(:,2).*cusresupd(:,3))>=mpefvpb);
      cusresu=cusresu(placeweneedh,:);
      cusresui=cusresui(placeweneedh,:);
      cusresuna=cusresuna(placeweneedh,:);
      cusresurv=cusresurv(placeweneedh,:);
      cusresupd=cusresupd(placeweneedh,:);
      qzi=qzi(placeweneedh);
    end
                
    if (mpefvpe~=999)&(length(cusresu)>0)
      placeweneedh=find((cusresupd(:,2).*cusresupd(:,3))<=mpefvpe);      
      cusresu=cusresu(placeweneedh,:);
      cusresui=cusresui(placeweneedh,:);
      cusresuna=cusresuna(placeweneedh,:);
      cusresurv=cusresurv(placeweneedh,:);
      cusresupd=cusresupd(placeweneedh,:);
      qzi=qzi(placeweneedh);
    end
        
    if (length(cusresu)>0)
      hmdats=min([mpefhl hmdats length(cusresu(1,:))/2]); mpefhl=hmdats;   
      cusresu=cusresu(:,1:(2*hmdats));
      if strcmp(mpefco,'Open')
        cusresu(:,length(cusresu(1,:)))=cusresu(:,length(cusresu(1,:))-1);
      end
      startplace=2*min([mpefhlqs hmdats])+1;
      if mpefhlqs>0
        if strcmp(mpefcoqs,'Open')
          startplace=max([1 startplace-1]);  
        end
      end
      if startplace>1           
        for slk=1:length(cusresu(:,1))
          if cusresupd(slk,1)>0
            cusresupd(slk,7)=cusresupd(slk,7)+cusresu(slk,startplace-1);
          else
            cusresupd(slk,7)=cusresupd(slk,7)-cusresu(slk,startplace-1);
          end            
          cusresu(slk,:)=cusresu(slk,:)-cusresu(slk,startplace-1);
          cusresu(slk,1:startplace-1)=0*cusresu(slk,1:startplace-1);
        end
      end
      cusresui=cusresui(:,1:length(cusresu(1,:)));
      if startplace>1
        cusresui(:,1:startplace-1)=0*cusresui(:,1:startplace-1);
      end        
    end
            
    % Run Any cell condition
    if (norunhere==0)&(length(cusresu)>0)     
      cda=cusresupd;
      crv=cusresurv;
      editpass=0*cusresupd(:,1);
      cuslenf=length(cusresupd(:,1));
      custname='$$$$$$';
      
      % stat about signals, next line only, originally used to make a notradelist for wbstsimulist.m to use.
      [HN,WR,TN]=wbhnwrtn(cusresuna,cusresu(:,length(cusresu(1,:))),cusresupd,qzi);
      
      mpsdl=sdate(length(sdate(:,1)),:);
      SDATEHH=sdate;
      if lower(RunTickOrDay)=='d'
        load c:\matlab\pattern\sdate.txt -ascii
        stockmpsdl=sdate; clear sdate;
      else
        load c:\matlab\pattern\stime.txt -ascii
        stockmpsdl=stime; clear stime;          
      end
      
      %stockmpsdl=stgetdaa('spx',lower(RunTickOrDay)); 
      %mpsdl=sdate(length(sdate(:,1)),:);
      sdate=SDATEHH; clear SDATEHH
      %endfakeplace=0;
      %while sum(abs(sdate(length(sdate(:,1)),:)-sdate(length(sdate(:,1))-endfakeplace-1,:)))==0
      %  endfakeplace=endfakeplace+1;  
      %end
      
      if lower(RunTickOrDay)=='d'
        mpsdlhere=find((stockmpsdl(:,1)==mpsdl(1))&(stockmpsdl(:,2)==mpsdl(2))&(stockmpsdl(:,3)==mpsdl(3)));
      else
        mpsdlhere=find((stockmpsdl(:,1)==mpsdl(1))&(stockmpsdl(:,2)==mpsdl(2))&(stockmpsdl(:,3)==mpsdl(3))&(stockmpsdl(:,4)==mpsdl(4))&(stockmpsdl(:,5)==mpsdl(5)));
      end
      if length(mpsdlhere)>0
        mpsdladd=length(stockmpsdl(:,1))-mpsdlhere;
      else
        mpsdladd=0;
      end
      
      NOWhms=now;
      for j=1:cuslenf
          
        if strcmp('NO',upper(stcommand(1:2)))==0
          if rem(j-1,min([400 max([200 round(0.1*cuslenf)])]))==0
            cd(fpwserverplace);
            templatefile = which('wbduringrun.html');
            smps2.fpwtime=[datestr(now-NOWhms,13),', ',time1];       
            smps2.fpwusername=fpwusername;
            smps2.fpwrprogram = ['FSEC: ',upper(mpptname(1:min([10 length(mpptname)])))];
            smps2.percfinished=num2str(round(1000*j/cuslenf)/10);
            str = htmlrep(smps2, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\twbduringrun.html'],'noheader');
            cd([Wherematlab,'stock']);
          end
          if rem(j-1,max([400 round(0.18*cuslenf)]))==0
            cd(fpwserverplace);
            cidsmamamiya=fpwloginstatus(fpwusername,clock);
            smps2.Runmemo='Running ......';
            templatefile = which('duringrun.html');      
            str = htmlrep(smps2, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\tduringrun.html'],'noheader');                     
            cd([Wherematlab,'stock']);  
            % wbststopritm.mat file is issued by fpwwbststopritm.m in c:\matlab\stock.
            if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbststopritm.mat'])~=2
              wbststopritm=0;
              eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbststopritm.mat wbststopritm']);
            end
            eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbststopritm.mat']);        
            if wbststopritm==1
              wbststopritm=0;
              eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbststopritm.mat wbststopritm']);
              cd(fpwserverplace);
              cidsmamamiya=fpwloginstatus(fpwusername,clock);
              smps2.Runmemo='IRQ Stopped.';
              templatefile = which('duringrun.html');
              str = htmlrep(smps2, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\tduringrun.html'],'noheader');           
              cd([Wherematlab,'stock']);
              error(['  Stop-running has been requested. ',num2str(j),'-',num2str(cuslenf),'.']);
            end
          end
        end
          
        % variables available in any case
        hn=HN(j); wr=WR(j); tn=TN(j);
        enw=length(sdate(:,1))-abs(cda(j,1))+1; endi=sign(cda(j,1)); enp=cda(j,7);
        c0=cda(j,2);c1=cda(j,4);
        v0=cda(j,3);v1=cda(j,5);
        r3=crv(j,1);r6=crv(j,2);r12=crv(j,3);
        c3=crv(j,7);c6=crv(j,8);c12=crv(j,9);
        v3=crv(j,4);v6=crv(j,5);v12=crv(j,6);
        c25=crv(j,10);c75=crv(j,11);c250=crv(j,12);
        if length(crv(j,:))>12
          v25=crv(j,13);v75=crv(j,14);v250=crv(j,15);
        end
        if length(crv(j,:))>15
          Xi=crv(j,16); Xi6=crv(j,17); Xi12=crv(j,18);
          Xi25=crv(j,19); Xi75=crv(j,20); Xi250=crv(j,21);
        end
        if length(crv(j,:))>21
          Xi25m=crv(j,22); Xi75m=crv(j,23); Xi250m=crv(j,24);
        end
        if length(crv(j,:))>24
          Xs=crv(j,25);
        end
        if length(crv(j,:))>25
          h250=crv(j,26); l250=crv(j,27);
          h25=crv(j,28); l25=crv(j,29);
          h0=crv(j,30); l0=crv(j,31); sct=crv(j,32);
        end
        if length(crv(j,:))>32
          noe=crv(j,33); ccode=crv(j,34); cap=crv(j,35);
        end
        if length(crv(j,:))>35
          lastbs=crv(j,36);
        end
        if length(crv(j,:))>36
          c2=crv(j,37); v2=crv(j,38);
        end
        if length(crv(j,:))>38
          mpind=crv(j,39);
        end
        if length(crv(j,:))>39
          h75=crv(j,40); l75=crv(j,41);
          h3=crv(j,42); l3=crv(j,43);
          h6=crv(j,44); l6=crv(j,45);
          h12=crv(j,46); l12=crv(j,47);
        end
        if length(crv(j,:))>47
          c3m=crv(j,48); c6m=crv(j,49); c12m=crv(j,50);
          c25m=crv(j,51); c75m=crv(j,52); c250m=crv(j,53);
        end
        if length(crv(j,:))>53
          Xh0=crv(j,54); Xh3=crv(j,55); Xh6=crv(j,56); Xh12=crv(j,57);
          Xh25=crv(j,58); Xh75=crv(j,59); Xh250=crv(j,60);
          Xl0=crv(j,61); Xl3=crv(j,62); Xl6=crv(j,63); Xl12=crv(j,64);
          Xl25=crv(j,65); Xl75=crv(j,66); Xl250=crv(j,67);
        end
        if length(crv(j,:))>67
          Xih6=crv(j,68); Xih12=crv(j,69);
          Xih25=crv(j,70); Xih75=crv(j,71); Xih250=crv(j,72);
          Xil6=crv(j,73); Xil12=crv(j,74);
          Xil25=crv(j,75); Xil75=crv(j,76); Xil250=crv(j,77);    
        end
        if length(crv(j,:))>77; stobi=crv(j,78); end
        if length(crv(j,:))>78; Xi1m=crv(j,79); end
        if length(crv(j,:))>79; 
          Xi25a=crv(j,80); Xi75a=crv(j,81); Xi250a=crv(j,82);
        end
        if length(crv(j,:))>82;
          Xhh=crv(j,83);
        end
        if length(crv(j,:))>83;
          h500=crv(j,84); l500=crv(j,85);
        end
        if length(crv(j,:))>85;
          Xh500=crv(j,86); Xl500=crv(j,87);
        end
        if length(crv(j,:))>87;
          dayn=crv(j,88); weekn=crv(j,89);
        end
        if length(crv(j,:))>89;
          Xr7=crv(j,90); Xr14=crv(j,91); Xr30=crv(j,92); Xr100=crv(j,96);
          rsi7=crv(j,93); rsi14=crv(j,94); rsi30=crv(j,95);
        end        
        mynh=lower(markfilt(cusresuna(j,:)));
        mydh=sdate(enw,:);
        
        % to find exit price
        % dire*([o(i+1) c(i+1) o(i+2) c(i+2) .... o(i+hmdats) c(i+hmdats)]-c(i))
        if strcmp(noempty(upper(mpefco)),'OPEN')
          exp=endi*cusresu(j,2*hmdats-1)+c0;
        else
          exp=endi*cusresu(j,2*hmdats)+c0;
        end
        
        % to find entry price
        if mpefhlqs>0
          if strcmp(noempty(upper(mpefcoqs)),'OPEN')
            enp=endi*cusresu(j,2*mpefhlqs-1)+c0;
          else
            enp=endi*cusresu(j,2*mpefhlqs)+c0;
          end
        end
        
        if strcmp('NO',upper(stcommand(1:2)))==0
          cusnused=lower(markfilt(cusresuna(j,:)));
          if strcmp(custname,cusnused)==0
            custname=cusnused;
            %cusnused=lower(markfilt(cusnused));
            stock=stgetdaa(cusnused,lower(RunTickOrDay),max([15 fix(1.2*(abs(cusresupd(j,1))))])+mpsdladd); %wphdtu
            %if lower(RunTickOrDay)=='d'
            %  mpsdlhere=find((stock(:,1)==mpsdl(1))&(stock(:,2)==mpsdl(2))&(stock(:,3)==mpsdl(3)));
            %else
            %  mpsdlhere=find((stock(:,1)==mpsdl(1))&(stock(:,2)==mpsdl(2))&(stock(:,3)==mpsdl(3))&(stock(:,4)==mpsdl(4))&(stock(:,5)==mpsdl(5)));
            %end    
            if length(stock(:,1))>mpsdladd
              stock=stock(1:length(stock(:,1))-mpsdladd,:);            
            else
              stock=[];  
            end
            
            if length(stock)>0
              if lower(RunTickOrDay)=='d'
                stock=stock(:,4:8);
              else
                stock=stock(:,6:10);
              end
              % add data to the end
              stockADDF=[zeros(endfakeplace,4)+stock(length(stock(:,1)),4) zeros(endfakeplace,1)];
              stock=[stock;stockADDF];
              clear stockADDF                
              o=stock(:,1); h=stock(:,2); l=stock(:,3);
              c=stock(:,4); v=stock(:,5);
            else
              o=[];
            end
          end
          if length(o)>0
            i=length(o)-abs(cusresupd(j,1))+1;
            if i>15
              eval(['editpass(j)=(',stcommand,');']);
            end
          end
        else
          if length(stcommand)>2
            eval(['editpass(j)=(',stcommand(3:length(stcommand)),');']);
          end 
        end      
      end        
      if (nud12==1); mpefef=['NDU',mpefef]; mpefef=qzistrtestOriginal; end
      passedst=find(editpass>0);
      if length(passedst)>0 
        cusresu=cusresu(passedst,:);
        cusresui=cusresui(passedst,:);
        cusresuna=cusresuna(passedst,:);
        cusresupd=cusresupd(passedst,:);
        cusresurv=cusresurv(passedst,:);
        qzi=qzi(passedst);
        % update Dcom1 -> Dcom2 then save current as Dcom1
        cd([fpwserverplace,fpwclientdirectory,fpwusername,'\stock\']); 
        if (nud12==0)&(exist('lastrun1.mat')==2)        
          cd([Wherematlab,'stock']);
          wbstsimud12(fpwusername);
          cd([fpwserverplace,fpwclientdirectory,fpwusername,'\stock\']);
        end
        mpefsp=mpefsp-endfakeplace;
        wphdtu=wphdtu-endfakeplace;
        if (nud12==0)
          eval(['save -v4 lastrun1 mpptname mpmruon mpmrvo cusresu cusresui cusresuna cusresupd cusresurv wphdtu hmdats nums ',...
              'marke stopnum objenum herestopp hereobjep herekindm RunTickOrDay sdate mpefls mpefco mpefcoqs mpefhlqs qzi'])         
        else
          eval(['save -v4 lastrun mpptname mpmruon mpmrvo cusresu cusresui cusresuna cusresupd cusresurv wphdtu hmdats nums ',...
              'marke stopnum objenum herestopp hereobjep herekindm RunTickOrDay sdate mpefls mpefco mpefcoqs mpefhlqs qzi'])
        end
      else
        cusresu=[];   
      end
      if 0 %strcmp('NO',upper(stcommand(1:2)))==0
        cd(fpwserverplace);
        templatefile = which('wbduringrun.html');
        smps2.fpwtime=[datestr(now-NOWhms,13),', ',time1];
        smps2.fpwrprogram = ['FSEC: ',upper(mpptname(1:min([10 length(mpptname)])))];
        smps2.percfinished='100';
        str = htmlrep(smps2, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\twbduringrun.html'],'noheader');
        cd([Wherematlab,'stock']);    
    
        smps2.Runmemo='Completed.';
        templatefile = which('duringrun.html');      
        str = htmlrep(smps2, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\tduringrun.html'],'noheader');
      end
    elseif (length(cusresu)>0) 
      if (nud12==1); mpefef=['NDU',mpefef]; mpefef=qzistrtestOriginal; end
      hmdats=min([mpefhl hmdats length(cusresu(1,:))/2]); mpefhl=hmdats;        
      cd([fpwserverplace,fpwclientdirectory,fpwusername,'\stock\']); 
      if (nud12==0)&(exist('lastrun1.mat')==2)       
        cd([Wherematlab,'stock']);
        wbstsimud12(fpwusername); %save lastrun1 to lastrun2
        cd([fpwserverplace,fpwclientdirectory,fpwusername,'\stock\']);
      end
      mpefsp=mpefsp-endfakeplace;
      wphdtu=wphdtu-endfakeplace;
      if (nud12==0)
        eval(['save -v4 lastrun1 mpptname mpmruon mpmrvo cusresu cusresui cusresuna cusresupd cusresurv wphdtu hmdats nums ',...
            'marke stopnum objenum herestopp hereobjep herekindm RunTickOrDay sdate mpefls mpefco mpefcoqs mpefhlqs qzi'])      
      else
        eval(['save -v4 lastrun mpptname mpmruon cusresu cusresui mpmrvo cusresuna cusresupd cusresurv wphdtu hmdats nums ',...
            'marke stopnum objenum herestopp hereobjep herekindm RunTickOrDay sdate mpefls mpefco mpefcoqs mpefhlqs qzi'])
      end
    end
            
    if (length(cusresu)>0)
      cd([Wherematlab,'stock']);
      %save myvemtem1
      [mpsimFig mpsimsta]=wbstsimuchart(fpwusername,42);       
      set(mpsimFig,'inverthardcopy','off'); hold off
      set(mpsimFig,'PaperPosition',[.25 .25 5.92 3.15]);
      cd([fpwserverplace,fpwclientdirectory,fpwusername,'\stock']);
      drawnow;
      wsprintjpeg(mpsimFig,'Mpsimujpeg.jpeg');
      close(mpsimFig);
              
      mpswinno=mpsimsta(1);
      mpslossno=mpsimsta(2);	
      mpsdrawno=mpsimsta(3);	
      mpswinper=mpsimsta(4);	
      mpsevdd=mpsimsta(5);	
      mpsprfr=mpsimsta(6);	
      mpsequity=mpsimsta(7);	
      mpsmaxfp=mpsimsta(8);
      mpsmaxdd=mpsimsta(9);	
      mpsavet=mpsimsta(10);	
      mpsavew=mpsimsta(11);	
      mpsavel=mpsimsta(12);  
      mpsmaxw=mpsimsta(13);		
      mpsmaxl=mpsimsta(14);
      cd(fpwserverplace);
      templatefile = which('MPsimulationR1.html');
      if (nud12==0)
        smps.StatusReport = ['Front simulation is Dcom 1 at. ',time1];        
      else
        smps.StatusReport = ['Front simulation is Dcom 0 at. ',time1];
      end
      str = htmlrep(smps, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\tMPsimulationR1.html'],'noheader');       
      mpsimwindow=2; 
    else
      cd(fpwserverplace);
      templatefile = which('MPsimulationR1.html');
      smps.StatusReport = ['No signal satisfying the filter conditions. ',time1];        
      str = htmlrep(smps, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\tMPsimulationR1.html'],'noheader');      
      mpsimwindow=2;       
    end
    
    if strcmp('NO',upper(stcommand(1:2)))==0
      cd(fpwserverplace);
      templatefile = which('wbduringrun.html');
      smps2.fpwtime=[datestr(now-NOWhms,13),', ',time1];
      smps2.fpwrprogram = ['FSEC: ',upper(mpptname(1:min([10 length(mpptname)])))];
      smps2.percfinished='100';
      str = htmlrep(smps2, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\twbduringrun.html'],'noheader');
      cd([Wherematlab,'stock']);    
  
      smps2.Runmemo='Completed.';
      templatefile = which('duringrun.html');      
      str = htmlrep(smps2, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\tduringrun.html'],'noheader');
    end    
  end 

  if strcmp(mprunindex,'77')
    % only aimed to work for original simulation
    cd([fpwserverplace,fpwclientdirectory,fpwusername,'\stock\']);
    INSTRUCT= instruct;
    load lastsimu mpptname cusresu cusresuna cusresupd cusresurv wphdtu hmdats nums marke RunTickOrDay sdate instruct
    mpptfilef=instruct.mpptfilef;
    mpptfilef=mpptfilef(find(mpptfilef~=10));
    mpspsp=str2num(instruct.mpspsp); 
    mpsphl=max([1 min([mpmaxlength str2num(instruct.mpsphl)])]); % with maximum allowed as 99 bars
    mpspv=str2num(instruct.mpspv);
    mpspp=str2num(instruct.mpspp);
    mpspvp=str2num(instruct.mpspvp);    
    clear instruct;
    instruct=INSTRUCT;
    mpsphl=max([1 min([mpmaxlength str2num(instruct.mpsphl)])]);
    hmdatsori=hmdats;
    hmdats=mpsphl;
    if hmdatsori~=hmdats
      cusresupd(:,1)=sign(cusresupd(:,1)).*(abs(cusresupd(:,1))-(hmdatsori-hmdats));
      cusresupd(:,6)=0*cusresupd(:,6)+hmdats;
      cusresu=zeros(length(cusresupd(:,1)),2*hmdats);
    end
    clear INSTRUCT    
    instruct.mpptfilef=mpptfilef;
        
    instruct.mpspsp=num2str(mpspsp);
    instruct.mpsphl=num2str(mpsphl);
    instruct.mpspv=['[',num2str(mpspv(1)),', ',num2str(mpspv(2)),']'];
    instruct.mpspp=['[',num2str(mpspp(1)),', ',num2str(mpspp(2)),']'];
    instruct.mpspvp=['[',num2str(mpspvp(1)),', ',num2str(mpspvp(2)),']'];
    instruct.mpmruon=num2str(mpmruon);  
    instruct.mpmrkind=num2str(mpmrkind); 
    instruct.mpmrvo=num2str(mpmrvo);
    instruct.mpmrstop=num2str(mpmrstop);  
    instruct.mpmrobje=num2str(mpmrobje);   
    instruct.mpptname=mpptname;    
    
    cd([Wherematlab,'stock']);
    cusresupd(:,7)=cusresupd(:,2);
    cusresui=0*cusresu+1;
    mpmruon=1; % in case forget turning the switch on.    
    cuslenf=length(cusresupd(:,1));
    custname='$$$$$$';
    mpsdl=sdate(length(sdate(:,1)),:);
    global Stopnum Objenum
    Stopnum=0; Objenum=0;
               
    NOWhms=now;
    for j=1:cuslenf
      if rem(j-1,min([400 max([200 round(0.1*cuslenf)])]))==0
        cd(fpwserverplace);
        templatefile = which('wbduringrun.html');
        smps2.fpwtime=[datestr(now-NOWhms,13),', ',time1];    
        smps2.fpwusername=fpwusername;
        smps2.fpwrprogram = ['FSEC: ',upper(mpptname(1:min([10 length(mpptname)])))];
        smps2.percfinished=num2str(round(1000*j/cuslenf)/10);
        str = htmlrep(smps2, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\twbduringrun.html'],'noheader');
        cd([Wherematlab,'stock']);
      end
      if rem(j-1,max([400 round(0.18*cuslenf)]))==0
        cd(fpwserverplace);
        cidsmamamiya=fpwloginstatus(fpwusername,clock);
        smps2.Runmemo='Running ......';
        templatefile = which('duringrun.html');      
        str = htmlrep(smps2, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\tduringrun.html'],'noheader');                     
        cd([Wherematlab,'stock']);
      end
      
      cusnused=lower(markfilt(cusresuna(j,:)));
      if strcmp(custname,cusnused)==0
        custname=cusnused;
        stock=stgetdaa(cusnused,lower(RunTickOrDay),round(1.25*wphdtu)+100); %do not do RM operate after tens days later 
        if lower(RunTickOrDay)=='d'
          mpsdlhere=find((stock(:,1)==mpsdl(1))&(stock(:,2)==mpsdl(2))&(stock(:,3)==mpsdl(3)));
        else
          mpsdlhere=find((stock(:,1)==mpsdl(1))&(stock(:,2)==mpsdl(2))&(stock(:,3)==mpsdl(3))&(stock(:,4)==mpsdl(4))&(stock(:,5)==mpsdl(5)));
        end    
        if lower(RunTickOrDay)=='d'
          stock=stock(1:mpsdlhere(1),4:8);
        else
          stock=stock(1:mpsdlhere(1),6:10);              
        end   
        stock=stock(max([1 length(stock(:,1))-wphdtu-nums+1]):length(stock(:,1)),:);
        stockADDF=[zeros(hmdats,4)+stock(length(stock(:,1)),4) zeros(hmdats,1)];
        stock=[stock;stockADDF];
        clear stockADDF        
      end   
      
      [cusresus ewrfn smdbs ostg]=ststatis(stock,cusresupd(j,2),sign(cusresupd(j,1)),length(stock(:,1))-abs(cusresupd(j,1))+1,hmdats,mpmrstop,mpmrobje,mpmrkind,mpmrvo);
      cusresu(j,:)=cusresus;
      cusresupd(j,6)=ewrfn;
      cusresupd(j,8:12)=ostg;
      if cusresupd(j,6)<hmdats
        cusresui(j,2*cusresupd(j,6)+1:2*hmdats)=0*cusresui(j,2*cusresupd(j,6)+1:2*hmdats);
      end
    end  
    
    cd(fpwserverplace);
    templatefile = which('wbduringrun.html');
    smps2.fpwtime=[datestr(now-NOWhms,13),', ',time1];
    smps2.fpwrprogram = ['FSEC: ',upper(mpptname(1:min([10 length(mpptname)])))];
    smps2.percfinished='100';
    str = htmlrep(smps2, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\twbduringrun.html'],'noheader');
    %cd([Wherematlab,'stock']);    
    %smps2.Runmemo='Completed.';
    %templatefile = which('duringrun.html');      
    %str = htmlrep(smps2, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\tduringrun.html'],'noheader');    
    
    cd([fpwserverplace,fpwclientdirectory,fpwusername,'\stock\']);
    if 0 %exist('lastsimu.mat')==2 % No simu1-2 update
      cd([Wherematlab,'stock']);
      wbstsimu12(fpwusername);
      cd([fpwserverplace,fpwclientdirectory,fpwusername,'\stock\']);
    end
    herestopp=mpmrstop; hereobjep=mpmrobje; herekindm=mpmrkind;
    stopnum=Stopnum; objenum=Objenum;
    eval(['save lastsimu mpptname mpmruon mpmrvo cusresu cusresui cusresuna cusresupd cusresurv wphdtu hmdats nums ',...
        'marke stopnum objenum herestopp hereobjep herekindm RunTickOrDay sdate instruct']); 
      
    % reset the filter edit part
    mpsrsindex='1';
      
    % graphic output
    cd([Wherematlab,'stock']);
    [mpsimFig mpsimsta]=wbstsimuchart(fpwusername,91);
    set(mpsimFig,'inverthardcopy','off'); hold off
    set(mpsimFig,'PaperPosition',[.25 .25 5.92 3.15]);
    smps2.Runmemo='Completed.';
    templatefile = which('duringrun.html');      
    str = htmlrep(smps2, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\tduringrun.html'],'noheader');    
    cd([fpwserverplace,fpwclientdirectory,fpwusername,'\stock']);
    drawnow;
    wsprintjpeg(mpsimFig,'Mpsimujpeg.jpeg');
    close(mpsimFig);
    
    mpefsp=wphdtu;
    mpefhl=hmdats;  
    mpefhlqs=0;
    mpefvb=0;
    mpefve=999;  
    mpefpb=0;
    mpefpe=999;
    mpefvpb=0;
    mpefvpe=999;
    mpefls='+/-';  
    mpefco='Close'; 
    mpefcoqs='Close';
    mpefef='Enter any statement here.';
      
    mpswinno=mpsimsta(1);
    mpslossno=mpsimsta(2);	
    mpsdrawno=mpsimsta(3);	
    mpswinper=mpsimsta(4);	
    mpsevdd=mpsimsta(5);	
    mpsprfr=mpsimsta(6);	
    mpsequity=mpsimsta(7);	
    mpsmaxfp=mpsimsta(8);
    mpsmaxdd=mpsimsta(9);	
    mpsavet=mpsimsta(10);	
    mpsavew=mpsimsta(11);	
    mpsavel=mpsimsta(12);  
    mpsmaxw=mpsimsta(13);		
    mpsmaxl=mpsimsta(14);
    
    cd(fpwserverplace);
    templatefile = which('MPsimulationR1.html');
    smps.StatusReport = ['Simulation of Simu1 with NEW MM Rules finished at: ',time1];
    str = htmlrep(smps, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\tMPsimulationR1.html'],'noheader');
    cd([Wherematlab,'stock']);      
    mpsimwindow=2;
  end
    
  if strcmp(mprunindex,'81')
    global NDNi
    NDNi=1;
    NDNs=upper(noempty(mpefef));
    if length(NDNs)>=3
      if strcmp('NDN',NDNs(1:3))==1
        NDNi=0;
      end
    end
    
    if 0
     newVLI=upper(noempty(mpefef)); %VLI always put in the end following by [percentage maxKS] 
     VLI=0; VLImax=1000;
     if length(newVLI)>3
      if length(strfind(newVLI,'VLI'))>0
        comaplace=strfind(newVLI,'VLI');
        eval(['VLI=',newVLI(comaplace(1)+3:length(newVLI)),';']);
        if length(VLI)==2
          VLImax=VLI(2); VLI=VLI(1);
        elseif length(VLI)==1
          VLImax=1000; VLI=VLI(1);
        end
      end
     end
     eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\myVLI.mat VLI VLImax']);
    end
    
    smps.fpwzoneoutput=wbstsimunet(fpwusername);
    smps.fpwusername=fpwusername;
    smps.fpwusername4=fpwusername4;
    smps.fpwulvl=instruct.fpwulvl;
    smps.mpplistnet='N';
    smps.thousandnum='0';
    smps.addminus='-1';
    %smps.tradenumber=['http://www.WSQSI.com',fpwclientdirectory,fpwusername,'/stock/tradenumber.jpg'];
    smps.tradenumber=[fpwclientdirectory,fpwusername,'/stock/tradenumber.jpeg']; %no more use 
    smps.dollarposi=[fpwclientdirectory,fpwusername,'/stock/dollarposi.jpeg']; %no more use 
    smps.withspyhedge=[fpwclientdirectory,fpwusername,'/stock/withspyhedge.jpeg']; %no more use
    mpsimwindow=31;           
  end

  if strcmp(mprunindex,'191')    
    cd([fpwserverplace,fpwclientdirectory,fpwusername,'\stock\']);                
    load lastsimu
    if exist('cusresui')~=1
      cusresui=0*cusresu+1;
    end      
    if ~(exist('qzi')==1)
      qzi=ones(length(cusresu(:,1)),1);
    end
    if length(qzi)~=length(cusresu(:,1))
      save c:\matlab\stock\wbstsimuqzierror.mat
      qzi=ones(length(cusresu(:,1)),1);
      disp(' Someting wrong with weighted index, check it out');
    end
    mpefco='Close'; mpefhl=hmdats; mpefcoqs='Close'; mpefhlqs=0;
    eval(['save -v4 lastrun mpptname mpmruon mpmrvo cusresu cusresui cusresuna cusresupd cusresurv wphdtu hmdats nums ',...
          'marke stopnum objenum herestopp hereobjep herekindm RunTickOrDay sdate mpefls mpefco mpefcoqs mpefhlqs qzi']) 
    mpmrstop=herestopp; 
    mpmrobje=hereobjep; 
    mpmrkind=herekindm;
    mpptmrk=marke; 
    if RunTickOrDay=='D'
      mpptdt='Daily';
    else
      mpptdt='Tick';        
    end
    mpefsp=wphdtu;
    mpspsp=mpefsp;
    mpefhl=hmdats;
    mpsphl=mpefhl;
    mpefvb=0;
    mpefve=999;  
    mpefpb=0;
    mpefpe=999;
    mpefvpb=0;
    mpefvpe=999;
    mpefls='+/-';  
    mpefco='Close';  
    mpefef='Enter any statement here.';
    cd(fpwserverplace);
    templatefile = which('MPsimulationR1.html');
    smps.StatusReport = ['System reseted successfully. ',time1];
    str = htmlrep(smps, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\tMPsimulationR1.html'],'noheader'); 
    
    cd([Wherematlab,'stock']);
    [mpsimFig mpsimsta]=wbstsimuchart(fpwusername,91);       
    set(mpsimFig,'inverthardcopy','off'); hold off
    set(mpsimFig,'PaperPosition',[.25 .25 5.92 3.15]);
    cd([fpwserverplace,fpwclientdirectory,fpwusername,'\stock']);
    drawnow;
    wsprintjpeg(mpsimFig,'Mpsimujpeg.jpeg');
    close(mpsimFig);
    mpsimwindow=2;      
  end
  
  % prepare to output back
  % general parameters
  smps.fpwusername=fpwusername;  
  smps.fpwusername4=fpwusername4;
  smps.mprunindex=mprunindex; % in string format
  smps.mpsrsindex=mpsrsindex;
  
  % simulation parameters
  smps.mpspsp=num2str(mpspsp);
  smps.mpsphl=num2str(mpsphl);
  smps.mpspv=['[',num2str(mpspv(1)),', ',num2str(mpspv(2)),']'];
  smps.mpspp=['[',num2str(mpspp(1)),', ',num2str(mpspp(2)),']'];
  smps.mpspvp=['[',num2str(mpspvp(1)),', ',num2str(mpspvp(2)),']'];
  smps.mpmruon=num2str(mpmruon);  
  smps.mpmrkind=num2str(mpmrkind); 
  smps.mpmrvo=num2str(mpmrvo);
  smps.mpmrstop=num2str(mpmrstop);  
  smps.mpmrobje=num2str(mpmrobje);   

  % simulation pattern file  
  smps.mpptname=mpptname;
  smps.mpptdt=mpptdt;
  smps.mpptmrk=mpptmrk;
  smps.mpptfilef=mpptfilef;
  
  % Decomposition parameters
  smps.mpefsp=num2str(mpefsp);
  smps.mpefhl=num2str(mpefhl); 
  smps.mpefhlqs=num2str(mpefhlqs);
  smps.mpefvb=num2str(mpefvb);
  smps.mpefve=num2str(mpefve);  
  smps.mpefpb=num2str(mpefpb);
  smps.mpefpe=num2str(mpefpe);
  smps.mpefvpb=num2str(mpefvpb);
  smps.mpefvpe=num2str(mpefvpe);
  smps.mpefls=mpefls;  
  smps.mpefco=mpefco;  
  smps.mpefcoqs=mpefcoqs;
  smps.mpefef=mpefef;
  
  % Previous Statistics output
  smps.mpswinno=num2str(mpswinno);
  smps.mpslossno=num2str(mpslossno);	
  smps.mpsdrawno=num2str(mpsdrawno);	
  smps.mpswinper=sprintf('%6.2f',mpswinper);	
  smps.mpsevdd=sprintf('%5.2f',mpsevdd);	
  smps.mpsprfr=sprintf('%5.2f',mpsprfr);	
  smps.mpsequity=num2str(round(mpsequity));	
  smps.mpsmaxfp=num2str(mpsmaxfp);	
  smps.mpsmaxdd=num2str(round(mpsmaxdd));	
  smps.mpsavet=num2str(round(mpsavet));	
  smps.mpsavew=num2str(round(mpsavew));	
  smps.mpsavel=num2str(round(mpsavel));  
  smps.mpsmaxw=num2str(round(mpsmaxw));		
  smps.mpsmaxl=num2str(round(mpsmaxl));
  if isfield(instruct,'fpwulvl')
    smps.fpwulvl=instruct.fpwulvl;
  end
  smps.ProgressM=strrep([fpwclientdirectory,fpwusername,'\stock\twbduringrun.html'],'\','/');
  smps.MPsrsource=strrep(['http:\\www.WSQSI.com',fpwclientdirectory,fpwusername,'\stock\tMPsimulationR1.html'],'\','/');
  smps.Mpsimujpeg=['http:\\www.WSQSI.com',fpwclientdirectory,fpwusername,'\stock\Mpsimujpeg.jpeg'];  
  eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\fpwstmpsimu smps']);  
  
elseif (strcmp(WhereOrderFrom,'INDX'))
    
  VLI=0; VLImax=1000;
  eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\myVLI.mat VLI VLImax']);
  
  if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\stock\fpwstmpsimu.mat'])==2
    eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\fpwstmpsimu']);
    smps.ProgressM=strrep([fpwclientdirectory,fpwusername,'\stock\twbduringrun.html'],'\','/');
    smps.fpwusername=fpwusername;
    smps.fpwusername4=fpwusername4;
    if ~(isfield(smps,'mpefhlqs'))
      smps.mpefcoqs='Close';
      smps.mpefhlqs='0';
    end
  else
    smps.fpwusername=fpwusername;
    smps.fpwusername4=fpwusername4;
    smps.mprunindex='0'; % in string format
    smps.mpsrsindex='1';     
    
    % simulation parameters
    smps.mpspsp='1500';
    smps.mpsphl='30';
    smps.mpspv='[4, 6]';
    smps.mpspp='[10, 4]';
    smps.mpspvp='[200, 50]';
    smps.mpmruon='0';  
    smps.mpmrkind='2'; 
    smps.mpmrvo='15';
    smps.mpmrstop='12';  
    smps.mpmrobje='24';   
  
    % simulation pattern file  
    smps.mpptname='Pattern';
    smps.mpptdt='Daily';
    smps.mpptmrk='NYSE';
    eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\mpptfilef']);
    mpptfilef=mpptfilef(find(mpptfilef~=char(10)));
    smps.mpptfilef=mpptfilef;
  
    % Decomposition parameters
    smps.mpefsp='1500';
    smps.mpefhl='30';  
    smps.mpefhlqs='0';
    smps.mpefvb='0';
    smps.mpefve='999';  
    smps.mpefpb='0';
    smps.mpefpe='999';
    smps.mpefvpb='0';
    smps.mpefvpe='999';
    smps.mpefls='+/-';  
    smps.mpefco='Close';  
    smps.mpefcoqs='Close';
    smps.mpefef='Enter any statement here.';
    
    % Previous Statistics output
    smps.mpswinno='2086';
    smps.mpslossno='1786';	
    smps.mpsdrawno='45';	
    smps.mpswinper='53.26';	
    smps.mpsevdd='4.36';	
    smps.mpsprfr='1.29';	
    smps.mpsequity='1524000';	
    smps.mpsmaxfp='334';	
    smps.mpsmaxdd='350000';	
    smps.mpsavet='389';	
    smps.mpsavew='3286';	
    smps.mpsmaxw='7850';	
    smps.mpsavel='2986';	
    smps.mpsmaxl='7893';
    smps.ProgressM=strrep([fpwclientdirectory,fpwusername,'\stock\twbduringrun.html'],'\','/');
    smps.MPsrsource=strrep(['http:\\www.WSQSI.com',fpwclientdirectory,fpwusername,'\stock\tMPsimulationR1.html'],'\','/');
    smps.Mpsimujpeg=['http:\\www.WSQSI.com',fpwclientdirectory,fpwusername,'\stock\Mpsimujpeg.jpeg'];    
  end
  if isfield(instruct,'fpwulvl')
    smps.fpwulvl=instruct.fpwulvl;
  end  
elseif (strcmp(WhereOrderFrom,'SCFL'))
  mpsimwindow=4;
  Rno=instruct.mprunindex;
  if (strcmp(Rno(1),'5'))|(strcmp(Rno(1),'6'))
    smps.StatusReport = ['Warning, banned words found: ',urbanwords];
    mpsimwindow=1; 
  end
end 

cd(fpwserverplace);
cids=fpwloginstatus(fpwusername,clock);
if mpsimwindow==1   % status report
  templatefile = which('MPsimulationR1.html');
  if (nargin == 1)
    str = htmlrep(smps, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\tMPsimulationR1.html'],'noheader');      
    retstr = htmlrep(smps, templatefile);
  elseif (nargin == 2)
    retstr = htmlrep(smps, templatefile, outfile);
  end    
elseif mpsimwindow==2  % simulation graphic output
  templatefile = which('MPsimulation.html');    
  if (nargin == 1)
    retstr = htmlrep(smps, templatefile);     
  elseif (nargin == 2)
    retstr = htmlrep(smps, templatefile, outfile);
  end
elseif mpsimwindow==3  % P V PV and summary
  smps.wbstmpstatchart=[fpwclientdirectory,fpwusername,'\stock1\'];
  if strcmp(mprunindex,'24')
    smps.wbstmpstatchart=[fpwclientdirectory,fpwusername,'\stock\'];
    templatefile = which('wbstmpstatchart.html');
    str = htmlrep(smps, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbstmpstatchart.html'],'noheader');
    templatefile = which('fpwmppseo.html');
    str = htmlrep(smps, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\fpwmppseo.html'],'noheader');    
    templatefile = which('wbstmpsls8.html');
  else
    templatefile = which('wbstmpsls.html');    
  end
  if (nargin == 1)
    retstr = htmlrep(smps, templatefile);     
  elseif (nargin == 2)
    retstr = htmlrep(smps, templatefile, outfile);
  end
elseif mpsimwindow==31  % daily net
  smps.tntvalue='T';
  templatefile = which('wbstmpsls1.html');    
  if (nargin == 1)
    retstr = htmlrep(smps, templatefile);     
  elseif (nargin == 2)
    retstr = htmlrep(smps, templatefile, outfile);
  end  
elseif mpsimwindow==311  % trading list
  smps.TLinextl=num2str(TLi(1));
  smps.TLinexth=num2str(TLi(2));
  templatefile = which('wbstmpsls2.html');    
  if (nargin == 1)
    retstr = htmlrep(smps, templatefile);     
  elseif (nargin == 2)
    retstr = htmlrep(smps, templatefile, outfile);
  end    
elseif mpsimwindow==4  % trading list
  templatefile = which('wbcheckbanw.html');    
  smps.mpgfoutput=' ';
  if (nargin == 1)
    retstr = htmlrep(smps, templatefile);     
  elseif (nargin == 2)
    retstr = htmlrep(smps, templatefile, outfile);
  end  
elseif mpsimwindow==5  % trading list
  templatefile = which('fpwopenfile1.html');
  if (nargin == 1)
    retstr = htmlrep(outstruct, templatefile);   
  elseif (nargin == 2)
    retstr = htmlrep(outstruct, templatefile, outfile);
  end
elseif mpsimwindow==6  % trading list
  templatefile = which('fpwdeletefile1.html');
  if (nargin == 1)
    retstr = htmlrep(outstruct, templatefile);   
  elseif (nargin == 2)
    retstr = htmlrep(outstruct, templatefile, outfile);
  end  
end
end