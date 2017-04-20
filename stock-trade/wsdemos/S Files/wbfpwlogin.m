function retstr = wbfpwlogin(instruct, outfile)

% Author(s): N. Zhu, 11-15-2003
% This is a WB (Web-Based) mirror program to <dzhckout.m> in desktop version

wbfpwbasic;
cd(fpwserverplace)
% save c:\matlab\stock\tempipcheck

retstr = char('');
fpwusername=instruct.fpwusername;
fpwpassword=instruct.fpwpassword;
s={};
s.emptyreturn='NotMatched';
passwordcheck=0;
fpwclientinfodire='\webclient1992816372146245525x051069z053063tmdtnndyournameinfofpw\'; % '\clientinfo\';
if exist([fpwserverplace,fpwclientdirectory,fpwusername])==7;
  if exist([fpwserverplace,fpwclientdirectory,fpwusername,fpwclientinfodire,'fpwclientpassword.mat'])==2
    eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,fpwclientinfodire,'fpwclientpassword.mat']);
    if (strcmp(fpwpassword,fpwclientpassword))
      passwordcheck=1;
      s.fpwusernameid=fpwusername;
    end
  end
end
if passwordcheck==0
  templatefile = which('wbfpwlogin1.html');
elseif passwordcheck==1
  [instatus,intime,lat,outtime,loginle,loginIP2]=fpwloginstatus(fpwusername);
  if ((instatus==0)&(datenum(outtime)-datenum(intime)>0))|(strcmp(upper(fpwusername),'NINGZHU'))|(strcmp(upper(fpwusername),'AARONZHU'))|(strcmp(upper(fpwusername),'DIANEXU'))
    if(strcmp(upper(fpwusername),'NINGZHU'))
      templatefile = which('indexzhu.html');
    else
      if ~(strcmp(upper(fpwusername(1:4)),'USER'))
        templatefile = which('index.html');
      else
        templatefile = which('index_nlink.html');
      end
    end
    Weekdays=['Sunday   ';
              'Monday   ';
              'Tuesday  ';
              'Wednesday';
              'Thursday ';
              'Friday   ';
              'Saturday '];
    MonthDS=['January  ';
             'February ';
             'March    ';
             'April    ';
             'May      ';
             'June     ';
             'July     ';
             'August   ';
             'September';
             'October  ';
             'November ';
             'December '];
              
    s.WeekdaySH=noempty(Weekdays(weekday(now),:));
    TimeSH=time1;
    s.TimeSH=TimeSH(1:8);
    s.DateSH=[noempty(MonthDS(str2num(datestr(now,5)),:)),' ',datestr(now,7),', ',datestr(now,10)];
    s.fpwulvl=loginle;
    fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
    fseek(fid1,-50,1); fprintf(fid1,[time,' LGIN\n']); fclose(fid1); clear fid1
    loginiph=instruct.UserIPAddress; %'192.168.2.8';  % add real IP here
    loginids=fpwloginstatus(fpwusername,clock,1,loginiph);
    wbfpwid4=sprintf('%06d',rem(fix(1000000*rand),999999)); %before its 100 PPM now change to 1 PPM error
    eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,fpwclientinfodire,'fpwusername4.mat wbfpwid4']);
    s.fpwusernameid4=wbfpwid4;
    wbststopritm=0;
    eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbststopritm.mat wbststopritm']);
  else
      
    if loginle==0
      s.FDloginlevel='Tech Tools'; % $14.99/Month';
    elseif loginle==1
      s.FDloginlevel='MarketPulse';%, $49/Month';  
    elseif loginle==2
      s.FDloginlevel='MarketPulse Pro';%, $149/Month';      
    elseif loginle==3
      s.FDloginlevel='PatternWorkshop';%, $499/Month';      
    elseif loginle==4
      s.FDloginlevel='PatternWorkshop Pro';%, $999/Month';      
    end      
    s.FDlogintime=time(intime);
    s.FDlogouttime=time(outtime);
    s.FDloginIP2=loginIP2;
    s.FDfpwusername=fpwusername;
    templatefile = which('wbfpwdlogin.html');     
  end
  
end

% Rotating middle small Pictur
fpwserverplaceimages=[fpwserverplace,'\images'];
middlesmallnum=sprintf('%02d',ceil(50*rand));
if exist([fpwserverplaceimages,'\middlesmall',middlesmallnum,'.jpg'],'file')==2
  s.msfnum=['images/middlesmall',middlesmallnum,'.jpg'];
else
  s.msfnum=['images/middlesmall06.jpg'];
end

% Rotating top long banner logo
toplongnum=sprintf('%1d',ceil(9*rand));
if exist([fpwserverplaceimages,'\toplong',toplongnum,toplongnum,'1.jpg'],'file')==2
  s.tlbnum=['images\toplong',toplongnum,toplongnum,'1.jpg'];
else
  s.tlbnum=['images\toplong111.jpg'];
end
if exist([fpwserverplaceimages,'\toplong',toplongnum,toplongnum,'1.jpg'],'file')==2
  s.tlsnum=['images\toplong',toplongnum,toplongnum,'2.jpg'];
else
  s.tlsnum=['images\toplong112.jpg'];
end

if (nargin == 1)
  retstr = htmlrep(s, templatefile);   
elseif (nargin == 2)
  retstr = htmlrep(s, templatefile, outfile);
end