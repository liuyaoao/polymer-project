function retstr = wbdzhputmi(instruct, outfile)

% Author(s): N. Zhu, 11-15-2003
% This is a WB (Web-Based) mirror program to <dzhputmi.m> in desktop version

wbfpwbasic;
cd(fpwserverplace);
retstr = char('');
global fpwusername fpwusername4
fpwusername=instruct.mlid{1};
fpwusername4=instruct.mlid4;
filetypeid=instruct.filetypeid;
%save fpwtempfile

% To Change PaperPosition, one needs to change 5 m-files:
% wbfpwoutput, wbfpwsimu, wbfpwport, wbdzhputmi and fpwfsmarket.
%MyPaperPosiH=[.25 .25 4.4 4.25]; % old small one, used before 2016-07-14
MyPaperPosiH=[.25 .25 8.259 4.355];

if (strcmp(filetypeid,'mpdzhL'))|(strcmp(filetypeid,'mpdzhD'))
  if (isfield(instruct,'zsobx31'))
    cd([Wherematlab,'pattern']);
    if fpwsecucheck([instruct.zsobx31,instruct.zsobx53,instruct.zsobx57])>0
      error(' Hei! Not allowed content found, are you seriously trying to .... Sorry, change it.');
    end
    cd(fpwserverplace);
  end
  filenamewronge=0; 
  if (~length(noempty(instruct.filenametoopen)))|(strcmp(instruct.filenametoopen,'Enter your file name here'))
    filenamewronge=1;
    s.StatusReport = ['Not enter a file name or cancelled. ',time1];
  end    
  if (filenamewronge==0)
    FPWMPfiletoopen = [fpwserverplace,fpwclientdirectory,fpwusername,'\stock\usermpdzh\mpdzh',noempty(instruct.filenametoopen),'.mat'];
    if (exist(FPWMPfiletoopen)~=2)
      filenamewronge=1; 
      s.StatusReport = ['You entered an unexisted file name. ',time1];
    else
      instruct.filenametoopen=noempty(instruct.filenametoopen);
    end 
    if filenamewronge==0    
      if filetypeid(6)=='L'
        filenametopenhere=noempty(instruct.filenametoopen);
        eval(['load ',FPWMPfiletoopen]);
        eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbdzhinput instruct']);
        outstruct.FDhdzsobx39=instruct.hdzsobx39;
        linecond=instruct.zsobx31;
        outstruct.FDzsobx31=linecond(find(linecond~=10));
        outstruct.FDhdzsobx311=instruct.hdzsobx311;
        outstruct.FDzsobx312=instruct.zsobx312;
        outstruct.FDzsobx41=instruct.zsobx41;
        outstruct.FDhdzsobx42=instruct.hdzsobx42;
        outstruct.FDhdzsobx43=instruct.hdzsobx43;
        outstruct.FDzsobx44=instruct.zsobx44;
        outstruct.FDzsobx451=instruct.zsobx451;
        outstruct.FDzsobx452=instruct.zsobx452;
        outstruct.FDzsobx453=instruct.zsobx453;
        outstruct.FDhdzsobx46=instruct.hdzsobx46;
        outstruct.FDzsobx53=instruct.zsobx53;
        outstruct.FDhdzsobx55=instruct.hdzsobx55;
        linecond=instruct.zsobx57;
        outstruct.FDzsobx57=linecond(find(linecond~=13));
        outstruct.FDzsobx62=instruct.zsobx62;
        if isfield(instruct,'zsobx622')
          outstruct.FDzsobx622=instruct.zsobx622;
        end
        outstruct.FDhdzsobx64=instruct.hdzsobx64;
        outstruct.FDzsobx71=instruct.zsobx71;
        outstruct.FDzsobx72=instruct.zsobx72;  
        if isfield(instruct,'zsobxSG')
          outstruct.FDzsobxSG=instruct.zsobxSG;
        else
          outstruct.FDzsobxSG='-1';
        end
        
        fpwlastruntime=dirdet([fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbdzhinput.mat']);
        fpwlastruntime=fpwlastruntime(2:6);
        outstruct.fpwlastruntime=date2str(fpwlastruntime);
        outstruct.MPmainoutputdata=[fpwclientdirectory,fpwusername,'\stock\tMarketpulseR.html'];
        outstruct.MPstatusreport=['http:\\www.WSQSI.com',fpwclientdirectory,fpwusername,'\stock\tMarketpulseR1.html'];
        outstruct.FDfpwusername=fpwusername; 
        outstruct.FDfpwusername4=fpwusername4; 
        if isfield(instruct,'fpwulvl')
          outstruct.fpwulvl=instruct.fpwulvl;
        end
        if isfield(instruct,'zsobx622')
          if isfield(instruct,'mybarh23')
            for i=1:20
              eval(['outstruct.mybarh',int2str(i),'=instruct.mybarh',int2str(i),';']);
            end
            if ~((length(strfind(instruct.mybarh23,'$'))>0)|(length(instruct.mybarh23)==0))
              for i=23:52
                eval(['outstruct.mybarh',int2str(i),'=instruct.mybarh',int2str(i),';']);
              end
            else
              heightsh=[3 15 20 25 30 45 40 39 36 38 40 45 50 60 70 75 80 74 70 60 0 0,...
                        3 15 20 25 30 45 40 39 36 38 40 45 50 60 70 75 80 74 70 60,...
                        40 45 50 60 70 75 80 74 70 60];
              for i=23:52
                eval(['outstruct.mybarh',int2str(i),'=''',int2str(heightsh(i)),'px'';']);
              end 
            end
          else
            heightsh=[3 15 20 25 30 45 40 39 36 38 40 45 50 60 70 75 80 74 70 60 0 0,...
                      3 15 20 25 30 45 40 39 36 38 40 45 50 60 70 75 80 74 70 60,...
                      40 45 50 60 70 75 80 74 70 60];
            for i=1:20
              eval(['outstruct.mybarh',int2str(i),'=''',int2str(heightsh(i)),'px'';']);
            end   
            for i=23:52
              eval(['outstruct.mybarh',int2str(i),'=''',int2str(heightsh(i)),'px'';']);
            end 
          end
        else
          if isfield(instruct,'mybarh1')
            for i=1:20
              eval(['outstruct.mybarh',int2str(i),'=instruct.mybarh',int2str(i),';']);
            end
          else
            heightsh=[3 15 20 25 30 45 40 39 36 38 40 45 50 60 70 75 80 74 70 60];
            for i=1:20
              eval(['outstruct.mybarh',int2str(i),'=''',int2str(heightsh(i)),'px'';']);
            end    
          end
        end
        if ~(strcmp(upper(fpwusername(1:4)),'USER'))
          if strcmp(upper(fpwusername),'NINGZHU')
            outstruct.mybarh21=int2str(60000); 
            outstruct.mybarh22=int2str(700);
          else
            outstruct.mybarh21=int2str(300000);
            outstruct.mybarh22=int2str(12);
          end
        else
          outstruct.mybarh21=int2str(9999999);
          outstruct.mybarh22=int2str(3);
        end
    
        cd(fpwserverplace);
        s.StatusReport = ['Data loaded from file ',upper(filenametopenhere),' successfully. ',time1];
        templatefile = which('MarketpulseR1.html');
        str = htmlrep(s, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\tMarketpulseR1.html'],'noheader');   
      elseif filetypeid(6)=='D'
        delete(FPWMPfiletoopen);
        filenamewronge=1;
        s.StatusReport = ['File ',upper(filenametopenhere),' deleted successfully. ',time1]; 
      end
    end
  end
  
  if filenamewronge==1
    eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbdzhinput']);
    outstruct.FDhdzsobx39=instruct.hdzsobx39;
    linecond=instruct.zsobx31;
    outstruct.FDzsobx31=linecond(find(linecond~=10));
    outstruct.FDhdzsobx311=instruct.hdzsobx311;
    outstruct.FDzsobx312=instruct.zsobx312;
    outstruct.FDzsobx41=instruct.zsobx41;
    outstruct.FDhdzsobx42=instruct.hdzsobx42;
    outstruct.FDhdzsobx43=instruct.hdzsobx43;
    outstruct.FDzsobx44=instruct.zsobx44;
    outstruct.FDzsobx451=instruct.zsobx451;
    outstruct.FDzsobx452=instruct.zsobx452;
    outstruct.FDzsobx453=instruct.zsobx453;
    outstruct.FDhdzsobx46=instruct.hdzsobx46;
    outstruct.FDzsobx53=instruct.zsobx53;
    outstruct.FDhdzsobx55=instruct.hdzsobx55;
    linecond=instruct.zsobx57;
    outstruct.FDzsobx57=linecond(find(linecond~=13));
    outstruct.FDzsobx62=instruct.zsobx62;
    if isfield(instruct,'zsobx622')
      outstruct.FDzsobx622=instruct.zsobx622;
    end
    outstruct.FDhdzsobx64=instruct.hdzsobx64;
    outstruct.FDzsobx71=instruct.zsobx71;
    outstruct.FDzsobx72=instruct.zsobx72;  
    if isfield(instruct,'zsobxSG')
      outstruct.FDzsobxSG=instruct.zsobxSG;
    else
      outstruct.FDzsobxSG='-1';
    end
  
    fpwlastruntime=dirdet([fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbdzhinput.mat']);
    fpwlastruntime=fpwlastruntime(2:6);
    outstruct.fpwlastruntime=date2str(fpwlastruntime);
    outstruct.MPmainoutputdata=[fpwclientdirectory,fpwusername,'\stock\tMarketpulseR.html'];
    outstruct.MPstatusreport=['http:\\www.WSQSI.com',fpwclientdirectory,fpwusername,'\stock\tMarketpulseR1.html'];
    outstruct.FDfpwusername=fpwusername; 
    outstruct.FDfpwusername4=fpwusername4; 
    
    if isfield(instruct,'fpwulvl')
      outstruct.fpwulvl=instruct.fpwulvl;
    end
    if isfield(instruct,'zsobx622')
      if isfield(instruct,'mybarh23')
        for i=1:20
          eval(['outstruct.mybarh',int2str(i),'=instruct.mybarh',int2str(i),';']);
        end
        if ~((length(strfind(instruct.mybarh23,'$'))>0)|(length(instruct.mybarh23)==0))
          for i=23:52
            eval(['outstruct.mybarh',int2str(i),'=instruct.mybarh',int2str(i),';']);
          end
        else
          heightsh=[3 15 20 25 30 45 40 39 36 38 40 45 50 60 70 75 80 74 70 60 0 0,...
                    3 15 20 25 30 45 40 39 36 38 40 45 50 60 70 75 80 74 70 60,...
                    40 45 50 60 70 75 80 74 70 60];
          for i=23:52
            eval(['outstruct.mybarh',int2str(i),'=''',int2str(heightsh(i)),'px'';']);
          end 
        end
      else
        heightsh=[3 15 20 25 30 45 40 39 36 38 40 45 50 60 70 75 80 74 70 60 0 0,...
                  3 15 20 25 30 45 40 39 36 38 40 45 50 60 70 75 80 74 70 60,...
                  40 45 50 60 70 75 80 74 70 60];
        for i=1:20
          eval(['outstruct.mybarh',int2str(i),'=''',int2str(heightsh(i)),'px'';']);
        end    
        for i=23:52
          eval(['outstruct.mybarh',int2str(i),'=''',int2str(heightsh(i)),'px'';']);
        end 
      end 
    else
      if isfield(instruct,'mybarh1')
        for i=1:20
          eval(['outstruct.mybarh',int2str(i),'=instruct.mybarh',int2str(i),';']);
        end
      else
        heightsh=[3 15 20 25 30 45 40 39 36 38 40 45 50 60 70 75 80 74 70 60];
        for i=1:20
          eval(['outstruct.mybarh',int2str(i),'=''',int2str(heightsh(i)),'px'';']);
        end    
      end      
    end
    if ~(strcmp(upper(fpwusername(1:4)),'USER'))
      if strcmp(upper(fpwusername),'NINGZHU')
        outstruct.mybarh21=int2str(60000); 
        outstruct.mybarh22=int2str(700);
      else
        outstruct.mybarh21=int2str(300000);
        outstruct.mybarh22=int2str(12);
      end
    else
      outstruct.mybarh21=int2str(9999999);
      outstruct.mybarh22=int2str(3);
    end
        
    cd(fpwserverplace);
    templatefile = which('MarketpulseR1.html');
    str = htmlrep(s, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\tMarketpulseR1.html'],'noheader'); 
  end  
       
  outstruct.FDfpwusername=fpwusername; 
  outstruct.FDfpwusername4=fpwusername4; 
  templatefile = which('Marketpulse0.html');
  if (nargin == 1)
    retstr = htmlrep(outstruct, templatefile); 
  elseif (nargin == 2)
    retstr = htmlrep(outstruct, templatefile, outfile);
  end
  
elseif (strcmp(filetypeid,'mpsimL'))|(strcmp(filetypeid,'mpsimD'))
  filenamewronge=0; 
  if (~length(noempty(instruct.filenametoopen)))|(strcmp(instruct.filenametoopen,'Enter your file name here'))
    filenamewronge=1;
    s.StatusReport = ['Not enter a file name or cancelled. ',time1];
  else
    instruct.filenametoopen=noempty(instruct.filenametoopen);
  end    
  if (filenamewronge==0)
    FPWMPfiletoopen = [fpwserverplace,fpwclientdirectory,fpwusername,'\stock\usermpsim\mpsim',noempty(instruct.filenametoopen),'.mat'];
    if (exist(FPWMPfiletoopen)~=2)
      filenamewronge=1; 
      s.StatusReport = ['You entered an unexisted file name. ',time1];
    end 
    if filenamewronge==0    
      if filetypeid(6)=='L'
        filenametopenhere=noempty(instruct.filenametoopen);
        eval(['load ',FPWMPfiletoopen]);
        
        if exist('cusresupd')==1
          if exist('cusresui')~=1
            cusresui=0*cusresu+1;
          end             
          if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\stock\lastsimu.mat'])==2
            cd([Wherematlab,'stock']);
            wbstsimu12(fpwusername);
          end
          eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\lastsimu ',...
              'mpptname mpmruon mpmrvo cusresu cusresui cusresuna cusresupd cusresurv wphdtu hmdats nums ',...
              'marke stopnum objenum herestopp hereobjep herekindm RunTickOrDay sdate instruct']);          
          
          cd([Wherematlab,'stock']);
          [mpsimFig mpsimsta simupara mpptnamest errormsg]=wbstsimuchart(fpwusername,91);
          %SRmsg='Simu 1, ';      
          if strcmp(errormsg,'No')
            set(mpsimFig,'inverthardcopy','off'); hold off
            set(mpsimFig,'PaperPosition',[.25 .25 5.92 3.15]);
            cd([fpwserverplace,fpwclientdirectory,fpwusername,'\stock']);
            drawnow;
            wsprintjpeg(mpsimFig,'Mpsimujpeg.jpeg');
            close(mpsimFig);
            
            instruct.mpefsp=num2str(simupara(1));
            instruct.mpefhl=num2str(simupara(2)); 
            instruct.mpspsp=num2str(simupara(1));
            instruct.mpsphl=num2str(simupara(2));
            instruct.mpsphlqs=num2str(simupara(10));            
            instruct.mpefvb='0';
            instruct.mpefve='999';  
            instruct.mpefpb='0';
            instruct.mpefpe='999';
            instruct.mpefvpb='0';
            instruct.mpefvpe='999';
            if simupara(3)==0
              instruct.mpefls='+/-';
            elseif simupara(3)==1
              instruct.mpefls='++';
            elseif simupara(3)==-1
              instruct.mpefls='- -';
            end
            if simupara(4)==1
              instruct.mpefco='Close';  
            else
              instruct.mpefco='Open'; 
            end
            if simupara(11)==1
              instruct.mpefcoqs='Close';  
            else
              instruct.mpefcoqs='Open'; 
            end            
            instruct.mpefef='Enter any statement here.';
            instruct.mpmruon=num2str(simupara(5));
            instruct.mpmrstop=num2str(simupara(6)); 
            instruct.mpmrobje=num2str(simupara(7)); 
            instruct.mpmrkind=num2str(simupara(8));
            instruct.mpmrvo=num2str(simupara(9));
            instruct.mpptname=noempty(mpptnamest(1,:));
            instruct.mpptmrk=noempty(mpptnamest(2,:));
            instruct.RunTickOrDay=upper(noempty(mpptnamest(3,:)));
            if RunTickOrDay=='D'
              instruct.mpptdt='Daily';
            else
              instruct.mpptdt='Tick';        
            end
        
            instruct.mpswinno=num2str(mpsimsta(1));
            instruct.mpslossno=num2str(mpsimsta(2));	
            instruct.mpsdrawno=num2str(mpsimsta(3));	
            instruct.mpswinper=sprintf('%6.2f',mpsimsta(4));	
            instruct.mpsevdd=sprintf('%5.2f',mpsimsta(5));	
            instruct.mpsprfr=sprintf('%5.2f',mpsimsta(6));	
            instruct.mpsequity=num2str(round(mpsimsta(7)));	
            instruct.mpsmaxfp=num2str(mpsimsta(8));
            instruct.mpsmaxdd=num2str(round(mpsimsta(9)));	
            instruct.mpsavet=num2str(round(mpsimsta(10)));	
            instruct.mpsavew=num2str(round(mpsimsta(11)));	
            instruct.mpsavel=num2str(round(mpsimsta(12)));  
            instruct.mpsmaxw=num2str(mpsimsta(13));		
            instruct.mpsmaxl=num2str(mpsimsta(14));            
          end
        end
        
        smps=instruct;
        if ~(isfield(smps,'mpefhlqs'))
          smps.mpefcoqs='Close';
          smps.mpefhlqs='0';
        end        
        mpptfilef=instruct.mpptfilef;
        mpptfilef=mpptfilef(find(mpptfilef~=10));
        smps.mpptfilef=mpptfilef;
        smps.MPsrsource=[fpwclientdirectory,fpwusername,'\stock\tMPsimulationR1.html'];
        smps.Mpsimujpeg=[fpwclientdirectory,fpwusername,'\stock\Mpsimujpeg.jpeg'];   
        smps.fpwusername=fpwusername;
        smps.fpwusername4=fpwusername4;
        smps.mpptdt=smps.hdmpptdt;
        smps.mpefco=smps.hdmpefco;
        smps.mpefls=smps.hdmpefls;
        smps.ProgressM=strrep([fpwclientdirectory,fpwusername,'\stock\twbduringrun.html'],'\','/');
        cd(fpwserverplace);
        templatefile = which('MPsimulationR1.html');
        s.StatusReport = ['Load file ',upper(filenametopenhere),'.MAT successfully. ',time1];        
        str = htmlrep(s, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\tMPsimulationR1.html'],'noheader');  
        eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\fpwstmpsimu smps']);
      elseif filetypeid(6)=='D'
        delete(FPWMPfiletoopen);
        filenamewronge=1;
        s.StatusReport = ['File ',upper(filenametopenhere),'.MAT deleted successfully. ',time1]; 
      end
    end
  end
  
  if filenamewronge==1
    eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\fpwstmpsimu']);  
    smps.fpwusername=fpwusername;
    smps.fpwusername4=fpwusername4;
    templatefile = which('MPsimulationR1.html');     
    str = htmlrep(s, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\tMPsimulationR1.html'],'noheader'); 
  end  
  
  smps.fpwusername=fpwusername;
  smps.fpwusername4=fpwusername4;  
  templatefile = which('MPsimulation.html');
  if (nargin == 1)
    retstr = htmlrep(smps, templatefile); 
  elseif (nargin == 2)
    retstr = htmlrep(smps, templatefile, outfile);
  end
  
elseif (strcmp(lower(filetypeid(1:3)),'fpw'))  
  filenamewronge=0;
  if (~length(noempty(instruct.filenametoopen)))|(strcmp(instruct.filenametoopen,'Enter your file name here'))
    filenamewronge=1;
    s.StatusReport = ['Not enter a file name or cancelled. ',time1];
  else
    instruct.filenametoopen=noempty(instruct.filenametoopen);
  end    
  if (strcmp(upper(filetypeid(5)),'P'))&(filenamewronge==0)
    FPWMPfiletoopen = [fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\userip\',filetypeid(1:4),noempty(instruct.filenametoopen),'.mat'];
    if (exist(FPWMPfiletoopen)~=2)
      filenamewronge=1; 
      s.StatusReport = ['You entered an unexisted file name. ',time1];
    end 
    if filenamewronge==0
      eval(['load ',FPWMPfiletoopen]);
      sfpw.fpwpttype='P';
      
      if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\wbfpwfrontbs.mat'])==2
        eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\wbfpwfrontbs']);
        if filetypeid(4)=='B'
          frontfpwb=sfpw.fpwptfilef;      
        else
          frontfpws=sfpw.fpwptfilef;    
        end       
      else
        if filetypeid(4)=='B'
          frontfpwb=sfpw.fpwptfilef;
          frontfpws='Your most recent sell pattern is not available yet';       
        else
          frontfpws=sfpw.fpwptfilef;
          frontfpwb='Your most recent buy pattern is not available yet';       
        end   
      end
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
      hdfpwexfilefb=frontfpwexb;
      hdfpwexfilefs=frontfpwexs;
      hdfpwstfilefb=frontfpwstb;
      hdfpwstfilefs=frontfpwsts;
      hdfpwobfilefb=frontfpwobb;
      hdfpwobfilefs=frontfpwobs;
      hdfpwptfilefs=frontfpws;
      hdfpwptfilefb=frontfpwb; 
      
      if isfield(sfpw,'fpwexfilef')~=1
        sfpw.fpwexfilef='Not Assigned for this pattern.';
        sfpw.fpwstfilef='Not Assigned for this pattern.';
        sfpw.fpwobfilef='Not Assigned for this pattern.';
      end
      
      eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\wbfpwfrontbs frontfpws frontfpwb frontfpwexs frontfpwexb frontfpwsts frontfpwstb frontfpwobs frontfpwobb']);
      sfpw.zhu45s=filetypeid(4);
      sfpw.fpwptname=upper(noempty(instruct.filenametoopen(1:length(instruct.filenametoopen)-1)));
      sfpw.hdfpwptfilefb=hdfpwptfilefb;  
      sfpw.hdfpwptfilefs=hdfpwptfilefs;
      s.StatusReport = ['Loaded from ',upper([filetypeid(1:4),noempty(instruct.filenametoopen)]),'.Mat successfully. ',time1];
      templatefile = which('MPsimulationR1.html');
      str = htmlrep(s, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\twbfpwinputR1.html'],'noheader');  
    end
  elseif (strcmp(upper(filetypeid(5)),'R'))&(filenamewronge==0)
    vbnamehere=noempty(instruct.filenametoopen);  
    FPWMPfiletoopen = [fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\',filetypeid(1:3),noempty(instruct.filenametoopen),'.m'];
    if (length(noempty(instruct.filenametoopen))~=6)
      filenamewronge=1;  
      s.StatusReport = ['Rule file name sytax error, should enter a six letters string here. ',time1];
    end    
    if (filenamewronge==0)&(exist(FPWMPfiletoopen)~=2)
      filenamewronge=1;  
      s.StatusReport = ['You entered a not existed file name. ',time1];
    end    
    eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\wbfpwinput']);
    if filenamewronge==0
      fid=fopen(FPWMPfiletoopen,'r');
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
      fpwptfilef=linecodes;
      sfpw.fpwptfilef=linecodes;
      if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\wbfpwfrontbs.mat'])==2
        eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\wbfpwfrontbs']);
      %  if vbnamehere(5)=='B'
      %    frontfpwb=fpwptfilef;      
      %  else
      %    frontfpws=fpwptfilef;    
      %  end       
      else
      %  if vbnamehere(5)=='B'
      %    frontfpwb=fpwptfilef;
           frontfpws='Your most recent sell pattern is not available yet';       
      %  else
      %    frontfpws=fpwptfilef;
           frontfpwb='Your most recent buy pattern is not available yet';       
      %  end   
      end
      hdfpwptfilefs=frontfpws;
      hdfpwptfilefb=frontfpwb;
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
      hdfpwexfilefb=frontfpwexb;
      hdfpwexfilefs=frontfpwexs;
      hdfpwstfilefb=frontfpwstb;
      hdfpwstfilefs=frontfpwsts;
      hdfpwobfilefb=frontfpwobb;
      hdfpwobfilefs=frontfpwobs;
      sfpw.hdfpwptfilefb=hdfpwptfilefb;  
      sfpw.hdfpwptfilefs=hdfpwptfilefs;
      sfpw.fpwptname=upper(vbnamehere(1:4));
      sfpw.fpwptname2=upper(vbnamehere(5)); 
      sfpw.fpwptname3=vbnamehere(6);
      sfpw.fpwpttype='R';
      s.StatusReport = ['Loaded from ',upper([filetypeid(1:3),noempty(instruct.filenametoopen)]),'.M successfully. ',time1];
      templatefile = which('MPsimulationR1.html');
      str = htmlrep(s, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\twbfpwinputR1.html'],'noheader');      
    end
  elseif (strcmp(upper(filetypeid(5)),'A'))&(filenamewronge==0)       
    % filetypeid format: [filetypeid,zhu712(1),'A',zhu713]    
    cd([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\']);
    % find out what is source filename sfilename
    sfilename=['fpw',noempty(instruct.filenametoopen),'.m'];
    % figure out what should be the destination filename dfilename
    dfilename=sfilename;
    if upper(filetypeid(4))=='E'
      dfilename(4:7)='exit';
      if upper(filetypeid(6))=='1'
        dfilename(9)='7';
      else
        dfilename(9)='8';          
      end
    elseif upper(filetypeid(4))=='S'
      dfilename(4:7)='stop';  
      if upper(filetypeid(6))=='1'
        dfilename(9)='8';
      else
        dfilename(9)='9';          
      end      
    elseif upper(filetypeid(4))=='O'
      dfilename(4:7)='obje';  
      if upper(filetypeid(6))=='1'
        dfilename(9)='8';
      else
        dfilename(9)='9';          
      end            
    end
    if exist(sfilename)==2
      eval(['!copy ',sfilename,' ',dfilename]);
      s.StatusReport = ['Copy ',upper(sfilename),' to ',upper(dfilename),' successfully. ',time1];
      templatefile = which('MPsimulationR1.html');
      str = htmlrep(s, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\twbfpwinputR1.html'],'noheader'); 
      
      eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\wbfpwinput']);
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
    else
      filenamewronge=1;
    end
  elseif (strcmp(upper(filetypeid(5)),'D'))&(filenamewronge==0)
    if strcmp(upper(filetypeid(6)),'P')
      FPWMPfiletoopen = [fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\userip\',filetypeid(1:4),noempty(instruct.filenametoopen),'.mat'];
      s.StatusReport = ['File ',upper([filetypeid(1:4),noempty(instruct.filenametoopen)]),'.MAT deleted successfully. ',time1];  
    elseif strcmp(upper(filetypeid(6)),'R')
      FPWMPfiletoopen = [fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\',filetypeid(1:3),noempty(instruct.filenametoopen),'.m'];
      s.StatusReport = ['File ',upper([filetypeid(1:3),noempty(instruct.filenametoopen)]),'.M deleted successfully. ',time1];
    end  
    if (exist(FPWMPfiletoopen)~=2)
      filenamewronge=1; 
      s.StatusReport = ['You entered an unexisted file name. ',time1];
    else
      delete(FPWMPfiletoopen);
      filenamewronge=1;
    end
  end
  
  if filenamewronge==1
    eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\wbfpwinput']);        
    %s.StatusReport = ['Nothing done, entered a wrong file name. Run again. ',time1];
    templatefile = which('MPsimulationR1.html');
    str = htmlrep(s, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\twbfpwinputR1.html'],'noheader');
    if ~isfield(sfpw,'fpwaddnoise')
      sfpw.fpwaddnoise='AN: 0';
    end 
  else
    if ~isfield(sfpw,'fpwaddnoise')
      sfpw.fpwaddnoise='AN: 0';
    end 
    eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\wbfpwinput sfpw']);
  end

  fpwmrlistb=strfind(sfpw.MRlist,'option selected value="')+23;
  fpwmrliste=strfind(sfpw.MRlist(fpwmrlistb:length(sfpw.MRlist)),'"'); fpwmrliste=fpwmrliste(1)-1;
  sfpw.fpwmrlist=sfpw.MRlist(fpwmrlistb:fpwmrlistb+fpwmrliste-1);
  
  cd(fpwserverplace);
  templatefile = which('wbfpwinput.html');
  sfpw.ProgressM=strrep([fpwclientdirectory,fpwusername,'\pattern\twbduringrun.html'],'\','/');
  sfpw.fpwusername=fpwusername;
  sfpw.fpwusername4=fpwusername4;
  if (nargin == 1)
    retstr = htmlrep(sfpw, templatefile); 
  elseif (nargin == 2)
    retstr = htmlrep(sfpw, templatefile, outfile);
  end 
elseif (strcmp(filetypeid(1:3),'out'))
  filenamewronge=0;
  if (~length(noempty(instruct.filenametoopen)))|(strcmp(instruct.filenametoopen,'Enter your file name here'))
    filenamewronge=1;
    s.StatusReport = ['Not enter a file name or cancelled. ',time1];
  else
    instruct.filenametoopen=noempty(instruct.filenametoopen);
  end    
  if (filenamewronge==0)
    FPWMPfiletoopen = [fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data2\fpwt',noempty(instruct.filenametoopen),'.mat'];
    if (exist(FPWMPfiletoopen)~=2)
      filenamewronge=1; 
      s.StatusReport = ['You entered an unexisted file name. ',time1];
    end 
    if filenamewronge==0
      if (strcmp(filetypeid(4),'L'))
        eval(['load ',FPWMPfiletoopen]);
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
          fpwout1.fpwulvl=filetypeid(5);
          fpwout1.outrunindex='00';
          fpwout1.outptname=upper(noempty(instruct.filenametoopen));
               
          set(fpwout1.fpwoutfig,'PaperPosition',MyPaperPosiH);
          cd([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern']);
          drawnow;
          wsprintjpeg(fpwout1.fpwoutfig,'fpwoutjpeg.jpeg');
          close(fpwout1.fpwoutfig);
          cd([Wherematlab,'pattern']);
          fpwout1.fpwoutjpeg=[fpwclientdirectory,fpwusername,'\pattern\fpwoutjpeg.jpeg']; 
                           
          s.StatusReport=['Loaded from FPWT',upper(noempty(instruct.filenametoopen)),'.MAT successfully. ',time1];
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
      elseif (strcmp(filetypeid(4),'D'))
         delete(FPWMPfiletoopen);
         s.StatusReport = ['Simulation file FPWT',upper(noempty(instruct.filenametoopen)),'.MAT deleted from database successfully. ',time1];
         filenamewronge=1;
      end
    end  
  end
  if filenamewronge==1
    eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwfrontout']);
    fpwoutwindow=21;
    fpwout1.fpwsource=filetypeid(6:length(filetypeid));
    fpwout1.fpwusername=fpwusername;
    fpwout1.fpwusername4=fpwusername4;
    fpwout1.fpwulvl=filetypeid(5);
    fpwout1.outrunindex='00';
    fpwout1.fpwoutjpeg=[fpwclientdirectory,fpwusername,'\pattern\fpwoutjpeg.jpeg'];      
    fpwout1.FPWoutstatus=strrep([fpwclientdirectory,fpwusername,'\pattern\twbfpwoutputR1.html'],'\','/');       

    templatefile = which('MPsimulationR1.html');
    str = htmlrep(s, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\twbfpwoutputR1.html'],'noheader');
  end
  
  fpwout1.fpwusername=fpwusername;
  fpwout1.fpwusername4=fpwusername4;
  cd(fpwserverplace);
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
  elseif fpwoutwindow==24
    templatefile = which('fpwnotrade.html');    
    if (nargin == 1)
      retstr = htmlrep(fpwout1, templatefile);     
    elseif (nargin == 2)
      retstr = htmlrep(fpwout1, templatefile, outfile);
    end 
  end
end