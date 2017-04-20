function retstr = wbdzhscsav(instruct, outfile)

% Author(s): N. Zhu, 11-15-2003
% This is a WB (Web-Based) mirror program to <dzhscsav.m> in desktop version

wbfpwbasic;
cd(fpwserverplace)
retstr = char('');
fpwusername=instruct.mlid{1};
fpwusername4=instruct.mlid4;

if (isfield(instruct,'zsobx31'))
  cd([Wherematlab,'pattern']);
  if fpwsecucheck([instruct.zsobx31,instruct.zsobx53,instruct.zsobx57])>0
    error(' Hei! Not allowed content found, are you seriously trying to .... Sorry, change it.');
  end
  cd(fpwserverplace);
end

%save c:\matlab\pattern\mybug20160710.mat
if isfield(instruct,'zsobx622')
  if (length(strfind(instruct.mybarh23,'$'))>0)|(length(instruct.mybarh23)==0)
    heightsh=[3 15 20 25 30 45 40 39 36 38 40 45 50 60 70 75 80 74 70 60 0 0,...
              3 15 20 25 30 45 40 39 36 38 40 45 50 60 70 75 80 74 70 60,...
              40 45 50 60 70 75 80 74 70 60];
    for i=23:52
      eval(['instruct.mybarh',int2str(i),'=''',int2str(heightsh(i)),'px'';']);
      %eval(['instruct.mybarh',int2str(i),'=',int2str(heightsh(i)),';']);
    end 
  end
end

eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbdzhinput instruct']); 

if isfield(instruct,'zsobx622')
 if strcmp('2',instruct.hdpatseed3)
  if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwpatseed.mat'])==2
    eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwpatseed PatSeed']);
  else
    PatSeed=zeros(20,50)+10;
  end
  dzhline=zeros(52,1);
  for i=1:20
    eval(['mybarhx=instruct.mybarh',int2str(i),';']);
    if length(strfind(mybarhx,'px'))>0
      dzhline(i,1)=str2num(mybarhx(1:length(mybarhx)-2));
    else
      dzhline(i,1)=str2num(mybarhx);
    end
  end
  for i=23:52
    eval(['mybarhx=instruct.mybarh',int2str(i),';']);
    if length(strfind(mybarhx,'px'))>0
      dzhline(i,1)=str2num(mybarhx(1:length(mybarhx)-2));
    else
      dzhline(i,1)=str2num(mybarhx);
    end
  end
  dzhline(21)=dzhline(51);
  dzhline(22)=dzhline(52);
  dzhline=round(dzhline(1:50));
  zsobx622=str2num(instruct.zsobx622);
  PatSeed(zsobx622,:)=dzhline';
  eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwpatseed PatSeed']);
  outstruct.StatusReport = ['Data saved to the default and PatSeed files successfully. ',time];
 else
  outstruct.StatusReport = ['Data saved to the default file successfully. ',time];
 end
else
  outstruct.StatusReport = ['Data saved to the default file successfully. ',time];
end

outstruct.fpwclientdirectory=fpwclientdirectory;
outstruct.fpwusername=fpwusername;
outstruct.fpwusername4=fpwusername4;

templatefile = which('MarketpulseR1.html');
if (nargin == 1)
  retstr = htmlrep(outstruct, templatefile);
  str = htmlrep(outstruct, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\tMarketpulseR1.html'],'noheader');  
elseif (nargin == 2)
  retstr = htmlrep(outstruct, templatefile, outfile);
end