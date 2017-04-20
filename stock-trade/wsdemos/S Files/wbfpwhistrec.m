function retstr = wbstsea(instruct, outfile)

% Author(s): N. Zhu, 11-15-2003
% This is used to show user's historical using information.

wbfpwbasic;
cd(fpwserverplace);
retstr = char('');
fpwusername=instruct.mlid{1};
fpwCPAL=0;
fpwloginIP='192.168.2.8';
fpwcheckil;

if fpwcheckilpass==1
  myhistrecplace=[fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'];
  fidHere = fopen(myhistrecplace,'r');
  mywbfpwhistrecCode = fread(fidHere);
  mywbfpwhistrecCode=mywbfpwhistrecCode(max([1 length(mywbfpwhistrecCode)-50000]):length(mywbfpwhistrecCode));
  fclose(fidHere);
  s.mywbfpwhistrec=char(mywbfpwhistrecCode');
else
  s.mywbfpwhistrec='wrong user information.';  
end
s.fpwusername=fpwusername;
s.fpwusername4=instruct.mlid4;
s.fpwulvl=instruct.fpwulvl;
s.fpwshowtitle='Here are your most recent using records.';
s.myShowingTitle='Using History';

cids=fpwloginstatus(fpwusername,clock);
templatefile = which('wbfpwhistrec.html');
if (nargin == 1)
  retstr = htmlrep(s, templatefile);
elseif (nargin == 2)
  retstr = htmlrep(s, templatefile, outfile);
end