function retstr = wbfpwport(instruct, outfile)

% Author(s): N. Zhu, 11-15-2003
% This is a WB (Web-Based) mirror program to <wsozc3*> and more in desktop version

wbfpwbasic;
cd(fpwserverplace);

retstr = char('');
global fpwusername fpwusername4
fpwusername=instruct.mlid{1};
fpwCPAL=4;
fpwloginIP='192.168.2.8';
fpwcheckil;

% To Change PaperPosition, one needs to change 5 m-files:
% wbfpwoutput, wbfpwsimu, wbfpwport, wbdzhputmi and fpwfsmarket.
%MyPaperPosiH=[.25 .25 4.4 4.25]; % old small one, used before 2016-07-14
MyPaperPosiH=[.25 .25 8.259 4.355];

if fpwcheckilpass==1

  fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
  fseek(fid1,-50,1); fprintf(fid1,[time,' PORT\n']); fclose(fid1);
  clear fid1
  
  fpwulvl=str2num(instruct.fpwulvl);
  %global mname name stock datem   
  if strcmp(instruct.WhereOrderFrom,'SLFE')
    outrunindex=instruct.outrunindex;
  else
    outrunindex='417';
  end
  
  cd([Wherematlab,'\pattern']);
  
  if strcmp(outrunindex,'41')|strcmp(outrunindex,'415') % reset 415 - from Go, 41 - from output portfolio button
    if strcmp(outrunindex,'41')
      eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwfrontout']);
      name=fpwout.name; mname=fpwout.mname; 
      clear fpwout fpwout1   
      pMname=[mname,name];
    else
      pMname=noempty(instruct.pMname);
    end
    pMnamelength=length(pMname);
    if strcmp(name,'ZZXY')
      error(' - Note: This web-based portfolio managing program was designed for single market models only.')    
    end    
    %open portfolio manager page
    FPWMPfiletoopen = [fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data2\fpwt',pMname,'*.mat'];
    a=dir(FPWMPfiletoopen);
    if length(a)>0
      for i=1:length(a)
        stringnumport=str2num(a(i).name(5+pMnamelength:length(a(i).name)-4));
        if length(stringnumport)==1
          Pazhu(i)=stringnumport;
        else
          Pazhu(i)=-1;          
        end
      end
      clear stringnumport
      Pazhu=Pazhu(find(Pazhu>=0));
      if length(Pazhu)==0
        error([' - There is no saved models for ',upper(pMname)]);          
      end
      [qww qiw]=sort(Pazhu);
      Pazhu=Pazhu(qiw);
      portchosen=char(zeros(1,207)+48);
      for i=1:207
        if i<=length(Pazhu)
          portchosen(i)='1';
          eval(['fpwport.PAzhu',num2str(i),'=''',num2str(Pazhu(i)),''';']); 
        else
          eval(['fpwport.PAzhu',num2str(i),'='' '';']);
        end
      end
    else
      error([' - There is no saved models for ',upper(pMname)]);
    end
    
    portchosen(208)='1';
    fpwport.portchosen=portchosen;
    fpwport.pMname=upper(pMname);
    fpwport.pMCT=' ';
    for i=1:3
      for j=1:13
        eval(['fpwport.c',num2str(j),num2str(i),'='' '';']);
      end
    end
    for i=1:27
      if i<19
         eval(['fpwport.PBzhu',num2str(i),'='' '';']);
      end
      eval(['fpwport.PCzhu',num2str(i),'='' '';']);  
    end
    fpwport.Pzhu108='10';fpwport.Pzhu110='FE'; fpwport.Pzhu111='1'; fpwport.Pzhu300='Models'; fpwport.Pzhu121='4';
    fpwport.Pzhu301='[2 3]';  fpwport.Pzhu303='99';  fpwport.Pzhu305='3.00'; fpwport.Pzhu112='7'; fpwport.PCzhu1='208';
    fpwport.portFE='Ka'; fpwport.portMQ='Ka'; fpwport.portDD='Ka'; fpwport.portFP='Ka'; fpwport.portWP='Ka'; fpwport.portGN='0';   
    fpwport.fpwusername=fpwusername;
    fpwport.fpwusername4=fpwusername4;
    fpwport.fpwulvl=instruct.fpwulvl;
    fpwport.outrunindex=outrunindex;
    eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portfront fpwport']);
    
  elseif strcmp(outrunindex,'411')
    % link individual model to output page
    runmodel=instruct.runmodel; pMname=noempty(instruct.pMname);
    eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data2\fpwt',pMname,runmodel]);
    if fpwout.tradeh(1,1)~=0
      fpwoutwindow=21;
      cd([Wherematlab,'\pattern']);
      fpwoutf2(fpwusername);
      fpwout.pdzhu=str2num(runmodel);
      eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwoutput fpwout']);  
      fpwout.outonoff='0';
      fpwout.fpwsource='fpwoutput';
      fpwout1=fpwozc3(fpwout);    
      fpwout1.fpwsource='fpwoutput';
      fpwout1.fpwusername=fpwusername;
      fpwout1.fpwusername4=fpwusername4;
      fpwout1.fpwulvl=instruct.fpwulvl;
      fpwout1.outrunindex='00';
      fpwout1.outptname=upper([pMname,runmodel]);
      fpwout1.fpwdailynet=[fpwclientdirectory,fpwusername,'\pattern\fpwdailynet.txt'];
      
      set(fpwout1.fpwoutfig,'PaperPosition',MyPaperPosiH);
      cd([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern']);
      drawnow;
      wsprintjpeg(fpwout1.fpwoutfig,'fpwoutjpeg.jpeg');
      close(fpwout1.fpwoutfig);
      cd([Wherematlab,'pattern']);
      fpwout1.fpwoutjpeg=[fpwclientdirectory,fpwusername,'\pattern\fpwoutjpeg.jpeg']; 
                          
      s.StatusReport=['Loaded from FPWT',upper([pMname,runmodel]),'.MAT. ',time];
      templatefile = which('MPsimulationR1.html');
      str = htmlrep(s, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\twbfpwoutputR1.html'],'noheader');      
      fpwout1.FPWoutstatus=strrep([fpwclientdirectory,fpwusername,'\pattern\twbfpwoutputR1.html'],'\','/');    
    else
      fpwoutwindow=24;
      fpwout1.fpwusername=fpwusername;
      fpwout1.fpwusername4=fpwusername4;
      fpwout1.fpwulvl=instruct.fpwulvl;
      fpwout1.outrunindex='00';               
    end
     
  elseif strcmp(outrunindex,'412')
    % portfolio sort
    NOWhms=now;
    eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portfront']);
    pMname=noempty(instruct.pMname);
    portchosen=char(zeros(1,207)+48);
    portchosenum=zeros(1,207);
    
    for i=1:207
      if isfield(instruct,['pS',num2str(i)])
        portchosen(i)='1';   portchosenum(i)=1; 
      end
      eval(['modelindex=noempty(fpwport.PAzhu',num2str(i),');']);
      if length(modelindex)
        PAzhu(i)=str2num(modelindex);
      else
        PAzhu(i)=0;
      end
    end
    PAzhu=portchosenum.*PAzhu;
    PAzhun=PAzhu(find(PAzhu~=0));
    fpwport.pMname=upper(pMname);
    
    if 1
      PBzhu=[];
      for i=1:18
        eval(['modelindex=noempty(instruct.PBzhu',num2str(i),');']);
        eval(['fpwport.PBzhu',num2str(i),'=noempty(instruct.PBzhu',num2str(i),');']);
        if length(modelindex)
          eval(['fpwport.PBzhu',num2str(i),'=modelindex;']);
          PBzhunewi=[];
          eval(['PBzhunewi=[',modelindex,'];'])
          PBzhu=[PBzhu,PBzhunewi];
          clear PBzhunewi
        else
          PBzhu=[PBzhu,0];
          eval(['fpwport.PBzhu',num2str(i),'='' '';']);
        end
      end  
      PBzhun=PBzhu(find(PBzhu~=0)); 
    else
      for i=1:18
        eval(['modelindex=noempty(instruct.PBzhu',num2str(i),');']);
        if length(modelindex)
          PBzhu(i)=str2num(modelindex);
          eval(['fpwport.PBzhu',num2str(i),'=modelindex;']);
        else
          PBzhu(i)=0;
          eval(['fpwport.PBzhu',num2str(i),'='' '';']);
        end
      end  
      PBzhun=PBzhu(find(PBzhu~=0));
    end
    Pzhu108=str2num(instruct.Pzhu108);
    % sort begin to give portGN, portFE, portMQ, portDD, portFP, portWP
    %fpwport.portFE='Ka'; fpwport.portMQ='Ka'; fpwport.portDD='Ka'; fpwport.portFP='Ka'; fpwport.portWP='Ka'; fpwport.portGN='0'; 

    % first to find a common datem to cover all models, suppose their date are all overlaped
    Datem=[];
    % do the same for stock when combine models
    for i=1:length(PAzhun)
      eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data2\fpwt',pMname,num2str(PAzhun(i))]);
      if length(Datem)~=0
        datem=fpwout.datem;
        if dnabs(datem(1,1:3))<dnabs(Datem(1,1:3))
          dindex=datef2(Datem(1,1:3),datem);
          Datem=[datem(1:dindex-1,1:3);Datem];
        end
        if dnabs(datem(length(datem(:,1)),1:3))>dnabs(Datem(length(Datem(:,1)),1:3))
          dindex=datef2(Datem(length(Datem(:,1)),1:3),datem);
          Datem=[Datem; datem(dindex+1:length(datem(:,1)),1:3)];
        end        
      else
        Datem=fpwout.datem;
      end
    end
           
    for i=1:length(PAzhun)
      eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data2\fpwt',pMname,num2str(PAzhun(i))]);
      datem=fpwout.datem; net=fpwout.net; net1=fpwout.net1;
      dindexb=datef2(datem(1,1:3),Datem);
      if dindexb~=1
        net=[zeros(dindexb-1,1);net];
        net1=[zeros(dindexb-1,1);net1];
      end
      dindexe=datef2(datem(length(datem(:,1)),1:3),Datem);
      if dindexe~=length(Datem(:,1))
        net=[net;zeros(length(Datem(:,1))-length(datem(:,1)),1)];
        net1=[net1;zeros(length(Datem(:,1))-length(datem(:,1)),1)];          
      end
      eval(['global NET',num2str(PAzhun(i))]);
      eval(['global NETW',num2str(PAzhun(i))]);
      eval(['NET',num2str(PAzhun(i)),'=net;']);
      eval(['NETW',num2str(PAzhun(i)),'=net1;']);
    end
       
    if length(PBzhun)~=0
      for j=1:length(PBzhun)
        [powsss poplace]=find(PAzhun-PBzhun(j)~=0);
        PAzhun=PAzhun(poplace);
      end
    end
       
    if Pzhu108>=length(PAzhun)
      instruct.Pzhu108=num2str(length(PAzhun)+length(PBzhun)-1); 
      Pzhu108=length(PAzhun)+length(PBzhun)-1;
    end
    p108=max([1 (Pzhu108)-length(PBzhun)]);
    
    % sort all candidates by MQ, then choose the top best to controle all combination less than 1500
    for i=1:length(PAzhun)
      allp(i,1:5)=modelsys(PAzhun(i));
    end
    [ponum poqueu]=sort(allp(:,2));
    PAzhun=PAzhun(poqueu');
          
    i=0;
    while combine(length(PAzhun)-i,p108)>1500
      i=i+1;
    end
    
    if i>0
      PAzhun=PAzhun(i+1:length(PAzhun));
    end
    
    % begin to sort 
    allpc=kenon(PAzhun,p108);
    
    if length(allpc(:,1))>100
      smps2.Runmemo='Running ......';
      templatefile = which('duringrun.html');      
      str = htmlrep(smps2, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\tduringrun.html'],'noheader');    
    end
    
    for i=1:length(allpc(:,1))
        % it will take a long time for some cases.
      if length(allpc(:,1))>100
        if rem(i-1,round(0.1*length(allpc(:,1))))==0
          cd(fpwserverplace);
          templatefile = which('wbduringrun.html');
          smps2.fpwtime=[datestr(now-NOWhms,13),', ',time1];
          smps2.fpwrprogram = ['PORT: ',upper(pMname)];
          smps2.percfinished=num2str(round(100*i/length(allpc(:,1))));
          str = htmlrep(smps2, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\twbduringrun.html'],'noheader');
          if rem(i,round(0.2*length(allpc(:,1))))==0
            cidsmamamiya=fpwloginstatus(fpwusername,clock);
          end
          cd([Wherematlab,'pattern']);
        end            
      end
      allpcp(i,1:5)=modelsys([allpc(i,:),PBzhun]);
    end
    
    if length(allpc(:,1))>100
      smps2.Runmemo='Completed.';
      templatefile = which('duringrun.html');      
      str = htmlrep(smps2, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\tduringrun.html'],'noheader');    
    end    
    
    cd(fpwserverplace);
    templatefile = which('wbduringrun.html');
    smps2.fpwtime=[datestr(now-NOWhms,13),', ',time1];
    smps2.fpwrprogram = ['PORT: ',upper(pMname)];
    smps2.percfinished='100';
    str = htmlrep(smps2, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\twbduringrun.html'],'noheader');
    cd([Wherematlab,'pattern']);
    
    [pofe1 pofe2]=numsort(allpcp(:,1),20); pofe=allpc(pofe2,:);
    [pomq1 pomq2]=numsort(allpcp(:,2),20); pomq=allpc(pomq2,:);
    [powp1 powp2]=numsort(allpcp(:,3),20); powp=allpc(powp2,:);
    [podd1 podd2]=numsort(allpcp(:,4),-20); podd=allpc(podd2,:);
    [pofp1 pofp2]=numsort(allpcp(:,5),-20); pofp=allpc(pofp2,:);
     
    portGN=length(pofe(1,:)); fpwport.portGN=num2str(portGN);
    portGC=length(pofe(:,1)); fpwport.portGC=num2str(portGC);
    fpwport.portFE=''; fpwport.portMQ=''; fpwport.portFP='';fpwport.portDD='';fpwport.portWP='';
    
    fpwport.Pzhu110=instruct.Pzhu110;
    fpwport.Pzhu111=instruct.Pzhu111;
    fpwport.Pzhu112=instruct.Pzhu112;
    eval(['portXX=po',lower(instruct.Pzhu110),';']);
    portbestn=min([portGC str2num(instruct.Pzhu111)]);
    PCzhun=portXX(portbestn,:);
    for i=1:27
      if i<=length(PCzhun)
        eval(['fpwport.PCzhu',num2str(i),'=''',num2str(PCzhun(i)),''';']);
      else
        eval(['fpwport.PCzhu',num2str(i),'='' '';']);         
      end
    end    
    
    pofe=reshape(pofe',1,portGN*portGC); 
    pomq=reshape(pomq',1,portGN*portGC);
    powp=reshape(powp',1,portGN*portGC);
    podd=reshape(podd',1,portGN*portGC);
    pofp=reshape(pofp',1,portGN*portGC);

    for i=1:portGN*portGC
      fpwport.portFE=[fpwport.portFE sprintf('%02d',pofe(i))];
      fpwport.portMQ=[fpwport.portMQ sprintf('%02d',pomq(i))];
      fpwport.portDD=[fpwport.portDD sprintf('%02d',podd(i))];
      fpwport.portFP=[fpwport.portFP sprintf('%02d',pofp(i))];
      fpwport.portWP=[fpwport.portWP sprintf('%02d',powp(i))];
    end
    
    % prepare output back other elements
    fpwport.pMCT=instruct.pMCT;
    fpwport.Pzhu108=instruct.Pzhu108;  
    fpwport.Pzhu300=instruct.hdPzhu300; % 'models' or 'lots', not in use any more.
    fpwport.Pzhu121=instruct.Pzhu121;
    fpwport.Pzhu301=instruct.Pzhu301;
    fpwport.Pzhu303=instruct.Pzhu303;
    fpwport.Pzhu305=instruct.Pzhu305;
    
    fpwport.fpwusername=fpwusername;
    fpwport.fpwusername4=fpwusername4;
    fpwport.fpwulvl=instruct.fpwulvl;
    fpwport.outrunindex=outrunindex;
    if isfield(instruct,'pS208')
      portchosen(208)='1';
    end
    fpwport.portchosen=portchosen;
    eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portfront fpwport']);    
     
  elseif strcmp(outrunindex,'413')
    % model combination
    NOWhms=now;
    eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portfront fpwport']);
    PORUNLTD=abs(str2num(instruct.Pzhu121));
    if length(PORUNLTD)==0
      PORUNLTD=0;
    end
    load c:\matlab\pattern\tradehsizes.mat
    if 0  % 1 - for old GUI
      PORUNW=upper(instruct.hdPzhu300); PORUNW=PORUNW(1);
    else
      PORUNW='M'; % for the new powerful GUI, 20160722
    end
    if PORUNLTD==0
      error(' Did not enter model number limit.');    
    end
    pdzhu=[];
    
    if ~strcmp(noempty(upper(instruct.PCzhu1)),'208')
      PBzhu=[];
      for i=1:18
        eval(['modelindex=noempty(instruct.PBzhu',num2str(i),');']);
        if length(modelindex)
          eval(['fpwport.PBzhu',num2str(i),'=modelindex;']);
          PBzhunewi=[];
          eval(['PBzhunewi=[',modelindex,'];'])
          PBzhu=[PBzhu,PBzhunewi];
          clear PBzhunewi
        else
          eval(['fpwport.PBzhu',num2str(i),'='' '';']);
          PBzhu=[PBzhu,0];
        end
      end  
      PBzhun=PBzhu(find(PBzhu~=0));    
      
      PCzhu=[];
      for i=1:27
        eval(['modelindex=noempty(instruct.PCzhu',num2str(i),');']);
        if length(modelindex)
          eval(['fpwport.PCzhu',num2str(i),'=modelindex;']);
          PCzhunewi=[];
          eval(['PCzhunewi=[',modelindex,'];'])
          PCzhu=[PCzhu,PCzhunewi];
          clear PCzhunewi
        else
          eval(['fpwport.PCzhu',num2str(i),'='' '';']);
          PCzhu=[PCzhu,0];
        end
      end
      PCzhun=PCzhu(find(PCzhu~=0));
        
      if (length(PBzhun)~=0)&(length(PCzhun)~=0) % avoid double input
        for j=1:length(PBzhun)
          [powsss poplace]=find(PCzhun-PBzhun(j)~=0);
          if length(poplace)~=0
            PCzhun=PCzhun(poplace);
          end
        end
      end
        
      Pdzhu=[PBzhun,PCzhun];
      if length(Pdzhu)~=0
        pdzhu=Pdzhu(find(Pdzhu~=0));
      end
    else % from PAzhu choices
      portchosenum=zeros(1,207);    
      for i=1:207
        if isfield(instruct,['pS',num2str(i)])
          portchosenum(i)=1; 
        end
        eval(['modelindex=noempty(fpwport.PAzhu',num2str(i),');']);
        if length(modelindex)
          PAzhu(i)=str2num(modelindex);
        else
          PAzhu(i)=0;
        end
      end
      PAzhu=portchosenum.*PAzhu;
      pdzhu=PAzhu(find(PAzhu~=0)); 
      
    end
    
    fpwport.Pzhu121=instruct.Pzhu121;
    fpwport.Pzhu300=instruct.hdPzhu300; % 'models' or 'lots', not in use any more.
    fpwport.Pzhu301=instruct.Pzhu301;
    fpwport.Pzhu303=instruct.Pzhu303;
    fpwport.Pzhu305=instruct.Pzhu305;
    fpwport.Pzhu108=instruct.Pzhu108;
    fpwport.Pzhu110=instruct.Pzhu110;
    fpwport.Pzhu111=instruct.Pzhu111;
    fpwport.Pzhu112=instruct.Pzhu112;
    if isfield(instruct,'pS208')
      portchosen(208)='1';
    end
    fpwport.portchosen=instruct.portchosen;
    eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portfront fpwport']); 
    
    if length(pdzhu)==0
      error(' There is no model list entered or chosen.');  
    end
    
    pMname=upper(noempty(instruct.pMname));
    Datem=[]; Stock=[];
    for i=1:length(pdzhu)
      eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data2\fpwt',pMname,num2str(pdzhu(i))]);
      if length(Datem)~=0
        datem=fpwout.datem; stock=fpwout.stock;
        if dnabs(datem(1,1:3))<dnabs(Datem(1,1:3))
          dindex=datef2(Datem(1,1:3),datem);
          Datem=[datem(1:dindex-1,1:3);Datem];
          Stock=[stock(1:dindex-1,1:3);Stock];
        end
        if dnabs(datem(length(datem(:,1)),1:3))>dnabs(Datem(length(Datem(:,1)),1:3))
          dindex=datef2(Datem(length(Datem(:,1)),1:3),datem);
          Datem=[Datem; datem(dindex+1:length(datem(:,1)),1:3)];
          Stock=[Stock; stock(dindex+1:length(stock(:,1)),1:3)];
        end        
      else
        Datem=fpwout.datem; Stock=fpwout.stock;
      end
    end
    NET=0*Datem(:,1); NET1=NET; Lotshis=zeros(length(NET),length(pdzhu));
    Tradeh=[]; Tradeh2=[]; Tradeh3=[]; Tradeo=[]; Tradeeach=[]; zhusc75=zeros(207,1);
    
    for i=1:length(pdzhu)
      eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data2\fpwt',pMname,num2str(pdzhu(i))]);
      datem=fpwout.datem; net=fpwout.net; net1=fpwout.net1; lotshis=fpwout.lotshis; 
      tradeh=fpwout.tradeh; tradeo=fpwout.tradeo; tradeeach=fpwout.tradeeach;
      zhu75=fpwout.zhu75; zhusc75(pdzhu(i))=str2num(zhu75); % only used by LABAC(ii,3) in wbfpwoutput
      if isfield(fpwout,'tradeh2')==1
        tradeh2=fpwout.tradeh2; tradeh3=fpwout.tradeh3;
        if (length(tradeh2(1,:))<TradehSizes(1))|(length(tradeh3(1,:))<TradehSizes(2))
          d23show=[' Not enough T2 or T3 data for ',int2str(pdzhu(i)),'.'];
        end
        if length(tradeh2(1,:))~=TradehSizes(1)
          tradeh2=[tradeh2 zeros(length(tradeh(:,1)),TradehSizes(1)-length(tradeh2(1,:)))];
        end
        if length(tradeh3(1,:))~=TradehSizes(2)
          tradeh3=[tradeh3 zeros(length(tradeh(:,1)),TradehSizes(2)-length(tradeh3(1,:)))];
        end
      else
        d23show=[' No T2 or T3 data for ',num2str(pdzhu(i))];
        tradeh2=zeros(length(tradeh(:,1)),TradehSizes(1));
        tradeh3=zeros(length(tradeh(:,1)),TradehSizes(2));
      end
      
      clear fpwout
      if length(lotshis(1,:))>1;  lotshis=(sum(lotshis'))'; end
      dindexb=datef2(datem(1,1:3),Datem);
      if dindexb~=1
        net=[zeros(dindexb-1,1);net];
        net1=[zeros(dindexb-1,1);net1];
        lotshis=[zeros(dindexb-1,1);lotshis];
        % correct tradeeach first
        for ii=1:length(tradeh(:,3))
          tradeeach(tradeh(ii,10):(tradeh(ii,10)+tradeh(ii,11)-1)/2)=...
          tradeeach(tradeh(ii,10):(tradeh(ii,10)+tradeh(ii,11)-1)/2)+dindexb-1;
        end        
        tradeh(:,3)=tradeh(:,3)+dindexb-1;
        tradeh(:,5)=tradeh(:,5)+dindexb-1;
        tradeo(:,1)=tradeo(:,1)+dindexb-1;
      end
      dindexe=datef2(datem(length(datem(:,1)),1:3),Datem);
      if dindexe~=length(Datem(:,1))
        net=[net;zeros(length(Datem(:,1))-length(datem(:,1)),1)];
        net1=[net1;zeros(length(Datem(:,1))-length(datem(:,1)),1)]; 
        lotshis=[lotshis;zeros(length(Datem(:,1))-length(datem(:,1)),1)];
      end
      if 0 %PORUNW=='L'
        tradeh(:,2)=lotshis(tradeh(:,3),1); 
        % condition for this operation: model could not change direction for life, long is long, 
        % short is short, could not mess up. otherwise use Models as unit instead of Lots.
      end
      NET=NET+net;
      NET1=NET1+net1;
      Lotshis(:,i)=lotshis;
      tradeh(:,12)=0*tradeh(:,12)+i;
      tradeh(:,13)=0*tradeh(:,12)+pdzhu(i);
      tradeh(:,10)=tradeh(:,10)+length(Tradeeach);
      tradeh(:,11)=tradeh(:,11)+length(Tradeeach);
      Tradeh=[Tradeh;tradeh];
      Tradeh2=[Tradeh2;tradeh2];
      Tradeh3=[Tradeh3;tradeh3];
      Tradeo=[Tradeo;tradeo];
      Tradeeach=[Tradeeach;tradeeach];  
      clear net net1 tradeo tradeh tradeeach lotshis datem
    end    
    
    net=NET;net1=NET1;tradeh=Tradeh; clear Tradeh NET NET1
    tradeh2=Tradeh2; tradeh3=Tradeh3; clear Tradeh2 Tradeh3
    tradeo=Tradeo; clear Tradeo 
    lotshis=Lotshis; clear Lotshis
    tradeeach=Tradeeach; clear Tradeeach
    [qww qiw]=sort(tradeh(:,3)+tradeh(:,9)/24);
    tradeh=[tradeh(qiw,:);zeros(1,13)];
    tradeo=tradeo(qiw,:);
    tradeh2=tradeh2(qiw,:);
    tradeh3=tradeh3(qiw,:);
    
    if 0 % this is the old way, only for max model/lots limits
      % rule out some trades because M or L limits
      if (PORUNW=='M')
        pdzhuindex=length(pdzhu);
      else
        pdzhuindex=max(sum(lotshis'));
      end
      if (pdzhuindex>PORUNLTD)
        entrydayi=tradeh(1,3);engrouph=[];engrouph2=[];engrouph3=[];engroupo=[];
        tradeh1=[];tradeo1=[]; tradeh21=[]; tradeh31=[];
        for i=1:length(tradeh(:,1))
          if (tradeh(i,3)==entrydayi)|(length(engrouph)==0)
            engrouph=[engrouph;tradeh(i,:)];
            engrouph2=[engrouph2;tradeh2(i,:)];
            engrouph3=[engrouph3;tradeh3(i,:)];
            engroupo=[engroupo;tradeo(i,:)];
          else
            %sort engroup by time if engroup > PORUNLTD then reset
            [dqww dqiw]=sort(engrouph(:,9));
            engrouph=[engrouph(dqiw,:) ones(length(dqww),1) (1:length(dqww))' cumsum(engrouph(:,2))];
            engrouph2=engrouph2(dqiw,:);
            engrouph3=engrouph3(dqiw,:);
            engroupo=engroupo(dqiw,:);
            if max(abs(cumsum(engrouph(:,2))))>PORUNLTD 
              % this only limit new signal effect in a day, only right for pure daytrading
              engrouph11=cumsum(engrouph(:,2));
              II=0;
              while abs(engrouph11(II+1))<=PORUNLTD
                II=II+1;
              end
              engrouph(II,13)=min([PORUNLTD II]);
              tradeh1=[tradeh1;engrouph(1:II,:)];
              tradeh21=[tradeh21;engrouph2(1:II,:)];
              tradeh31=[tradeh31;engrouph3(1:II,:)];
              tradeo1=[tradeo1;engroupo(1:II,:)];
              for kk=II+1:length(engrouph(:,2))
                k=engrouph(kk,3);
                dropitwp=tradeeach(engrouph(kk,10):engrouph(kk,11));
                dropitwp=reshape(dropitwp,length(dropitwp)/2,2);
                if engrouph(kk,3)==engrouph(kk,5)
                  lotshis(k,engrouph(kk,12))=0;
                else
                  lotshis(k:engrouph(kk,5)-1,engrouph(kk,12))=0*...
                  lotshis(k:engrouph(kk,5)-1,engrouph(kk,12));
                end
                net(dropitwp(:,1))=net(dropitwp(:,1))-dropitwp(:,2);
                net1(k)=net1(k)-sum(dropitwp(:,2));
              end
            else
              IFIND=find(abs(cumsum(engrouph(:,2)))==PORUNLTD);
              if length(IFIND)>0
                engrouph(IFIND(1),13)=PORUNLTD;
              end
              tradeh1=[tradeh1;engrouph];   
              tradeh21=[tradeh21;engrouph2];
              tradeh31=[tradeh31;engrouph3];
              tradeo1=[tradeo1;engroupo];
            end
            if i~=length(tradeh(:,1))
              entrydayi=tradeh(i,3);
              engrouph=tradeh(i,:);
              engrouph2=tradeh2(i,:);
              engrouph3=tradeh3(i,:);
              engroupo=tradeo(i,:);
            end
          end
        end
        clear tradeh tradeo
        tradeh=tradeh1;
        tradeh2=tradeh21;
        tradeh3=tradeh31;
        tradeo=tradeo1;
      else % forget why to drop the last one?
        tradeh=tradeh(1:length(tradeh(:,1))-1,:);
      end
    else
      % using new configure to rule out unwanted trades
      Aai=0; Bbi=0; Cci=0; Ddi=1; Eei=0; Ffi=0; Ggi=0; Hhi=0; Iii=0; Jji=0;
      % so far, DE still not used yet
      wbststopritm=0;
      tipbin=0*tradeh(:,1:2); % Trade in Position Book's Initial numbers [absolute_posi net_posi]
      eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbststopritm.mat wbststopritm']);
      tradeh=tradeh(1:length(tradeh(:,1))-1,:);
      
      mxp=str2num(instruct.Pzhu121);
      if length(mxp)==1
        mxpl=mxp; mxps=mxp;
      else
        if length(mxp)==2
          mxpl=mxp(1); mxps=mxp(2); mxp=min(mxp);
        elseif length(mxp)>2
          error(' Wrong format for MxP. It should be a 1x1 or 1x2 int vector.');
        end
      end 
      
      mxo=round(str2num(instruct.Pzhu301));
      if length(mxo)==1
        mxol=mxo; mxos=mxo;
      else
        if length(mxo)==2
          mxol=mxo(1); mxos=mxo(2); mxo=min(mxo);
        elseif length(mxo)>2
          error(' Wrong format for MxO. It should be a 1x1 or 1x2 int vector.');
        end
      end   
      
      mxl=str2num(instruct.Pzhu303);
      if length(mxl)==1
        mxll=mxl; mxls=mxl;
      else
        if length(mxl)==2
          mxll=mxl(1); mxls=mxl(2); mxl=min(mxl);
        elseif length(mxl)>2
          error(' Wrong format for MxL. It should be a 1x1 or 1x2 int vector.');
        end
      end     
      
      mxv=str2num(instruct.Pzhu305);
      tradeh(:,14)=tradeh3(:,172);
      
      if isfield(instruct,'pS208')
        pfi=str2num(instruct.Pzhu112);
      else
        pfi=0; % unchecked the box
      end
      pfi_original=pfi;
      DropNet1=0;
      if pfi>7
        DropNet1=pfi-7;
        pfi=7;
      end
      
      global o h l c v datem
      [o h l c v]=wsov(Stock);
      datem=Datem;
      % add 3 days to the end, since some conditions may use future dates
      % assuming always cut at the end of a month.
      futdate=wsfddate(datem(length(datem(:,1)),:),5);
      mfdih=[];
      mfdihii=[];
      for mfdihi=1:5
        if fpwholiday(futdate(mfdihi,:),0,0)==0
          mfdih=[mfdih;futdate(mfdihi,:)]; 
        else
          mfdihii=mfdihi;
        end
      end
      datem=[datem; mfdih(1:3,:)];
      clear mfdihi mfdihii futdate
      
      if (strcmp(upper(fpwusername),'NINGZHU'))|...
        (strcmp(upper(fpwusername),'AARONZHU'))|...
        (strcmp(upper(fpwusername),'DIANEXU'))
        nis2kon=zeros(1,207);
        pnsis=[ 71  57   9  33  11   1   3  75  77  79,...
                81  83  85  87  89  91  35  16   2  34,...
                42  30  36  24  74  76  80  78  82  84,...
                86  88  90  61  62  65  66  69  70  54,...
                53  52  63  64  67  68  49  50  55  56,...
                47  48  45  46  73  43  41  44  39  40,...
                95  97  98  22   7   8   5   6  17  18,...
                19  20  25  26  27  28  31  32  13  15,...
                21  10  23   4  29  12  59  14  58  99,...
                93  72  37  60 103  96 105  38 121 131,...
               132 135 137 138 144 145 146 161 163 165,...
               167 168 169 170 171 173 174 175 176 177]; 
        for i=1:length(pnsis)
          nis2kon(pnsis(i))=find(pnsis==pnsis(i));
        end      
        % add double mother/daughter things
        nis2kon(51)=40;
        nis2kon(101)=56;
        nis2kon(102)=39;
        nis2kon(104)=42;
        nis2kon(106)=33;
        nis2kon(107)=55;
        nis2kon(108)=21;
        nis2kon(110)=23;
        nis2kon(148)=42;
        nis2kon(158)=89;
      end
      
      % Firstly, making conditions check
      if (pfi==3)|(pfi>=5)
        tpd=0*tradeh(:,1)+1; % trade pass index
        eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme\pmedefault\portpme3']);
        PMEc3='';
        for k=1:9
          if length(strfind(portpme3{k},'Not Assigned yet'))==0
            PMEc3=[PMEc3,portpme3{k},char(10)];
          end
        end
        
        if length(PMEc3)>0
          cd(fpwserverplace);
          [fpwscpass]=wbcheckbanw('filterc3',PMEc3);
          cd([Wherematlab,'pattern']);
          if (fpwsecucheck(PMEc3)>0)|(fpwscpass~=1)
            error(' Hei! Not allowed content found in filter conditions, are you seriously trying to .... Sorry, change it.');
          end
        end
        
        if length(noempty(PMEc3,1))>0 %inluding to rule out return note.
          if 0 % using customerized way to speed up
            vo10=ma(h-l,10); vo5=ma(h-l,5);
            rsi7=rsiall(c,7); rsi14=rsiall(c);
            ma10=ma(c,10); ma20=ma(c,20); ma30=ma(c,30);
            ma15=ma(c,15); ma50=ma(c,50); ma100=ma(c,100);
            ea100=ema(c,100); ea200=ema(c,200);
          else
            % to check [pre-cals]
            MyPCondi=strfind(PMEc3,'[pre-cals]');
            if length(MyPCondi)>0
              MyPCond='';
              if length(MyPCondi)~=2
                error('[pre-cals] pair not matched!');
              else
                MyPCond=PMEc3(MyPCondi(1)+10:MyPCondi(2)-1);
                if MyPCondi(1)>1
                  if length(PMEc3)>=MyPCondi(2)+10
                    PMEc3=[PMEc3(1:MyPCondi(1)-1),PMEc3(MyPCondi(2)+10:length(PMEc3))];
                  else
                    PMEc3=PMEc3(1:MyPCondi(1)-1);
                  end
                else
                  if length(PMEc3)>=MyPCondi(2)+10
                    PMEc3=PMEc3(MyPCondi(2)+10:length(PMEc3));
                  else
                    PMEc3='';
                  end
                end
              end
              if length(noempty(PMEc3,1))>0
                if length(noempty(MyPCond,1))>0
                  eval(MyPCond);
                end
              end
            end
          end        
        end
        
        if length(noempty(PMEc3,1))>0
            
          if length(tradeh(:,1))>3000
            cd(fpwserverplace);
            smps2.Runmemo='Running3 ......';
            templatefile = which('duringrun.html');      
            str = htmlrep(smps2, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\tduringrun.html'],'noheader');    
            cd([Wherematlab,'pattern']);
          end           
          
          for j=1:length(tradeh(:,1)) % for for each signal
            tp=1; i=tradeh(j,3); enp=tradeh(j,1);
            endi=tradeh(j,2); datetoday=datem(i,:);
            nis=tradeh(j,13); 
            if (strcmp(upper(fpwusername),'NINGZHU'))|...
              (strcmp(upper(fpwusername),'AARONZHU'))|...
              (strcmp(upper(fpwusername),'DIANEXU'))
              kon=nis2kon(nis);
            else
              kon=nis;  
            end
            
            if (length(tradeh(:,1))>3000)&(j>100)
              if rem(j-1,round(0.05*length(tradeh(:,1))))==0
                cd(fpwserverplace);
                templatefile = which('wbduringrun.html');
                smps2.fpwtime=[datestr(now-NOWhms,13),', ',time1];
                smps2.fpwusername=fpwusername;
                smps2.fpwrprogram = ['PM-GF: ',upper(pMname)];
                smps2.percfinished=num2str(round(100*j/length(tradeh(:,1))));
                str = htmlrep(smps2, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\twbduringrun.html'],'noheader');
                if rem(i,round(0.2*length(tradeh(:,1))))==0
                  cidsmamamiya=fpwloginstatus(fpwusername,clock);
                end
                cd([Wherematlab,'pattern']);
                % wbststopritm.mat file is issued by fpwwbststopritm.m in c:\matlab\stock.
                if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbststopritm.mat'])~=2
                  wbststopritm=0;
                  eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbststopritm.mat wbststopritm']);
                else
                  eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbststopritm.mat']);        
                  if wbststopritm==1
                    wbststopritm=0;
                    eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbststopritm.mat wbststopritm']);
                    cd(fpwserverplace);
                    smps2.Runmemo='IRQ Stopped.';
                    templatefile = which('duringrun.html');
                    str = htmlrep(smps2, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\tduringrun.html'],'noheader');
                    cd([Wherematlab,'pattern']);
                    error(['  IRQ Stop has been requested. ',num2str(j),'-',num2str(length(tradeh(:,1))),'.']);
                  end
                end
              end
            end
            
            timecal=tradeh(j,9);
            eval(PMEc3); % run DaZhaDao files(1-9)
            if tp==0 % drop this tradeh(j,:) from net1, net, tradeeach and lotshis
              Jji=Jji+1;
              tpd(j)=0;
              net1(i)=net1(i)-tradeh(j,6);
              lotshis(i:tradeh(j,5)-1,tradeh(j,12))=0*lotshis(i:tradeh(j,5)-1,tradeh(j,12));
              tradeeachi=[tradeh(j,10) fix(mean(tradeh(j,10:11)))];
              tradeeachi=[tradeeachi tradeeachi(2)+1 tradeh(j,11)];
              net(tradeeach(tradeeachi(1):tradeeachi(2)))=net(tradeeach(tradeeachi(1):tradeeachi(2)))-...
              tradeeach(tradeeachi(3):tradeeachi(4));
              tradeeach(tradeeachi(3):tradeeachi(4))=0*tradeeach(tradeeachi(3):tradeeachi(4));
            end
          end
          tpi=find(tpd==1);
          if length(tpi)>0
            tradeh=tradeh(tpi,:);
            tradeo=tradeo(tpi,:);
            tradeh2=tradeh2(tpi,:);
            tradeh3=tradeh3(tpi,:);
            tipbin=tipbin(tpi,:);
          end
          if length(tradeh(:,1))>3000
            cd(fpwserverplace);
            smps2.Runmemo='PM-Cond Done.';
            templatefile = which('duringrun.html');      
            str = htmlrep(smps2, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\tduringrun.html'],'noheader');    
            cd([Wherematlab,'pattern']);
          end 
        end
      end
      % drop the extra added datem
      datem=datem(1:length(c),:);
      
      % Secondly, checking filters due to overlap, Max Position, Max loose and max Overnight
      %   Key: to make any of these filers work, one needs to rebuild PosiBook history
      if (pfi==2)|(pfi==4)|(pfi>=6)|(mxp<222)|(mxl<222)|(mxo<222)
        TWi=ones(length(tradeh(:,1)),1); % Trade Weight Index
        tradeh(:,14)=tradeh3(:,172);
        TimeIn=tradeh(:,3)+tradeh(:,9)/24;
        TimeOut=tradeh(:,5)+tradeh(:,14)/24;
        [timein timeini]=sort(TimeIn);
        tradehI=tradeh(timeini,:); % tradeh in the order of in_time
        %[timeex timeexi]=sort(TimeOut);
        %TradehE=tradeh(timeexi,:); % tradeh in the order of out_time
        TimeClose=tradeh(1,3):length(c);
        TimeClose=TimeClose'+0.9;
        TimeA=sort([TimeIn;TimeOut;TimeClose]);
        
        if (pfi==2)|(pfi==4)|(pfi>=6)
          eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme\pmedefault\portpme2']);
          PMEc2='';
          for k=1:9
            if length(strfind(portpme2{k},'Not Assigned yet'))==0
              PMEc2=[PMEc2,portpme2{k},char(10)];
            end
          end
          
          if length(PMEc2)>0
            cd(fpwserverplace);
            [fpwscpass]=wbcheckbanw('filterc3',PMEc2);
            cd([Wherematlab,'pattern']);
            if (fpwsecucheck(PMEc2)>0)|(fpwscpass~=1)
              error(' Hei! Not allowed content found in filter conditions, are you seriously trying to .... Sorry, change it.');
            end
          end
          
          MyPCondi=strfind(PMEc2,'[pre-cals]');
          if length(MyPCondi)>0
            MyPCond='';
            if length(MyPCondi)~=2
              error('[pre-cals] pair not matched!');
            else
              MyPCond=PMEc2(MyPCondi(1)+10:MyPCondi(2)-1);
              if MyPCondi(1)>1
                if length(PMEc2)>=MyPCondi(2)+10
                  PMEc2=[PMEc2(1:MyPCondi(1)-1),PMEc2(MyPCondi(2)+10:length(PMEc2))];
                else
                  PMEc2=PMEc2(1:MyPCondi(1)-1);
                end
              else
                if length(PMEc2)>=MyPCondi(2)+10
                  PMEc2=PMEc2(MyPCondi(2)+10:length(PMEc2));
                else
                  PMEc2='';
                end
              end
            end
            if length(noempty(PMEc2,1))>0
              if length(noempty(MyPCond,1))>0
                eval(MyPCond);
              end
            end
          end
        end
        
        if length(tradeh(:,1))>3000
          cd(fpwserverplace);
          smps2.Runmemo='Running2 ......';
          templatefile = which('duringrun.html');      
          str = htmlrep(smps2, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\tduringrun.html'],'noheader');    
          cd([Wherematlab,'pattern']);
        end
          
        tpd=0*tradeh(:,1)+1; % trade pass index
        PosiBook=[1 tradeh(1,[13 1]) 0 0 tradeh(1,3)+tradeh(1,9)/24 tradeh(1,2) tradeh(1,5)+tradeh(1,14)/24 1];
          % tradeh: [enp, direction, enw, exitp, exitw, ...]
          % PosiBook: [1 kon Entryp Stopp Objep OrderTime Lotsize ExitTime reference_Ii]
        Ii=1; % index for In-serial
        for j=2:length(TimeA) 
          % to classify this trade as in-time (1), out-time (2) or close-time (3) first
          if (length(TimeA)>8000)&(j>100)
            if rem(j-1,round(0.05*length(TimeA)))==0
              cd(fpwserverplace);
              templatefile = which('wbduringrun.html');
              smps2.fpwtime=[datestr(now-NOWhms,13),', ',time1];
              smps2.fpwusername=fpwusername;
              smps2.fpwrprogram = ['PM-XOL: ',upper(pMname)];
              smps2.percfinished=num2str(round(100*j/length(TimeA)));
              str = htmlrep(smps2, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\twbduringrun.html'],'noheader');
              if rem(i,round(0.2*length(TimeA)))==0
                cidsmamamiya=fpwloginstatus(fpwusername,clock);
              end
              cd([Wherematlab,'pattern']);
              % wbststopritm.mat file is issued by fpwwbststopritm.m in c:\matlab\stock.
              if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbststopritm.mat'])~=2
                wbststopritm=0;
                eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbststopritm.mat wbststopritm']);
              else
                eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbststopritm.mat']);        
                if wbststopritm==1
                  wbststopritm=0;
                  eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbststopritm.mat wbststopritm']);
                  cd(fpwserverplace);
                  smps2.Runmemo='IRQ Stopped.';
                  templatefile = which('duringrun.html');
                  str = htmlrep(smps2, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\tduringrun.html'],'noheader');
                  cd([Wherematlab,'pattern']);
                  error(['  IRQ Stop has been requested. ',num2str(j),'-',num2str(length(TimeA)),'.']);
                end
              end
            end
          end
          
          % first check old trades out, can be multiple
          if length(PosiBook)>0
            outPn=find(PosiBook(:,8)<=TimeA(j)+0.00001);
            if length(outPn)>0
              PosiBook(outPn,1)=0*PosiBook(outPn,1)-1;
              Posileft=find(PosiBook(:,1)>0);
              if length(Posileft)>0
                PosiBook=PosiBook(Posileft,:);
              else
                PosiBook=[];
              end
            end
          end
          
          % then checking if new trade(s) coming in
          newIn=0;
          while (Ii+newIn<length(tradehI(:,1)))&...
            (tradehI(Ii+1+newIn,3)+tradehI(Ii+1+newIn,9)/24<=TimeA(j)+0.00001)
            newIn=newIn+1;
          end
          if newIn>0 % new trades getting in
            for nti=1:newIn 
              % add to PosiBook:
              tp=1;
              Ii=Ii+1;
              if tpd(timeini(Ii))==1
                if length(PosiBook)>0
                  PosiBook(length(PosiBook(:,1))+1,:)=[1 tradehI(Ii,[13 1]) 0 0 tradehI(Ii,3)+tradehI(Ii,9)/24 tradehI(Ii,2) tradehI(Ii,5)+tradehI(Ii,14)/24 Ii];
                else
                  PosiBook=[1 tradehI(Ii,[13 1]) 0 0 tradehI(Ii,3)+tradehI(Ii,9)/24 tradehI(Ii,2) tradehI(Ii,5)+tradehI(Ii,14)/24 Ii];
                end
                tipbin(timeini(Ii),:)=[length(PosiBook(:,1)) sum(PosiBook(:,7))];
                
                % Once getting in to the Position Book, many things begin to check
                % First, checking overlaping if needed
                if (pfi==2)|(pfi==4)|(pfi>=6)
                  % get parameters:
                  i=tradehI(Ii,3); enp=tradehI(Ii,1);
                  endi=tradehI(Ii,2); datetoday=datem(i,:);
                  nis=tradehI(Ii,13); timecal=tradehI(Ii,9);
                  eval(PMEc2); % run overlap files(1-9)
                  if tp==0 %drop it from PosiBook
                    Cci=Cci+1;
                    if length(PosiBook(:,1))>1  
                      PosiBook=PosiBook(1:length(PosiBook(:,1))-1,:);
                    else
                      PosiBook=[];
                    end
                  end
                  
                  if tp==0 % drop this tradeh(j,:) from net1, net, tradeeach and lotshis
                    tpd(timeini(Ii))=0;
                    net1(i)=net1(i)-tradeh(timeini(Ii),6);
                    lotshis(i:tradeh(timeini(Ii),5)-1,tradeh(timeini(Ii),12))=0*lotshis(i:tradeh(timeini(Ii),5)-1,tradeh(timeini(Ii),12));
                    tradeeachi=[tradeh(timeini(Ii),10) fix(mean(tradeh(timeini(Ii),10:11)))];
                    tradeeachi=[tradeeachi tradeeachi(2)+1 tradeh(timeini(Ii),11)];
                    net(tradeeach(tradeeachi(1):tradeeachi(2)))=net(tradeeach(tradeeachi(1):tradeeachi(2)))-...
                    tradeeach(tradeeachi(3):tradeeachi(4));
                    tradeeach(tradeeachi(3):tradeeachi(4))=0*tradeeach(tradeeachi(3):tradeeachi(4));
                  end
                end
                  
                if tp==1 % further checking mxp mxl
                  % checking mxp
                  if (sum(PosiBook(:,7))>mxpl)|(sum(PosiBook(:,7))<-mxps)
                    Hhi=Hhi+1;
                    tp=0;    
                  end
                  
                  % checking mxl
                  if tp==1
                    endi=tradehI(Ii,2);
                    if endi>0
                      mxl=mxll; 
                    else
                      mxl=mxls;
                    end
                    enp=tradehI(Ii,1);
                    tiln=find((PosiBook(:,7)*endi>0)&(endi*(enp-PosiBook(:,3))<0-0.00001));
                    if length(tiln)>mxl
                      Ggi=Ggi+1;
                      tp=0;
                    end                  
                  end
                    
                  if tp==0 %drop it from PosiBook
                    if length(PosiBook(:,1))>1  
                      PosiBook=PosiBook(1:length(PosiBook(:,1))-1,:);
                    else
                      PosiBook=[];
                    end
                  end
                  
                  if tp==0 % drop this tradeh(j,:) from net1, net, tradeeach and lotshis
                    tpd(timeini(Ii))=0;
                    i=tradehI(Ii,3); 
                    net1(i)=net1(i)-tradehI(Ii,6);
                    lotshis(i:tradehI(Ii,5)-1,tradehI(Ii,12))=0*lotshis(i:tradehI(Ii,5)-1,tradehI(Ii,12));
                    tradeeachi=[tradeh(timeini(Ii),10) fix(mean(tradeh(timeini(Ii),10:11)))];
                    tradeeachi=[tradeeachi tradeeachi(2)+1 tradeh(timeini(Ii),11)];
                    net(tradeeach(tradeeachi(1):tradeeachi(2)))=net(tradeeach(tradeeachi(1):tradeeachi(2)))-...
                    tradeeach(tradeeachi(3):tradeeachi(4));
                    tradeeach(tradeeachi(3):tradeeachi(4))=0*tradeeach(tradeeachi(3):tradeeachi(4));
                  end
                end
              end
            end
          end
          
          % checking overnight limits
          if (round(rem(TimeA(j),1)*10)==9)&(length(PosiBook)>0) % market closed
            if (sum(PosiBook(:,7))>mxol)|(sum(PosiBook(:,7))<-mxos) % too many overnight trades
              odi=sum(PosiBook(:,7));
              odid=0;
              if sum(PosiBook(:,7))>0
                mxo=mxol;
              else
                mxo=mxos;
              end
              for i=1:length(PosiBook(:,1))
                if (sign(PosiBook(i,7))==sign(odi))&(fix(PosiBook(i,8))>fix(TimeA(j)))
                  % to exit this overnight trade earlier
                  PosiBook(i,1)=-1; Ffi=Ffi+1;
                  cth=timeini(PosiBook(i,9));
                  if tradeh(cth,3)==tradeeach(tradeh(cth,10))  % not in at close
                    lotshis(fix(TimeA(j)):tradeh(cth,5)-1,tradeh(cth,12))=0*lotshis(fix(TimeA(j)):tradeh(cth,5)-1,tradeh(cth,12));
                    if fix(TimeA(j))==tradeh(cth,3)
                      lotshis(fix(TimeA(j)),tradeh(cth,12))=tradeh(cth,2);
                      stph=1;
                    else
                      lotshis(tradeh(cth,3):fix(TimeA(j))-1,tradeh(cth,12))=0*lotshis(tradeh(cth,3):fix(TimeA(j))-1,tradeh(cth,12))+tradeh(cth,2);
                      stph=fix(TimeA(j))-tradeh(cth,3)+1;
                    end
                    tradeeachi=[tradeh(cth,10) fix(mean(tradeh(cth,10:11)))];
                    tradeeachi=[tradeeachi tradeeachi(2)+1 tradeh(cth,11)];
                    NewNet=sum(tradeeach(tradeeachi(3):tradeeachi(3)+stph-1))-zhusc75(tradeh(cth,13));
                    net1(tradeh(cth,3))=net1(tradeh(cth,3))-tradeh(cth,6)+NewNet; %(count at signal day only)             
                    tradeh(cth,6)=NewNet;
                    tradeo(cth,:)=[fix(TimeA(j)) c(fix(TimeA(j))) 23];                
                    net(tradeeach(tradeeachi(1):tradeeachi(2)))=net(tradeeach(tradeeachi(1):tradeeachi(2)))-...
                      tradeeach(tradeeachi(3):tradeeachi(4)); % first drop all
                    tradeeach(tradeeachi(3)+stph-1)=tradeeach(tradeeachi(3)+stph-1)-zhusc75(tradeh(cth,13));
                    tradeeach(tradeeachi(3)+stph:tradeeachi(4))=0*tradeeach(tradeeachi(3)+stph:tradeeachi(4));
                    net(tradeeach(tradeeachi(1):tradeeachi(2)))=net(tradeeach(tradeeachi(1):tradeeachi(2)))+...
                      tradeeach(tradeeachi(3):tradeeachi(4));
                    tradeh(cth,5)=fix(TimeA(j));
                  else % triggered at close, so simply as no trade
                    tpd(cth)=0; Iii=Iii+1;
                    net1(tradeh(cth,3))=net1(tradeh(cth,3))-tradeh(cth,6);
                    lotshis(tradeh(cth,3):tradeh(cth,5)-1,tradeh(cth,12))=0*lotshis(tradeh(cth,3):tradeh(cth,5)-1,tradeh(cth,12));
                    tradeeachi=[tradeh(cth,10) fix(mean(tradeh(cth,10:11)))];
                    tradeeachi=[tradeeachi tradeeachi(2)+1 tradeh(cth,11)];
                    net(tradeeach(tradeeachi(1):tradeeachi(2)))=net(tradeeach(tradeeachi(1):tradeeachi(2)))-...
                    tradeeach(tradeeachi(3):tradeeachi(4));
                    tradeeach(tradeeachi(3):tradeeachi(4))=0*tradeeach(tradeeachi(3):tradeeachi(4));
                  end
                  
                  odid=odid+1;
                  if abs(odi)-odid<=mxo
                    % has already exit enough trades
                    % clean up PosiBook
                    PosiBook=PosiBook(find(PosiBook(:,1)~=-1),:);
                    break;
                  end
                end
              end
            end
          end
        end
        
        tpi=find(tpd==1);
        if length(tpi)>0
          tradeh=tradeh(tpi,:);
          tradeo=tradeo(tpi,:);
          tradeh2=tradeh2(tpi,:);
          tradeh3=tradeh3(tpi,:);
          tipbin=tipbin(tpi,:);
        end
        if length(tradeh(:,1))>3000
          cd(fpwserverplace);
          smps2.Runmemo='PM-XOL Done.';
          templatefile = which('duringrun.html');      
          str = htmlrep(smps2, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\tduringrun.html'],'noheader');    
          cd([Wherematlab,'pattern']);
        end 
      end
      
      if length(tradeh(:,1))>3000
        cd(fpwserverplace);
        smps2.Runmemo='Running ......';
        templatefile = which('duringrun.html');      
        str = htmlrep(smps2, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\tduringrun.html'],'noheader');    
        cd([Wherematlab,'pattern']);
      end
      
      % Finally, making volatility and weight correction
      if (pfi==1)|(pfi==7)|(pfi==4)|(pfi==5)|(mxv<222)
        mwi=ones(1,207);
        
        if (pfi==1)|(pfi==7)|(pfi==4)|(pfi==5)
          eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme\pmedefault\portpme1']);
          PMEc1='';
          for k=1:9
            if length(strfind(portpme1{k},'Not Assigned yet'))==0
              PMEc1=[PMEc1,portpme1{k},char(10)];
            end
          end
          if length(PMEc1)>0
            cd(fpwserverplace);
            [fpwscpass]=wbcheckbanw('filterc3',PMEc1);
            cd([Wherematlab,'pattern']);
            if (fpwsecucheck(PMEc1)>0)|(fpwscpass~=1)
              error(' Hei! Not allowed content found in filter conditions, are you seriously trying to .... Sorry, change it.');
            end
          end
          MyPCondi=strfind(PMEc1,'[pre-cals]');
          if length(MyPCondi)>0
            error(' For model weights files, it does not need pre-calculations! Please drop them.')
          end
          eval(PMEc1); % run special trading weight files(1-9)
        end
        
        if 1 %mxv<222
          vo5=100*ma(h-l,5)./c;
          for ii=1:length(tradeh(:,1))
            if vo5(tradeh(ii,3)-1)>mxv
              VCRAFi=mwi(tradeh(ii,13))*round(100*mxv/vo5(tradeh(ii,3)-1))/100;
              Bbi=Bbi+1;
            else
              VCRAFi=mwi(tradeh(ii,13));
            end
            if VCRAFi~=1
              % making the weighting adjustment, trading volume may need to reduce
              lotshis(tradeh(ii,3):tradeh(ii,5)-1,tradeh(ii,12))=VCRAFi*lotshis(tradeh(ii,3):tradeh(ii,5)-1,tradeh(ii,12));
              net1(tradeh(ii,3))=net1(tradeh(ii,3))-(1-VCRAFi)*tradeh(ii,6); %(count at signal day only)             
              tradeh(ii,6)=VCRAFi*tradeh(ii,6);
              tradeh(ii,2)=VCRAFi*tradeh(ii,2);
              tradeeachi=[tradeh(ii,10) fix(mean(tradeh(ii,10:11)))];
              tradeeachi=[tradeeachi tradeeachi(2)+1 tradeh(ii,11)];
              net(tradeeach(tradeeachi(1):tradeeachi(2)))=net(tradeeach(tradeeachi(1):tradeeachi(2)))-...
                (1-VCRAFi)*tradeeach(tradeeachi(3):tradeeachi(4));
              tradeeach(tradeeachi(3):tradeeachi(4))=VCRAFi*tradeeach(tradeeachi(3):tradeeachi(4));
            end
          end
        end
      end
      if length(tradeh(:,1))>3000
        cd(fpwserverplace);
        templatefile = which('wbduringrun.html');
        smps2.fpwtime=[datestr(now-NOWhms,13),', ',time1];
        smps2.fpwusername=fpwusername;
        smps2.fpwrprogram = ['PM-XOL: ',upper(pMname)];
        smps2.percfinished='100';
        str = htmlrep(smps2, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\twbduringrun.html'],'noheader');
        smps2.Runmemo='Completed.';
        templatefile = which('duringrun.html');      
        str = htmlrep(smps2, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\tduringrun.html'],'noheader');    
        cd([Wherematlab,'pattern']);
      end 
    end
    
    if DropNet1>0
      tpdon=0*tradeh(:,1);
      tpdoni=find(abs(tipbin(:,2))>DropNet1);
      if length(tpdoni)>0
        tpdon(tpdoni)=tpdon(tpdoni)+1;
        for j=1:length(tradeh(:,1))
          if tpdon(j)==0
            % drop this trade
            Aai=Aai+1;
            net1(tradeh(j,3))=net1(tradeh(j,3))-tradeh(j,6);
            lotshis(tradeh(j,3):tradeh(j,5)-1,tradeh(j,12))=0*lotshis(tradeh(j,3):tradeh(j,5)-1,tradeh(j,12));
            tradeeachi=[tradeh(j,10) fix(mean(tradeh(j,10:11)))];
            tradeeachi=[tradeeachi tradeeachi(2)+1 tradeh(j,11)];
            net(tradeeach(tradeeachi(1):tradeeachi(2)))=net(tradeeach(tradeeachi(1):tradeeachi(2)))-...
            tradeeach(tradeeachi(3):tradeeachi(4));
            tradeeach(tradeeachi(3):tradeeachi(4))=0*tradeeach(tradeeachi(3):tradeeachi(4));
          end
        end
        tradeh=tradeh(tpdoni,:);
        tradeo=tradeo(tpdoni,:);
        tradeh2=tradeh2(tpdoni,:);
        tradeh3=tradeh3(tpdoni,:);
      end
    end
    %save c:\matlab\pattern\mybug201608029.mat
    
    fpwout.datem=Datem; fpwout.stock=Stock; fpwout.net=net; fpwout.net1=net1; fpwout.lotshis=lotshis;
    fpwout.tradeh=tradeh; fpwout.tradeh2=tradeh2; fpwout.tradeh3=tradeh3;
    if DropNet1==0; fpwout.tipbin=tipbin; end
    fpwout.tradeo=tradeo; fpwout.tradeeach=tradeeach; fpwout.pdzhu=pdzhu;
    fpwout.mname=pMname(1); 
    if (strcmp(upper(pMname(2:length(pMname))),'PZ'))|(strcmp(upper(pMname(2:length(pMname))),'PX'))|...
      (strcmp(upper(pMname(2:length(pMname))),'PQ'))|(strcmp(upper(pMname(2:length(pMname))),'PA'))|...
      (strcmp(upper(pMname(2:length(pMname))),'PN'))
      fpwout.name='PY';
      fpwout.nameNZE=pMname(2:length(pMname));
    else
      fpwout.name=pMname(2:length(pMname));
    end
    fpwout.zhu52='1'; fpwout.zhu54='1';
    fpwout.wsscale=1;
    fpwout.zhu75=zhu75;
    fpwout.zhusc75=zhusc75;
    
    if fpwout.tradeh(1,1)~=0    
      fpwoutwindow=21;
      cd([Wherematlab,'\pattern']);
      fpwoutf2(fpwusername);
      eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwoutput fpwout']);  
      fpwout.outonoff='0';
      fpwout.fpwsource='fpwoutput';
      fpwout1=fpwozc3(fpwout);    
      fpwout1.fpwsource='fpwoutput';
      fpwout1.fpwusername=fpwusername;
      fpwout1.fpwusername4=fpwusername4;
      fpwout1.fpwulvl=instruct.fpwulvl;
      fpwout1.outrunindex='00';
      fpwout1.fpwdailynet=[fpwclientdirectory,fpwusername,'\pattern\fpwdailynet.txt'];
                 
      set(fpwout1.fpwoutfig,'PaperPosition',MyPaperPosiH);
      cd([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern']);
      drawnow;
      wsprintjpeg(fpwout1.fpwoutfig,'fpwoutjpeg.jpeg');
      close(fpwout1.fpwoutfig);
      cd([Wherematlab,'pattern']);
      fpwout1.fpwoutjpeg=[fpwclientdirectory,fpwusername,'\pattern\fpwoutjpeg.jpeg']; 
    else
      fpwoutwindow=24;
      fpwout1.fpwusername=fpwusername;
      fpwout1.fpwusername4=fpwusername4;
      fpwout1.fpwulvl=instruct.fpwulvl;
      fpwout1.outrunindex='00';               
    end
    
    NLHfor=['[',num2str(pdzhu(1))];
    if length(pdzhu)>1
      for i=2:length(pdzhu)
        NLHfor=[NLHfor,' ',num2str(pdzhu(i))];
      end
    end
    NLHfor=[NLHfor,']'];
    
    if 0 % for old ways
      s.StatusReport=['This is a combination of models: ',NLHfor,' of ',upper(pMname),'. ',time];
    else
      s.StatusReport=['Blocked or shorten trades: GF(DZD): ',int2str(Jji),', Overlap: ',int2str(Cci),...
      ', MxPosi: ',int2str(Hhi),', MxLoss: ',int2str(Ggi),', MxOverNight: ',int2str(Ffi),' / ',int2str(Iii),...
      ', VCAed: ',int2str(Bbi)];
      if DropNet1>0
        s.StatusReport=[s.StatusReport,', DropFNP',int2str(DropNet1),': ',int2str(Aai)];
      end
    end
    templatefile = which('MPsimulationR1.html');
    str = htmlrep(s, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\twbfpwoutputR1.html'],'noheader');      
    fpwout1.FPWoutstatus=strrep([fpwclientdirectory,fpwusername,'\pattern\twbfpwoutputR1.html'],'\','/');  

  elseif strcmp(outrunindex,'414')
    % model correlation modelindex
    eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portfront']);
    pMname=noempty(instruct.pMname);
    portchosen=char(zeros(1,207)+48);
    portchosenum=zeros(1,207);
    for i=1:207
      if isfield(instruct,['pS',num2str(i)])
        portchosen(i)='1';   portchosenum(i)=1; 
      end
      eval(['modelindex=noempty(fpwport.PAzhu',num2str(i),');']);
      if length(modelindex)
        PAzhu(i)=str2num(modelindex);
      else
        PAzhu(i)=0;
      end
    end
    PAzhu=portchosenum.*PAzhu;
    pdzhu=PAzhu(find(PAzhu~=0));   
    
    PBCOR=str2num(noempty(instruct.pMCT));
    if rem(PBCOR,1)==0
      AllOrSame='S';
    else
      AllOrSame='A';
      PBCOR=fix(PBCOR);
    end
    if length(find(pdzhu-PBCOR==0))==0
      error(' - The model you entered is not among the model list you chose.');
    end    
    
    Datem=[];
    for i=1:length(pdzhu)
      eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data2\fpwt',pMname,num2str(pdzhu(i))]);
      if length(Datem)~=0
        datem=fpwout.datem; stock=fpwout.stock;
        if dnabs(datem(1,1:3))<dnabs(Datem(1,1:3))
          dindex=datef2(Datem(1,1:3),datem);
          Datem=[datem(1:dindex-1,1:3);Datem];
        end
        if dnabs(datem(length(datem(:,1)),1:3))>dnabs(Datem(length(Datem(:,1)),1:3))
          dindex=datef2(Datem(length(Datem(:,1)),1:3),datem);
        end        
      else
        Datem=fpwout.datem;
      end
    end
    
    Lotshis=zeros(length(Datem(:,1)),length(pdzhu));PBNUM=zeros(1,length(pdzhu)); PBcor=PBNUM;
    for i=1:length(pdzhu)
      eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data2\fpwt',pMname,num2str(pdzhu(i))]);
      datem=fpwout.datem; lotshis=fpwout.lotshis; tradeh=fpwout.tradeh;
      if length(lotshis(1,:))>1;  lotshis=(sum(lotshis'))'; end
      lotshis=0*lotshis; lotshis(tradeh(:,3))=sign(tradeh(1,2))*ones(size(tradeh(:,3)));
      clear fpwout
      dindexb=datef2(datem(1,1:3),Datem);
      if dindexb~=1
        lotshis=[zeros(dindexb-1,1);lotshis];
      end
      dindexe=datef2(datem(length(datem(:,1)),1:3),Datem);
      if dindexe~=length(Datem(:,1))
        lotshis=[lotshis;zeros(length(Datem(:,1))-length(datem(:,1)),1)];
      end
      Lotshis(:,i)=lotshis;
      PBNUM(i)=length(tradeh(:,1));
      clear lotshis datem tradeh
    end    
    
    LotshisZhu=Lotshis(:,find(pdzhu==PBCOR));
    for i=1:length(pdzhu)
      if AllOrSame=='S'
        PBcor(i)=length(find(abs(LotshisZhu+Lotshis(:,i))==2)); % only care about same direction trades, so it's not abs(L)+abs(l)
      else
        PBcor(i)=length(find(abs(LotshisZhu)+abs(Lotshis(:,i))==2));
      end
    end
    clear LotshisZhu
    [PBcww PBciw]=sort(-PBcor);
    PBcor=PBcor(PBciw);
    PBNUM=PBNUM(PBciw);
    pdzhu=pdzhu(PBciw);
    
    for i=1:13
      if i<=length(pdzhu)
        eval(['fpwport.c',num2str(i),num2str(1),'=',num2str(pdzhu(i)),';']);
        eval(['fpwport.c',num2str(i),num2str(2),'=',num2str(PBcor(i)),';']);
        eval(['fpwport.c',num2str(i),num2str(3),'=',num2str(PBNUM(i)),';']);
      else
        eval(['fpwport.c',num2str(i),num2str(1),'='' '';']);
        eval(['fpwport.c',num2str(i),num2str(2),'='' '';']);
        eval(['fpwport.c',num2str(i),num2str(3),'='' '';']); 
      end
    end   
    fpwport.pMname=pMname;
    fpwport.pMCT=num2str(PBCOR);
    for i=1:27
      if i<19
        eval(['fpwport.PBzhu',num2str(i),'=instruct.PBzhu',num2str(i),';']);
      end
      eval(['fpwport.PCzhu',num2str(i),'=instruct.PCzhu',num2str(i),';']);
    end    
    fpwport.Pzhu108=instruct.Pzhu108; 
    fpwport.Pzhu110=instruct.Pzhu110;
    fpwport.Pzhu111=instruct.Pzhu111; 
    fpwport.Pzhu112=instruct.Pzhu112;
    fpwport.Pzhu300=instruct.hdPzhu300; % 'models' or 'lots', not in use any more.
    fpwport.Pzhu121=instruct.Pzhu121; 
    fpwport.Pzhu301=instruct.Pzhu301;
    fpwport.Pzhu303=instruct.Pzhu303;
    fpwport.Pzhu305=instruct.Pzhu305;
    if isfield(instruct,'pS208')
      portchosen(208)='1';
    end
    fpwport.portchosen=portchosen;
    
    fpwport.fpwusername=fpwusername;
    fpwport.fpwusername4=fpwusername4;
    fpwport.fpwulvl=instruct.fpwulvl;
    fpwport.outrunindex=outrunindex;
    eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portfront fpwport']);
  
  elseif strcmp(outrunindex,'416')
    % Add all chosen models together
    eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portfront']);
    pMname=noempty(instruct.pMname);
    portchosen=char(zeros(1,207)+48);
    portchosenum=zeros(1,207);
    load c:\matlab\pattern\tradehsizes.mat
    
    for i=1:207
      if isfield(instruct,['pS',num2str(i)])
        portchosen(i)='1';   portchosenum(i)=1; 
      end
      eval(['modelindex=noempty(fpwport.PAzhu',num2str(i),');']);
      if length(modelindex)
        PAzhu(i)=str2num(modelindex);
      else
        PAzhu(i)=0;
      end
    end
    PAzhu=portchosenum.*PAzhu;
    pdzhu=PAzhu(find(PAzhu~=0));    
    
    for i=1:27
      if i<19
        eval(['fpwport.PBzhu',num2str(i),'=instruct.PBzhu',num2str(i),';']);
      end
      eval(['fpwport.PCzhu',num2str(i),'=instruct.PCzhu',num2str(i),';']);
    end
       
    fpwport.Pzhu108=instruct.Pzhu108; 
    fpwport.Pzhu110=instruct.Pzhu110;
    fpwport.Pzhu111=instruct.Pzhu111; 
    fpwport.Pzhu112=instruct.Pzhu112;
    fpwport.Pzhu300=instruct.hdPzhu300; % 'models' or 'lots', not in use any more.
    fpwport.Pzhu121=instruct.Pzhu121; 
    fpwport.Pzhu301=instruct.Pzhu301;
    fpwport.Pzhu303=instruct.Pzhu303;
    fpwport.Pzhu305=instruct.Pzhu305;
    if isfield(instruct,'pS208')
      portchosen(208)='1';
    end
    fpwport.portchosen=portchosen;
    eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portfront fpwport']);
    
    if length(pdzhu)==0
      error(' You did not choose any model yet.');  
    end
    
    if 1 % original way to adding up, fast
      Datem=[]; Stock=[];
      % use time to exchange ROM space, load them twice to save mem ussage.
      for i=1:length(pdzhu)
        eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data2\fpwt',pMname,num2str(pdzhu(i))]);
        if length(Datem)~=0
          datem=fpwout.datem; stock=fpwout.stock;
          if dnabs(datem(1,1:3))<dnabs(Datem(1,1:3))
            dindex=datef2(Datem(1,1:3),datem);
            Datem=[datem(1:dindex-1,1:3);Datem];
            Stock=[stock(1:dindex-1,1:5);Stock];
          end
          if dnabs(datem(length(datem(:,1)),1:3))>dnabs(Datem(length(Datem(:,1)),1:3))
            dindex=datef2(Datem(length(Datem(:,1)),1:3),datem);
            Datem=[Datem; datem(dindex+1:length(datem(:,1)),1:3)];
            Stock=[Stock; stock(dindex+1:length(stock(:,1)),1:5)];
          end        
        else
          Datem=fpwout.datem; Stock=fpwout.stock;
        end
      end
      NET=0*Datem(:,1); NET1=NET; Lotshis=zeros(length(NET),length(pdzhu));
      Tradeh=[]; Tradeh2=[]; Tradeh3=[]; Tradeo=[]; Tradeeach=[];
      zhusc75=zeros(207,1); % only used by LABAC(ii,3) in wbfpwoutput
      
      for i=1:length(pdzhu)
        eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data2\fpwt',pMname,num2str(pdzhu(i))]);
        datem=fpwout.datem; net=fpwout.net; net1=fpwout.net1; lotshis=fpwout.lotshis; 
        tradeh=fpwout.tradeh; tradeo=fpwout.tradeo; tradeeach=fpwout.tradeeach; 
        zhu75=fpwout.zhu75; zhusc75(pdzhu(i))=str2num(zhu75);
        if isfield(fpwout,'tradeh2')==1
          tradeh2=fpwout.tradeh2; tradeh3=fpwout.tradeh3;
          if (length(tradeh2(1,:))<TradehSizes(1))|(length(tradeh3(1,:))<TradehSizes(2))
            d23show=[' Not enough T2 or T3 data for ',int2str(pdzhu(i)),'.'];
          end
          if length(tradeh2(1,:))~=TradehSizes(1)
            tradeh2=[tradeh2 zeros(length(tradeh(:,1)),TradehSizes(1)-length(tradeh2(1,:)))];
          end
          if length(tradeh3(1,:))~=TradehSizes(2)
            tradeh3=[tradeh3 zeros(length(tradeh(:,1)),TradehSizes(2)-length(tradeh3(1,:)))];
          end
        else
          d23show=[' No T2 or T3 data for ',num2str(pdzhu(i))];
          tradeh2=zeros(length(tradeh(:,1)),TradehSizes(1));
          tradeh3=zeros(length(tradeh(:,1)),TradehSizes(2));
        end
        
        if length(lotshis(1,:))>1;  lotshis=(sum(lotshis'))'; end
        dindexb=datef2(datem(1,1:3),Datem);
        if dindexb~=1
          net=[zeros(dindexb-1,1);net];
          net1=[zeros(dindexb-1,1);net1];
          lotshis=[zeros(dindexb-1,1);lotshis];
          % correct tradeeach first
          for ii=1:length(tradeh(:,3))
            tradeeach(tradeh(ii,10):(tradeh(ii,10)+tradeh(ii,11)-1)/2)=...
            tradeeach(tradeh(ii,10):(tradeh(ii,10)+tradeh(ii,11)-1)/2)+dindexb-1;
          end        
          tradeh(:,3)=tradeh(:,3)+dindexb-1;
          tradeh(:,5)=tradeh(:,5)+dindexb-1;
          tradeo(:,1)=tradeo(:,1)+dindexb-1;
        end
        dindexe=datef2(datem(length(datem(:,1)),1:3),Datem);
        if dindexe~=length(Datem(:,1))
          net=[net;zeros(length(Datem(:,1))-length(datem(:,1)),1)];
          net1=[net1;zeros(length(Datem(:,1))-length(datem(:,1)),1)]; 
          lotshis=[lotshis;zeros(length(Datem(:,1))-length(datem(:,1)),1)];
        end
        
        NET=NET+net;
        NET1=NET1+net1;
        Lotshis(:,i)=lotshis;
        tradeh(:,12)=0*tradeh(:,12)+i;
        tradeh(:,13)=0*tradeh(:,12)+pdzhu(i);
        tradeh(:,10)=tradeh(:,10)+length(Tradeeach);
        tradeh(:,11)=tradeh(:,11)+length(Tradeeach);
        Tradeh=[Tradeh;tradeh];
        Tradeh2=[Tradeh2;tradeh2];
        Tradeh3=[Tradeh3;tradeh3];
        Tradeo=[Tradeo;tradeo];
        Tradeeach=[Tradeeach;tradeeach];  
        clear net net1 tradeo tradeh tradeeach lotshis datem
      end    
      
      net=NET;net1=NET1;tradeh=Tradeh;clear Tradeh NET NET1
      tradeh2=Tradeh2;tradeh3=Tradeh3;clear Tradeh2 Tradeh3
      tradeo=Tradeo; clear Tradeo 
      lotshis=Lotshis; clear Lotshis
      tradeeach=Tradeeach; clear Tradeeach
      [qww qiw]=sort(tradeh(:,3));
      tradeh=[tradeh(qiw,:)];
      tradeh2=[tradeh2(qiw,:)];
      tradeh3=[tradeh3(qiw,:)];
      tradeo=tradeo(qiw,:);
          
      fpwout.datem=Datem; fpwout.stock=Stock; fpwout.net=net; fpwout.net1=net1; fpwout.lotshis=lotshis;
      fpwout.tradeh=tradeh; fpwout.tradeo=tradeo; fpwout.tradeeach=tradeeach; fpwout.pdzhu=pdzhu;
      fpwout.tradeh2=tradeh2; fpwout.tradeh3=tradeh3;
      fpwout.zhu75=zhu75; fpwout.zhusc75=zhusc75;
      fpwout.zhu52='1'; fpwout.zhu54='1';
      fpwout.wsscale=1;
    else  % can handle different datem to combine, but much slower! 2 times at least up to 50 times.
      zhusc75=zeros(207,1); % only used by LABAC(ii,3) in wbfpwoutput
      for i=1:length(pdzhu)
        eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data2\fpwt',pMname,num2str(pdzhu(i))]);
        zhu75=fpwout.zhu75; zhusc75(pdzhu(i))=str2num(zhu75);
        if i>1
          fpwout.tradeh(:,12)=0*fpwout.tradeh(:,12)+i;
          fpwout.tradeh(:,13)=0*fpwout.tradeh(:,12)+pdzhu(i);
          Fpwout1=fpwoutadd(Fpwout,fpwout);
          Fpwout=Fpwout1;
        else
          fpwout.tradeh(:,12)=0*fpwout.tradeh(:,12)+1;
          fpwout.tradeh(:,13)=0*fpwout.tradeh(:,12)+pdzhu(i);
          Fpwout=fpwout;
        end
      end
      fpwout.pdzhu=pdzhu;
      fpwout=Fpwout;
      fpwout.zhu75=zhu75; fpwout.zhusc75=zhusc75;
    end %new
    
    fpwout.mname=pMname(1);
    if (strcmp(upper(pMname(2:length(pMname))),'PZ'))|(strcmp(upper(pMname(2:length(pMname))),'PX'))|...
      (strcmp(upper(pMname(2:length(pMname))),'PQ'))|(strcmp(upper(pMname(2:length(pMname))),'PA'))|...
      (strcmp(upper(pMname(2:length(pMname))),'PN'))
      fpwout.name='PY';
      fpwout.nameNZE=pMname(2:length(pMname));
    else
      fpwout.name=pMname(2:length(pMname));
    end
    
    if fpwout.tradeh(1,1)~=0    
      fpwoutwindow=21;
      cd([Wherematlab,'\pattern']);
      fpwoutf2(fpwusername);
      eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwoutput fpwout']);  
      fpwout.outonoff='0';
      fpwout.fpwsource='fpwoutput';
      fpwout1=fpwozc3(fpwout);    
      fpwout1.fpwsource='fpwoutput';
      fpwout1.fpwusername=fpwusername;
      fpwout1.fpwusername4=fpwusername4;
      fpwout1.fpwulvl=instruct.fpwulvl;
      fpwout1.outrunindex=outrunindex;
      fpwout1.fpwdailynet=[fpwclientdirectory,fpwusername,'\pattern\fpwdailynet.txt'];
                 
      set(fpwout1.fpwoutfig,'PaperPosition',MyPaperPosiH);
      cd([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern']);
      drawnow;
      wsprintjpeg(fpwout1.fpwoutfig,'fpwoutjpeg.jpeg');
      close(fpwout1.fpwoutfig);
      cd([Wherematlab,'pattern']);
      fpwout1.fpwoutjpeg=[fpwclientdirectory,fpwusername,'\pattern\fpwoutjpeg.jpeg']; 
      
      NLHfor=['[',num2str(pdzhu(1))];
      if length(pdzhu)>1
        for i=2:length(pdzhu)
          NLHfor=[NLHfor,' ',num2str(pdzhu(i))];
        end
      end
      NLHfor=[NLHfor,']'];
          
      s.StatusReport=['This is a combination of models: ',NLHfor,' of ',upper(pMname),'. ',time];
      templatefile = which('MPsimulationR1.html');
      str = htmlrep(s, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\twbfpwoutputR1.html'],'noheader');      
      fpwout1.FPWoutstatus=strrep([fpwclientdirectory,fpwusername,'\pattern\twbfpwoutputR1.html'],'\','/');    
    else
      fpwoutwindow=24;
      fpwout1.fpwusername=fpwusername;
      fpwout1.fpwusername4=fpwusername4;
      fpwout1.fpwulvl=instruct.fpwulvl;
      fpwout1.outrunindex='00';               
    end  
    
  elseif strcmp(outrunindex,'417')
    eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portfront']);
    fpwport.fpwusername=fpwusername;
    fpwport.fpwusername4=fpwusername4;
    if isfield(fpwport,'Pzhu301')==0
      fpwport.Pzhu121='4';
      fpwport.PCzhu1='208';
      fpwport.Pzhu301='[2 3]';
      fpwport.Pzhu303='99';
      fpwport.Pzhu305='3.00';
      fpwport.portchosen(208)='1';
      fpwport.Pzhu112='7';
    end     
  elseif strcmp(outrunindex,'418')
    fpwport.fpwusername=fpwusername;
    fpwport.fpwusername4=fpwusername4;
    firsttimeuseid=0;
    if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme'])~=7
      cd([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern']);
      mkdir('portpme');
      cd([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme']);
      mkdir('pmeDefault');
      mkdir('pmeBackup'); % Save to a safe place
      cd([Wherematlab,'\pattern']);
      if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme1.mat'])==2
        firsttimeuseid=1;
        eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme1']);
        eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme\pmeBackup\portpme1.mat portpme1']);
        eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme\pmeDefault\portpme1.mat portpme1']);  
      end
      if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme2.mat'])==2
        firsttimeuseid=1;
        eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme2']);
        eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme\pmeBackup\portpme2.mat portpme2']);
        eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme\pmeDefault\portpme2.mat portpme2']);
      end
      if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme3.mat'])==2
        firsttimeuseid=1;
        eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme3']);
        eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme\pmeBackup\portpme3.mat portpme3']);
        eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme\pmeDefault\portpme3.mat portpme3']);
      end
    end
    
    if strcmp(instruct.Pzhu112,'1')==1 % load weights
      if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme\pmedefault\portpme1.mat'])~=2
        if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme1.mat'])~=2
          portpme1{1}='Not Assigned yet.'; portpme1{2}=portpme1{1}; portpme1{3}=portpme1{1};
          portpme1{4}=portpme1{1}; portpme1{5}=portpme1{1};portpme1{6}=portpme1{1};
          portpme1{7}=portpme1{1}; portpme1{8}=portpme1{1};portpme1{9}=portpme1{1};
          eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme\pmedefault\portpme1.mat portpme1']);
        else
          eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme1']);
          eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme\pmedefault\portpme1.mat portpme1']);
          eval(['delete ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme1.mat']);
        end
      else
        eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme\pmedefault\portpme1']);
      end
      fpwport.fpwpmt1=portpme1{1};
      fpwport.fpwpmt2=portpme1{2};
      fpwport.fpwpmt3=portpme1{3};
      fpwport.fpwpmt4=portpme1{4};
      fpwport.fpwpmt5=portpme1{5};
      fpwport.fpwpmt6=portpme1{6};
      fpwport.fpwpmt7=portpme1{7};
      fpwport.fpwpmt8=portpme1{8};
      fpwport.fpwpmt9=portpme1{9};
      pmefilename='portpme1.mat';
    elseif strcmp(instruct.Pzhu112,'2')==1 % load overlaps
      if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme\pmedefault\portpme2.mat'])~=2
        if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme2.mat'])~=2
          portpme2{1}='Not Assigned yet.'; portpme2{2}=portpme2{1}; portpme2{3}=portpme2{1};
          portpme2{4}=portpme2{1}; portpme2{5}=portpme2{1};portpme2{6}=portpme2{1};
          portpme2{7}=portpme2{1}; portpme2{8}=portpme2{1};portpme2{9}=portpme2{1};
          eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme\pmedefault\portpme2.mat portpme2']);
        else
          eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme2']);
          eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme\pmedefault\portpme2.mat portpme2']);
          eval(['delete ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme2.mat']);
        end
      else
        eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme\pmedefault\portpme2']);
      end
      fpwport.fpwpmt1=portpme2{1};
      fpwport.fpwpmt2=portpme2{2};
      fpwport.fpwpmt3=portpme2{3};
      fpwport.fpwpmt4=portpme2{4};
      fpwport.fpwpmt5=portpme2{5};
      fpwport.fpwpmt6=portpme2{6};
      fpwport.fpwpmt7=portpme2{7};
      fpwport.fpwpmt8=portpme2{8};
      fpwport.fpwpmt9=portpme2{9};
      pmefilename='portpme2.mat';
    else % % load conditions
      if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme\pmedefault\portpme3.mat'])~=2
        if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme3.mat'])~=2
          portpme3{1}='Not Assigned yet.'; portpme3{2}=portpme3{1}; portpme3{3}=portpme3{1};
          portpme3{4}=portpme3{1}; portpme3{5}=portpme3{1};portpme3{6}=portpme3{1};
          portpme3{7}=portpme3{1}; portpme3{8}=portpme3{1};portpme3{9}=portpme3{1};
          eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme\pmedefault\portpme3.mat portpme3']);
        else
          eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme3']);
          eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme\pmedefault\portpme3.mat portpme3']);
          eval(['delete ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme3.mat']);
        end
      else
        eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme\pmedefault\portpme3']);
      end
      fpwport.fpwpmt1=portpme3{1};
      fpwport.fpwpmt2=portpme3{2};
      fpwport.fpwpmt3=portpme3{3};
      fpwport.fpwpmt4=portpme3{4};
      fpwport.fpwpmt5=portpme3{5};
      fpwport.fpwpmt6=portpme3{6};
      fpwport.fpwpmt7=portpme3{7};
      fpwport.fpwpmt8=portpme3{8};
      fpwport.fpwpmt9=portpme3{9};
      pmefilename='portpme3.mat';
      instruct.Pzhu112='3';
    end
    fpwport.outrunindex='1';
    fpwport.Pzhu112=instruct.Pzhu112;
    fpwport.Pzhu118='Default';
    fpwport.fpwulvl=instruct.fpwulvl; 
    fpwport.FPWsrsource=strrep([fpwclientdirectory,fpwusername,'\stock\tfpwpmR1.html'],'\','/');
    
    if firsttimeuseid==0
      smps2.StatusReport = ['Data loaded from file Default.',noempty(pmefilename),' successfully. ',time1];
    else
      smps2.StatusReport = ['Initial Data created or loaded from file ',noempty(pmefilename),'. ***** Please save them by your own name ASAP.',time1];
    end
    templatefile = which('MarketpulseR1.html');
    str = htmlrep(smps2, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\tfpwpmR1.html'],'noheader');
  end
  
  fpwport.ProgressM=strrep([fpwclientdirectory,fpwusername,'\pattern\twbduringrun.html'],'\','/');
  cd(fpwserverplace);
  cids=fpwloginstatus(fpwusername,clock);
  
  if (strcmp(outrunindex,'411'))|(strcmp(outrunindex,'413'))|(strcmp(outrunindex,'416'))
    if fpwoutwindow==21
      templatefile = which('wbfpwoutput.html');    
      if ~strcmp(fpwout1.outGOsm,'UrSym')
        fpwout1.outGOsm=noempty(upper(fpwout1.outGOsm));
      end      
      if (nargin == 1)
        retstr = htmlrep(fpwout1, templatefile);     
      elseif (nargin == 2)
        retstr = htmlrep(fpwout1, templatefile, outfile);
      end 
    else
      templatefile = which('wbfpwnotrade.html');    
      if (nargin == 1)
        retstr = htmlrep(fpwout1, templatefile);     
      elseif (nargin == 2)
        retstr = htmlrep(fpwout1, templatefile, outfile);
      end       
    end
  elseif (strcmp(outrunindex,'418'))
    templatefile = which('wbfpwpme.html');    
    if (nargin == 1)
      retstr = htmlrep(fpwport, templatefile);     
    elseif (nargin == 2)
      retstr = htmlrep(fpwport, templatefile, outfile);
    end 
  else   
    templatefile = which('wbfpwport.html');    
    if (nargin == 1)
      retstr = htmlrep(fpwport, templatefile);     
    elseif (nargin == 2)
      retstr = htmlrep(fpwport, templatefile, outfile);
    end 
  end
end