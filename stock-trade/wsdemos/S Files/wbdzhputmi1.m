function retstr = wbdzhputmi1(instruct, outfile)

% Author(s): N. Zhu, 11-15-2003
% This is a WB (Web-Based) mirror program to <dzhputmi1.m> in desktop version

wbfpwbasic;
cd(fpwserverplace);
retstr = char('');
fpwusername=instruct.mlid{1};
fpwusername4=instruct.mlid4;
eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbdzhinput instruct']);
filetypeid=instruct.filetypeid;
if strcmp(upper(filetypeid(1:5)),'MPSIM')
  FPWMPfiletoopen = [fpwserverplace,fpwclientdirectory,fpwusername,'\stock\usermpsim\mpsim*.mat'];
elseif strcmp(upper(filetypeid(1:5)),'MPDZH')
  FPWMPfiletoopen = [fpwserverplace,fpwclientdirectory,fpwusername,'\stock\usermpdzh\mpdzh*.mat'];    
end
a=dir(FPWMPfiletoopen);
outputtext={};
filesinaline=4;
if length(a)>0
  for i=1:length(a)
    outputtext{fix((i-1)/filesinaline)+1,rem(i-1,filesinaline)+1}=a(i).name(6:length(a(i).name)-4);
  end
  if ((rem(i-1,filesinaline)+1)~=filesinaline)&(fix((i-1)/filesinaline)>0)
    for j=rem(i-1,filesinaline)+2:filesinaline
      outputtext{fix((i-1)/filesinaline)+1,j}='';
    end
  end
else
  outputtext{1}='No available file.';
end

outstruct.MPfiletoshow=outputtext;
outstruct.FDfpwusername=fpwusername;
outstruct.FDfpwusername4=fpwusername4;
outstruct.FDfiletypeid=filetypeid;

cd(fpwserverplace);
templatefile = which('MPopenfile1R.html');
str = htmlrep(outstruct, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\tMPopenfile1R.html'],'noheader');
outstruct.MPloadreport=[fpwclientdirectory,fpwusername,'\stock\tMPopenfile1R.html'];

if filetypeid(6)=='L'
  templatefile = which('fpwopenfile1.html');
elseif filetypeid(6)=='D'
  templatefile = which('fpwdeletefile1.html');    
end

if strcmp(upper(fpwusername(1:5)),'USER0')==1
  templatefile = which('fpwUser0Note.html');
end

if (nargin == 1)
  retstr = htmlrep(outstruct, templatefile);   
elseif (nargin == 2)
  retstr = htmlrep(outstruct, templatefile, outfile);
end