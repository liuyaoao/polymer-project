function retstr = wbstrdata(instruct, outfile)

% Author(s): N. Zhu, 11-15-2003
% This is a WB (Web-Based) mirror program to <> in desktop version

wbfpwbasic;
cd(fpwserverplace);
retstr = char('');
fpwusername=instruct.mlid{1};

fpwCPAL=0;
fpwloginIP='192.168.2.8';
fpwcheckil;

if fpwcheckilpass==1

if ~strcmp(instruct.mlmfvar,'leavemealone')
  name=noempty(instruct.mlmfvar);
  name=name(2:length(name));
else
  name=noempty(instruct.zsobx72);
end
mname='S';
name=strrep(lower(name),'_','-');

if (length(name)==0)|(length(name)>6)
    error('Entered wrong symbol.');
else
  if isfield(instruct,'hdzsobx39')
    eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbdzhinput instruct']); 
    fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
    fseek(fid1,-50,1); fprintf(fid1,[time,' MPGY: ',upper(name),'\n']); fclose(fid1);
    clear fid1
  end
end

if ~strcmp(instruct.mlmfvar,'leavemealone')
  if instruct.mlmfvar(1)=='F'
    s.fpwtoyahoo=['http://finance.yahoo.com/q/pr?s=',upper(name)]; 
  elseif instruct.mlmfvar(1)=='E'
    s.fpwtoyahoo=['http://finance.yahoo.com/q/h?s=',upper(name)];      
  end
else
  if instruct.zsobx71=='F'
    s.fpwtoyahoo=['http://finance.yahoo.com/q/pr?s=',upper(name)];
  elseif instruct.zsobx71=='E'
    s.fpwtoyahoo=['http://finance.yahoo.com/q/h?s=',upper(name)];
  end
end

s.fpwcurrentm=['S',name];
s.fpwusername=fpwusername;
s.fpwusername4=fpwusername4;
s.fpwulvl=instruct.fpwulvl;
cd(fpwserverplace);
cids=fpwloginstatus(fpwusername,clock);
templatefile = which('wbsttoyahoo.html');
if (nargin == 1)
  retstr = htmlrep(s, templatefile);
elseif (nargin == 2)
  retstr = htmlrep(s, templatefile, outfile);
end 
end