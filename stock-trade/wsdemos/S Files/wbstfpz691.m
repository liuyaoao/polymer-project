function retstr = wbstfpz691(instruct, outfile)

% Author(s): N. Zhu, 11-15-2003
% This is a WB (Web-Based) mirror program to <stfpz691.m> in desktop version

wbfpwbasic;
cd(fpwserverplace);
retstr = char('');
fpwusername=instruct.mlid{1};
fpwCPAL=0;
fpwloginIP='192.168.2.8';
fpwcheckil;

if fpwcheckilpass==1
  mnamehere='S';
  if ~strcmp(instruct.mlmfvar,'leavemealone')
    WhereOrderFromH='LINK';
  else    
    WhereOrderFromH=instruct.WhereOrderFrom;
  end
  if ~(strcmp(WhereOrderFromH,'INDX'))
    if strcmp(WhereOrderFromH,'SLFE')
      mnamehere=instruct.fpwfstype;    
    elseif strcmp(WhereOrderFromH,'LINK')  
      namehere=noempty(instruct.mlmfvar);
      mnamehere=upper(namehere(1));
      clear namehere      
    end
  end
  if mnamehere=='F'
    fpwCPAL=3;
    fpwloginIP='192.168.2.8';
    fpwcheckil;
  end
  clear mnamehere WhereOrderFromH  
end

if fpwcheckilpass==1

if ~strcmp(instruct.mlmfvar,'leavemealone')
  WhereOrderFrom='LINK'; % order from Data link
else    
  WhereOrderFrom=instruct.WhereOrderFrom;
end

if strcmp(WhereOrderFrom,'MPLG') % order from MP Login window
  eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbdzhinput instruct']); 
end

cd([Wherematlab,'stock']);
%save fpwzonetest.mat

if ~(strcmp(WhereOrderFrom,'INDX')) %order directly from index.html

  if strcmp(WhereOrderFrom,'MPLG')
    name=noempty(instruct.zsobx72);
    global mname; 
    mname='S';
    zone69=6;
    oycy=2;
  elseif strcmp(WhereOrderFrom,'SLFE') % from itself page
    name=noempty(instruct.fpwsymbol);
    global mname; 
    mname=instruct.fpwfstype;    
    zone69=str2num(instruct.fpwzone69(1));  
    oycy=str2num(instruct.fpwzone69(2));  
  elseif strcmp(WhereOrderFrom,'LINK')  
    name=noempty(instruct.mlmfvar);
    global mname;
    mname=upper(name(1));
    name=name(2:length(name));     
    zone69=6;
    oycy=2;
  end
  if (length(name)==0)|(length(name)>6)
    error('Entered wrong symbol.');
  end

  loadi=1;    % setup to 2 once for a two months
              % 1 means to load the statistics and cal it if NO data there
              % 2 means to calculate it everytime
              %
              % Or delete all zone data in [Rfddataplace,'zones'] directory for every two months

  name=lower(name);
  stock=fsdaydat([mname,name]);
  
  if length(stock)==0
    error('No data available for this stock, please check the symbol.');
  end
  
  if strcmp(WhereOrderFrom,'MPLG')
    fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
    fseek(fid1,-50,1); fprintf(fid1,[time,' MPGZ: ',upper(mname),num2str(zone69),'-',upper(name),'\n']); fclose(fid1);
    clear fid1
  elseif strcmp(WhereOrderFrom,'SLFE')
    fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
    fseek(fid1,-50,1); fprintf(fid1,[time,' SLFZ: ',upper(mname),num2str(zone69),'-',upper(name),'\n']); fclose(fid1);
    clear fid1
  elseif strcmp(WhereOrderFrom,'LINK')
    fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
    fseek(fid1,-50,1); fprintf(fid1,[time,' LNKZ: ',upper(mname),'-',upper(name),'\n']); fclose(fid1);
    clear fid1   
  end
  
  if loadi==1
    if strcmp(upper(mname),'F')==1
      if oycy==2
        if zone69==9
          if exist([Rfddataplace,'zones\fe',name,'.mat'])==2
            eval(['load ',Rfddataplace,'zones\fe',name]);
          else
            [output2,outputc2,outputr2,outputs2]=fpnamee(name,stock);
          end          
        else
          if exist([Rfddataplace,'zones\f',name,'.mat'])==2
            eval(['load ',Rfddataplace,'zones\f',name]);
          else
            [output2,outputc2,outputr2,outputs2]=fpname(name,stock);
          end
        end
      else
        if zone69==9
          if exist([Rfddataplace,'zones\fse',name,'.mat'])==2
            eval(['load ',Rfddataplace,'zones\fse',name]);
          else
            [output2,outputc2,outputr2,outputs2]=fpnamese(name,stock);
          end          
        else
          if exist([Rfddataplace,'zones\fs',name,'.mat'])==2
            eval(['load ',Rfddataplace,'zones\fs',name]);
          else
            [output2,outputc2,outputr2,outputs2]=fpnames(name,stock);
          end
        end
      end
    else
      if oycy==2
        if zone69==9
          if exist([Rfddataplace,'zones\se',name,'.mat'])==2
            eval(['load ',Rfddataplace,'zones\se',name]);
          else
            [output2,outputc2,outputr2,outputs2]=fpnamee(name,stock);
          end          
        else
          if exist([Rfddataplace,'zones\s',name,'.mat'])==2
            eval(['load ',Rfddataplace,'zones\s',name]);
          else
            [output2,outputc2,outputr2,outputs2]=fpname(name,stock);
          end
        end
      else
        if zone69==9
          if exist([Rfddataplace,'zones\sse',name,'.mat'])==2
            eval(['load ',Rfddataplace,'zones\sse',name]);
          else
            [output2,outputc2,outputr2,outputs2]=fpnamese(name,stock);
          end          
        else
          if exist([Rfddataplace,'zones\ss',name,'.mat'])==2
            eval(['load ',Rfddataplace,'zones\ss',name]);
          else
            [output2,outputc2,outputr2,outputs2]=fpnames(name,stock);
          end 
        end
      end
    end
  else
    if oycy==2
      if zone69==9
        [output2,outputc2,outputr2,outputs2]=fpnamee(name,stock);
      else
        [output2,outputc2,outputr2,outputs2]=fpname(name,stock);
      end
    else
      if zone69==9
        [output2,outputc2,outputr2,outputs2]=fpnamese(name,stock);
      else
        [output2,outputc2,outputr2,outputs2]=fpnames(name,stock);
      end
    end
  end
  
  enterd=stock(length(stock)-1:length(stock),1:4);
  oyy=enterd(1,1);hyy=enterd(1,2);lyy=enterd(1,3);cyy=enterd(1,4);
  oy=enterd(2,1);hy=enterd(2,2);ly=enterd(2,3);cy=enterd(2,4);
  
  if oycy==2
    if (cy>oy)
      a=2; AA=2;
    else
      a=1; AA=1;
    end
  else
    a=1; AA=3;
  end
  
  if zone69==9
    b=length(find(sort(frsp6e(hyy,lyy,cyy))<cy))+1;
    pcode=100*a+10*b;
    zspn=abs(sort(-frsp6e(hy,ly,cy)));
    zspn=[2*mean([hy ly cy])+hy-2*ly zspn];
    out=output2;data=out(:,12);
    outc=outputc2;outr=outputr2;outs=outputs2;
    naen=['ZONE 9';'ZONE 8';'ZONE 7';'ZONE 6';'ZONE 5';'ZONE 4';'ZONE 3';'ZONE 2';'ZONE 1'];
    fpwzoneoutput='';
  
    if AA==2
      YON=['YOC=','U'];
    elseif AA==1
      YON=['YOC=','D'];
    else
      YON=['YOC=','X'];
    end
    fpwzoneoutput=[fpwzoneoutput,sprintf(['  ',time,' %1s%1d: %5s  Zone Analysis: ',YON,', LTD-CP=%8.3f,Z=%1d\n\n'],upper(mname),zone69,upper(name),cy,b)];
    for d=9:-1:1
      fpwzoneoutput=[fpwzoneoutput,sprintf('  IF THE OPEN IS INSIDE ZONE %1d:\n',d)];
      pr=find(data==pcode+d);
      if length(pr)~=0
        per=out(pr,9:-1:1);
        perc=outc(pr,9:-1:1);
        perr=outr(pr,9:-1:1);
        pers=outs(pr,9:-1:1);
        pp(9-d+1)=out(pr,10);
        sam=int2str(out(pr,11));
        SAM(9-d+1)=out(pr,11);
        fpwzoneoutput=[fpwzoneoutput,sprintf('    There is a %3d percent chance of a higher close. (%4s samples)\n',pp(9-d+1),sam)];
        for ii=1:9
          fpwzoneoutput=[fpwzoneoutput,sprintf('    C:%3d  R:%3d  S:%3d and  %3d percent chance hit %8.3f -%7s\n',perc(ii),perr(ii),pers(ii),per(ii),zspn(ii),naen(ii,:))];
        end
      else
        fpwzoneoutput=[fpwzoneoutput,sprintf('    No Occurrences\n')];
      end
      fpwzoneoutput=[fpwzoneoutput,sprintf('\n')]; 
    end
    fpwzoneoutput=[fpwzoneoutput,sprintf('  NTD: %3d percent chance of a higher close no matter where to open.\n',round(sum(pp.*SAM)/sum(SAM)))];
  else
    b=length(find(sort(frsp6(hyy,lyy,cyy))<cy))+1;
    pcode=100*a+10*b;
    zspn=abs(sort(-frsp6(hy,ly,cy)));
    zspn=[1.05*zspn(1) zspn];
    out=output2;data=out(:,9);
    outc=outputc2;outr=outputr2;outs=outputs2;
    naen=['ZONE 6';'ZONE 5';'ZONE 4';'ZONE 3';'ZONE 2';'ZONE 1'];
    fpwzoneoutput='';
      
    if AA==2
      YON=['YOC=','U'];
    elseif AA==1
      YON=['YOC=','D'];
    else
      YON=['YOC=','X'];
    end
    fpwzoneoutput=[fpwzoneoutput,sprintf(['  ',time,' %1s%1d: %5s  Zone Analysis: ',YON,', LTD-CP=%8.3f,Z=%1d\n\n'],upper(mname),zone69,upper(name),cy,b)];
    for d=6:-1:1
      fpwzoneoutput=[fpwzoneoutput,sprintf('  IF THE OPEN IS INSIDE ZONE %1d:\n',d)];
      pr=find(data==pcode+d);
      if length(pr)~=0
        per=out(pr,6:-1:1);
        perc=outc(pr,6:-1:1);
        perr=outr(pr,6:-1:1);
        pers=outs(pr,6:-1:1);
        pp(6-d+1)=out(pr,7);
        sam=int2str(out(pr,8));
        SAM(6-d+1)=out(pr,8);
        fpwzoneoutput=[fpwzoneoutput,sprintf('    There is a %3d percent chance of a higher close. (%3s samples)\n',pp(6-d+1),sam)];
        for ii=1:6
          fpwzoneoutput=[fpwzoneoutput,sprintf('    C:%3d  R:%3d  S:%3d and  %3d percent chance hit %8.3f -%7s\n',perc(ii),perr(ii),pers(ii),per(ii),zspn(ii),naen(ii,:))];
        end
      else
        fpwzoneoutput=[fpwzoneoutput,sprintf('    No Occurrences\n')];
      end
      fpwzoneoutput=[fpwzoneoutput,sprintf('\n')]; 
    end
    fpwzoneoutput=[fpwzoneoutput,sprintf('  NTD: %3d percent chance of a higher close no matter where to open.\n',round(sum(pp.*SAM)/sum(SAM)))];
  end
  s.fpwzoneoutput=fpwzoneoutput;
  s.fpwusername=fpwusername;
  s.fpwusername4=fpwusername4;
  s.ZoneResultsOut=[fpwclientdirectory,fpwusername,'\stock\twbstfpz691R.html'];
  cd(fpwserverplace);
  s.fpwsymbol=upper(name);
  s.fpwfstype=mname;
  eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\fpwstzone s']);
else
  if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\stock\fpwstzone.mat'])==2
     eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\fpwstzone']);
  else
    s.fpwzoneoutput='No output yet';
    s.fpwusername=fpwusername;
    s.fpwusername4=fpwusername4;
    s.ZoneResultsOut=[fpwclientdirectory,fpwusername,'\stock\twbstfpz691R.html'];
    cd(fpwserverplace);
    s.fpwsymbol='UrSymbol';
    s.fpwfstype='S'; 
  end
end
s.fpwcurrentm=[s.fpwfstype,s.fpwsymbol];
cids=fpwloginstatus(fpwusername,clock);
s.fpwusername=fpwusername;
s.fpwusername4=fpwusername4;
s.fpwulvl=instruct.fpwulvl;

if (strcmp(WhereOrderFrom,'MPLG'))|(strcmp(WhereOrderFrom,'INDX'))|(strcmp(WhereOrderFrom,'LINK'))
  if (strcmp(WhereOrderFrom,'MPLG'))|(strcmp(WhereOrderFrom,'LINK'))
    templatefile = which('wbstfpz691R.html');
    str = htmlrep(s, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\twbstfpz691R.html'],'noheader');
  end
  if ~(strcmp(upper(fpwusername(1:4)),'USER'))
    templatefile = which('wbstfpz691.html');
  else
    templatefile = which('wbstfpz691_nlink.html');
  end
  if (nargin == 1)
    retstr = htmlrep(s, templatefile);
  elseif (nargin == 2)
    retstr = htmlrep(s, templatefile, outfile);
  end
elseif strcmp(WhereOrderFrom,'SLFE')
  templatefile = which('wbstfpz691R.html');
  if (nargin == 1)
    str = htmlrep(s, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\twbstfpz691R.html'],'noheader');      
    retstr = htmlrep(s, templatefile);
  elseif (nargin == 2)
    retstr = htmlrep(s, templatefile, outfile);
  end    
end
end