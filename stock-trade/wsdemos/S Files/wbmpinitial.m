function retstr = wbmpinitial(instr, outfile)

% Author(s): N. Zhu, 11-15-2003
% This is a WB (Web-Based) mirror program to <dzhckout.m> in desktop version

wbfpwbasic;
cd(fpwserverplace);
retstr = char('');
fpwusername=instr.mlid{1}; %only need to know the username to initial MP

fpwCPAL=1;
fpwloginIP='192.168.2.8';
fpwcheckil;

if fpwcheckilpass==1

  eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbdzhinput']);
  if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbdzhsort.mat'])==2
    eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbdzhsort']);
  else
    wbdzhsid=10; eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbdzhsort wbdzhsid']);
  end
  fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
  fseek(fid1,-50,1); fprintf(fid1,[time,' MPLG\n']); fclose(fid1); clear fid1
  cids=fpwloginstatus(fpwusername,clock);
  
  outstruct.FDhdzsobx39='STAT'; %instruct.hdzsobx39;
  linecond=instruct.zsobx31;
  if length(noempty(linecond))==0; linecond='  '; end
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
  outstruct.FDmlmfvar2=num2str(wbdzhsid);
  if isfield(instruct,'zsobxSG')
    outstruct.FDzsobxSG=instruct.zsobxSG;
  else
    outstruct.FDzsobxSG='-1';
  end
  
  %fpwlastruntime=dirdet([fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbdzhinput.mat']);
  %fpwlastruntime=fpwlastruntime(2:6);
  %outstruct.fpwlastruntime=date2str(fpwlastruntime);
  outstruct.MPmainoutputdata=[fpwclientdirectory,fpwusername,'\stock\tMarketpulseR.html'];
  outstruct.MPstquotedata=[fpwclientdirectory,fpwusername,'\stock\twbfpwstquote.html'];
  outstruct.MPstatusreport=['http:\\www.WSQSI.com',fpwclientdirectory,fpwusername,'\stock\tMarketpulseR1.html'];
  outstruct.FDfpwusername=fpwusername;
  outstruct.FDfpwusername4=fpwusername4;
  if isfield(instr,'fpwulvl')
    outstruct.fpwulvl=instr.fpwulvl;
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
      outstruct.mybarh21=int2str(26000); % every minute to auto-update, and loop for 700 times, 11.75 hours
      outstruct.mybarh22=int2str(2100);
    else
      outstruct.mybarh21=int2str(300000);% every 5 minutes to auto-update, and loop for 12 times, 1 hour
      outstruct.mybarh22=int2str(12);
    end
  else
    outstruct.mybarh21=int2str(9999999); % basically no auto-update
    outstruct.mybarh22=int2str(3);
  end
  
  if isfield(instruct,'zsobx622')
    if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwpatseed.mat'])==2
      eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwpatseed PatSeed']);
    else
      PatSeed=zeros(20,50)+10;
    end
    patseedj=reshape(PatSeed',1,1000); 
    hdpatseed='';
    for i=1:1000
      hdpatseed=[hdpatseed,sprintf('%02d',round(patseedj(i)))];
    end
    outstruct.hdpatseed=hdpatseed;
  end
  
  if ~(strcmp(upper(fpwusername(1:4)),'USER'))
    templatefile = which('Marketpulse0.html');
  else
    templatefile = which('Marketpulse0_nlink.html');
  end

  if (nargin == 1)
    retstr = htmlrep(outstruct, templatefile); 
  elseif (nargin == 2)
    retstr = htmlrep(outstruct, templatefile, outfile);
  end
end