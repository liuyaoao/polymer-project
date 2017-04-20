function retstr = wbstquote(instruct, outfile)

% Author(s): N. Zhu, 11-15-2003
% This is a WB (Web-Based) mirror program to <dzhjust.m> in desktop version

wbfpwbasic;
cd(fpwserverplace);
retstr = char('');
fpwusername=instruct.mlid{1};
fpwCPAL=1;
fpwloginIP='192.168.2.8';
fpwcheckil; % contains fpwusername4 and others

outstruct.fpwusername=fpwusername;
outstruct.fpwusername4=fpwusername4;
outstruct.fpwclientdirectory=fpwclientdirectory;
outstruct.fpwulvl=instruct.fpwulvl;
outstruct.oo='';
outstruct.stqbox01=''; outstruct.colorbr01='blue';
outstruct.stqbox02=''; outstruct.colorbr02='blue';
outstruct.stqbox03=''; outstruct.colorbr03='blue';
outstruct.stqbox04=''; outstruct.colorbr04='blue';
outstruct.stqbox05=''; outstruct.colorbr05='blue';
outstruct.stqbox06=''; outstruct.colorbr06='blue';
outstruct.stqbox07=''; outstruct.colorbr07='blue';
outstruct.stqbox08=''; outstruct.colorbr08='blue';
outstruct.stqbox09=''; outstruct.colorbr09='blue';
outstruct.stqbox10=''; outstruct.colorbr10='blue';
outstruct.stqbox11=''; outstruct.colorbr11='blue';
outstruct.stqbox12=''; outstruct.colorbr12='blue';
%outstruct.stqbox13=''; outstruct.colorbr13='blue';

cd([Wherematlab,'stock']);
load fpwnlt namelist

if fpwcheckilpass==1
  sortkind=str2num(instruct.mlmfvar3);
  if sortkind<20
    if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbstqlist.mat'])==2
      eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbstqlist']); %load data from disk wbstqlist{i}
      for i=1:12
        eval(['outstruct.stqbox',sprintf('%02d',i),'=upper(wbstqlist{i});']);
        if length(noempty(wbstqlist{i}))>0
          ip(i)=checknow(namelist,upper(wbstqlist{i}),'$');
        else
          ip(i)=0;      
        end
      end
      if sortkind==10
        if str2num(instruct.fpwulvl)>1
          refreshtimetotal=1; % 36; % 3 minutes
        else
          refreshtimetotal=1; % 12; % 1 minute
        end
        outstruct.refreshtime='18000'; %'5';
      else
        refreshtimetotal=1;
        outstruct.refreshtime='18000'; %'12';
      end
    else
      wbstqlist={};
      for i=1:12
        eval(['outstruct.stqbox',sprintf('%02d',i),'='''';']);
        wbstqlist{i}='';
      end
      ip=zeros(12,1);
      sampleq=namelist(1,:);
      sampleq=sampleq(find(sampleq~='$'));
      outstruct.stqbox01=sampleq;    
      wbstqlist{1}=sampleq;
      ip(1)=1;
      outstruct.refreshtime='18000';
      refreshtimetotal=1; 
      eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbstqlist wbstqlist ip']);
    end
  elseif sortkind==20
    %read data from screen and save  
    wbstqlist={};
    for i=1:12
      symbolh=eval(['instruct.dzhstqbx',sprintf('%02d',i)]);
      if length(symbolh)>0
        symbolh=symbolh(find(symbolh~=char(160)));
      end
      eval(['outstruct.stqbox',sprintf('%02d',i),'=symbolh;']);
      if length(noempty(symbolh))>0
        symbolh=upper(noempty(symbolh));
        eval(['outstruct.stqbox',sprintf('%02d',i),'=symbolh;']);
        wbstqlist{i}=symbolh;
        ip(i)=checknow(namelist,symbolh,'$');
      else
        wbstqlist{i}='';
        ip(i)=0;    
      end
    end
    eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbstqlist wbstqlist ip']);  
    outstruct.refreshtime='18000';
    refreshtimetotal=1;
  end
  
  %disp(' check point 0');
  %save wbstquote
  
  refreshtimes=1;
  load stchour1 outstandshare EPS
  indexeps=find(EPS==0); EPS(indexeps)=zeros(size(indexeps))+1;
 
  tradinghours=0;
  timevalue=clock;
  markethourst;
  timecal=timevalue(4)+timevalue(5)/60;
  datetoday=[timevalue(2:3) timevalue(1)-2000];
  tradingdays=0;
  if (closehourt>openhourt)&(dn(datetoday)<=5)
    tradingdays=1; 
  end  
  if (timecal>openhourt)&(timecal<closehourt+1/12)&(dn(datetoday)<=5)
    if closehourt>openhourt
      tradinghours=1;
    end
  end
  
  if ~((tradinghours==1)|((timecal>=4)&(timecal<=20)&(tradingdays==1)))
    refreshtimes=refreshtimetotal;  
    outstruct.refreshtime='18000';    
  end
  
  y={};
  while refreshtimes<=refreshtimetotal
    if sortkind==10 %refreshtimetotal>refreshtimes
      outstruct.oo='.On';
    else
      outstruct.oo='';
    end
    cd([Wherematlab,'stock']);
    if (tradinghours==1)|((timecal>=4)&(timecal<=20)&(tradingdays==1))
      %!copy x:\stock\fpwnltlast.mat c:\matlab\stock
      load fpwnltlast fpwnltlast
      ohlcvn=fpwnltlast(:,1:6);
    else
      load dayfnum
      eval(['load ',tickdayplacesc,'D',sprintf('%07d',dailyfilenumber-1),' ohlcvn']);  
    end      
    ohlcvn(:,2)=(max((ohlcvn(:,1:4))'))';
    ohlcvn(:,3)=(min((ohlcvn(:,1:4))'))';
    PE=ohlcvn(:,4)./EPS; 
    PE(indexeps)=zeros(size(indexeps));
    indexdiv=find(ohlcvn(:,4)==0.001);
    CAP=outstandshare.*ohlcvn(:,4)/1000; 
    CAP(indexdiv)=zeros(size(indexdiv));
    
    %disp(' check point 1');
    
    for i=1:length(ip)
      if ip(i)~=0
        if ohlcvn(ip(i),6)<0
          y{i,1}=sprintf('<font color="red" size="2" face="Arial"><b>%8.2f</b></font>',ohlcvn(ip(i),1));
          y{i,2}=sprintf('<font color="red" size="2" face="Arial"><b>%8.2f</b></font>',ohlcvn(ip(i),2));
          y{i,3}=sprintf('<font color="red" size="2" face="Arial"><b>%8.2f</b></font>',ohlcvn(ip(i),3));
          y{i,4}=sprintf('<font color="red" size="2" face="Arial"><b>%8.2f</b></font>',ohlcvn(ip(i),4));
          y{i,5}=sprintf('<font color="red" size="2" face="Arial"><b>%8.2f</b></font>',ohlcvn(ip(i),6));
          y{i,6}=sprintf('<font color="red" size="2" face="Arial"><b>%7d</b></font>',round(ohlcvn(ip(i),5)*100));
          y{i,7}=sprintf('<font color="red" size="2" face="Arial"><b>%8.2f</b></font>',PE(ip(i)));
          y{i,8}=sprintf('<font color="red" size="2" face="Arial"><b>%8.2f</b></font>',CAP(ip(i))); 
          eval(['outstruct.colorbr',sprintf('%02d',i),'=''Red'';']);
        else
          y{i,1}=sprintf('<font color="blue" size="2" face="Arial"><b>%8.2f</b></font>',ohlcvn(ip(i),1));
          y{i,2}=sprintf('<font color="blue" size="2" face="Arial"><b>%8.2f</b></font>',ohlcvn(ip(i),2));
          y{i,3}=sprintf('<font color="blue" size="2" face="Arial"><b>%8.2f</b></font>',ohlcvn(ip(i),3));
          y{i,4}=sprintf('<font color="blue" size="2" face="Arial"><b>%8.2f</b></font>',ohlcvn(ip(i),4));
          y{i,5}=sprintf('<font color="blue" size="2" face="Arial"><b>%8.2f</b></font>',ohlcvn(ip(i),6));
          y{i,6}=sprintf('<font color="blue" size="2" face="Arial"><b>%7d</b></font>',round(ohlcvn(ip(i),5)*100));
          y{i,7}=sprintf('<font color="blue" size="2" face="Arial"><b>%8.2f</b></font>',PE(ip(i)));
          y{i,8}=sprintf('<font color="blue" size="2" face="Arial"><b>%8.2f</b></font>',CAP(ip(i))); 
          eval(['outstruct.colorbr',sprintf('%02d',i),'=''blue'';']);
        end
        namet=eval(['outstruct.stqbox',sprintf('%02d',i)]);
        namett=sprintf('<font color="blue" size="2" face="Arial"><b>%6s</b></font>',namet);
        y{i,9}=sprintf(['<a href="http://finance.yahoo.com/q/pr?s=',namet,'" target="_blank">',namett,'</a>']);        
      else
        y{i,1}=''; y{i,2}=''; y{i,3}=''; y{i,4}=''; y{i,5}=''; y{i,6}=''; y{i,7}=''; y{i,8}=''; y{i,9}='';
      end     
    end
    
    for i=1:length(ip)
      for j=1:9
        eval(['outstruct.sq',sprintf('%02d%1d',i,j),'=y{',num2str(i),',',num2str(j),'};']);
      end
    end
    
    cd(fpwserverplace);
    cids=fpwloginstatus(fpwusername,clock);
    
    outstruct.Freshtarget=strrep([fpwclientdirectory,fpwusername,'\stock\twbfpwstquote.html'],'\','/');
    
    templatefile = which('wbfpwstquote.html');
    str = htmlrep(outstruct, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\twbfpwstquote.html'],'noheader');
    if refreshtimetotal>1
      pause(4.8);
      if refreshtimes>=refreshtimetotal-1
        outstruct.refreshtime='18000'; % meaningless to change the time interval
        %Cause no more data update, so stop to refresh for every 5 seconds!
      end
    end
    
    % in case user enter new symbol during run
    if refreshtimes<refreshtimetotal
      cd([Wherematlab,'stock']);
      eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbstqlist']); %load data from disk wbstqlist{i}
      for i=1:12
        eval(['outstruct.stqbox',sprintf('%02d',i),'=upper(wbstqlist{i});']);
        if length(noempty(wbstqlist{i}))>0
          ip(i)=checknow(namelist,upper(wbstqlist{i}),'$');
        else
          ip(i)=0;      
        end
      end
    end
    
    refreshtimes=refreshtimes+1;
  end
  outstruct.TheOutputTimeIs=time2;
  
  if (nargin == 1)
    retstr = htmlrep(outstruct, templatefile);
    str = htmlrep(outstruct, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\twbfpwstquote.html'],'noheader');
  elseif (nargin == 2)
    retstr = htmlrep(outstruct, templatefile, outfile);
  end
end