function retstr = wbfpwir(instruct, outfile)

% Author(s): N. Zhu, 11-15-2003
% This is used to send IR

wbfpwbasic;
cd(fpwserverplace);
retstr = char('');
fpwusername=instruct.mlid{1};
fpwCPAL=1;
fpwloginIP='192.168.2.8';
fpwcheckil;

if fpwcheckilpass==1
    
  wbststopritm=1;
  eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbststopritm.mat wbststopritm']);
  
  templatefile = which('MessageBoard.html');
  cd(fpwserverplace);
  smps2.fpwusername=fpwusername;
  smps2.MBmemo='A Stop-runing request has been issued ......';     
  if (nargin == 1)
    retstr = htmlrep(smps2, templatefile);     
  elseif (nargin == 2)
    retstr = htmlrep(smps2, templatefile, outfile);
  end   
  cd([Wherematlab,'stock']);
  
end