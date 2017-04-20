function retstr = wbfpwsimu(instruct, outfile)

% Author(s): N. Zhu, 11-15-2003
% This is a WB (Web-Based) mirror program to <stsimulp>, <stsiedit>, <stsirun> and more in desktop version
fpwaddnoise=instruct.hdfpwaddnoise;
if strcmp(fpwaddnoise,'AN: 0')
  wbfpwbasic; % to clean database - [AN: 0]
else
  wbfpwbasic1; % to different noise added database [AN: 5], [AN:15] and [AN:30]
end
cd(fpwserverplace);

retstr = char('');
global fpwusername fpwusername4 totc
clear global totc
global totc

fpwusername=instruct.mlid{1};
if isfield(instruct,'fpwrunindex')
  if (strcmp(instruct.fpwrunindex,'91'))|(strcmp(instruct.fpwrunindex,'71'))|(strcmp(instruct.fpwrunindex,'51'))|(strcmp(instruct.fpwrunindex,'31'))|...
    ((strcmp(instruct.fpwrunindex,'61'))&(strcmp(instruct.hdfpwpttype,'R')))|((strcmp(instruct.fpwrunindex,'81'))&(strcmp(instruct.hdfpwpttype,'R')))
    fpwCPAL=4;
  end
else
  fpwCPAL=3;
end
fpwloginIP='192.168.2.8';
fpwcheckil;
wbststopritm=0;

% To Change PaperPosition, one needs to change 5 m-files:
% wbfpwoutput, wbfpwsimu, wbfpwport, wbdzhputmi and fpwfsmarket.
%MyPaperPosiH=[.25 .25 4.4 4.25]; % old small one, used before 2016-07-14
MyPaperPosiH=[.25 .25 8.259 4.355];
eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbststopritm.mat wbststopritm']);

if fpwcheckilpass==1
  
  WhereOrderFrom=instruct.WhereOrderFrom;
  if ~(strcmp(WhereOrderFrom,'INDX'))
    urbanwords='';
    [fpwscpass1,whereban1,whatban1]=wbcheckbanw('FPWFile',instruct.fpwptfilef);
    if isfield(instruct,'fpwexfilef')~=1
      [fpwscpass1,whereban1,whatban1]=wbcheckbanw('FPWFile',instruct.fpwptfilef);
    else
      [fpwscpass1,whereban1,whatban1]=wbcheckbanw('FPWFile',...
      [instruct.fpwptfilef,instruct.fpwexfilef,instruct.fpwstfilef,instruct.fpwobfilef]); 
    end
    if fpwscpass1~=1
      urbanwords=[urbanwords,whereban1,': ',whatban1,'; '];
    end            
    [fpwscpass2,whereban2,whatban2]=wbcheckbanw('FPWPTNAME',instruct.fpwptname);
    if fpwscpass2~=1
      urbanwords=[urbanwords,whereban2,': ',whatban2,'; '];
    end                     
    if (fpwscpass1+fpwscpass2)~=2
      fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
      fseek(fid1,-50,1); fprintf(fid1,[time,' FAIL: ',urbanwords,'\n']); fclose(fid1);
      clear fid1    
      WhereOrderFrom='SCFL'
      sfpw.urbanwords=urbanwords;
    end
    clear urbanwords fpwscpass1 whereban1 whatban1 fpwscpass2 whereban2 whatban2
  end
    
  cd([Wherematlab,'pattern']);
  if (strcmp(WhereOrderFrom,'SLFE'))
    if (isfield(instruct,'fpwptfilef'))
      if fpwsecucheck(instruct.fpwptfilef)>0
        error(' Hei! Not allowed content found in fpwptfilef, are you seriously trying to .... Sorry, change it.');
      end
    end
    if (isfield(instruct,'fpwexfilef'))
      if fpwsecucheck(instruct.fpwexfilef)>0
        error(' Hei! Not allowed content found in fpwexfilef, are you seriously trying to .... Sorry, change it.');
      end
    end
    if (isfield(instruct,'fpwstfilef'))
      if fpwsecucheck(instruct.fpwstfilef)>0
        error(' Hei! Not allowed content found in fpwstfilef, are you seriously trying to .... Sorry, change it.');
      end
    end
    if (isfield(instruct,'fpwobfilef'))
      if fpwsecucheck(instruct.fpwobfilef)>0
        error(' Hei! Not allowed content found in fpwobfilef, are you seriously trying to .... Sorry, change it.');
      end
    end
    
    fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
    fseek(fid1,-50,1); fprintf(fid1,[time,' PW',instruct.fpwrunindex,'\n']); fclose(fid1);
    clear fid1
    fpwrunindex=instruct.fpwrunindex; zhu45s=instruct.zhu45s;
    if strcmp(fpwrunindex,'11')
      global stock datem
      global sts stl obs obl CPS;
      global sl5 riskd commission tickstep stk dam lotshis ldctime ltdss lcps tradeh MiMi MiMi2 MiMi3 MiMi4
      global intra ycp brkl brks bkei trendv fdctime wstime sj ldcday ltpd wspt cgno PatSeed PatWeight MyPat
      global zhu61 zhu62 zhu63 zhu64 zhu65new zhu65 zhu66 zhu67new zhu67 zhu68 zhu52 zhu59
      global zhu81 tkdv zhu82 zhu83 zhu84 zhu85 zhu86 zhu87 zhu88 zhu89
      global zhu91 zhu92 zhu93 zhu94 zhu95 zhu96 zhu97 zhu98 zhu99
      global obje2nd ent01 zhu17l zhu22l zhu24l stk3 dam3 stk4 dam4 stk5 dam5
      global new301 new302 new303 new304 new305 new306 new401 new402 new403 new404 
      global zhu712 zhu713 zhu722 zhu723 zhu732 zhu733 zhu742 zhu743
      global cgno name zhu101 zhu1013 zhu1014 zhu1015
    end
    global mname
    % forget what this cgno is for
    cgnoini=[0 0 0 0 0 0 0 0 0 0];
    cgno=cgnoini; 
    
    % buttons
    tkdv=instruct.hdtkdv; zhu62=instruct.hdzhu62; zhu04s=instruct.hdzhu04s; zhu89=instruct.hdzhu89; zhusm=instruct.hdzhusm;
    zhu68=instruct.hdzhu68; zhu66=instruct.hdzhu66; zhu97=instruct.hdzhu97; zhu59=instruct.hdzhu59; marent03=instruct.hdmarent03;
    zhu84=instruct.hdzhu84; zhuyun=instruct.hdzhuyun; fpwptname2=instruct.hdfpwptname2; zhu712=instruct.hdzhu712;
    zhu713=instruct.hdzhu713; PBKE=instruct.hdPBKE; zhu99=instruct.hdzhu99; fpwpttype=instruct.hdfpwpttype; zhuron=instruct.hdzhuron;
    % drop-downs
    zhu22l=instruct.zhu22l; zhu24l=instruct.zhu24l; zhu17l=instruct.zhu17l;
    fpwchartspan=instruct.fpwchartspan; fpwptname3=instruct.fpwptname3;
    % all others
    zhu52=instruct.zhu52; zhu54=instruct.zhu54; ent01=instruct.ent01; ent02=instruct.ent02; ent03=instruct.ent03; zhu75=instruct.zhu75;
    zhu200=instruct.zhu200; zhu61=instruct.zhu61; zhu63=instruct.zhu63; zhu64=instruct.zhu64; zhu65new=instruct.zhu65new; 
    zhu65=instruct.zhu65; zhu67new=instruct.zhu67new; zhu67=instruct.zhu67;
    new301=instruct.new301; new302=instruct.new302; new303=instruct.new303; new304=instruct.new304; new305=instruct.new305; new306=instruct.new306; 
    new401=instruct.new401; new402=instruct.new402; new403=instruct.new403; new404=instruct.new404;
    zhu722=instruct.zhu722; zhu723=instruct.zhu723; zhu732=instruct.zhu732; zhu733=instruct.zhu733; zhu742=instruct.zhu742; zhu743=instruct.zhu743; 
    zhu81=instruct.zhu81; zhu82=instruct.zhu82; zhu83=instruct.zhu83; zhu85=instruct.zhu85; zhu86=instruct.zhu86; zhu87=instruct.zhu87; zhu88=instruct.zhu88;
    zhu91=instruct.zhu91; zhu92=instruct.zhu92; zhu93=instruct.zhu93; zhu94=instruct.zhu94; zhu95=instruct.zhu95; zhu96=instruct.zhu96; zhu98=instruct.zhu98;
    obje2nd=instruct.obje2nd; zhu26=instruct.zhu26;
    fpwptname=instruct.fpwptname; zhu101=instruct.zhu101; zhu1013=instruct.zhu1013; zhu1014=instruct.zhu1014; zhu1015=instruct.zhu1015;

    fpwptfilef=instruct.fpwptfilef; fpwptfilef=fpwptfilef(find(fpwptfilef~=13));
    if isfield(instruct,'fpwexfilef')~=1
      fpwexfilef='Not Assigned for this pattern.';
      fpwstfilef='Not Assigned for this pattern.';
      fpwobfilef='Not Assigned for this pattern.';   
    else
      fpwexfilef=instruct.fpwexfilef; fpwexfilef=fpwexfilef(find(fpwexfilef~=13));
      fpwstfilef=instruct.fpwstfilef; fpwstfilef=fpwstfilef(find(fpwstfilef~=13));
      fpwobfilef=instruct.fpwobfilef; fpwobfilef=fpwobfilef(find(fpwobfilef~=13));
    end

    % checks
    ESOchosen=['00000000000000000000000000'];
    for i=1:26
      if isfield(instruct,['fpweso',num2str(i+10)])
        ESOchosen(i)='1';
      end
    end
    
    % general variables
    filetypeid=instruct.filetypeid;
    FirstorS=str2num(instruct.FirstorS);
    name=noempty(zhu26);
    mname=zhu99;      
    fpwchartbase='V';
    
    if (length(name)==0)|(length(name)>6)
      error('Entered wrong symbol.');
    end
    name=lower(name);
    [stock datem]=fsdaydat([mname,name]);
    if length(stock)==0
      if (strcmp(instruct.fpwrunindex,'91'))        
        if mname=='F'; mname='S'; else mname='F'; end
        [stock datem]=fsdaydat([mname,name]);
        if mname=='F'; mname='S'; else mname='F'; end
      end
    end
    
    if length(stock)>0       
        
      if (FirstorS==0)
        fpwchartspan='DD';
        fpwchartbase='V';    
        fpwchartft=[1 length(datem(:,1))];
      else    
        fpwFdate=instruct.fpwFdate;
        slplace=find(fpwFdate=='/');
        if length(slplace)~=2
          slplace=find(fpwFdate=='-');
          if length(slplace)~=2
            error('Entered a wrong start F date');
          end
        end
        startd=[str2num(fpwFdate(1:slplace(1)-1)) str2num(fpwFdate(slplace(1)+1:slplace(2)-1)) str2num(fpwFdate(slplace(2)+1:length(fpwFdate)))];
        datecheck(startd,1);
        fpwTdate=instruct.fpwTdate;    
        slplace=find(fpwTdate=='/');
        if length(slplace)~=2
          slplace=find(fpwTdate=='-');
          if length(slplace)~=2
            error('Entered a wrong start T date');
          end
        end
        endd=[str2num(fpwTdate(1:slplace(1)-1)) str2num(fpwTdate(slplace(1)+1:slplace(2)-1)) str2num(fpwTdate(slplace(2)+1:length(fpwTdate)))];
        datecheck(endd,1); 
        fpwchartft(1)=datef2(startd,datem);
        fpwchartft(2)=datef2(endd,datem);
        if fpwchartft(1)>fpwchartft(2)
          fpwchartft=fpwchartft([2 1]);
        end
      end
      Datem=datem;Stock=stock;
      
      if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\wbfpwfrontbs.mat'])==2
        eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\wbfpwfrontbs']);
        if (~strcmp(fpwptfilef,'K'))&(fpwpttype=='P')    
          if fpwptname2=='B'
            frontfpwb=fpwptfilef;
            if exist('fpwexfilef')==1
              frontfpwexb=fpwexfilef;
              frontfpwstb=fpwstfilef;
              frontfpwobb=fpwobfilef;
            else
              frontfpwexb='Your most recent buy Special Exit Rule is not available yet';
              frontfpwstb='Your most recent buy Special Stop Rule is not available yet';
              frontfpwobb='Your most recent buy Special Objective Rule is not available yet';
            end
          else
            frontfpws=fpwptfilef;
            if exist('fpwexfilef')==1
              frontfpwexs=fpwexfilef;
              frontfpwsts=fpwstfilef;
              frontfpwobs=fpwobfilef;
            else
              frontfpwexs='Your most recent sell Special Exit Rule is not available yet';
              frontfpwsts='Your most recent sell Special Stop Rule is not available yet';
              frontfpwobs='Your most recent sell Special Objective Rule is not available yet';
            end
          end 
        end
      else
        if (~strcmp(fpwptfilef,'K'))&(fpwpttype=='P')          
          if fpwptname2=='B'
            frontfpwb=fpwptfilef;
            frontfpws='Your most recent sell pattern is not available yet';    
            frontfpwexs='Your most recent sell Special Exit Rule is not available yet';
            frontfpwsts='Your most recent sell Special Stop Rule is not available yet';
            frontfpwobs='Your most recent sell Special Objective Rule is not available yet';
          else
            frontfpws=fpwptfilef;
            frontfpwb='Your most recent buy pattern is not available yet'; 
            frontfpwexb='Your most recent buy Special Exit Rule is not available yet';
            frontfpwstb='Your most recent buy Special Stop Rule is not available yet';
            frontfpwobb='Your most recent buy Special Objective Rule is not available yet';
          end   
        else
          frontfpws='Your most recent sell pattern is not available yet';       
          frontfpwb='Your most recent buy pattern is not available yet';  
          frontfpwexs='Your most recent sell Special Exit Rule is not available yet';
          frontfpwsts='Your most recent sell Special Stop Rule is not available yet';
          frontfpwobs='Your most recent sell Special Objective Rule is not available yet';
          frontfpwexb='Your most recent buy Special Exit Rule is not available yet';
          frontfpwstb='Your most recent buy Special Stop Rule is not available yet';
          frontfpwobb='Your most recent buy Special Objective Rule is not available yet';
        end
      end
      hdfpwptfilefs=frontfpws;
      hdfpwptfilefb=frontfpwb; 
      if exist('frontfpwexs')~=1
        frontfpwexs='Your most recent sell Special Exit Rule is not available yet';
        frontfpwsts='Your most recent sell Special Stop Rule is not available yet';
        frontfpwobs='Your most recent sell Special Objective Rule is not available yet';
        frontfpwexb='Your most recent buy Special Exit Rule is not available yet';
        frontfpwstb='Your most recent buy Special Stop Rule is not available yet';
        frontfpwobb='Your most recent buy Special Objective Rule is not available yet';
      end
      hdfpwexfilefs=frontfpwexs;
      hdfpwexfilefb=frontfpwexb; 
      hdfpwstfilefs=frontfpwsts;
      hdfpwstfilefb=frontfpwstb; 
      hdfpwobfilefs=frontfpwobs;
      hdfpwobfilefb=frontfpwobb; 
      if fpwpttype=='P'
        eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\wbfpwfrontbs frontfpws frontfpwb frontfpwexs frontfpwexb frontfpwsts frontfpwstb frontfpwobs frontfpwobb']);
      end
        
      if strcmp(fpwrunindex,'11')
        if fpwpttype=='R'
          error(' - Make sure your script is for a pattern, not for a rule function.')  
        end       
        
        if strcmp(instruct.hdzhuyun,'FT-Link')        
          zhu52=int2str(fpwchartft(1));
          zhu54=int2str(length(datem(:,1))-fpwchartft(2)+1);
        end
        
        % run simulation, about another 2000 lines for itself alone
        global linecondpr linecodemp linecodempex linecodempst linecodempob
        linecond=fpwptfilef;
        mimiprerun=strfind(fpwptfilef,'[/MiMi]');
        if length(mimiprerun)==0
          LSMi=0;
          % save all text to fpwenteb(s)1.m
          if length(noempty(fpwptfilef))>0        
            filenametw=[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwente',fpwptname2,'1.m'];
            fid=fopen(filenametw,'wt');
            fprintf(fid,[' function y=fpwente',fpwptname2,'1(stock,i,enp,enw)\n']);
            fprintf(fid,' o=stock(:,1);h=stock(:,2);l=stock(:,3);c=stock(:,4);v=stock(:,5);\n');
            fprintf(fid,' global intra sl5 riskd commission tickstep stk dam ycp trendv fdctime wstime sj lotshis MiMi MiMi2 MiMi3 MiMi4 ltdss lcps ltpd tradeh brkl brks bkei stl sts obl obs tot totc wspt stk3 dam3 stk4 dam4 stk5 dam5\n');
            fprintf(fid,' global sl5 riskd commission tickstep stk dam trendv fdctime wstime sj lotshis MiMi MiMi2 MiMi3 MiMi4 ltdss lcps ltpd tradeh stl sts obl obs tot totc wspt MyOT MyCT PatSeed PatWeight MyPat\n');
            fprintf(fid,' global wsgp wsgp1 wsgp2 wsgp3 wsgp4 wsmh MyNexti exitpai stoppai objepai endi TExit TStop TObje wsgf wsgf1 wspo wspo1; wspo=''; wspo1=''; wsgf=''; wsgf1=''; wsgp4=[stock sj]; wstd350g;\n');
            fprintf(fid,fpwptfilef);
            fclose(fid);
            clear fid
            linecodemp=fpwptfilef;
          else
            error(' - Pattern is empty, put your pattern codes to the text area.');             
          end      
        elseif length(mimiprerun)==1
          LSMi=1;
          % save what before [/MiMi] to fpwmimib1.m, what after to fpwenteb(s)1.m, while if length(noempty(mimi-part))==0; LSMi=0;
                     
          % now save the MiMi part first
          if mimiprerun==1
            LSMi=0;            
          else
            linecondpr=fpwptfilef(1:mimiprerun-1);
            if length(noempty(linecondpr))==0
              LSMi=0;                   
            else
              filenametw=[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwmimib1.m'];
              fid=fopen(filenametw,'wt');
              fprintf(fid,[' function y=fpwmimib1(stock,i,enp,enw)\n']);
              fprintf(fid,' o=stock(:,1);h=stock(:,2);l=stock(:,3);c=stock(:,4);v=stock(:,5);\n');
              fprintf(fid,' global intra sl5 riskd commission tickstep stk dam ycp trendv fdctime wstime sj lotshis MiMi MiMi2 MiMi3 MiMi4 ltdss lcps ltpd tradeh brkl brks bkei stl sts obl obs tot totc wspt stk3 dam3 stk4 dam4 stk5 dam5\n');
              fprintf(fid,' global sl5 riskd commission tickstep stk dam trendv fdctime wstime sj lotshis MiMi MiMi2 MiMi3 MiMi4 ltdss lcps ltpd tradeh stl sts obl obs tot totc wspt MyOT MyCT PatSeed PatWeight MyPat\n');
              fprintf(fid,' global wsgp wsgp1 wsgp2 wsgp3 wsgp4 wsmh MyNexti exitpai stoppai objepai endi TExit TStop TObje wsgf wsgf1 wspc wspo wspo1; wspo=''; wspo1=''; wsgf=''; wsgf1=''; wsgp4=[stock sj]; wstd350g;\n');
              fprintf(fid,linecondpr);
              fclose(fid);
              clear fid            
            end 
          end
          
          % then save the main pattern to fpwenteb(s)1.m
          if length(fpwptfilef)<mimiprerun+7
            error(' - Main Pattern part is empty, put your main pattern codes after ''[/MiMi]''.');              
          end
          linecodemp=fpwptfilef(mimiprerun+7:length(fpwptfilef));
          if length(noempty(linecodemp))>0        
            filenametw=[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwente',fpwptname2,'1.m'];
            fid=fopen(filenametw,'wt');
            fprintf(fid,[' function y=fpwente',fpwptname2,'1(stock,i,enp,enw)\n']);
            fprintf(fid,' o=stock(:,1);h=stock(:,2);l=stock(:,3);c=stock(:,4);v=stock(:,5);\n');
            fprintf(fid,' global intra sl5 riskd commission tickstep stk dam ycp trendv fdctime wstime sj lotshis MiMi MiMi2 MiMi3 MiMi4 ltdss lcps ltpd tradeh brkl brks bkei stl sts obl obs tot totc wspt stk3 dam3 stk4 dam4 stk5 dam5\n');
            fprintf(fid,' global sl5 riskd commission tickstep stk dam trendv fdctime wstime sj lotshis MiMi MiMi2 MiMi3 MiMi4 ltdss lcps ltpd tradeh stl sts obl obs tot totc wspt MyOT MyCT PatSeed PatWeight MyPat\n');
            fprintf(fid,' global wsgp wsgp1 wsgp2 wsgp3 wsgp4 wsmh MyNexti exitpai stoppai objepai endi TExit TStop TObje wsgf wsgf1 wspc wspo wspo1; wspo=''; wspo1=''; wsgf=''; wsgf1=''; wsgp4=[stock sj]; wstd350g;\n');
            fprintf(fid,linecodemp);
            fclose(fid);
            clear fid
          else
            error(' - Pattern is empty, put your pattern codes after ''[/MiMi]'' in the pattern text area.');             
          end      
        else
          error(' - Pattern format not right, use ONE ''[/MiMi]'' to seperate prerun and the main part.'); 
        end
        
        if length(noempty(fpwexfilef))>0        
          filenametw=[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwexit',fpwptname2,'9.m'];
          fid=fopen(filenametw,'wt');
          fprintf(fid,[' function y=fpwexit',fpwptname2,'9(stock,i,enp,enw)\n']);
          fprintf(fid,' o=stock(:,1);h=stock(:,2);l=stock(:,3);c=stock(:,4);v=stock(:,5);\n');
          fprintf(fid,' global intra sl5 riskd commission tickstep stk dam ycp trendv fdctime wstime sj lotshis MiMi MiMi2 MiMi3 MiMi4 ltdss lcps ltpd tradeh brkl brks bkei stl sts obl obs tot totc wspt stk3 dam3 stk4 dam4 stk5 dam5\n');
          fprintf(fid,' global sl5 riskd commission tickstep stk dam trendv fdctime wstime sj lotshis MiMi MiMi2 MiMi3 MiMi4 ltdss lcps ltpd tradeh stl sts obl obs tot totc wspt MyOT MyCT PatSeed PatWeight MyPat\n');
          fprintf(fid,' global wsgp wsgp1 wsgp2 wsgp3 wsgp4 wsmh MyNexti exitpai stoppai objepai endi TExit TStop TObje wsgf wsgf1 wspc wspo wspo1; wspo=''; wspo1=''; wsgf=''; wsgf1=''; wsgp4=[stock sj]; wstd350g;\n');
          fprintf(fid,fpwexfilef);
          fclose(fid);
          clear fid
          linecodempex=fpwexfilef;
        else
          linecodempex='Not Assigned for this pattern.';             
        end
        
        if length(noempty(fpwstfilef))>0        
          filenametw=[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwstop',fpwptname2,'10.m'];
          fid=fopen(filenametw,'wt');
          fprintf(fid,[' function y=fpwstop',fpwptname2,'10(stock,i,enp,enw)\n']);
          fprintf(fid,' o=stock(:,1);h=stock(:,2);l=stock(:,3);c=stock(:,4);v=stock(:,5);\n');
          fprintf(fid,' global intra sl5 riskd commission tickstep stk dam ycp trendv fdctime wstime sj lotshis MiMi MiMi2 MiMi3 MiMi4 ltdss lcps ltpd tradeh brkl brks bkei stl sts obl obs tot totc wspt stk3 dam3 stk4 dam4 stk5 dam5\n');
          fprintf(fid,' global sl5 riskd commission tickstep stk dam trendv fdctime wstime sj lotshis MiMi MiMi2 MiMi3 MiMi4 ltdss lcps ltpd tradeh stl sts obl obs tot totc wspt MyOT MyCT PatSeed PatWeight MyPat\n');
          fprintf(fid,' global wsgp wsgp1 wsgp2 wsgp3 wsgp4 wsmh MyNexti exitpai stoppai objepai endi TExit TStop TObje wsgf wsgf1 wspc wspo wspo1; wspo=''; wspo1=''; wsgf=''; wsgf1=''; wsgp4=[stock sj]; wstd350g;\n');
          fprintf(fid,fpwstfilef);
          fclose(fid);
          clear fid
          linecodempst=fpwstfilef;
        else
          linecodempst='Not Assigned for this pattern.';             
        end
        
        if length(noempty(fpwobfilef))>0        
          filenametw=[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwobje',fpwptname2,'10.m'];
          fid=fopen(filenametw,'wt');
          fprintf(fid,[' function y=fpwobje',fpwptname2,'10(stock,i,enp,enw)\n']);
          fprintf(fid,' o=stock(:,1);h=stock(:,2);l=stock(:,3);c=stock(:,4);v=stock(:,5);\n');
          fprintf(fid,' global intra sl5 riskd commission tickstep stk dam ycp trendv fdctime wstime sj lotshis MiMi MiMi2 MiMi3 MiMi4 ltdss lcps ltpd tradeh brkl brks bkei stl sts obl obs tot totc wspt stk3 dam3 stk4 dam4 stk5 dam5\n');
          fprintf(fid,' global sl5 riskd commission tickstep stk dam trendv fdctime wstime sj lotshis MiMi MiMi2 MiMi3 MiMi4 ltdss lcps ltpd tradeh stl sts obl obs tot totc wspt MyOT MyCT PatSeed PatWeight MyPat\n');
          fprintf(fid,' global wsgp wsgp1 wsgp2 wsgp3 wsgp4 wsmh MyNexti exitpai stoppai objepai endi TExit TStop TObje wsgf wsgf1 wspc wspo wspo1; wspo=''; wspo1=''; wsgf=''; wsgf1=''; wsgp4=[stock sj]; wstd350g;\n');
          fprintf(fid,fpwobfilef);
          fclose(fid);
          clear fid
          linecodempob=fpwobfilef;
        else
          linecodempob='Not Assigned for this pattern.';             
        end
        
        % used by global tot when exit1 has not being chosen
        if ESOchosen(1)=='0'
          if length(strfind(noempty(linecodemp),'tot=['))>0
            totlocate=strfind(linecodemp,'tot'); %
            for totlocatei=1:length(totlocate)
              totlocateif=strfind(linecodemp(totlocate(totlocatei):length(linecodemp)),'[');
              totlocateit=strfind(linecodemp(totlocate(totlocatei):length(linecodemp)),']');
              totfactors(totlocatei,1:4)=str2num(linecodemp(totlocate(totlocatei)-1+totlocateif(1):totlocate(totlocatei)-1+totlocateit(1)));
            end
            if length(totlocate)>1
              totfactors=(round(max(totfactors)*100))/100; 
            end
            if round(totfactors(1))==1
              zhu04s='T';
            else
              zhu04s='D';
            end
            zhu200=sprintf('%5.2f',totfactors(2));
            zhu61=int2str(round(totfactors(3)));
            if round(totfactors(4))==1
              zhu62='O';
            else
              zhu62='C';
            end
            ESOchosen(1)='1';
            clear totlocateif totlocateit totlocatei totlocate
          end
        end
        if length(strfind(ESOchosen(1:8),'1'))==0
          if (length(strfind(noempty(linecodemp),'totc.'))==0)&...
            (length(strfind(noempty(linecodemp),'tot=['))==0)
            error(': Not chosen any exit conditions.');
          end
        end
        
        % prepare secondary markets of [stk dam] [stk3 dam3] [stk4 dam4] [stk5 dam5]
        % for multi-market simulation, we will check this again for every market
        stk=[0 0 0 0 0];
        dam=[0 0 0];
        if length(noempty(zhu101))>0
          zhu101=upper(noempty(zhu101));
          if (zhu101(1)=='F')|(zhu101(1)=='S')
             [stk dam]=fsdaydat(zhu101);
          else
            error(' - The 1st secondary fsname format wrong, start the secondary market symbol with ''F'' or ''S''.')
          end
        end
           
        if length(noempty(zhu1013))>0
          zhu1013=upper(noempty(zhu1013));
          if (zhu1013(1)=='F')|(zhu1013(1)=='S')
             [stk3 dam3]=fsdaydat(zhu1013);
          else
            error(' - The 2nd secondary fsname format wrong, start the secondary market symbol with ''F'' or ''S''.')
          end
        end      
           
        if length(noempty(zhu1014))>0
          zhu1014=upper(noempty(zhu1014));
          if (zhu1014(1)=='F')|(zhu1014(1)=='S')
             [stk4 dam4]=fsdaydat(zhu1014);
          else
            error(' - The 3rd secondary fsname format wrong, start the secondary market symbol with ''F'' or ''S''.')
          end
        end      
           
        if length(noempty(zhu1015))>0
          zhu1015=upper(noempty(zhu1015));
          if (zhu1015(1)=='F')|(zhu1015(1)=='S')
             [stk5 dam5]=fsdaydat(zhu1015);
          else
            error(' - The 4th secondary fsname format wrong, start the secondary market symbol with ''F'' or ''S''.')
          end
        end      
          
        % run the simulation, the output cell is fpwout
        statonly=0; % leave the ability for statonly simulation untouched for later version expansion
        cd([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\']);
        global hdfpwpstopa1b hdfpwpstopa1s hdfpwpstopa2b hdfpwpstopa2s hdfpwpexita1b hdfpwpexita1s
        global hdfpwpexita2b hdfpwpexita2s hdfpwpobjea1b hdfpwpobjea1s hdfpwpobjea2b hdfpwpobjea2s
        fpwrulevars=['hdfpwpstopa1b';'hdfpwpstopa1s';'hdfpwpstopa2b';
                     'hdfpwpstopa2s';'hdfpwpexita1b';'hdfpwpexita1s';
                     'hdfpwpexita2b';'hdfpwpexita2s';'hdfpwpobjea1b';
                     'hdfpwpobjea1s';'hdfpwpobjea2b';'hdfpwpobjea2s'];
        fpwrulefile=['fpwstopb8.m';'fpwstops8.m';'fpwstopb9.m';'fpwstops9.m';
                     'fpwexitb7.m';'fpwexits7.m';'fpwexitb8.m';'fpwexits8.m';
                     'fpwobjeb8.m';'fpwobjes8.m';'fpwobjeb9.m';'fpwobjes9.m'];             
        for i=1:12
          fid=fopen(fpwrulefile(i,:),'r');
          if fid~=(-1)
            j=1; linecodes='';
            while 1
              tline = fgetl(fid);
              if ~ischar(tline), break, end
              if j>3
                linecodes=[linecodes,sprintf([tline,'\n'])];
              end
              j=j+1;
            end
            fclose(fid);
            eval([fpwrulevars(i,:),'=linecodes;']);
          else
            eval([fpwrulevars(i,:),'=''This rule is not set up yet.'';']);        
          end
        end        
        cd([Wherematlab,'\pattern']);
        fpwmodelpat;
            
        if wsmultim==1
          fpwsimwindow=22;
          cd([Wherematlab,'\pattern']);
          fpwout1.fpwusername=fpwusername;
          fpwout1.fpwusername4=fpwusername4;
          fpwout1.fpwulvl=instruct.fpwulvl;  
          if mname=='F'
            fpwout1.MMFS='Future';
          else
            fpwout1.MMFS='Stock';             
          end
          fpwout1.MM12='No.1';
          fpwout1.outGOsm='UrSym';
          fpwout1.outAnyU='c(i-2)>=h(i-4)';
          fpwout1.outAnyD='0.05';
          fpwout1.outAnyS='10';          
          for i=1:108
            if i<=length(runnamelist)
                %<input type="checkbox" value="1" name="pS4">
              YLFN=upper(noempty(runnamelist{i}));
              stringtofill=sprintf(['<input type="checkbox" value="1" name="mrkT',num2str(i),'"><input style="width: 45px" type="button" name="',YLFN,...
              '" onmouseover="window.status=''To output the simulation results of this market.''" value="',YLFN,...
              '" onmouseout="window.status=''Done''" onclick="javascript: mfsForm.marketrun.value=''',YLFN,...
              '''; mfsForm.submit();">']); 
              eval(['fpwout1.mfs',num2str(i),'=stringtofill;']);
            else
              eval(['fpwout1.mfs',num2str(i),'='' '';']);              
            end
          end
          fpwout1.marketMXL=int2str(length(runnamelist));
        else
          if (statonly~=1)&(tradeh(1,1)~=0)
            cd([Wherematlab,'\pattern']);
            %fpwout.zhu52='1'; fpwout.zhu54='1'; 
            fpwout.outonoff='0';
            fpwout.fpwfilesource=[fpwptname,'-',fpwptname3];
            fpwout1=fpwozc3(fpwout);
            fpwsimwindow=21;
            fpwout1.fpwsource='fpwoutput';
            fpwout1.fpwusername=fpwusername;
            fpwout1.fpwusername4=fpwusername4;
            fpwout1.fpwulvl=instruct.fpwulvl;
            fpwout1.outrunindex='00';
            
            set(fpwout1.fpwoutfig,'PaperPosition',MyPaperPosiH);
            cd([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern']);
            drawnow;
            wsprintjpeg(fpwout1.fpwoutfig,'fpwoutjpeg.jpeg');
            close(fpwout1.fpwoutfig);
            cd([Wherematlab,'pattern']);
            fpwout1.fpwoutjpeg=[fpwclientdirectory,fpwusername,'\pattern\fpwoutjpeg.jpeg']; 
                     
            sfpw1.StatusReport=[' This is the simulation output of pattern ',upper(fpwptname),' on market ',upper(mname),'-',upper(name),'. ',time1];
            templatefile = which('MPsimulationR1.html');
            str = htmlrep(sfpw1, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\twbfpwoutputR1.html'],'noheader');      
            fpwout1.FPWoutstatus=strrep([fpwclientdirectory,fpwusername,'\pattern\twbfpwoutputR1.html'],'\','/');
          else
            if (tradeh(1,1)==0)
              fpwsimwindow=24;
              fpwout1.fpwusername=fpwusername;
              fpwout1.fpwusername4=fpwusername4;
              fpwout1.fpwulvl=instruct.fpwulvl;
              fpwout1.outrunindex='00';          
              %error(' - No trades for this pattern.');
            end
            if (statonly==1)
              fpwsimwindow=25;        
              % output statistics only.  This function is cancelled for web version.    
            end
          end
        end
      end    
          
      if strcmp(fpwrunindex,'21')
        % firstly find out the raw [stock datem]
        ToD=fpwchartspan(1);
        if ToD=='D'
          stock=stock(fpwchartft(1):fpwchartft(2),:);
          datem=datem(fpwchartft(1):fpwchartft(2),:);
          if fpwchartspan(2)=='W'
            datetemp=daynum1(datem(1,:));
            stocktemp=stock(1,:);
            stockNEW=[];datemNEW=[];
            for i=2:length(stock(:,1))
              WrNEW=daynum1(datem(i,:)); 
              if WrNEW>datetemp
                stocktemp=[stocktemp;stock(i,:)];
              else
                datemNEW=[datemNEW;datem(i-1,:)];
                stockNEW=[stockNEW;wsohlcv(stocktemp)];
                stocktemp=stock(i,:);
              end
              datetemp=WrNEW;
            end
            datemNEW=[datemNEW;datem(i,:)];
            stockNEW=[stockNEW;wsohlcv(stocktemp)];
            stock=stockNEW;datem=datemNEW;
            clear datemNEW stockNEW datetemp stocktemp i WrNEW
          elseif fpwchartspan(2)=='M'
            datetemp=datem(1,:);
            stocktemp=stock(1,:);
            stockNEW=[];datemNEW=[];
            for i=2:length(stock(:,1))
              if (datetemp(1)==datem(i,1))&(datetemp(3)==datem(i,3))
                stocktemp=[stocktemp;stock(i,:)];
              else
                datemNEW=[datemNEW;datem(i-1,:)];
                stockNEW=[stockNEW;wsohlcv(stocktemp)];
                datetemp=datem(i,:);
                stocktemp=stock(i,:);
              end
            end
            datemNEW=[datemNEW;datem(i,:)];
            stockNEW=[stockNEW;wsohlcv(stocktemp)];
            stock=stockNEW;datem=datemNEW;
            clear datemNEW stockNEW datetemp stocktemp i
          end   
        else
          tickind=str2num(fpwchartspan(2:3));
          edate=datem(fpwchartft(1),:); %date from the 'From' date
          howmanybartoquot=tickind/5*115;
          stocklongdata=0;
          if howmanybartoquot==115
            if upper(mname)=='F'
              if wsfsn24(['f',name])==0
                stock=wsgettdt(edate,2,20,['f',name],0);
              else
                stock=wsgettdt(edate,0,24,['f',name],0);
              end
            else
              if wsfsn24(['s',name])==0
                stock=wsgettdt(edate,2,20,['s',name],0);
              else
                stock=wsgettdt(edate,0,24,['s',name],0);
              end
              if length(stock)==0
                stock=stgetdaa(name,'t'); %,tickind/5*142);
                stocklongdata=1;    
                if length(stock)>0
                  fffff=find((stock(:,1)==edate(1))&(stock(:,2)==edate(2))&(stock(:,3)==edate(3)));
                  if length(fffff)>0
                    datemfroms=stock(fffff(1),1:3);                      
                    stock=stock(max([fffff(1)-30 1]):min([fffff(length(fffff))+30 length(stock(:,1))]),:);
                  else
                    stock=stock(1:min([tickind/5*142 length(stock(:,1))]),:); 
                    datemfroms=stock(1,1:3);
                  end    
                  datemends=stock(length(stock(:,1)),1:3);
                end          
              end              
            end
            if length(stock)>0
              datemt=[ones(2,3);[stock(:,4) stock(:,5) stock(:,2)]];
              stockt=[stock(1:2,6:10);stock(:,6:10)];
              datemt=[datemt 0*datemt(:,1)];
              stockt(:,5)=stockt(:,5)*1000;
            end 
          else
            if upper(mname)=='F'
              if wsfsn24(['f',name])==0
                stock=wsgettdn(edate,2,howmanybartoquot,['f',lower(name)],0);
              else
                stock=wsgettdn(edate,0,howmanybartoquot,['f',lower(name)],0);
              end
            else
              if wsfsn24(['s',name])==0
                stock=wsgettdn(edate,2,howmanybartoquot,['s',lower(name)],0);
              else
                stock=wsgettdn(edate,0,howmanybartoquot,['s',lower(name)],0);
              end
              if length(stock)==0
                stock=stgetdaa(name,'t'); %,tickind/5*142);
                stocklongdata=1;
                if length(stock)>0
                  fffff=find((stock(:,1)==edate(1))&(stock(:,2)==edate(2))&(stock(:,3)==edate(3)));
                  if length(fffff)>0
                    stock=stock(fffff(1):min([fffff(1)+tickind/5*142 length(stock(:,1))]),:);
                  else
                    stock=stock(1:min([tickind/5*142 length(stock(:,1))]),:); 
                  end                  
                  datemfroms=stock(1,1:3);    
                  datemends=stock(length(stock(:,1)),1:3);            
                end
              end              
            end
            if length(stock)>0
              stockt=[];datemt=[];indexf=1;
              for i=2:length(stock(:,1))  
                if (rem(stock(i,5),tickind)==0)
                  stockt=[stockt;wsohlcv(stock(indexf:i,6:10))];
                  datemt=[datemt;[stock(i,4) stock(i,5) stock(i,2)]];
                  indexf=i+1;
                else
                  if (stock(i-1,2)~=stock(i,2))&(indexf<i)
                    stockt=[stockt;wsohlcv(stock(indexf:i-1,6:10))];
                    datemt=[datemt;[stock(i-1,4) stock(i-1,5) stock(i-1,2)]];
                    indexf=i;
                  end
                end
              end
              datemt=[ones(2,3);datemt];
              stockt=[stockt(1:2,:);stockt];
              datemt=[datemt 0*datemt(:,1)];
              indexf=0;
              for i=4:length(datemt(:,1))
                if datemt(i,3)~=datemt(i-1,3)
                  indexf=indexf+1;
                end
                datemt(i,4)=indexf;
              end
              stockt(:,5)=stockt(:,5)*1000;
            end
          end
          if length(stock)==0
            if upper(mname)=='S'
              stock=stgetdaa(name,'t',tickind/5*115);
              if length(stock)>0
                datemt=[ones(2,3);stock(:,[4 5 2])];
                stockt=[stock(1:2,6:10);stock(:,6:10)];
                stockt(:,5)=stockt(:,5);
                datemt=[datemt 0*datemt(:,1)];
              else
                error(' Tick Data not Available for the symbol you entered.');
              end
            else 
              error(' Tick Data not Available for the symbol you entered.');        
            end
          end
          stock=stockt;
          datem=datemt;
        end
                 
        % figure output
        Fig1=figure('pos',[2 4 635/2 434/2],'color','k','visible','off');
        zhu27r=axes('position',[0.091 0.353 .89 .62]);
        zhu28r=axes('position',[0.091 0.061 .89 .25]);
        if ToD=='D'
          % wsrawz22
          subplot(zhu27r)
          hold off
          if length(stock(:,1))<149
            %wsbar(stock,datem);
            stock=[stock(1,:);stock];
            datem=[datem(1,:);datem];
            yrs=length(stock(:,1))-1;
            x=[1:yrs];
            closeh=stock(:,4);
            high=stock(:,2);
            low=stock(:,3);
            open=stock(:,1);
            vol=stock(:,5)/1000+.01;
            X1=1:yrs;
            X2=X1-.35;
            X3=X1+.35;
            X(1:yrs,1:2)=[X1' X1'];
            X4(1:yrs,1:2)=[X2' X1'];
            X5(1:yrs,1:2)=[X1' X3'];
            line(1:yrs,1:2)=[low(2:yrs+1) high(2:yrs+1)];
            line1(1:yrs,1:2)=[closeh(2:yrs+1) closeh(2:yrs+1)];
            line2(1:yrs,1:2)=[open(2:yrs+1) open(2:yrs+1)];
            plot(x(1),closeh(2),'k');hold on;
            for I=1:yrs
              if (dn(datem(I+1,:))~=5)|(fpwchartspan(2)~='D')
                intradayc='g';
                if (fpwchartspan(2)=='W')
                  if weekfd(datem(I+1,:),1)==1
                    intradayc='w';   
                  else
                    intradayc='g';               
                  end
                elseif (fpwchartspan(2)=='M')
                  if datem(I,3)~=datem(I+1,3)
                    intradayc='w';   
                  else
                    intradayc='g';               
                  end
                end
              else
                intradayc='w';        
              end           
              plot(X(I,:),line(I,:),intradayc,'linewidth',.125);
              plot(X4(I,:),line2(I,:),intradayc,'linewidth',.125)
              plot(X5(I,:),line1(I,:),intradayc,'linewidth',.125)    
            end            
            datem(1:length(datem(:,1))-1,:)=datem(2:length(datem(:,1)),:);
            chgst93(datem);
          else
            plot(stock(:,4),'g');
            chgst93(datem);
          end
          ylabel('price');
          grid; set(gca,'Xcolor',[0.5 0.5 0.5]);
          set(gca,'Ycolor',[0.5 0.5 0.5]);          
              
          subplot(zhu28r)
          hold off
          vol=stock(:,5)+.0001;
          ylabelunit=0;
          if max(vol/1000)>100
            vol=vol/100; ylabelunit=1;
          end            
          if length(stock(:,1))<149
            barg(([vol(2:length(vol))])/1000);
            chgst93(datem);
          else
            dys=length(vol);  
            hold off
            if length(vol)<300
              X1=1:dys;
              X(1:dys,1:2)=[X1' X1'];
              line(1:dys,1:2)=[0*vol vol/1000];
              avg=fix(mean(vol(1:dys)))/1000;
              plot(1:dys,avg*ones(1,dys),'-y');
              hold on;
              avg=ma(vol(1:dys),20)/1000;
              plot(20:dys,avg(20:dys),'-w');
              for I=1:dys
                plot(X(I,:),line(I,:),'-g');
              end
              hold off
            else
              plot(vol/1000,'g');
            end
            chgst93(datem);      
          end
          %if mname=='F'
          %  ylabel('Vol in k')
          %else
          %  ylabel('Vol in 100k')
          %end
          if ylabelunit==0
            ylabel('Vol in 100K');
          else
            ylabel('Vol in 10M');
            vol=vol*100;
          end          
          grid; set(gca,'Xcolor',[0.5 0.5 0.5]);
          set(gca,'Ycolor',[0.5 0.5 0.5]);          
          hold off
        else
          % wsrawzt1
          subplot(zhu27r)
          hold off
          if length(stock(:,1))<149*2
            %wsbart1(stock,datem,tTry);
            yrs=length(stock(:,1))-1;
            stock(1:yrs,:)=stock(2:yrs+1,:);
            x=[1:yrs];
            closeh=stock(:,4); high=stock(:,2); low=stock(:,3);
            open=stock(:,1); vol=stock(:,5)/1000+.01;
            X1=1:yrs; X2=X1-.35; X3=X1+.35;
            X(1:yrs,1:2)=[X1' X1']; X4(1:yrs,1:2)=[X2' X1']; X5(1:yrs,1:2)=[X1' X3'];
            line(1:yrs,1:2)=[low(2:yrs+1) high(2:yrs+1)];
            line1(1:yrs,1:2)=[closeh(2:yrs+1) closeh(2:yrs+1)];
            line2(1:yrs,1:2)=[open(2:yrs+1) open(2:yrs+1)];
            plot(x(1),closeh(2),'k');hold on;
            intradayc='g';daychangep=1;
            if tickind==5
              numbercolumn=1; 
            else
              numbercolumn=4; 
            end
            for I=1:yrs-1
              if datem(I+1,3)~=datem(I+2,3); daychangep=I; end
              if (datem(I+1,numbercolumn)~=datem(max([1 I+2]),numbercolumn))&(I>1)
                intradayc='w';        
              else
                intradayc='g';        
              end           
              plot(X(I,:),line(I,:),intradayc,'linewidth',.125);
              plot(X4(I,:),line2(I,:),intradayc,'linewidth',.125)
              plot(X5(I,:),line1(I,:),intradayc,'linewidth',.125)    
            end             
            datem(1:length(datem(:,1))-1,:)=datem(2:length(datem(:,1)),:);
            datem(1:length(datem(:,1))-1,:)=datem(2:length(datem(:,1)),:);
            chgstt1(datem);
          else    
            plot(stock(:,4),'g');chgstt1(datem)
          end
          ylabel('price');
          grid; set(gca,'Xcolor',[0.5 0.5 0.5]);
          set(gca,'Ycolor',[0.5 0.5 0.5]);          
          
          subplot(zhu28r)
          hold off
          vol=stock(:,5)+.0001;
          ylabelunit=0;
          if max(vol/1000)>100
            vol=vol/100; ylabelunit=1;
          end          
          if length(stock(:,1))<149*2
            if upper(mname)=='F'
              axis([0 length(vol) 0 1.1*max(vol/10000)]);
              barg(([vol(3:length(vol))])/10000);
            else
              axis([0 length(vol) 0 1.1*max(vol/1000)]);
              barg(([vol(3:length(vol))])/1000);
            end
            hold off
          else
            dys=length(vol);  
            hold off
            if length(vol)<500
              X1=1:dys;
              X(1:dys,1:2)=[X1' X1'];
              if upper(mname)=='F'
                line(1:dys,1:2)=[0*vol vol/10000];
                axis([0 dys 0 1.1*max(vol/10000)]);
                avg=fix(mean(vol(1:dys)))/10000;
              else
                line(1:dys,1:2)=[0*vol vol/1000];
                axis([0 dys 0 1.1*max(vol/1000)]);
                avg=fix(mean(vol(1:dys)))/1000;
              end
              plot(1:dys,avg*ones(1,dys),'-w');
              if upper(mname)=='F'
                avg=ma(vol(1:dys),20)/10000; 
              else
                avg=ma(vol(1:dys),20)/1000;
              end
              plot(20:dys,avg(20:dys),'-w');
              hold on;
              for I=1:dys
                plot(X(I,:),line(I,:),'-g');
              end
              hold off
            else
              hold off   
              if upper(mname)=='F'
                plot(vol/10000,'g');  
              else
                plot(vol/1000,'g');
              end
              hold on
            end
          end
          chgstt1(datem);
          if ylabelunit==0
            ylabel('Vol in K');
          else
            ylabel('Vol in 100K');
            vol=vol*100;
          end          
          grid; set(gca,'Xcolor',[0.5 0.5 0.5]);
          set(gca,'Ycolor',[0.5 0.5 0.5]);          
        end
        set(zhu27r,'color',get(gcf,'color'));
        set(zhu28r,'color',get(gcf,'color'));
            
        xlo=get(zhu27r,'Xtick');
        for i=1:length(xlo);
          xln(i)=' ';    
        end
        set(zhu27r,'XTickLabel',xln);
           
        %set(zhu27r,'ycolor','w');
        %set(zhu28r,'xcolor','w');
        %set(zhu28r,'ycolor','w');  
        set(Fig1,'inverthardcopy','off'); hold off
        set(Fig1,'PaperPosition',[.25 .25 4.75 3.2]);
        cd([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern']);
        drawnow;
        wsprintjpeg(Fig1,'fpwjpeg.jpeg');
        fpwsimwindow=2;
      end
               
      if ~strcmp(fpwrunindex,'11')
        % prepare to output back
        sfpw.ESOchosen=ESOchosen; sfpw.fpwpttype=fpwpttype; sfpw.fpwptfilef=fpwptfilef; sfpw.zhu45s=zhu45s; 
        sfpw.fpwexfilef=fpwexfilef; sfpw.fpwstfilef=fpwstfilef; sfpw.fpwobfilef=fpwobfilef; 
        sfpw.fpwptname=fpwptname; sfpw.fpwptname2=fpwptname2; sfpw.fpwptname3=fpwptname3; sfpw.fpwrunindex=fpwrunindex;
                   
        sfpw.zhu52=zhu52; sfpw.zhu54=zhu54; sfpw.zhuyun=zhuyun; sfpw.zhu75=zhu75; sfpw.PBKE=PBKE; sfpw.zhusm=zhusm; sfpw.fpwaddnoise=fpwaddnoise;
        sfpw.zhu712=zhu712; sfpw.zhu713=zhu713; sfpw.zhu722=zhu722; sfpw.zhu723=zhu723; sfpw.zhu732=zhu732; sfpw.zhu733=zhu733; 
        sfpw.zhu742=zhu742; sfpw.zhu743=zhu743; sfpw.ent01=fpwticv(zhu26); sfpw.ent02=ent02; sfpw.ent03=ent03; sfpw.marent03=marent03;
         
        sfpw.zhu04s=zhu04s; sfpw.zhu200=zhu200; sfpw.zhu61=zhu61; sfpw.zhu62=zhu62; sfpw.zhu63=zhu63; sfpw.zhu64=zhu64; sfpw.zhu65=zhu65; 
        sfpw.zhu65new=zhu65new; sfpw.zhu66=zhu66; sfpw.zhu67=zhu67; sfpw.zhu67new=zhu67new; sfpw.zhu68=zhu68; sfpw.new301=new301;
        sfpw.new302=new302; sfpw.new303=new303; sfpw.new304=new304; sfpw.new305=new305; sfpw.new306=new306;
        sfpw.new401=new401; sfpw.new402=new402; sfpw.new403=new403; sfpw.new404=new404;
        
        sfpw.zhu81=zhu81; sfpw.zhu82=zhu82; sfpw.zhu83=zhu83; sfpw.zhu84=zhu84; sfpw.zhu85=zhu85; sfpw.zhu86=zhu86; sfpw.zhu87=zhu87; 
        sfpw.zhu88=zhu88; sfpw.zhu89=zhu89; sfpw.zhu59=zhu59; sfpw.tkdv=tkdv; sfpw.zhu17l=zhu17l; 
        
        sfpw.zhu91=zhu91; sfpw.zhu92=zhu92; sfpw.zhu93=zhu93; sfpw.zhu94=zhu94; sfpw.zhu95=zhu95; sfpw.zhu96=zhu96; sfpw.zhu97=zhu97; 
        sfpw.zhu22l=zhu22l; sfpw.zhu24l=zhu24l; sfpw.obje2nd=obje2nd;  sfpw.zhu98=zhu98;
        
        sfpw.zhu99=zhu99; sfpw.zhu26=upper(zhu26); sfpw.zhu101=upper(zhu101); 
        sfpw.zhu1013=upper(zhu1013); sfpw.zhu1014=upper(zhu1014); sfpw.zhu1015=upper(zhu1015); 
        
        % to generate the drop-down menu's market list for multi-market rules manager
        
        if fpwCPALh>3
          if zhu99=='F'
            if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\listorunf.mat'])==2
              eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\listorunf']);
            else
              listorun{1}='SP';
              listorun{2}='US';
              sfpwhere.StatusReport = ['You still did not choose markets list yet. ',time1];
              templatefile = which('MPsimulationR1.html');
              str = htmlrep(sfpwhere, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\twbfpwinputR1.html'],'noheader'); 
            end
          else
            if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\listoruns.mat'])==2
              eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\listoruns']);
            else
              listorun{1}='GE';
              listorun{2}='MSFT';
              sfpwhere.StatusReport = ['You still did not choose markets list yet. ',time1];
              templatefile = which('MPsimulationR1.html');
              str = htmlrep(sfpwhere, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\twbfpwinputR1.html'],'noheader');          
            end      
          end
        else
          if zhu99=='F'
            listorun{1}='SP';
            listorun{2}='US';          
          else
            listorun{1}='GE';
            listorun{2}='MSFT';
          end
        end
        sfpw.MRlist='';
        sfpw.MRlist=[sfpw.MRlist,sprintf('<select size="1" name="fpwmrlist" onmouseover="window.status=''For MM simulation only, the market list you chose most recently.''" onmouseout="window.status=''Done''">')];      
        thisnamene=noempty(listorun{1});
        thisnamele=length(noempty(listorun{1}));
        sfpw.MRlist=[sfpw.MRlist,sprintf(['<option selected value="%',num2str(thisnamele),'s">%',num2str(thisnamele),'s</option>'],thisnamene,thisnamene)];
        if length(listorun)>1
          for i=2:length(listorun)
            thisnamene=noempty(listorun{i});
            thisnamele=length(noempty(listorun{i}));
            sfpw.MRlist=[sfpw.MRlist,sprintf(['<option value="%',num2str(thisnamele),'s">%',num2str(thisnamele),'s</option>'],thisnamene,thisnamene)];
          end
        end
        sfpw.MRlist=[sfpw.MRlist,sprintf('</select>')]; sfpw.fpwmrlist=upper(noempty(listorun{1}));
        
        sfpw.fpwusername=fpwusername;
        sfpw.fpwusername4=fpwusername4;
        sfpw.fpwulvl=instruct.fpwulvl;
        sfpw.FirstorS='1';
        sfpw.fpwFdate=date2str(Datem(fpwchartft(1),:));
        sfpw.fpwTdate=date2str(Datem(fpwchartft(2),:));
        sfpw.fpwchartspan=fpwchartspan; 
        datestringout=[];
        for i=1:length(Datem(:,1))
          datestringout=[datestringout,sprintf('%02d%02d%02d',Datem(i,1:3))];
        end
        sfpw.fpwchartdatem=datestringout;
        sfpw.fpwfindex=num2str(fpwchartft(1));
        sfpw.fpwtindex=num2str(fpwchartft(2));
        sfpw.fpwMXI=num2str(length(Datem(:,1)));  
        sfpw.ProgressM=strrep([fpwclientdirectory,fpwusername,'\pattern\twbduringrun.html'],'\','/');
        sfpw.FPWsrsource=strrep([fpwclientdirectory,fpwusername,'\pattern\twbfpwinputR1.html'],'\','/');
        sfpw.fpwjpeg=[fpwclientdirectory,fpwusername,'\pattern\fpwjpeg.jpeg'];  
        
        sfpw.hdfpwptfilefb=frontfpwb;
        sfpw.hdfpwptfilefs=frontfpws;
        sfpw.hdfpwexfilefb=frontfpwexb;
        sfpw.hdfpwexfilefs=frontfpwexs;
        sfpw.hdfpwstfilefb=frontfpwstb;
        sfpw.hdfpwstfilefs=frontfpwsts;
        sfpw.hdfpwobfilefb=frontfpwobb;
        sfpw.hdfpwobfilefs=frontfpwobs;
        cd([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\']);
        fpwrulevars=['sfpw.hdfpwpstopa1b';'sfpw.hdfpwpstopa1s';'sfpw.hdfpwpstopa2b';
                     'sfpw.hdfpwpstopa2s';'sfpw.hdfpwpexita1b';'sfpw.hdfpwpexita1s';
                     'sfpw.hdfpwpexita2b';'sfpw.hdfpwpexita2s';'sfpw.hdfpwpobjea1b';
                     'sfpw.hdfpwpobjea1s';'sfpw.hdfpwpobjea2b';'sfpw.hdfpwpobjea2s'];
        fpwrulefile=['fpwstopb8.m';'fpwstops8.m';'fpwstopb9.m';'fpwstops9.m';
                     'fpwexitb7.m';'fpwexits7.m';'fpwexitb8.m';'fpwexits8.m';
                     'fpwobjeb8.m';'fpwobjes8.m';'fpwobjeb9.m';'fpwobjes9.m'];             
        for i=1:12
          fid=fopen(fpwrulefile(i,:),'r');
          if fid~=(-1)
            j=1; linecodes='';
            while 1
              tline = fgetl(fid);
              if ~ischar(tline), break, end
              if j>3
                linecodes=[linecodes,sprintf([tline,'\n'])];
              end
              j=j+1;
            end
            fclose(fid);
            eval([fpwrulevars(i,:),'=linecodes;']);
          else
            eval([fpwrulevars(i,:),'=''This rule is not set up yet.'';']);        
          end
        end
        %eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\wbfpwinput sfpw']);
      end
                
      if strcmp(fpwrunindex,'31')
        if strcmp(zhu712,'Exit')
          FPWMPfiletoopen = [fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\',filetypeid,'ee*.m'];
        elseif strcmp(zhu712,'Stop')
          FPWMPfiletoopen = [fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\',filetypeid,'ss*.m'];
        elseif strcmp(zhu712,'Obje')
          FPWMPfiletoopen = [fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\',filetypeid,'oo*.m'];
        end   
        a=dir(FPWMPfiletoopen);
        b=[];
        if length(a)>0
          for i=1:length(a)  
            filenametested=a(i).name;
            if length(filenametested)==11
              if upper(filenametested(8))==upper(zhu45s)
                b=[b i];
              end
            end
          end            
        end
        if length(b)>0
          a=a(b);
          outputtext={};
          filesinaline=4;
          for i=1:length(a)
            outputtext{fix((i-1)/filesinaline)+1,rem(i-1,filesinaline)+1}=upper(a(i).name(4:length(a(i).name)-2));
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
        outstruct.FDfiletypeid=[filetypeid,zhu712(1),'A',zhu713];
        cd(fpwserverplace);
        templatefile = which('MPopenfile1R.html');
        str = htmlrep(outstruct, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\tMPopenfile1R.html'],'noheader');
        outstruct.MPloadreport=[fpwclientdirectory,fpwusername,'\pattern\tMPopenfile1R.html'];
        fpwsimwindow=3;
      end  
                   
      if strcmp(fpwrunindex,'41')
        FPWMPfiletoopen = [fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\userip\',filetypeid,zhu45s,'*.mat'];
        a=dir(FPWMPfiletoopen);
        outputtext={};
        filesinaline=4;
        if length(a)>0
          for i=1:length(a)
            outputtext{fix((i-1)/filesinaline)+1,rem(i-1,filesinaline)+1}=a(i).name(5:length(a(i).name)-4);
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
        outstruct.FDfiletypeid=[filetypeid,zhu45s,'P'];
        cd(fpwserverplace);
        templatefile = which('MPopenfile1R.html');
        str = htmlrep(outstruct, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\tMPopenfile1R.html'],'noheader');
        outstruct.MPloadreport=[fpwclientdirectory,fpwusername,'\pattern\tMPopenfile1R.html'];
        fpwsimwindow=3;
      end
      
      if strcmp(fpwrunindex,'51')
        % market name
        fpwmrfsname=[zhu99,instruct.fpwmrlist];
        % Enter
        fpwmr.ESOchosen=ESOchosen; fpwmr.zhu52=zhu52; fpwmr.zhu54=zhu54; fpwmr.zhu75=zhu75; fpwmr.PBKE=PBKE; 
        fpwmr.ent01=ent01; fpwmr.ent02=ent02; fpwmr.ent03=ent03; fpwmr.marent03=marent03; fpwmr.fpwaddnoise=fpwaddnoise;
        % Stop
        fpwmr.zhu81=zhu81; fpwmr.zhu82=zhu82; fpwmr.zhu83=zhu83; fpwmr.zhu84=zhu84; fpwmr.zhu85=zhu85; fpwmr.zhu86=zhu86; fpwmr.zhu87=zhu87; 
        fpwmr.zhu88=zhu88; fpwmr.zhu89=zhu89; fpwmr.zhu59=zhu59; fpwmr.tkdv=tkdv; fpwmr.zhu17l=zhu17l; 
        % new added
        fpwmr.new301=new301; fpwmr.new302=new302; fpwmr.new303=new303; fpwmr.new304=new304; fpwmr.new305=new305; fpwmr.new306=new306;
        fpwmr.new401=new401; fpwmr.new402=new402; fpwmr.new403=new403; fpwmr.new404=new404;      
        fpwmr.zhu722=zhu722; fpwmr.zhu723=zhu723; fpwmr.zhu732=zhu732; fpwmr.zhu733=zhu733; fpwmr.zhu742=zhu742; fpwmr.zhu743=zhu743; 
        % Exit
        fpwmr.zhu04s=zhu04s; fpwmr.zhu200=zhu200; fpwmr.zhu61=zhu61; fpwmr.zhu62=zhu62; fpwmr.zhu63=zhu63; fpwmr.zhu64=zhu64; fpwmr.zhu65=zhu65; 
        fpwmr.zhu65new=zhu65new; fpwmr.zhu66=zhu66; fpwmr.zhu67=zhu67; fpwmr.zhu67new=zhu67new; fpwmr.zhu68=zhu68; 
        % Objective
        fpwmr.zhu91=zhu91; fpwmr.zhu92=zhu92; fpwmr.zhu93=zhu93; fpwmr.zhu94=zhu94; fpwmr.zhu95=zhu95; fpwmr.zhu96=zhu96; fpwmr.zhu97=zhu97; 
        fpwmr.zhu22l=zhu22l; fpwmr.zhu24l=zhu24l; fpwmr.obje2nd=obje2nd;  fpwmr.zhu98=zhu98;
        % markets
        fpwmr.zhu101=zhu101; fpwmr.zhu1013=zhu1013; fpwmr.zhu1014=zhu1014; fpwmr.zhu1015=zhu1015;    
        fpwmr.fpwexfilef=fpwexfilef; fpwmr.fpwstfilef=fpwstfilef; fpwmr.fpwobfilef=fpwobfilef;
        eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data4\fpwmr',fpwmrfsname,' fpwmr']);
        sfpw.StatusReport = ['Managing rules saved for ',upper(zhu99),'-',upper(instruct.fpwmrlist),' successfully. ',time1];
        fpwsimwindow=1;
      end  
        
      if strcmp(fpwrunindex,'61')
        fileerrorh=0;        
        if fpwpttype=='P'
          if(~length(noempty(fpwptname)))
            sfpw.StatusReport = ['Entered an empty file name, nothing done. ',time1];          
          else
            if (exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\userip\',filetypeid,fpwptname2,noempty(fpwptname),fpwptname3,'.mat'])==2)&...
              (strcmp(upper(fpwusername),'AARONZHU')~=1)&(strcmp(sfpw.new304,'999')~=1)
              fpwhfileoriginal=[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\userip\',filetypeid,fpwptname2,noempty(fpwptname),fpwptname3,'.mat'];
              fpwhfilebackuped=[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\userip\',filetypeid,fpwptname2,noempty(fpwptname),'BK',fpwptname3,'.mat'];
              wbfpwbackupmatfile(fpwhfileoriginal,fpwhfilebackuped);
              sfpw.StatusReport = ['Data saved to ',upper([filetypeid,fpwptname2,noempty(fpwptname),fpwptname3]),'.MAT successfully. ',time1,', *BK'];
              eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\userip\',filetypeid,fpwptname2,noempty(fpwptname),fpwptname3,' sfpw']);
            else
              sfpw.StatusReport = ['Data saved to ',upper([filetypeid,fpwptname2,noempty(fpwptname),fpwptname3]),'.MAT successfully. ',time1];
              eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\userip\',filetypeid,fpwptname2,noempty(fpwptname),fpwptname3,' sfpw']);
            end
          end
        else
          if length(noempty(fpwptname))~=4
            fileerrorh=1;
            sfpw.StatusReport=' FPW Rule file name is a 4 letters string: Stop, Exit, Obje, SSxx, EExx, or OOxx.';    
          else
            fpwptname=noempty(fpwptname); fpwptname=lower(fpwptname(1:4));
            if length(strfind(fpwptname,'stop'))+length(strfind(fpwptname,'exit'))+length(strfind(fpwptname,'obje'))+...
              length(strfind(fpwptname,'ee'))+length(strfind(fpwptname,'ss'))+length(strfind(fpwptname,'oo'))<1
              sfpw.StatusReport=' F FPW Rule file name is a 4 letters string: Stop, Exit, Obje, SSxx, EExx, or OOxx.'; 
              fileerrorh=1;
            else
              if strcmp(upper(fpwptname),'EXIT')
                if (str2num(fpwptname3)>8)|(str2num(fpwptname3)<7)
                  sfpw.StatusReport=' To save customerized exit rules, one can use only ''7'' or ''8''.';  
                  fileerrorh=1;                
                end
              elseif strcmp(upper(fpwptname),'STOP')
                if (str2num(fpwptname3)>9)|(str2num(fpwptname3)<8)
                  sfpw.StatusReport=' To save customerized stop rules, one can use only ''8'' or ''9''.';  
                  fileerrorh=1;                
                end
              elseif strcmp(upper(fpwptname),'OBJE')
                if (str2num(fpwptname3)>9)|(str2num(fpwptname3)<8)
                  sfpw.StatusReport=' To save customerized objective rules, one can use only ''8'' or ''9''.';  
                  fileerrorh=1;                
                end
              end
              if fileerrorh==0
                filenametw=[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\',filetypeid,fpwptname,fpwptname2,fpwptname3,'.m'];
                fid=fopen(filenametw,'wt');
                fprintf(fid,[' function y=',filetypeid,fpwptname,fpwptname2,fpwptname3,'(stock,i,enp,enw)\n']);
                fprintf(fid,' o=stock(:,1);h=stock(:,2);l=stock(:,3);c=stock(:,4);v=stock(:,5);\n');
                fprintf(fid,' global intra sl5 riskd commission tickstep stk dam ycp trendv fdctime wstime sj lotshis MiMi MiMi2 MiMi3 MiMi4 ltdss lcps ltpd tradeh brkl brks bkei stl sts obl obs tot totc wspt stk3 dam3 stk4 dam4 stk5 dam5\n');
                fprintf(fid,' global sl5 riskd commission tickstep stk dam trendv fdctime wstime sj lotshis MiMi MiMi2 MiMi3 MiMi4 ltdss lcps ltpd tradeh stl sts obl obs tot totc wspt MyOT MyCT PatSeed PatWeight MyPat\n');
                fprintf(fid,' global wsgp wsgp1 wsgp2 wsgp3 wsgp4 wsmh MyNexti exitpai stoppai objepai endi TExit TStop TObje wsgf wsgf1 wspc wspo wspo1; wspo=''; wspo1=''; wsgf=''; wsgf1=''; wsgp4=[stock sj]; wstd350g;\n');
                fprintf(fid,fpwptfilef);
                fclose(fid);
                clear fid
                sfpw.StatusReport = ['Data saved to ',upper([filetypeid,fpwptname,fpwptname2,fpwptname3]),'.M successfully. ',time1];
              end    
            end
          end
        end
        fpwsimwindow=1;
      end
               
      if strcmp(fpwrunindex,'71')
        % market name
        fpwmrfsname=[zhu99,instruct.fpwmrlist];
        if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data4\fpwmr',fpwmrfsname,'.mat'])==2
          eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data4\fpwmr',fpwmrfsname]);
          % Enter
          sfpw.ESOchosen=fpwmr.ESOchosen; sfpw.zhu52=fpwmr.zhu52; sfpw.zhu54=fpwmr.zhu54; sfpw.zhu75=fpwmr.zhu75; sfpw.PBKE=fpwmr.PBKE; 
          sfpw.ent01=fpwmr.ent01; sfpw.ent02=fpwmr.ent02; sfpw.ent03=fpwmr.ent03; sfpw.marent03=fpwmr.marent03; sfpw.fpwaddnoise=fpwmr.fpwaddnoise;
          % Stop
          sfpw.zhu81=fpwmr.zhu81; sfpw.zhu82=fpwmr.zhu82; sfpw.zhu83=fpwmr.zhu83; sfpw.zhu84=fpwmr.zhu84; sfpw.zhu85=fpwmr.zhu85; sfpw.zhu86=fpwmr.zhu86; sfpw.zhu87=fpwmr.zhu87; 
          sfpw.zhu88=fpwmr.zhu88; sfpw.zhu89=fpwmr.zhu89; sfpw.zhu59=fpwmr.zhu59; sfpw.tkdv=fpwmr.tkdv; sfpw.zhu17l=fpwmr.zhu17l; 
          % new added
          sfpw.new301=fpwmr.new301; sfpw.new302=fpwmr.new302; sfpw.new303=fpwmr.new303; sfpw.new304=fpwmr.new304; sfpw.new305=fpwmr.new305; sfpw.new306=fpwmr.new306;
          sfpw.new401=fpwmr.new401; sfpw.new402=fpwmr.new402; sfpw.new403=fpwmr.new403; sfpw.new404=fpwmr.new404;      
          sfpw.zhu722=fpwmr.zhu722; sfpw.zhu723=fpwmr.zhu723; sfpw.zhu732=fpwmr.zhu732; sfpw.zhu733=fpwmr.zhu733; sfpw.zhu742=fpwmr.zhu742; sfpw.zhu743=fpwmr.zhu743; 
          % Exit
          sfpw.zhu04s=fpwmr.zhu04s; sfpw.zhu200=fpwmr.zhu200; sfpw.zhu61=fpwmr.zhu61; sfpw.zhu62=fpwmr.zhu62; sfpw.zhu63=fpwmr.zhu63; sfpw.zhu64=fpwmr.zhu64; sfpw.zhu65=fpwmr.zhu65; 
          sfpw.zhu65neew=fpwmr.zhu65new; sfpw.zhu66=fpwmr.zhu66; sfpw.zhu67=fpwmr.zhu67; sfpw.zhu67new=fpwmr.zhu67new; sfpw.zhu68=fpwmr.zhu68; 
          % Objective
          sfpw.zhu91=fpwmr.zhu91; sfpw.zhu92=fpwmr.zhu92; sfpw.zhu93=fpwmr.zhu93; sfpw.zhu94=fpwmr.zhu94; sfpw.zhu95=fpwmr.zhu95; sfpw.zhu96=fpwmr.zhu96; sfpw.zhu97=fpwmr.zhu97; 
          sfpw.zhu22l=fpwmr.zhu22l; sfpw.zhu24l=fpwmr.zhu24l; sfpw.obje2nd=fpwmr.obje2nd;  sfpw.zhu98=fpwmr.zhu98;
          % markets
          sfpw.zhu101=fpwmr.zhu101; sfpw.zhu1013=fpwmr.zhu1013; sfpw.zhu1014=fpwmr.zhu1014; sfpw.zhu1015=fpwmr.zhu1015;
          sfpwhere.StatusReport = ['Showing Managing rules for ',upper(zhu99),'-',upper(instruct.fpwmrlist),'. ',time1];
        else    
          sfpwhere.StatusReport = ['Managing rules for ',upper(fpwmrfsname),' not existed yet. ',time1];
        end
        sfpw.fpwmrlist=instruct.fpwmrlist;
        templatefile = which('MPsimulationR1.html');
        str = htmlrep(sfpwhere, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\twbfpwinputR1.html'],'noheader');      
        fpwsimwindow=2;
      end  
             
      if (strcmp(fpwrunindex,'81'))|(strcmp(fpwrunindex,'82'))
        if fpwpttype=='P'
          FPWMPfiletoopen = [fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\userip\',filetypeid,fpwptname2,'*.mat'];
          a=dir(FPWMPfiletoopen);
          outputtext={};
          filesinaline=4;
          if length(a)>0
            for i=1:length(a)
              outputtext{fix((i-1)/filesinaline)+1,rem(i-1,filesinaline)+1}=upper(a(i).name(5:length(a(i).name)-4));
            end
            if ((rem(i-1,filesinaline)+1)~=filesinaline)&(fix((i-1)/filesinaline)>0)
              for j=rem(i-1,filesinaline)+2:filesinaline
                outputtext{fix((i-1)/filesinaline)+1,j}='';
              end
            end
          else
            outputtext{1}='No available file.';
          end
        else
          FPWMPfiletoopen = [fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\',filetypeid,'*.m'];
          a=dir(FPWMPfiletoopen);
          b=[];
          if length(a)>0
            for i=1:length(a)  
              filenametested=a(i).name;
              if length(filenametested)==11
                if upper(filenametested(8))==upper(fpwptname2)
                  b=[b i];
                end
              end
            end            
          end
          if length(b)>0
            a=a(b);
            outputtext={};
            filesinaline=4;
            for i=1:length(a)
              outputtext{fix((i-1)/filesinaline)+1,rem(i-1,filesinaline)+1}=upper(a(i).name(4:length(a(i).name)-2));
            end
            if ((rem(i-1,filesinaline)+1)~=filesinaline)&(fix((i-1)/filesinaline)>0)
              for j=rem(i-1,filesinaline)+2:filesinaline
                outputtext{fix((i-1)/filesinaline)+1,j}='';
              end
            end
          else
            outputtext{1}='No available file.';
          end
        end  
          
        outstruct.MPfiletoshow=outputtext;
        outstruct.FDfpwusername=fpwusername;
        outstruct.FDfpwusername4=fpwusername4;
        outstruct.fpwulvl=instruct.fpwulvl;
        cd(fpwserverplace);
        templatefile = which('MPopenfile1R.html');
        str = htmlrep(outstruct, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\tMPopenfile1R.html'],'noheader');
        outstruct.MPloadreport=[fpwclientdirectory,fpwusername,'\pattern\tMPopenfile1R.html'];        
        if (strcmp(fpwrunindex,'81'))
          outstruct.FDfiletypeid=[filetypeid,fpwptname2,fpwpttype];
          fpwsimwindow=3;
        elseif (strcmp(fpwrunindex,'82'))
          outstruct.FDfiletypeid=[filetypeid,fpwptname2,'D',fpwpttype];
          fpwsimwindow=8;          
        end
      end    
              
      if strcmp(fpwrunindex,'91')
        if instruct.hdzhu99=='F'
          if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\wbfpwsimuf.mat'])==2
            eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\wbfpwsimuf']);
          else
            s.fpwfmchosen=['100001000001000000100000000010000000100000'];
            stocklist=['sp';'us';'ed';'ty';'fy';'  ';'dx';'jy';'ec';'bp';'sf';'cd';'cl';'ho';'ng';'hu';'  ';'  ';'gc';'si';'za';'zc';'zn';
                'pl';'c ';'w ';'s ';'sm';'bo';'  ';'lc';'lh';'pb';'dj';'nd';'  ';'sb';'kc';'cc';'ct';'  ';'  '];
            for i=1:42
              eval(['s.fpwfmn',num2str(i+10),'s=upper(stocklist(i,:));']);
            end
          end
          s.fpwfmtype='F';
          fpwsimwindow=11;      
        else
          if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\wbfpwsimus.mat'])==2
            eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\wbfpwsimus']);
          else
            s.fpwsmchosen='000010000001000000001000000000001000000010000100000000100000001000100001000000010000001000000000010000000000'; 
            stocklist=['dell';'csco';'intc';'msft';'hpq ';'yhoo';'orcl';'amat';'c   ';'cien';'sunw';'cd  ';'psft';'lu  ';
                       'nt  ';'dis ';'t   ';'aol ';'ge  ';'jpm ';'aapl';'amzn';'ibm ';'bac ';'mu  ';'g   ';'ba  ';'pfe ';
                       'pep ';'hd  ';'ko  ';'mer ';'wmt ';'xon ';'mrk ';'slb ';'spls';'amgn';'mtc ';'dd  ';'sbc ';'emc ';
                       'lly ';'bmy ';'txn ';'f   ';'gm  ';'gd  ';'mwd ';'hal ';'ftu ';'fnm ';'one ';'ca  ';'pg  ';'rd  ';
                       'mot ';'aig ';'klac';'jnj ';'ups ';'fdx ';'bhi ';'amd ';'mcd ';'abt ';'axp ';'umg ';'col ';'tyc ';
                       'spy ';'qqq ';'dia ';'bgen';'fore';'sebl';'lfc ';'chn ';'neng';'erts';'bel ';'fdc ';'hrc ';'novl';
                       'chv ';'all ';'cost';'hi  ';'rn  ';'afs ';'txu ';'nsm ';'thc ';'cdn ';'ait ';'glm ';'low ';'usb ';
                       'unh ';'amr ';'ual ';'cat ';'bls ';'eds ';'nem ';'gps ';'ek  ';'xrx '];
            for i=1:108
              eval(['s.fpwsmn',num2str(i+10),'s=upper(noempty(stocklist(i,:)));']);
            end
          end
          s.fpwfmtype='S';
          fpwsimwindow=12;      
        end
        s.fpwusername=fpwusername; 
        s.fpwusername4=fpwusername4;
      end
       
      if ~strcmp(fpwrunindex,'11')
        eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\wbfpwinput sfpw']);
      end
      
    else
        
      if mname=='F'
        s.StatusReport = ['No data for future: ',upper(name) ,'. Check your symbol. ',time1];
      else
        s.StatusReport = ['No data for stock: ',upper(name) ,'. Check your symbol. ',time1];        
      end
      if strcmp(fpwrunindex,'11')
        error(s.StatusReport);
      end
      fpwsimwindow=2;
      cd(fpwserverplace);
      templatefile = which('MPsimulationR1.html');
      str = htmlrep(s, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\twbfpwinputR1.html'],'noheader');
      eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\wbfpwinput']);
      sfpw.zhu99=mname;
      sfpw.MRlist='';
      %sfpw.MRlist=[sfpw.MRlist,sprintf('<select size="1" name="fpwmrlist">')];
      sfpw.MRlist=[sfpw.MRlist,sprintf('<select size="1" name="fpwmrlist" onmouseover="window.status=''For MM simulation only, the market list you chose most recently.''" onmouseout="window.status=''Done''">')];            
      if sfpw.zhu99=='F'
        if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\listorunf.mat'])==2
          eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\listorunf']);
        else
          listorun{1}='SP';
          listorun{2}='US  ';
        end
      else
        if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\listoruns.mat'])==2
          eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\listoruns']);
        else
          listorun{1}='GE';
          listorun{2}='MSFT';
        end
      end
      thisnamene=noempty(listorun{1});
      thisnamele=length(noempty(listorun{1}));
      sfpw.MRlist=[sfpw.MRlist,sprintf(['<option selected value="%',num2str(thisnamele),'s">%',num2str(thisnamele),'s</option>'],thisnamene,thisnamene)];
      if length(listorun)>1
        for i=2:length(listorun)
          thisnamene=noempty(listorun{i});
          thisnamele=length(noempty(listorun{i}));
          sfpw.MRlist=[sfpw.MRlist,sprintf(['<option value="%',num2str(thisnamele),'s">%',num2str(thisnamele),'s</option>'],thisnamene,thisnamene)];
        end
      end
      sfpw.MRlist=[sfpw.MRlist,sprintf('</select>')]; sfpw.fpwmrlist=upper(noempty(listorun{1}));
      
      if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\wbfpwfrontbs.mat'])==2
        eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\wbfpwfrontbs']);
        sfpw.hdfpwptfilefs=frontfpws;
        sfpw.hdfpwptfilefb=frontfpwb;
        if exist('frontfpwexb')==1
          sfpw.hdfpwexfilefb=frontfpwexb;
          sfpw.hdfpwexfilefs=frontfpwexs;
          sfpw.hdfpwstfilefb=frontfpwstb;
          sfpw.hdfpwstfilefs=frontfpwsts;
          sfpw.hdfpwobfilefb=frontfpwobb;
          sfpw.hdfpwobfilefs=frontfpwobs;
        else
          frontfpwexs='Your most recent sell Special Any-Exit Rule is not available yet';
          frontfpwsts='Your most recent sell Special Any-Stop Rule is not available yet';
          frontfpwobs='Your most recent sell Special Any-Objective Rule is not available yet';
          frontfpwexb='Your most recent buy Special Any-Exit Rule is not available yet';
          frontfpwstb='Your most recent buy Special Any-Stop Rule is not available yet';
          frontfpwobb='Your most recent buy Special Any-Objective Rule is not available yet';
          sfpw.hdfpwexfilefb=frontfpwexb;
          sfpw.hdfpwexfilefs=frontfpwexs;
          sfpw.hdfpwstfilefb=frontfpwstb;
          sfpw.hdfpwstfilefs=frontfpwsts;
          sfpw.hdfpwobfilefb=frontfpwobb;
          sfpw.hdfpwobfilefs=frontfpwobs;
        end
      else
        frontfpws='Your most recent sell pattern is not available yet';       
        frontfpwb='Your most recent buy pattern is not available yet';   
        frontfpwexs='Your most recent sell Special Any-Exit Rule is not available yet';
        frontfpwsts='Your most recent sell Special Any-Stop Rule is not available yet';
        frontfpwobs='Your most recent sell Special Any-Objective Rule is not available yet';
        frontfpwexb='Your most recent buy Special Any-Exit Rule is not available yet';
        frontfpwstb='Your most recent buy Special Any-Stop Rule is not available yet';
        frontfpwobb='Your most recent buy Special Any-Objective Rule is not available yet';
      end 
      cd([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\']);
      fpwrulevars=['sfpw.hdfpwpstopa1b';'sfpw.hdfpwpstopa1s';'sfpw.hdfpwpstopa2b';
                   'sfpw.hdfpwpstopa2s';'sfpw.hdfpwpexita1b';'sfpw.hdfpwpexita1s';
                   'sfpw.hdfpwpexita2b';'sfpw.hdfpwpexita2s';'sfpw.hdfpwpobjea1b';
                   'sfpw.hdfpwpobjea1s';'sfpw.hdfpwpobjea2b';'sfpw.hdfpwpobjea2s'];
      fpwrulefile=['fpwstopb8.m';'fpwstops8.m';'fpwstopb9.m';'fpwstops9.m';
                   'fpwexitb7.m';'fpwexits7.m';'fpwexitb8.m';'fpwexits8.m';
                   'fpwobjeb8.m';'fpwobjes8.m';'fpwobjeb9.m';'fpwobjes9.m'];
      for i=1:12
        fid=fopen(fpwrulefile(i,:),'r');
        if fid~=(-1)
          j=1; linecodes='';
          while 1
            tline = fgetl(fid);
            if ~ischar(tline), break, end
            if j>3
              linecodes=[linecodes,sprintf([tline,'\n'])];
            end
            j=j+1;
          end
          fclose(fid);
          eval([fpwrulevars(i,:),'=linecodes;']);
        else
          eval([fpwrulevars(i,:),'=''This rule is not set up yet.'';']);        
        end
      end
      if ~isfield(sfpw,'zhusm')
        sfpw.zhusm='S';
      end
      if ~isfield(sfpw,'marent03')
        sfpw.zhusm='AllSame';
      end     
    end
  elseif (strcmp(WhereOrderFrom,'INDX'))
    fpwsimwindow=2;
    if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\wbfpwinput.mat'])==2
      eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\wbfpwinput']);
      sfpw.ProgressM=strrep([fpwclientdirectory,fpwusername,'\pattern\twbduringrun.html'],'\','/');
      sfpw.fpwusername=fpwusername; sfpw.fpwusername4=fpwusername4;
      if isfield(sfpw,'fpwexfilef')~=1
        sfpw.fpwexfilef='Not Assigned for this pattern.';
        sfpw.fpwstfilef='Not Assigned for this pattern.';
        sfpw.fpwobfilef='Not Assigned for this pattern.';    
      end
    else
      sfpw.zhu26='SP'; sfpw.zhu45s='B'; sfpw.fpwusername=fpwusername; sfpw.fpwusername4=fpwusername4; sfpw.fpwpttype='P'; sfpw.zhusm='S'; sfpw.fpwaddnoise='AN: 0';

      sfpw.tkdv='T'; sfpw.PBKE='0'; sfpw.zhuyun='FT-Unlink'; sfpw.fpwptname2='B'; sfpw.zhu97='H'; sfpw.zhu59='0'; sfpw.zhu84='C';
      sfpw.zhu62='C'; sfpw.zhu99='S'; sfpw.zhu712='Exit'; sfpw.zhu713='1'; sfpw.zhu04s='D'; sfpw.zhu89='H'; sfpw.zhu68='C'; sfpw.zhu66='C';
    
      sfpw.fpwchartspan='DD'; sfpw.fpwptname3='1'; sfpw.zhu24l='3'; sfpw.zhu22l='3'; sfpw.zhu17l='3';

      sfpw.zhu52='20'; sfpw.zhu54='15'; sfpw.ent01='25'; sfpw.ent02='100'; sfpw.ent03='1'; sfpw.marent03='AllSame'; sfpw.zhu75='75';
      sfpw.zhu200='20.00'; sfpw.zhu61='9'; sfpw.zhu63='4'; sfpw.zhu64='4'; sfpw.zhu65new='0'; sfpw.zhu65='2'; sfpw.zhu67new='0'; sfpw.zhu67='2';
      sfpw.new301='45'; sfpw.new302='45'; sfpw.new303='45'; sfpw.new304='45'; sfpw.new305='45'; sfpw.new306='45'; 
      sfpw.new401='45'; sfpw.new402='45'; sfpw.new403='45'; sfpw.new404='45';
      sfpw.zhu722='45'; sfpw.zhu723='45'; sfpw.zhu732='45'; sfpw.zhu733='45'; sfpw.zhu742='45'; sfpw.zhu743='45';
      sfpw.zhu81='100'; sfpw.zhu82='16'; sfpw.zhu83='50'; sfpw.zhu85='4'; sfpw.zhu86='35'; sfpw.zhu87='10'; sfpw.zhu88='2';
      sfpw.zhu91='100'; sfpw.zhu92='2'; sfpw.zhu93='0.75'; sfpw.zhu94='14'; sfpw.zhu95='4'; sfpw.zhu96='2'; sfpw.zhu98='2'; sfpw.obje2nd='120';
      sfpw.fpwptname='Enter'; sfpw.zhu101='fUS'; sfpw.zhu1013='sIBM'; sfpw.zhu1014=' '; sfpw.zhu1015='sge';

      sfpw.fpwrunindex='11';
      sfpw.FirstorS='0';
      sfpw.fpwFdate='01/03/90';
      sfpw.fpwTdate='09/11/01';
      sfpw.fpwchartdatem='010101010201010301010401010501010601070101';
      sfpw.fpwfindex='1';
      sfpw.fpwtindex='7';
      sfpw.fpwMXI='7';
      sfpw.ESOchosen=['01010101010101010101010101'];
      sfpw.ProgressM=strrep([fpwclientdirectory,fpwusername,'\pattern\twbduringrun.html'],'\','/');
      sfpw.FPWsrsource=strrep([fpwclientdirectory,fpwusername,'\pattern\twbfpwinputR1.html'],'\','/');
      sfpw.fpwjpeg=[fpwclientdirectory,fpwusername,'\pattern\fpwjpeg.jpeg'];    
      sfpw.fpwexfilef='Not Assigned for this pattern.';
      sfpw.fpwstfilef='Not Assigned for this pattern.';
      sfpw.fpwobfilef='Not Assigned for this pattern.';
    end
    
    % to generate the drop-down menu's market list for multi-market rules manager
    sfpw.MRlist='';
    %sfpw.MRlist=[sfpw.MRlist,sprintf('<select size="1" name="fpwmrlist">')];
    sfpw.MRlist=[sfpw.MRlist,sprintf('<select size="1" name="fpwmrlist" onmouseover="window.status=''For MM simulation only, the market list you chose most recently.''" onmouseout="window.status=''Done''">')];      
    if sfpw.zhu99=='F'
      if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\listorunf.mat'])==2
        eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\listorunf']);
      else
        listorun{1}='SP';
        listorun{2}='US  ';
      end
    else
      if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\listoruns.mat'])==2
        eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\listoruns']);
      else
        listorun{1}='GE';
        listorun{2}='MSFT';
      end
    end
    thisnamene=noempty(listorun{1});
    thisnamele=length(noempty(listorun{1}));
    sfpw.MRlist=[sfpw.MRlist,sprintf(['<option selected value="%',num2str(thisnamele),'s">%',num2str(thisnamele),'s</option>'],thisnamene,thisnamene)];
    if length(listorun)>1
      for i=2:length(listorun)
        thisnamene=noempty(listorun{i});
        thisnamele=length(noempty(listorun{i}));
        sfpw.MRlist=[sfpw.MRlist,sprintf(['<option value="%',num2str(thisnamele),'s">%',num2str(thisnamele),'s</option>'],thisnamene,thisnamene)];
      end
    end
    sfpw.MRlist=[sfpw.MRlist,sprintf('</select>')]; sfpw.fpwmrlist=upper(noempty(listorun{1}));
    
    if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\wbfpwfrontbs.mat'])==2
      eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\wbfpwfrontbs']);
      sfpw.hdfpwptfilefs=frontfpws;
      sfpw.hdfpwptfilefb=frontfpwb;
      if exist('frontfpwexb')==1
        sfpw.hdfpwexfilefb=frontfpwexb;
        sfpw.hdfpwexfilefs=frontfpwexs;
        sfpw.hdfpwstfilefb=frontfpwstb;
        sfpw.hdfpwstfilefs=frontfpwsts;
        sfpw.hdfpwobfilefb=frontfpwobb;
        sfpw.hdfpwobfilefs=frontfpwobs;
      else
        frontfpwexs='Your most recent sell Special Any-Exit Rule is not available yet';
        frontfpwsts='Your most recent sell Special Any-Stop Rule is not available yet';
        frontfpwobs='Your most recent sell Special Any-Objective Rule is not available yet';
        frontfpwexb='Your most recent buy Special Any-Exit Rule is not available yet';
        frontfpwstb='Your most recent buy Special Any-Stop Rule is not available yet';
        frontfpwobb='Your most recent buy Special Any-Objective Rule is not available yet';
        sfpw.hdfpwexfilefb=frontfpwexb;
        sfpw.hdfpwexfilefs=frontfpwexs;
        sfpw.hdfpwstfilefb=frontfpwstb;
        sfpw.hdfpwstfilefs=frontfpwsts;
        sfpw.hdfpwobfilefb=frontfpwobb;
        sfpw.hdfpwobfilefs=frontfpwobs;
      end
    else
      frontfpws='Your most recent sell pattern is not available yet';       
      frontfpwb='Your most recent buy pattern is not available yet'; 
      frontfpwexs='Your most recent sell Special Any-Exit Rule is not available yet';
      frontfpwsts='Your most recent sell Special Any-Stop Rule is not available yet';
      frontfpwobs='Your most recent sell Special Any-Objective Rule is not available yet';
      frontfpwexb='Your most recent buy Special Any-Exit Rule is not available yet';
      frontfpwstb='Your most recent buy Special Any-Stop Rule is not available yet';
      frontfpwobb='Your most recent buy Special Any-Objective Rule is not available yet';
    end 
    cd([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\']);
    fpwrulevars=['sfpw.hdfpwpstopa1b';'sfpw.hdfpwpstopa1s';'sfpw.hdfpwpstopa2b';
                 'sfpw.hdfpwpstopa2s';'sfpw.hdfpwpexita1b';'sfpw.hdfpwpexita1s';
                 'sfpw.hdfpwpexita2b';'sfpw.hdfpwpexita2s';'sfpw.hdfpwpobjea1b';
                 'sfpw.hdfpwpobjea1s';'sfpw.hdfpwpobjea2b';'sfpw.hdfpwpobjea2s'];
    fpwrulefile=['fpwstopb8.m';'fpwstops8.m';'fpwstopb9.m';'fpwstops9.m';
                 'fpwexitb7.m';'fpwexits7.m';'fpwexitb8.m';'fpwexits8.m';
                 'fpwobjeb8.m';'fpwobjes8.m';'fpwobjeb9.m';'fpwobjes9.m'];
    for i=1:12
      fid=fopen(fpwrulefile(i,:),'r');
      if fid~=(-1)
        j=1; linecodes='';
        while 1
          tline = fgetl(fid);
          if ~ischar(tline), break, end
          if j>3
            linecodes=[linecodes,sprintf([tline,'\n'])];
          end
          j=j+1;
        end
        fclose(fid);
        eval([fpwrulevars(i,:),'=linecodes;']);
      else
        eval([fpwrulevars(i,:),'=''This rule is not set up yet.'';']);        
      end
    end
    if ~isfield(sfpw,'zhusm')
      sfpw.zhusm='S';
    end
    if ~isfield(sfpw,'marent03')
      sfpw.zhusm='AllSame';
    end
    if ~isfield(sfpw,'fpwaddnoise')
      sfpw.fpwaddnoise='AN: 0';
    end    
    sfpw.fpwulvl=instruct.fpwulvl;
  elseif (strcmp(WhereOrderFrom,'SCFL'))
    fpwsimwindow=4;
    Rno=instruct.fpwrunindex;
    if (strcmp(Rno(1),'0'))|(strcmp(Rno(1),'9'))
      sfpw.StatusReport = ['Warning, banned words found: ',urbanwords];
      fpwsimwindow=1; 
    end
  end 
  
  cd(fpwserverplace);
  %save fpwtempfile1
  cids=fpwloginstatus(fpwusername,clock);

  if fpwsimwindow>20  % simulation graphic output
    if fpwsimwindow==21
      templatefile = which('wbfpwoutput.html');    
      if ~strcmp(fpwout1.outGOsm,'UrSym')
        fpwout1.outGOsm=noempty(upper(fpwout1.outGOsm));
      end      
      if (nargin == 1)
        retstr = htmlrep(fpwout1, templatefile);     
      elseif (nargin == 2)
        retstr = htmlrep(fpwout1, templatefile, outfile);
      end  
    elseif fpwsimwindow==22
      templatefile = which('fpwfsmarket.html');    
      if (nargin == 1)
        retstr = htmlrep(fpwout1, templatefile);     
      elseif (nargin == 2)
        retstr = htmlrep(fpwout1, templatefile, outfile);
      end
    elseif fpwsimwindow==24
      templatefile = which('fpwnotrade.html');    
      if (nargin == 1)
        retstr = htmlrep(fpwout1, templatefile);     
      elseif (nargin == 2)
        retstr = htmlrep(fpwout1, templatefile, outfile);
      end      
    end
  elseif fpwsimwindow==1   % status report
    templatefile = which('MPsimulationR1.html');
    if (nargin == 1)
      str = htmlrep(sfpw, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\twbfpwinputR1.html'],'noheader');      
      retstr = htmlrep(sfpw, templatefile);
    elseif (nargin == 2)
      retstr = htmlrep(sfpw, templatefile, outfile);
    end    
  elseif fpwsimwindow==2  % simulation graphic output
    templatefile = which('wbfpwinput.html');    
    if (nargin == 1)
      retstr = htmlrep(sfpw, templatefile);     
    elseif (nargin == 2)
      retstr = htmlrep(sfpw, templatefile, outfile);
    end
  elseif fpwsimwindow==3  % trading list
    templatefile = which('fpwopenfile1.html');
    if (nargin == 1)
      retstr = htmlrep(outstruct, templatefile);   
    elseif (nargin == 2)
      retstr = htmlrep(outstruct, templatefile, outfile);
    end
  elseif fpwsimwindow==8  % trading list
    templatefile = which('fpwdeletefile1.html');
    if (nargin == 1)
      retstr = htmlrep(outstruct, templatefile);   
    elseif (nargin == 2)
      retstr = htmlrep(outstruct, templatefile, outfile);
    end    
  elseif fpwsimwindow==4  % trading list
    templatefile = which('wbcheckbanw.html');  
    sfpw.mpgfoutput=' ';
    if (nargin == 1)
      retstr = htmlrep(sfpw, templatefile);     
    elseif (nargin == 2)
      retstr = htmlrep(sfpw, templatefile, outfile);
    end  
  elseif fpwsimwindow==11   % status report
    templatefile = which('fpwmarketf.html');
    if (nargin == 1)      
      retstr = htmlrep(s, templatefile);
    elseif (nargin == 2)
      retstr = htmlrep(s, templatefile, outfile);
    end    
  elseif fpwsimwindow==12  % simulation graphic output
    templatefile = which('fpwmarkets.html');    
    if (nargin == 1)
      retstr = htmlrep(s, templatefile);     
    elseif (nargin == 2)
      retstr = htmlrep(s, templatefile, outfile);
    end    
  end
end

function y=fpwenteb1(stock,i,enp,enw)
   o=stock(:,1);h=stock(:,2);l=stock(:,3);c=stock(:,4);v=stock(:,5);
   global sl5 riskd commission tickstep stk dam trendv fdctime wstime sj lotshis MiMi MiMi2 MiMi3 MiMi4 ltdss lcps ltpd tradeh stl sts obl obs tot totc wspt MyOT MyCT PatSeed PatWeight MyPat CPS
   global linecodemp; linecodemp=linecodemp(find(linecodemp>=32));
   global wsgp wsgp1 wsgp2 wsgp3 wsgp4 wsmh MyNexti exitpai stoppai objepai endi TExit TStop TObje wsgf wsgf1 wspc wspo wspo1; wspo=''; wspo1=''; wsgf=''; wsgf1=''; wsgp4=[stock sj]; wstd350g;
   eval(linecodemp); endi=y(1);
   
function y=fpwentes1(stock,i,enp,enw)
   o=stock(:,1);h=stock(:,2);l=stock(:,3);c=stock(:,4);v=stock(:,5);
   global sl5 riskd commission tickstep stk dam trendv fdctime wstime sj lotshis MiMi MiMi2 MiMi3 MiMi4 ltdss lcps ltpd tradeh stl sts obl obs tot totc wspt MyOT MyCT PatSeed PatWeight MyPat CPS
   global linecodemp; linecodemp=linecodemp(find(linecodemp>=32));
   global wsgp wsgp1 wsgp2 wsgp3 wsgp4 wsmh MyNexti exitpai stoppai objepai endi TExit TStop TObje wsgf wsgf1 wspc wspo wspo1; wspo=''; wspo1=''; wsgf=''; wsgf1=''; wsgp4=[stock sj]; wstd350g;
   eval(linecodemp); endi=y(1);
 
function y=fpwmimib1(stock,i,enp,enw)
   o=stock(:,1);h=stock(:,2);l=stock(:,3);c=stock(:,4);v=stock(:,5);
   global sl5 riskd commission tickstep stk dam trendv fdctime wstime sj lotshis MiMi MiMi2 MiMi3 MiMi4 ltdss lcps ltpd tradeh stl sts obl obs tot totc wspt MyOT MyCT PatSeed PatWeight MyPat
   global linecondpr MyMiRun; linecondpr=linecondpr(find(linecondpr>=32));
   global wsgp wsgp1 wsgp2 wsgp3 wsgp4 wsmh MyNexti exitpai stoppai objepai endi TExit TStop TObje wsgf wsgf1 wspc wspo wspo1; wspo=''; wspo1=''; wsgf=''; wsgf1=''; wsgp4=[stock sj]; wstd350g;
   eval(linecondpr);
   
function y=fpwexitb9(stock,i,enp,enw)
   o=stock(:,1);h=stock(:,2);l=stock(:,3);c=stock(:,4);v=stock(:,5);
   global sl5 riskd commission tickstep stk dam trendv fdctime wstime sj lotshis MiMi MiMi2 MiMi3 MiMi4 ltdss lcps ltpd tradeh stl sts obl obs tot totc wspt MyOT MyCT PatSeed PatWeight MyPat
   global linecodempex; linecodempex=linecodempex(find(linecodempex>=32));
   global wsgp wsgp1 wsgp2 wsgp3 wsgp4 wsmh MyNexti exitpai stoppai objepai endi TExit TStop TObje wsgf wsgf1 wspc wspo wspo1; wspo=''; wspo1=''; wsgf=''; wsgf1=''; wsgp4=[stock sj]; wstd350g;
   eval(linecodempex);
   
function y=fpwexits9(stock,i,enp,enw)
   o=stock(:,1);h=stock(:,2);l=stock(:,3);c=stock(:,4);v=stock(:,5);
   global sl5 riskd commission tickstep stk dam trendv fdctime wstime sj lotshis MiMi MiMi2 MiMi3 MiMi4 ltdss lcps ltpd tradeh stl sts obl obs tot totc wspt MyOT MyCT PatSeed PatWeight MyPat
   global linecodempex; linecodempex=linecodempex(find(linecodempex>=32));
   global wsgp wsgp1 wsgp2 wsgp3 wsgp4 wsmh MyNexti exitpai stoppai objepai endi TExit TStop TObje wsgf wsgf1 wspc wspo wspo1; wspo=''; wspo1=''; wsgf=''; wsgf1=''; wsgp4=[stock sj]; wstd350g;
   eval(linecodempex);
   
function y=fpwstopb10(stock,i,enp,enw)
   o=stock(:,1);h=stock(:,2);l=stock(:,3);c=stock(:,4);v=stock(:,5);
   global sl5 riskd commission tickstep stk dam trendv fdctime wstime sj lotshis MiMi MiMi2 MiMi3 MiMi4 ltdss lcps ltpd tradeh stl sts obl obs tot totc wspt MyOT MyCT PatSeed PatWeight MyPat
   global linecodempst; linecodempst=linecodempst(find(linecodempst>=32));
   global wsgp wsgp1 wsgp2 wsgp3 wsgp4 wsmh MyNexti exitpai stoppai objepai endi TExit TStop TObje wsgf wsgf1 wspc wspo wspo1; wspo=''; wspo1=''; wsgf=''; wsgf1=''; wsgp4=[stock sj]; wstd350g;
   eval(linecodempst);
   
function y=fpwstops10(stock,i,enp,enw)
   o=stock(:,1);h=stock(:,2);l=stock(:,3);c=stock(:,4);v=stock(:,5);
   global sl5 riskd commission tickstep stk dam trendv fdctime wstime sj lotshis MiMi MiMi2 MiMi3 MiMi4 ltdss lcps ltpd tradeh stl sts obl obs tot totc wspt MyOT MyCT PatSeed PatWeight MyPat
   global linecodempst; linecodempst=linecodempst(find(linecodempst>=32));
   global wsgp wsgp1 wsgp2 wsgp3 wsgp4 wsmh MyNexti exitpai stoppai objepai endi TExit TStop TObje wsgf wsgf1 wspc wspo wspo1; wspo=''; wspo1=''; wsgf=''; wsgf1=''; wsgp4=[stock sj]; wstd350g;
   eval(linecodempst);
   
function y=fpwobjeb10(stock,i,enp,enw)
   o=stock(:,1);h=stock(:,2);l=stock(:,3);c=stock(:,4);v=stock(:,5);
   global sl5 riskd commission tickstep stk dam trendv fdctime wstime sj lotshis MiMi MiMi2 MiMi3 MiMi4 ltdss lcps ltpd tradeh stl sts obl obs tot totc wspt MyOT MyCT PatSeed PatWeight MyPat
   global linecodempob; linecodempob=linecodempob(find(linecodempob>=32));
   global wsgp wsgp1 wsgp2 wsgp3 wsgp4 wsmh MyNexti exitpai stoppai objepai endi TExit TStop TObje wsgf wsgf1 wspc wspo wspo1; wspo=''; wspo1=''; wsgf=''; wsgf1=''; wsgp4=[stock sj]; wstd350g;
   eval(linecodempob);
   
function y=fpwobjes10(stock,i,enp,enw)
   o=stock(:,1);h=stock(:,2);l=stock(:,3);c=stock(:,4);v=stock(:,5);
   global sl5 riskd commission tickstep stk dam trendv fdctime wstime sj lotshis MiMi MiMi2 MiMi3 MiMi4 ltdss lcps ltpd tradeh stl sts obl obs tot totc wspt MyOT MyCT PatSeed PatWeight MyPat
   global linecodempob; linecodempob=linecodempob(find(linecodempob>=32));
   global wsgp wsgp1 wsgp2 wsgp3 wsgp4 wsmh MyNexti exitpai stoppai objepai endi TExit TStop TObje wsgf wsgf1 wspc wspo wspo1; wspo=''; wspo1=''; wsgf=''; wsgf1=''; wsgp4=[stock sj]; wstd350g;
   eval(linecodempob);
   
function y=fpwstopb8(stock,i,enp,enw)
   o=stock(:,1);h=stock(:,2);l=stock(:,3);c=stock(:,4);v=stock(:,5);
   global sl5 riskd commission tickstep stk dam trendv fdctime wstime sj lotshis MiMi MiMi2 MiMi3 MiMi4 ltdss lcps ltpd tradeh stl sts obl obs tot totc wspt MyOT MyCT PatSeed PatWeight MyPat
   global hdfpwpstopa1b; hdfpwpstopa1b=hdfpwpstopa1b(find(hdfpwpstopa1b>=32));
   global wsgp wsgp1 wsgp2 wsgp3 wsgp4 wsmh MyNexti exitpai stoppai objepai endi TExit TStop TObje wsgf wsgf1 wspc wspo wspo1; wspo=''; wspo1=''; wsgf=''; wsgf1=''; wsgp4=[stock sj]; wstd350g;
   eval(hdfpwpstopa1b);   
   
function y=fpwstops8(stock,i,enp,enw)
   o=stock(:,1);h=stock(:,2);l=stock(:,3);c=stock(:,4);v=stock(:,5);
   global sl5 riskd commission tickstep stk dam trendv fdctime wstime sj lotshis MiMi MiMi2 MiMi3 MiMi4 ltdss lcps ltpd tradeh stl sts obl obs tot totc wspt MyOT MyCT PatSeed PatWeight MyPat
   global hdfpwpstopa1s; hdfpwpstopa1s=hdfpwpstopa1s(find(hdfpwpstopa1s>=32));
   global wsgp wsgp1 wsgp2 wsgp3 wsgp4 wsmh MyNexti exitpai stoppai objepai endi TExit TStop TObje wsgf wsgf1 wspc wspo wspo1; wspo=''; wspo1=''; wsgf=''; wsgf1=''; wsgp4=[stock sj]; wstd350g;
   eval(hdfpwpstopa1s);    

function y=fpwstopb9(stock,i,enp,enw)
   o=stock(:,1);h=stock(:,2);l=stock(:,3);c=stock(:,4);v=stock(:,5);
   global sl5 riskd commission tickstep stk dam trendv fdctime wstime sj lotshis MiMi MiMi2 MiMi3 MiMi4 ltdss lcps ltpd tradeh stl sts obl obs tot totc wspt MyOT MyCT PatSeed PatWeight MyPat
   global hdfpwpstopa2b; hdfpwpstopa2b=hdfpwpstopa2b(find(hdfpwpstopa2b>=32));
   global wsgp wsgp1 wsgp2 wsgp3 wsgp4 wsmh MyNexti exitpai stoppai objepai endi TExit TStop TObje wsgf wsgf1 wspc wspo wspo1; wspo=''; wspo1=''; wsgf=''; wsgf1=''; wsgp4=[stock sj]; wstd350g;
   eval(hdfpwpstopa2b);   
   
function y=fpwstops9(stock,i,enp,enw)
   o=stock(:,1);h=stock(:,2);l=stock(:,3);c=stock(:,4);v=stock(:,5);
   global sl5 riskd commission tickstep stk dam trendv fdctime wstime sj lotshis MiMi MiMi2 MiMi3 MiMi4 ltdss lcps ltpd tradeh stl sts obl obs tot totc wspt MyOT MyCT PatSeed PatWeight MyPat
   global hdfpwpstopa2s; hdfpwpstopa2s=hdfpwpstopa2s(find(hdfpwpstopa2s>=32));
   global wsgp wsgp1 wsgp2 wsgp3 wsgp4 wsmh MyNexti exitpai stoppai objepai endi TExit TStop TObje wsgf wsgf1 wspc wspo wspo1; wspo=''; wspo1=''; wsgf=''; wsgf1=''; wsgp4=[stock sj]; wstd350g;
   eval(hdfpwpstopa2s); 
   
function y=fpwobjeb8(stock,i,enp,enw)
   o=stock(:,1);h=stock(:,2);l=stock(:,3);c=stock(:,4);v=stock(:,5);
   global sl5 riskd commission tickstep stk dam trendv fdctime wstime sj lotshis MiMi MiMi2 MiMi3 MiMi4 ltdss lcps ltpd tradeh stl sts obl obs tot totc wspt MyOT MyCT PatSeed PatWeight MyPat
   global hdfpwpobjea1b; hdfpwpobjea1b=hdfpwpobjea1b(find(hdfpwpobjea1b>=32));
   global wsgp wsgp1 wsgp2 wsgp3 wsgp4 wsmh MyNexti exitpai stoppai objepai endi TExit TStop TObje wsgf wsgf1 wspc wspo wspo1; wspo=''; wspo1=''; wsgf=''; wsgf1=''; wsgp4=[stock sj]; wstd350g;
   eval(hdfpwpobjea1b);   
   
function y=fpwobjes8(stock,i,enp,enw)
   o=stock(:,1);h=stock(:,2);l=stock(:,3);c=stock(:,4);v=stock(:,5);
   global sl5 riskd commission tickstep stk dam trendv fdctime wstime sj lotshis MiMi MiMi2 MiMi3 MiMi4 ltdss lcps ltpd tradeh stl sts obl obs tot totc wspt MyOT MyCT PatSeed PatWeight MyPat
   global hdfpwpobjea1s; hdfpwpobjea1s=hdfpwpobjea1s(find(hdfpwpobjea1s>=32));
   global wsgp wsgp1 wsgp2 wsgp3 wsgp4 wsmh MyNexti exitpai stoppai objepai endi TExit TStop TObje wsgf wsgf1 wspc wspo wspo1; wspo=''; wspo1=''; wsgf=''; wsgf1=''; wsgp4=[stock sj]; wstd350g;
   eval(hdfpwpobjea1s);    

function y=fpwobjeb9(stock,i,enp,enw)
   o=stock(:,1);h=stock(:,2);l=stock(:,3);c=stock(:,4);v=stock(:,5);
   global sl5 riskd commission tickstep stk dam trendv fdctime wstime sj lotshis MiMi MiMi2 MiMi3 MiMi4 ltdss lcps ltpd tradeh stl sts obl obs tot totc wspt MyOT MyCT PatSeed PatWeight MyPat
   global hdfpwpobjea2b; hdfpwpobjea2b=hdfpwpobjea2b(find(hdfpwpobjea2b>=32));
   global wsgp wsgp1 wsgp2 wsgp3 wsgp4 wsmh MyNexti exitpai stoppai objepai endi TExit TStop TObje wsgf wsgf1 wspc wspo wspo1; wspo=''; wspo1=''; wsgf=''; wsgf1=''; wsgp4=[stock sj]; wstd350g;
   eval(hdfpwpobjea2b);   
   
function y=fpwobjes9(stock,i,enp,enw)
   o=stock(:,1);h=stock(:,2);l=stock(:,3);c=stock(:,4);v=stock(:,5);
   global sl5 riskd commission tickstep stk dam trendv fdctime wstime sj lotshis MiMi MiMi2 MiMi3 MiMi4 ltdss lcps ltpd tradeh stl sts obl obs tot totc wspt MyOT MyCT PatSeed PatWeight MyPat
   global hdfpwpobjea2s; hdfpwpobjea2s=hdfpwpobjea2s(find(hdfpwpobjea2s>=32));
   global wsgp wsgp1 wsgp2 wsgp3 wsgp4 wsmh MyNexti exitpai stoppai objepai endi TExit TStop TObje wsgf wsgf1 wspc wspo wspo1; wspo=''; wspo1=''; wsgf=''; wsgf1=''; wsgp4=[stock sj]; wstd350g;
   eval(hdfpwpobjea2s);    

function y=fpwexitb7(stock,i,enp,enw)
   o=stock(:,1);h=stock(:,2);l=stock(:,3);c=stock(:,4);v=stock(:,5);
   global sl5 riskd commission tickstep stk dam trendv fdctime wstime sj lotshis MiMi MiMi2 MiMi3 MiMi4 ltdss lcps ltpd tradeh stl sts obl obs tot totc wspt MyOT MyCT PatSeed PatWeight MyPat
   global hdfpwpexita1b; hdfpwpexita1b=hdfpwpexita1b(find(hdfpwpexita1b>=32));
   global wsgp wsgp1 wsgp2 wsgp3 wsgp4 wsmh MyNexti exitpai stoppai objepai endi TExit TStop TObje wsgf wsgf1 wspc wspo wspo1; wspo=''; wspo1=''; wsgf=''; wsgf1=''; wsgp4=[stock sj]; wstd350g;
   eval(hdfpwpexita1b);
   if (y(1)>h(i))&(i==length(c)); y=[c(i) 3]; end;
   
function y=fpwexits7(stock,i,enp,enw)
   o=stock(:,1);h=stock(:,2);l=stock(:,3);c=stock(:,4);v=stock(:,5);
   global sl5 riskd commission tickstep stk dam trendv fdctime wstime sj lotshis MiMi MiMi2 MiMi3 MiMi4 ltdss lcps ltpd tradeh stl sts obl obs tot totc wspt MyOT MyCT PatSeed PatWeight MyPat
   global hdfpwpexita1s; hdfpwpexita1s=hdfpwpexita1s(find(hdfpwpexita1s>=32));
   global wsgp wsgp1 wsgp2 wsgp3 wsgp4 wsmh MyNexti exitpai stoppai objepai endi TExit TStop TObje wsgf wsgf1 wspc wspo wspo1; wspo=''; wspo1=''; wsgf=''; wsgf1=''; wsgp4=[stock sj]; wstd350g;
   eval(hdfpwpexita1s);    
   if (y(1)<0)&(i==length(c)); y=[c(i) 3]; end;

function y=fpwexitb8(stock,i,enp,enw)
   o=stock(:,1);h=stock(:,2);l=stock(:,3);c=stock(:,4);v=stock(:,5);
   global sl5 riskd commission tickstep stk dam trendv fdctime wstime sj lotshis MiMi MiMi2 MiMi3 MiMi4 ltdss lcps ltpd tradeh stl sts obl obs tot totc wspt MyOT MyCT PatSeed PatWeight MyPat
   global hdfpwpexita2b; hdfpwpexita2b=hdfpwpexita2b(find(hdfpwpexita2b>=32));
   global wsgp wsgp1 wsgp2 wsgp3 wsgp4 wsmh MyNexti exitpai stoppai objepai endi TExit TStop TObje wsgf wsgf1 wspc wspo wspo1; wspo=''; wspo1=''; wsgf=''; wsgf1=''; wsgp4=[stock sj]; wstd350g;
   eval(hdfpwpexita2b);
   if (y(1)>h(i))&(i==length(c)); y=[c(i) 3]; end;
   
function y=fpwexits8(stock,i,enp,enw)
   o=stock(:,1);h=stock(:,2);l=stock(:,3);c=stock(:,4);v=stock(:,5);
   global sl5 riskd commission tickstep stk dam trendv fdctime wstime sj lotshis MiMi MiMi2 MiMi3 MiMi4 ltdss lcps ltpd tradeh stl sts obl obs tot totc wspt MyOT MyCT PatSeed PatWeight MyPat
   global hdfpwpexita2s; hdfpwpexita2s=hdfpwpexita2s(find(hdfpwpexita2s>=32));
   global wsgp wsgp1 wsgp2 wsgp3 wsgp4 wsmh MyNexti exitpai stoppai objepai endi TExit TStop TObje wsgf wsgf1 wspc wspo wspo1; wspo=''; wspo1=''; wsgf=''; wsgf1=''; wsgp4=[stock sj]; wstd350g;
   eval(hdfpwpexita2s);
   if (y(1)<0)&(i==length(c)); y=[c(i) 3]; end;