function retstr = wbfpwport(instruct, outfile)

% Author(s): N. Zhu, 7-25-2016
% This is a program used by PM page or subpage.

wbfpwbasic;
cd(fpwserverplace);

retstr = char('');
global fpwusername fpwusername4
fpwusername=instruct.mlid{1};
fpwCPAL=4;
fpwloginIP='192.168.2.8';
fpwcheckil;

if fpwcheckilpass==1

  fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
  fseek(fid1,-50,1); fprintf(fid1,[time,' PMTS\n']); fclose(fid1);
  clear fid1
  
  fpwulvl=str2num(instruct.fpwulvl);
  outrunindex=instruct.outrunindex;
  
  cd([Wherematlab,'\pattern']);
  if strcmp(outrunindex,'1') % load data
    fileoki=1;
    fpwport.fpwusername=fpwusername;
    fpwport.fpwusername4=fpwusername4;
    instruct.Pzhu118=noempty(instruct.Pzhu118);
    if strcmp(instruct.Pzhu112,'1')==1 % load weights
      if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme\pme',instruct.Pzhu118,'\portpme1.mat'])~=2
        portpme1{1}='Not Assigned yet.'; portpme1{2}=portpme1{1}; portpme1{3}=portpme1{1};
        portpme1{4}=portpme1{1}; portpme1{5}=portpme1{1};portpme1{6}=portpme1{1};
        portpme1{7}=portpme1{1}; portpme1{8}=portpme1{1};portpme1{9}=portpme1{1};
        if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme\pme',instruct.Pzhu118])~=7
          cd([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme']);
          mkdir(['pme',instruct.Pzhu118]);
          cd([Wherematlab,'\pattern']);
        end
        fileoki=0;
        eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme\pme',instruct.Pzhu118,'\portpme1.mat portpme1']);
      else
        eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme\pme',instruct.Pzhu118,'\portpme1']);
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
      if (~strcmp(upper(instruct.Pzhu118),'DEFAULT'))&(fileoki==1)
        eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme\pmeDefault\portpme1.mat portpme1']);
      end
    elseif strcmp(instruct.Pzhu112,'2')==1 % load overlaps
      if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme\pme',instruct.Pzhu118,'\portpme2.mat'])~=2
        portpme2{1}='Not Assigned yet.'; portpme2{2}=portpme2{1}; portpme2{3}=portpme2{1};
        portpme2{4}=portpme2{1}; portpme2{5}=portpme2{1};portpme2{6}=portpme2{1};
        portpme2{7}=portpme2{1}; portpme2{8}=portpme2{1};portpme2{9}=portpme2{1};
        if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme\pme',instruct.Pzhu118])~=7
          cd([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme']);
          mkdir(['pme',instruct.Pzhu118]);
          cd([Wherematlab,'\pattern']);
        end
        fileoki=0;
        eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme\pme',instruct.Pzhu118,'\portpme2.mat portpme2']);
      else
        eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme\pme',instruct.Pzhu118,'\portpme2']);
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
      if (~strcmp(upper(instruct.Pzhu118),'DEFAULT'))&(fileoki==1)
        eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme\pmeDefault\portpme2.mat portpme2']);
      end
    else % % load conditions
      if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme\pme',instruct.Pzhu118,'\portpme3.mat'])~=2
        portpme3{1}='Not Assigned yet.'; portpme3{2}=portpme3{1}; portpme3{3}=portpme3{1};
        portpme3{4}=portpme3{1}; portpme3{5}=portpme3{1};portpme3{6}=portpme3{1};
        portpme3{7}=portpme3{1}; portpme3{8}=portpme3{1};portpme3{9}=portpme3{1};
        if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme\pme',instruct.Pzhu118])~=7
          cd([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme']);
          mkdir(['pme',instruct.Pzhu118]);
          cd([Wherematlab,'\pattern']);
        end
        fileoki=0;
        eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme\pme',instruct.Pzhu118,'\portpme3.mat portpme3']);
      else
        eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme\pme',instruct.Pzhu118,'\portpme3']);
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
      if (~strcmp(upper(instruct.Pzhu118),'DEFAULT'))&(fileoki==1)
        eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme\pmeDefault\portpme3.mat portpme3']);
      end
    end
    fpwport.outrunindex='1';
    fpwport.Pzhu112=instruct.Pzhu112;
    fpwport.Pzhu118=instruct.Pzhu118;
    fpwport.fpwulvl=instruct.fpwulvl; 
    fpwport.FPWsrsource=strrep([fpwclientdirectory,fpwusername,'\stock\tfpwpmR1.html'],'\','/');
    
    smps2.StatusReport = ['Data loaded from file ',noempty(instruct.Pzhu118),'.',noempty(pmefilename),' successfully. ***** Next run will use this one. ',time1];
    templatefile = which('MarketpulseR1.html');
    str = htmlrep(smps2, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\tfpwpmR1.html'],'noheader');
    
  elseif strcmp(outrunindex,'2') % save data
      
    if strcmp(instruct.Pzhu112,'1')==1 % save weights
      portpme1{1}=instruct.fpwpmt1; portpme1{1}=portpme1{1}(find(portpme1{1}~=13));
      portpme1{2}=instruct.fpwpmt2; portpme1{2}=portpme1{2}(find(portpme1{2}~=13));
      portpme1{3}=instruct.fpwpmt3; portpme1{3}=portpme1{3}(find(portpme1{3}~=13));
      portpme1{4}=instruct.fpwpmt4; portpme1{4}=portpme1{4}(find(portpme1{4}~=13));
      portpme1{5}=instruct.fpwpmt5; portpme1{5}=portpme1{5}(find(portpme1{5}~=13));
      portpme1{6}=instruct.fpwpmt6; portpme1{6}=portpme1{6}(find(portpme1{6}~=13));
      portpme1{7}=instruct.fpwpmt7; portpme1{7}=portpme1{7}(find(portpme1{7}~=13));
      portpme1{8}=instruct.fpwpmt8; portpme1{8}=portpme1{8}(find(portpme1{8}~=13));
      portpme1{9}=instruct.fpwpmt9; portpme1{9}=portpme1{9}(find(portpme1{9}~=13));
      if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme\pme',instruct.Pzhu118])~=7
        cd([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme']);
        mkdir(['pme',instruct.Pzhu118]);
        cd([Wherematlab,'\pattern']);
      end
      eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme\pme',noempty(instruct.Pzhu118),'\portpme1.mat portpme1']);
      eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme\pmeDefault\portpme1.mat portpme1']);
      pmefilename='portpme1.mat';
    elseif strcmp(instruct.Pzhu112,'2')==1 % save overlaps
      portpme2{1}=instruct.fpwpmt1; portpme2{1}=portpme2{1}(find(portpme2{1}~=13));
      portpme2{2}=instruct.fpwpmt2; portpme2{2}=portpme2{2}(find(portpme2{2}~=13));
      portpme2{3}=instruct.fpwpmt3; portpme2{3}=portpme2{3}(find(portpme2{3}~=13));
      portpme2{4}=instruct.fpwpmt4; portpme2{4}=portpme2{4}(find(portpme2{4}~=13));
      portpme2{5}=instruct.fpwpmt5; portpme2{5}=portpme2{5}(find(portpme2{5}~=13));
      portpme2{6}=instruct.fpwpmt6; portpme2{6}=portpme2{6}(find(portpme2{6}~=13));
      portpme2{7}=instruct.fpwpmt7; portpme2{7}=portpme2{7}(find(portpme2{7}~=13));
      portpme2{8}=instruct.fpwpmt8; portpme2{8}=portpme2{8}(find(portpme2{8}~=13));
      portpme2{9}=instruct.fpwpmt9; portpme2{9}=portpme2{9}(find(portpme2{9}~=13));
      if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme\pme',instruct.Pzhu118])~=7
        cd([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme']);
        mkdir(['pme',instruct.Pzhu118]);
        cd([Wherematlab,'\pattern']);
      end
      eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme\pme',noempty(instruct.Pzhu118),'\portpme2.mat portpme2']);
      eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme\pmeDefault\portpme2.mat portpme2']);
      pmefilename='portpme2.mat';
    else % % save conditions
      portpme3{1}=instruct.fpwpmt1; portpme3{1}=portpme3{1}(find(portpme3{1}~=13));
      portpme3{2}=instruct.fpwpmt2; portpme3{2}=portpme3{2}(find(portpme3{2}~=13));
      portpme3{3}=instruct.fpwpmt3; portpme3{3}=portpme3{3}(find(portpme3{3}~=13));
      portpme3{4}=instruct.fpwpmt4; portpme3{4}=portpme3{4}(find(portpme3{4}~=13));
      portpme3{5}=instruct.fpwpmt5; portpme3{5}=portpme3{5}(find(portpme3{5}~=13));
      portpme3{6}=instruct.fpwpmt6; portpme3{6}=portpme3{6}(find(portpme3{6}~=13));
      portpme3{7}=instruct.fpwpmt7; portpme3{7}=portpme3{7}(find(portpme3{7}~=13));
      portpme3{8}=instruct.fpwpmt8; portpme3{8}=portpme3{8}(find(portpme3{8}~=13));
      portpme3{9}=instruct.fpwpmt9; portpme3{9}=portpme3{9}(find(portpme3{9}~=13));
      if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme\pme',instruct.Pzhu118])~=7
        cd([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme']);
        mkdir(['pme',instruct.Pzhu118]);
        cd([Wherematlab,'\pattern']);
      end
      eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme\pme',noempty(instruct.Pzhu118),'\portpme3.mat portpme3']);
      eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme\pmeDefault\portpme3.mat portpme3']);
      pmefilename='portpme3.mat';
    end
    smps2.StatusReport = ['Data saved to file ',noempty(instruct.Pzhu118),'.',noempty(pmefilename),' successfully. ***** Next run will use this one. ',time1];
    
  elseif strcmp(outrunindex,'3') % list  
    eval(['mfl=dir(''',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme\pme*'');']);
    dto=[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\portpme\pme*'];
    mfl=dir(dto);
    MyOutStr=' ';
    if length(mfl)>0
      for i=1:length(mfl)
        if mfl(i).isdir==1
          MyOutStrh=mfl(i).name;
          if length(MyOutStrh)>3
            MyOutStrh=MyOutStrh(4:length(MyOutStrh));
            if ~strcmp(upper(MyOutStrh),'BACKUP')
              if i~=length(mfl)
                MyOutStr=[MyOutStr,MyOutStrh,', '];
              else
                MyOutStr=[MyOutStr,MyOutStrh];
              end
            end
          end
        end
      end
    else
      MyOutStr='No available file.';
    end
    smps2.StatusReport = MyOutStr;
  elseif strcmp(outrunindex,'4') % delete
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
  
  cd(fpwserverplace);
  cids=fpwloginstatus(fpwusername,clock);
  
  if (strcmp(outrunindex,'1'))
    templatefile = which('wbfpwpme.html');    
    if (nargin == 1)
      retstr = htmlrep(fpwport, templatefile);     
    elseif (nargin == 2)
      retstr = htmlrep(fpwport, templatefile, outfile);
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