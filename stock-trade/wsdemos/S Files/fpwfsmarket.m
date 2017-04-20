function retstr = fpwfsmarket(instruct, outfile)

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
  fseek(fid1,-50,1); fprintf(fid1,[time,' MMFS\n']); fclose(fid1);
  clear fid1
  cd([Wherematlab,'\pattern']);
  if ~(strcmp(instruct.marketrun,'addall'))
    if strcmp(instruct.MMFS,'Future')
      if length(instruct.marketrun)==1
        instruct.marketrun(length(instruct.marketrun)+1)='_';
      end        
      if strcmp(instruct.MM12,'No.1')
        if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data4\',noempty(instruct.marketrun),'output.mat'])==2
          eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data4\',noempty(instruct.marketrun),'output']);
          wsftf=dirdet([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data4\',noempty(instruct.marketrun),'output.mat']);
          wsftf=[wsftf([4 2 3 5 6]) 0];
          outDSM='6';
        else
          error([' - There is no data file for ',noempty(instruct.marketrun),' in the first future MM directory.']);
        end 
      elseif strcmp(instruct.MM12,'No.2')
        if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data5\',noempty(instruct.marketrun),'output.mat'])==2
          eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data5\',noempty(instruct.marketrun),'output']);
          wsftf=dirdet([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data5\',noempty(instruct.marketrun),'output.mat']);
          wsftf=[wsftf([4 2 3 5 6]) 0];
          outDSM='7';          
        else
          error([' - There is no data file for ',noempty(instruct.marketrun),' in the second future MM directory.']);
        end 
      else
        if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data0\',noempty(instruct.marketrun),'output.mat'])==2
          eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data0\',noempty(instruct.marketrun),'output']);
          wsftf=dirdet([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data0\',noempty(instruct.marketrun),'output.mat']);
          wsftf=[wsftf([4 2 3 5 6]) 0];
          outDSM='10';          
        else
          error([' - There is no data file for ',noempty(instruct.marketrun),' in the Dcom future MM directory.']);
        end         
      end
    else
      if strcmp(instruct.MM12,'No.1')
        if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\stock1\rts',noempty(instruct.marketrun),'.mat'])==2
          eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\stock1\rts',noempty(instruct.marketrun)]);
          wsftf=dirdet([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\stock1\rts',noempty(instruct.marketrun),'.mat']);
          wsftf=[wsftf([4 2 3 5 6]) 0];
          outDSM='8';          
        else
          error([' - There is no data file for ',noempty(instruct.marketrun),' in the first stock MM directory.']);
        end 
      elseif strcmp(instruct.MM12,'No.2')
        if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\stock2\rts',noempty(instruct.marketrun),'.mat'])==2
          eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\stock2\rts',noempty(instruct.marketrun)]);
          wsftf=dirdet([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\stock2\rts',noempty(instruct.marketrun),'.mat']);
          wsftf=[wsftf([4 2 3 5 6]) 0];
          outDSM='9';          
        else
          error([' - There is no data file for ',noempty(instruct.marketrun),' in the second stock MM directory.']);
        end 
      else
        if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\stockd1\rts',noempty(instruct.marketrun),'.mat'])==2
          eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\stockd1\rts',noempty(instruct.marketrun)]);
          wsftf=dirdet([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\stockd1\rts',noempty(instruct.marketrun),'.mat']);
          wsftf=[wsftf([4 2 3 5 6]) 0];
          outDSM='11';          
        else
          error([' - There is no data file for ',noempty(instruct.marketrun),' in the Dcom stock MM directory.']);
        end         
      end         
    end
    if fpwout.tradeh(1,1)~=0
      fpwoutwindow=21;
      cd([Wherematlab,'\pattern']);
      fpwoutf2(fpwusername);
      eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwoutput fpwout']);
      outDSM='1';      
      %fpwout.zhu52='1'; fpwout.zhu54='1'; 
      fpwout.outonoff='0';
      fpwout1=fpwozc3(fpwout);    
      fpwout1.fpwsource='fpwoutput';
      fpwout1.fpwusername=fpwusername;
      fpwout1.fpwulvl=instruct.fpwulvl;
      fpwout1.outrunindex='00';
               
      set(fpwout1.fpwoutfig,'PaperPosition',MyPaperPosiH);
      cd([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern']);
      drawnow;
      wsprintjpeg(fpwout1.fpwoutfig,'fpwoutjpeg.jpeg');
      close(fpwout1.fpwoutfig);
      cd([Wherematlab,'pattern']);
      fpwout1.fpwoutjpeg=[fpwclientdirectory,fpwusername,'\pattern\fpwoutjpeg.jpeg']; 
                       
      sfpw1.StatusReport=[' This is the simulation output for ',instruct.MMFS(1),'-',noempty(instruct.marketrun),' saved in your MM file. ',time(wsftf)];
      templatefile = which('MPsimulationR1.html');
      str = htmlrep(sfpw1, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\twbfpwoutputR1.html'],'noheader');      
      fpwout1.FPWoutstatus=strrep([fpwclientdirectory,fpwusername,'\pattern\twbfpwoutputR1.html'],'\','/');    
    else
      fpwoutwindow=24;
      fpwout1.fpwusername=fpwusername;
      fpwout1.fpwulvl=instruct.fpwulvl;
      fpwout1.outrunindex='00';               
    end
  else
    %save fpwtempfile
    %[stock datem]=fsdaydat('fsp'); % find a best time base
    %Find namelist and datem first
    MMFS=instruct.MMFS; MM12=instruct.MM12;
    if strcmp(instruct.MMFS,'Future')
      if strcmp(instruct.MM12,'No.1')
        directplaceh=[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data4\'];
        outDSM='6';        
      elseif strcmp(instruct.MM12,'No.2')
        directplaceh=[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data5\'];
        outDSM='7';                
      else
        directplaceh=[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data0\'];  
        outDSM='10';                
      end  
      name='ZZXY';
      mname='F'; 
    else
      if strcmp(instruct.MM12,'No.1')
        directplaceh=[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\stock1\'];
        outDSM='8';                
      elseif strcmp(instruct.MM12,'No.2')
        directplaceh=[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\stock2\'];
        outDSM='9';                
      else
        directplaceh=[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\stockd1\'];    
        outDSM='11';                
      end  
      name='ZZXY';
      mname='S';          
    end
    cd(directplaceh);
    if exist('marketlist.mat')==2
      load marketlist
    else
      error(' - There is no data file inside this MM directory.');
    end 
    
    mrktchosen=zeros(1,length(runnamelist));
    for i=1:length(runnamelist)
      if isfield(instruct,['mrkT',num2str(i)])
        mrktchosen(i)=1;
      end
    end
    runnamelist=runnamelist(find(mrktchosen==1));
    if length(runnamelist)==0
      error(' _ you did not choose any market.');
    end
    
    Datem=[];
    for i=1:length(runnamelist)
      if strcmp(MMFS,'Future')
        if length(runnamelist{i})==1
          runnamelist{i}=[runnamelist{i},'_'];  
        end
        eval(['load ',directplaceh,runnamelist{i},'output']);
      else
        eval(['load ',directplaceh,'rts',runnamelist{i}]);
      end
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
    datem=Datem;
        
    %save fpwtempfile
    %[stock datem]=fsdaydat('fsp'); % find a best time base    
    NET=0*datem(:,1);
    NET1=NET;
    Lotshis1=NET;
    TradeH=[]; 
    TradeD=[];
    TradeO=[];
    stock=[0 0 0 0 0];
    global mname
    
    if strcmp(instruct.MMFS,'Future')
      for i=1:length(runnamelist)
        if (length(noempty(runnamelist{i}))==1)
          runnamelist{i}(2)='_';
        end   
        
        if exist([runnamelist{i},'output.mat'])==2
          eval(['load ',runnamelist{i},'output']);
          net=fpwout.net; net1=fpwout.net1; tradeh=fpwout.tradeh; tradeo=fpwout.tradeo;
          lotshis=fpwout.lotshis; stockmar=fpwout.stock; datemar=fpwout.datem;  
          if length(lotshis(1,:))>1;  lotshis=(sum(lotshis'))'; end
          if (dnabs(datemar(1,1:3))>dnabs(datem(length(datem(:,1)),1:3)))|(dnabs(datemar(length(datemar(:,1)),1:3))<dnabs(datem(1,1:3)))
            %These is no time overlap area
            tradeh(1,1)=0; 
          end           
        else
          tradeh(1,1)=0;          
        end

        if tradeh(1,1)~=0
          if dnabs(datemar(length(datemar(:,1)),1:3))>dnabs(datem(length(datem(:,1)),1:3))
            DayoffsetnumE=length(datemar(:,1))-datef2(datem(length(datem(:,1)),1:3),datemar);
            datem=[datem;datemar(length(datemar(:,1))-DayoffsetnumE+1:length(datemar(:,1)),1:3)];
            NET=[NET;0*datemar(length(datemar(:,1))-DayoffsetnumE+1:length(datemar(:,1)),1)];
            NET1=[NET1;0*datemar(length(datemar(:,1))-DayoffsetnumE+1:length(datemar(:,1)),1)];
            Lotshis1=[Lotshis1;0*datemar(length(datemar(:,1))-DayoffsetnumE+1:length(datemar(:,1)),1)];              
          end
          if dnabs(datemar(1,1:3))<dnabs(datem(1,1:3))
            DayoffsetnumB=datef2(datem(1,1:3),datemar);
            datem=[datemar(1:DayoffsetnumB-1,1:3);datem];
            NET=[0*datemar(1:DayoffsetnumB-1,1);NET];
            NET1=[0*datemar(1:DayoffsetnumB-1,1);NET1];
            Lotshis1=[0*datemar(1:DayoffsetnumB-1,1);Lotshis1];
          end

          DayoffsetnumRB=datef2(datemar(1,1:3),datem);
          if length(datem(:,1))-DayoffsetnumRB+1<length(net)
            NET=[NET;0*((1:length(net)-length(datem(:,1))+DayoffsetnumRB-1)')];
            NET1=[NET1;0*((1:length(net)-length(datem(:,1))+DayoffsetnumRB-1)')];
            Lotshis1=[Lotshis1;0*((1:length(net)-length(datem(:,1))+DayoffsetnumRB-1)')];
            datem=[datem;[0*((1:length(net)-length(datem(:,1))+DayoffsetnumRB-1)')+datem(length(datem(:,1)),1),...
            0*((1:length(net)-length(datem(:,1))+DayoffsetnumRB-1)')+datem(length(datem(:,1)),2),...
            0*((1:length(net)-length(datem(:,1))+DayoffsetnumRB-1)')+datem(length(datem(:,1)),3)]];
          end
          Net=0*NET; Net1=Net; Lotshis=0*Lotshis1;
          Net(DayoffsetnumRB:length(net)+DayoffsetnumRB-1)=net;
          Net1(DayoffsetnumRB:length(net)+DayoffsetnumRB-1)=net1;
          Lotshis(DayoffsetnumRB:length(net)+DayoffsetnumRB-1)=lotshis;
          net=Net; net1=Net1; lotshis=Lotshis; 
          clear Net Net1 Lotshis
          
          traded=[datemar(tradeh(:,3),[3 1 2]) datemar(tradeh(:,5),[3 1 2])];
          traded(find(traded(:,1)<100),1)=traded(find(traded(:,1)<100),1)+1900;
          traded(find(traded(:,1)<1950),1)=traded(find(traded(:,1)<1950),1)+100;
          traded(find(traded(:,4)<100),4)=traded(find(traded(:,4)<100),4)+1900;
          traded(find(traded(:,4)<1950),4)=traded(find(traded(:,4)<1950),4)+100;     
          TradeD=[TradeD;[datemar(tradeh(:,3),1:3) datenum(traded(:,1:3)) datemar(tradeh(:,5),1:3) datenum(traded(:,4:6))]];

          % after do our best about datem, just cook it!
          % and fortunately, our analysis are not based on datem, all original info are carried by
          % tradeh, tradeo and tradeeach and its own datem and stock for each model,
          % the datem in here is just used as best time table to show them together.
          if length(net)>length(NET)
            Net=0*net; Net1=net; Lotshis=0*net;
            Net(length(net)-length(NET)+1:length(net))=NET;
            Net1(length(net)-length(NET)+1:length(net))=NET1;
            Lotshis(length(net)-length(NET)+1:length(net))=Lotshis1;
            NET=Net; NET1=Net1; Lotshis1=Lotshis; 
            clear Net Net1 Lotshis     
            datem=datemar;
          elseif length(NET)>length(net)
            Net=0*NET; Net1=Net; Lotshis=0*Net;
            Net(length(NET)-length(net)+1:length(NET))=net;
            Net1(length(NET)-length(net)+1:length(NET))=net1;
            Lotshis(length(NET)-length(net)+1:length(NET))=lotshis;
            net=Net; net1=Net1; lotshis=Lotshis; 
            clear Net Net1 Lotshis   
          end                  
          
          tradeh(:,13)=i*ones(size(tradeh(:,1)));
          NET=NET+net;
          NET1=NET1+net1;
          Lotshis1=Lotshis1+lotshis;
          TradeH=[TradeH;tradeh];
          TradeO=[TradeO;tradeo];
        end
      end
    else
      for i=1:length(runnamelist)
          
        if exist(['rts',runnamelist{i},'.mat'])==2
          eval(['load rts',runnamelist{i}]);
          net=fpwout.net; net1=fpwout.net1; tradeh=fpwout.tradeh; tradeo=fpwout.tradeo;
          lotshis=fpwout.lotshis; stockmar=fpwout.stock; datemar=fpwout.datem; 
          if length(lotshis(1,:))>1;  lotshis=(sum(lotshis'))'; end
          if (dnabs(datemar(1,1:3))>dnabs(datem(length(datem(:,1)),1:3)))|(dnabs(datemar(length(datemar(:,1)),1:3))<dnabs(datem(1,1:3)))
            %These is no time overlap area
            tradeh(1,1)=0; 
          end           
        else
          tradeh(1,1)=0;          
        end
            
        if tradeh(1,1)~=0
          if dnabs(datemar(length(datemar(:,1)),1:3))>dnabs(datem(length(datem(:,1)),1:3))
            DayoffsetnumE=length(datemar(:,1))-datef2(datem(length(datem(:,1)),1:3),datemar);
            datem=[datem;datemar(length(datemar(:,1))-DayoffsetnumE+1:length(datemar(:,1)),1:3)];
            NET=[NET;0*datemar(length(datemar(:,1))-DayoffsetnumE+1:length(datemar(:,1)),1)];
            NET1=[NET1;0*datemar(length(datemar(:,1))-DayoffsetnumE+1:length(datemar(:,1)),1)];
            Lotshis1=[Lotshis1;0*datemar(length(datemar(:,1))-DayoffsetnumE+1:length(datemar(:,1)),1)];              
          end
          if dnabs(datemar(1,1:3))<dnabs(datem(1,1:3))
            DayoffsetnumB=datef2(datem(1,1:3),datemar);
            datem=[datemar(1:DayoffsetnumB-1,1:3);datem];
            NET=[0*datemar(1:DayoffsetnumB-1,1);NET];
            NET1=[0*datemar(1:DayoffsetnumB-1,1);NET1];
            Lotshis1=[0*datemar(1:DayoffsetnumB-1,1);Lotshis1];
          end
          
          DayoffsetnumRB=datef2(datemar(1,1:3),datem);
          if length(datem(:,1))-DayoffsetnumRB+1<length(net)
            NET=[NET;0*((1:length(net)-length(datem(:,1))+DayoffsetnumRB-1)')];
            NET1=[NET1;0*((1:length(net)-length(datem(:,1))+DayoffsetnumRB-1)')];
            Lotshis1=[Lotshis1;0*((1:length(net)-length(datem(:,1))+DayoffsetnumRB-1)')];
            datem=[datem;[0*((1:length(net)-length(datem(:,1))+DayoffsetnumRB-1)')+datem(length(datem(:,1)),1),...
            0*((1:length(net)-length(datem(:,1))+DayoffsetnumRB-1)')+datem(length(datem(:,1)),2),...
            0*((1:length(net)-length(datem(:,1))+DayoffsetnumRB-1)')+datem(length(datem(:,1)),3)]];
          end
          Net=0*NET; Net1=Net; Lotshis=0*Lotshis1;
          Net(DayoffsetnumRB:length(net)+DayoffsetnumRB-1)=net;
          Net1(DayoffsetnumRB:length(net)+DayoffsetnumRB-1)=net1;
          Lotshis(DayoffsetnumRB:length(net)+DayoffsetnumRB-1)=lotshis;
          net=Net; net1=Net1; lotshis=Lotshis; 
          clear Net Net1 Lotshis
          
          traded=[datemar(tradeh(:,3),[3 1 2]) datemar(tradeh(:,5),[3 1 2])];
          traded(find(traded(:,1)<100),1)=traded(find(traded(:,1)<100),1)+1900;
          traded(find(traded(:,1)<1950),1)=traded(find(traded(:,1)<1950),1)+100;
          traded(find(traded(:,4)<100),4)=traded(find(traded(:,4)<100),4)+1900;
          traded(find(traded(:,4)<1950),4)=traded(find(traded(:,4)<1950),4)+100;     
          TradeD=[TradeD;[datemar(tradeh(:,3),1:3) datenum(traded(:,1:3)) datemar(tradeh(:,5),1:3) datenum(traded(:,4:6))]];          
           
          % after do our best about datem, just cook it!
          % and fortunately, our analysis are not based on datem, all original info are carried by
          % tradeh, tradeo and tradeeach and its own datem and stock for each model,
          % the datem in here is just used as best time table to show them together.
          if length(net)>length(NET)
            Net=0*net; Net1=net; Lotshis=0*net;
            Net(length(net)-length(NET)+1:length(net))=NET;
            Net1(length(net)-length(NET)+1:length(net))=NET1;
            Lotshis(length(net)-length(NET)+1:length(net))=Lotshis1;
            NET=Net; NET1=Net1; Lotshis1=Lotshis; 
            clear Net Net1 Lotshis     
            datem=datemar;
          elseif length(NET)>length(net)
            Net=0*NET; Net1=Net; Lotshis=0*Net;
            Net(length(NET)-length(net)+1:length(NET))=net;
            Net1(length(NET)-length(net)+1:length(NET))=net1;
            Lotshis(length(NET)-length(net)+1:length(NET))=lotshis;
            net=Net; net1=Net1; lotshis=Lotshis; 
            clear Net Net1 Lotshis   
          end            
          
          tradeh(:,13)=i*ones(size(tradeh(:,1)));
          NET=NET+net;
          NET1=NET1+net1;
          Lotshis1=Lotshis1+lotshis;
          TradeH=[TradeH;tradeh];
          TradeO=[TradeO;tradeo];
        end
      end
    end

    net=NET;net1=NET1;lotshis=Lotshis1;tradeh=TradeH; tradeo=TradeO; 
    clear i NET NET1 Lotshis1 tradeH stockmar datemar wheremar traded
    
    if tradeh(1,1)~=0
      fpwoutwindow=21; 
      fpwout.TradeD=TradeD;
      fpwout.net=net; fpwout.net1=net1; fpwout.tradeh=tradeh; fpwout.tradeo=tradeo;
      fpwout.runnamelist=runnamelist; fpwout.lotshis=lotshis; fpwout.datem=datem;
      fpwout.MM12=instruct.MM12; fpwout.MMFS=instruct.MMFS;  fpwout.mname=mname;
      fpwout.name=name; fpwout.stock=stock; % fpwout.tradeeach=tradeeach;
      fpwout.zhu52='1'; fpwout.zhu54='1'; fpwout.wsscale=1; fpwout.outonoff='0';
      eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwany300 fpwout']);
      
      fpwout.fpwsource='fpwany300';
      fpwout1=fpwozc3(fpwout); 
      fpwout1.fpwsource='fpwany300';
      fpwout1.fpwusername=fpwusername;
      fpwout1.fpwulvl=instruct.fpwulvl;
      fpwout1.outrunindex='00';
      fpwout1.outDSM=outDSM;        
               
      set(fpwout1.fpwoutfig,'PaperPosition',MyPaperPosiH);
      cd([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern']);
      drawnow;
      wsprintjpeg(fpwout1.fpwoutfig,'fpwoutjpeg.jpeg');
      close(fpwout1.fpwoutfig);
      cd([Wherematlab,'pattern']);
      fpwout1.fpwoutjpeg=[fpwclientdirectory,fpwusername,'\pattern\fpwoutjpeg.jpeg']; 
                     
      sfpw1.StatusReport=[' This is the combined simulation output for ',mname,'-',instruct.MM12(4),' saved in your MM file. ',time];
      templatefile = which('MPsimulationR1.html');
      str = htmlrep(sfpw1, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\twbfpwoutputR1.html'],'noheader');      
      fpwout1.FPWoutstatus=strrep([fpwclientdirectory,fpwusername,'\pattern\twbfpwoutputR1.html'],'\','/');  
    else
      fpwoutwindow=24;
      fpwout1.fpwusername=fpwusername;
      fpwout1.fpwulvl=instruct.fpwulvl;
      fpwout1.outrunindex='00';               
    end    
  end 
  
  fpwout1.outGOsm=instruct.outGOsm;
  fpwout1.outAnyU=instruct.outAnyU;
  fpwout1.outAnyD=instruct.outAnyD;
  fpwout1.outAnyS=instruct.outAnyS;
  fpwout1.fpwusername4=fpwusername4;
  
  cd(fpwserverplace);
  cids=fpwloginstatus(fpwusername,clock);
  if fpwoutwindow==21;
    templatefile = which('wbfpwoutput.html');    
    if ~strcmp(fpwout1.outGOsm,'UrSym')
      fpwout1.outGOsm=noempty(upper(fpwout1.outGOsm));
    end    
    if (nargin == 1)
      retstr = htmlrep(fpwout1, templatefile);     
    elseif (nargin == 2)
      retstr = htmlrep(fpwout1, templatefile, outfile);
    end
  elseif fpwoutwindow==24;
    templatefile = which('fpwnotrade.html');    
    if (nargin == 1)
      retstr = htmlrep(fpwout1, templatefile);     
    elseif (nargin == 2)
      retstr = htmlrep(fpwout1, templatefile, outfile);
    end    
  end
end