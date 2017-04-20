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
    fpwport.Pzhu108='10';fpwport.Pzhu110='FE'; fpwport.Pzhu111='1'; fpwport.Pzhu300='Models'; fpwport.Pzhu121='120';
    fpwport.Pzhu301='2';  fpwport.Pzhu303='2';  fpwport.Pzhu305='3.00'; fpwport.Pzhu112='1'; 
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
          smps2.fpwtime=time1;
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
    smps2.fpwtime=time1;
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
    eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portfront fpwport']);
    PORUNLTD=abs(str2num(instruct.Pzhu121));
    if length(PORUNLTD)==0
      PORUNLTD=0;
    end
    load c:\matlab\pattern\tradehsizes.mat
    PORUNW=upper(instruct.hdPzhu300); PORUNW=PORUNW(1);
    if PORUNLTD==0
      error(' Did not enter model number limit.');    
    end
    
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
    fpwport.Pzhu121=instruct.Pzhu121;
    fpwport.Pzhu300=instruct.hdPzhu300; % 'models' or 'lots', not in use any more.
    fpwport.Pzhu301=instruct.Pzhu301;
    fpwport.Pzhu303=instruct.Pzhu303;
    fpwport.Pzhu305=instruct.Pzhu305;
    fpwport.Pzhu108=instruct.Pzhu108;
    fpwport.Pzhu110=instruct.Pzhu110;
    fpwport.Pzhu111=instruct.Pzhu111;
    fpwport.Pzhu112=instruct.Pzhu112;
    fpwport.portchosen=instruct.portchosen;
    
    eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portfront fpwport']); 
      
    if (length(PBzhun)~=0)&(length(PCzhun)~=0)
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
    if length(pdzhu)==0
      error(' There is no model list entered.');  
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
      if PORUNW=='L'
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
    %LABACON=lotsabac(tradeh,Datem);
    
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
    else
      tradeh=tradeh(1:length(tradeh(:,1))-1,:);
    end
    
    fpwout.datem=Datem; fpwout.stock=Stock; fpwout.net=net; fpwout.net1=net1; fpwout.lotshis=lotshis;
    fpwout.tradeh=tradeh; fpwout.tradeh2=tradeh2; fpwout.tradeh3=tradeh3; 
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
        
    s.StatusReport=['This is a combination of models: ',NLHfor,' of ',upper(pMname),'. ',time];
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
    
    Datem=[]; Stock=[];
    % use time to exchange ROM space, load them twice to save mem ussage.
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
      fpwport.Pzhu301='2';
      fpwport.Pzhu303='2';
      fpwport.Pzhu305='3.00';
      fpwport.portchosen(208)='1';
      fpwport.Pzhu112='1';
    end       
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
  else   
    templatefile = which('wbfpwport.html');    
    if (nargin == 1)
      retstr = htmlrep(fpwport, templatefile);     
    elseif (nargin == 2)
      retstr = htmlrep(fpwport, templatefile, outfile);
    end 
  end
end