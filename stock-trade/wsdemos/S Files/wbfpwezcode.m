function retstr = wbfpwezcode(instruct,outfile)

% Author(s): N. Zhu, 2-10-2017

wbfpwbasic;
cd(fpwserverplace);

retstr = char('');
global fpwusername fpwusername4
fpwusername=instruct.mlid{1};
fpwCPAL=4;
fpwloginIP='192.168.2.8';
fpwcheckil;

if 0 %fpwcheckilpass==1
    
  fpwulvl=str2num(instruct.fpwulvl);
  hdfpwptez=str2num(instruct.hdfpwptez);
  hdfpwptez1=str2num(instruct.hdfpwptez1);
  
  fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
  fseek(fid1,-50,1); fprintf(fid1,[time,' CODE ',hdfpwptez,' ',hdfpwptez1,'\n']); fclose(fid1);
  clear fid1
  cd([Wherematlab,'\pattern']);
  
  if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\Code'])~=7
    cd([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern']);
    mkdir('Code');
    cd([Wherematlab,'\pattern']);
  end
  save c:\matlab\pattern\mybug201702104.mat
  if 0 %strcmp(hdfpwptez,'1') % Entry Pattern
    if strcmp(hdfpwptez1,'1') % load from default
      eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\code\Code_',hdfpwptez,'_',hdfpwptez1,'front fpwezout']);
    elseif strcmp(hdfpwptez1,'2') % load from spefific file
        
    elseif strcmp(hdfpwptez1,'3') % save to spefific file and default
      fpwezout=instruct;
      
      eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\code\ezcodefront fpwezcode']);
        
    elseif strcmp(hdfpwptez1,'4') % run
         
    end      
  elseif strcmp(hdfpwptez,'2') % Special-Exit
    if strcmp(hdfpwptez1,'1') % load from default
        
    elseif strcmp(hdfpwptez1,'2') % load from spefific file
        
    elseif strcmp(hdfpwptez1,'3') % save to spefific file and default
        
    elseif strcmp(hdfpwptez1,'4') % run
        
    end  
  elseif strcmp(hdfpwptez,'3') % Special-Stop
    if strcmp(hdfpwptez1,'1') % load from default
        
    elseif strcmp(hdfpwptez1,'2') % load from spefific file
        
    elseif strcmp(hdfpwptez1,'3') % save to spefific file and default
        
    elseif strcmp(hdfpwptez1,'4') % run
        
    end  
  elseif strcmp(hdfpwptez,'4') % Special-Objective
    if strcmp(hdfpwptez1,'1') % load from default
        
    elseif strcmp(hdfpwptez1,'2') % load from spefific file
        
    elseif strcmp(hdfpwptez1,'3') % save to spefific file and default
        
    elseif strcmp(hdfpwptez1,'4') % run
         
    end  
  elseif 0
    if (~strcmp(upper(noempty(instruct.Pzhu118)),'DEFAULT'))&(~strcmp(upper(noempty(instruct.Pzhu118)),'BACKUP'))
      dirName = [fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme\pme',instruct.Pzhu118];
      if exist(dirName)==7
        dosCommand = ['rd /s /q "' dirName '"'];
        dos(dosCommand);
        smps2.StatusReport = [' All files related to ',noempty(instruct.Pzhu118),' are deleted. ',time1];
      else
        smps2.StatusReport = [' File you want to delete does not exist. ',time1];
      end
    else
      smps2.StatusReport = [' One can not delete the default and or backup files. ',time1];
    end
  end
  
  fpwezout.fpwusername=fpwusername;
  fpwezout.fpwusername4=fpwusername4;
  fpwezout.fpwulvl=instruct.fpwulvl;
  fpwezout.outrunindex=outrunindex;
  eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\code\ezcodefront fpwezout']);
end

if 1
  fpwezout.FPWsrsource=strrep([fpwclientdirectory,fpwusername,'\stock\tfpwpmR1.html'],'\','/');
  smps2.StatusReport = ['Data loaded from file successfully. ***** Next run will use this one. ',time1];
  templatefile = which('MarketpulseR1.html');
  str = htmlrep(smps2, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\tfpwpmR1.html'],'noheader');
    
  cd(fpwserverplace);
  cids=fpwloginstatus(fpwusername,clock);
  
  if 1%(strcmp(hdfpwptez1,'1'))|(strcmp(hdfpwptez1,'4'))
    templatefile = which('wbfpwezcode.html');    
    if (nargin == 1)
      retstr = htmlrep(fpwezout, templatefile);     
    elseif (nargin == 2)
      retstr = htmlrep(fpwezout, templatefile, outfile);
    end 
  else   
    templatefile = which('MarketpulseR1.html');  
    str = htmlrep(smps2, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\tfpwpmR1.html'],'noheader');
    if (nargin == 1)
      retstr = htmlrep(smps2, templatefile);
      str = htmlrep(smps2, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\tfpwpmR1.html'],'noheader'); 
    elseif (nargin == 2)
      retstr = htmlrep(smps2, templatefile, outfile);
    end  
  end
end