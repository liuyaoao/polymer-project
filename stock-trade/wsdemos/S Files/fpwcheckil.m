% this is m-file script to check web-based FPW username login status and using authority level
% if found it is not currently logined in yet, to prompt the login page
% if found not enough authority, prompt a notice to help user call us to raise his/her user level

fpwcheckilpass=1;
if length(strfind(fpwusername,'$'))>0
  loginid=0;
else
  [loginid onlyusedherea onlyusedhereb onlyusedherec fpwCPALh fpwloginIPh]=fpwloginstatus(fpwusername);
end
if exist('instruct')==1
  if isfield(instruct,'fpwulvl')
    if str2num(instruct.fpwulvl)~=fpwCPALh
      instruct.fpwulvl=num2str(fpwCPALh);
      s.StatusReport = ['Don''t try to change your user level by yourself. Not work. ',time];
      cd(fpwserverplace);
      templatefile = which('MPsimulationR1.html');
      str = htmlrep(s, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\twbfpwinputR1.html'],'noheader');
    end
  end
end

fpwclientinfodire='\webclient1992816372146245525x051069z053063tmdtnndyournameinfofpw\';
eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,fpwclientinfodire,'fpwusername4.mat']);

if exist('instruct')==1; 
  mlmfilerun=instruct.mlmfile;
  if isfield(instruct,'mlid4')
    fpwusername4=instruct.mlid4; 
  else
    fpwusername4=wbfpwid4;
  end
elseif exist('instr')==1; 
  mlmfilerun=instr.mlmfile;
  if isfield(instr,'mlid4')
    fpwusername4=instr.mlid4; 
  else
    fpwusername4=wbfpwid4;
  end
end

% here is for DZH output window links <wbst*> to work in the next initial open.
if length(mlmfilerun)>4
  if strcmp('WBST',upper(noempty(mlmfilerun(1:4))))
    fpwusername4=wbfpwid4; 
  end
end

if (loginid==0)|(~strcmp(fpwusername4,wbfpwid4))
  templatefile = which('wbfpwrelogin.html');
  outstructhereonly.a=1;
  retstr = htmlrep(outstructhereonly, templatefile);
  fpwcheckilpass=0;
else
 if fpwCPALh<fpwCPAL 
  if fpwCPALh==0
     outstruct.FDuloginlevel='Tech Tools';
  elseif (fpwCPALh>=1)&(fpwCPALh<2)
     outstruct.FDuloginlevel=['MarketPulse ',sprintf('%4.2f',fpwCPALh)];  
  elseif fpwCPALh==2
     outstruct.FDuloginlevel='MarketPulse Pro';      
  elseif fpwCPALh==3
     outstruct.FDuloginlevel='PatternWorkshop';      
  elseif fpwCPALh==4
     outstruct.FDuloginlevel='PatternWorkshop Pro';     
  end
  if fpwCPAL==0
     outstruct.FDploginlevel='Tech Tools';
  elseif (fpwCPAL>=1)&(fpwCPAL<2)
     outstruct.FDploginlevel=['MarketPulse ',sprintf('%4.2f',fpwCPAL)];  
  elseif fpwCPAL==2
     outstruct.FDploginlevel='MarketPulse Pro';
  elseif fpwCPAL==3
     outstruct.FDploginlevel='PatternWorkshop';
  elseif fpwCPAL==4
     outstruct.FDploginlevel='PatternWorkshop Pro';
  end
  outstruct.FDfpwusername=fpwusername;    
  outstruct.FDfpwusername4=fpwusername4; 
    
  templatefile = which('wbfpwlogoutAL.html');
  retstr = htmlrep(outstruct, templatefile);
  fpwcheckilpass=0;
  
 elseif ~strcmp(fpwloginIPh,fpwloginIP)
  if fpwCPALh==0
    s.FDloginlevel='Tech Tools';
  elseif (fpwCPALh>=1)&(fpwCPALh<2)
    s.FDloginlevel=['MarketPulse ',sprintf('%4.2f',fpwCPALh)];
  elseif fpwCPALh==2
    s.FDloginlevel='MarketPulse Pro';
  elseif fpwCPALh==3
    s.FDloginlevel='PatternWorkshop';
  elseif fpwCPALh==4
    s.FDloginlevel='PatternWorkshop Pro';
  end      
  s.FDlogintime=time(onlyusedherea);
  s.FDlogouttime=time(onlyusedherec);
  s.FDloginIP2=fpwloginIPh;
  s.FDfpwusername=fpwusername;
  s.FDfpwusername4=fpwusername4;
  
  templatefile = which('wbfpwdlogin.html');
  retstr = htmlrep(s, templatefile);
  fpwcheckilpass=0;    
 end
end
clear onlyusedherea onlyusedhereb onlyusedherec