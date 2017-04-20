function retstr = wbfpwlogout(instruct, outfile)

% Author(s): N. Zhu, 11-15-2003
% This is a WB (Web-Based) mirror program to <dzhckout.m> in desktop version

wbfpwbasic;
cd(fpwserverplace);
retstr = char('');
fpwusername=instruct.mlid{1}; %only need to know the username to logou
fpwusername4=instruct.mlid4;

fpwclientinfodire='\webclient1992816372146245525x051069z053063tmdtnndyournameinfofpw\';
eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,fpwclientinfodire,'fpwusername4.mat']);

[cids cintime clat couttime]=fpwloginstatus(fpwusername);
if (cids==1)&(strcmp(fpwusername4,wbfpwid4))
  fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
  fseek(fid1,-50,1); fprintf(fid1,[time,' LGEX\n']); fclose(fid1); clear fid1    
  [cids cintime c d loginl]=fpwloginstatus(fpwusername,clock,0); 
  if loginl==0
     outstruct.FDloginlevel='Tech Tools';
  elseif loginl==1
     outstruct.FDloginlevel='MarketPulse';
  elseif loginl==2
     outstruct.FDloginlevel='MarketPulse Pro';
  elseif loginl==3
     outstruct.FDloginlevel='PatternWorkshop';
  elseif loginl==4
     outstruct.FDloginlevel='PatternWorkshop Pro';
  end
  outstruct.FDlogintime=time1(cintime);
  outstruct.FDlogouttime=time1(couttime);
  outstruct.FDcurrenttime=time1;  
  outstruct.FDfpwusername=fpwusername;
  outstruct.FDfpwusername4=fpwusername4;
  templatefile = which('wbfpwlogout.html');
  
  if (nargin == 1)
    retstr = htmlrep(outstruct, templatefile); 
  elseif (nargin == 2)
    retstr = htmlrep(outstruct, templatefile, outfile);
  end
else
  outstruct.FDtimeout=time1(clat);  
  outstruct.FDfpwusername=fpwusername;
  outstruct.FDfpwusername4=fpwusername4;
  templatefile = which('fpwtimeout.html');
  
  if (nargin == 1)
    retstr = htmlrep(outstruct, templatefile); 
  elseif (nargin == 2)
    retstr = htmlrep(outstruct, templatefile, outfile);   
  end
end
