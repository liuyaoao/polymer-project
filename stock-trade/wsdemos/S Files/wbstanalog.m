function retstr = wbstanalog(instruct, outfile)

% Author(s): N. Zhu, 11-15-2003
% This is a WB (Web-Based) mirror program to <stanalog.m> in desktop version

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
      nameHHH=noempty(instruct.mlmfvar);
      mnamehere=upper(nameHHH(1)); 
      clear nameHHH
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
  WhereOrderFrom='LINK';
else    
  WhereOrderFrom=instruct.WhereOrderFrom;
end
  
if strcmp(WhereOrderFrom,'MPLG')
  eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbdzhinput instruct']); 
end

cd([Wherematlab,'stock']);

if ~(strcmp(WhereOrderFrom,'INDX'))

if strcmp(WhereOrderFrom,'MPLG')
  name=noempty(instruct.zsobx72);
  global mname
  mname='S';
  dayl=63;  
  fpwanalogtd='D';
elseif strcmp(WhereOrderFrom,'SLFE')
  name=noempty(instruct.fpwsymbol);
  global mname
  mname=instruct.fpwfstype;    
  dayl=str2num(instruct.fpwanalogp);
  fpwanalogtd=instruct.hdfpwanalogtd;
elseif strcmp(WhereOrderFrom,'LINK')  
  name=noempty(instruct.mlmfvar);
  global mname
  mname=upper(name(1));
  name=name(2:length(name));    
  dayl=63;  
  fpwanalogtd='D';    
end
if (length(name)==0)|(length(name)>6)
  error('Entered wrong symbol.');
end

name=lower(name);  
if fpwanalogtd=='D'
  [stock1 datem]=fsdaydat([mname,name]);
  if strcmp(upper(mname),'S')==1
    testdata=stgetdaa(name,'t',1);
  end
  if ((length(stock1)>0)|(length(testdata)>0))&(strcmp(upper(mname),'S')==1)
    tradinghours=0;
    timevalue=clock;
    markethourst;
    timecal=timevalue(4)+timevalue(5)/60;
    datetoday=[timevalue(2:3) timevalue(1)-2000];
    if (timecal>openhourt+1/12)&(timecal<closehourt+1/12)&(dn(datetoday)<=5)
      if closehourt>openhourt
        tradinghours=1;
      end
    end
    if tradinghours==1    
      load nlt namelist
      stocknameph=checknow(namelist,name,'$'); 
      if stocknameph>0
        %!copy x:\stock\fpwnltlast.mat c:\matlab\stock
        load fpwnltlast timevaluea fpwnltlast
        datem=[datem;timevaluea(1:3)];
        stock1=[stock1;fpwnltlast(stocknameph(1),1:5)];
      end
    end
  end  
else
  if mname=='F'
    [stock1 datem]=fsdaydat([mname,name]);
    loope=datem(max([1 length(datem(:,1))-22]),:);
    if wsfsn24([mname,name])==0
      stock1=wsgettdn(loope,2,2500,[mname,name],0);
    else
      stock1=wsgettdn(loope,0,2500,[mname,name],0);
    end
    %datem2=stock1(:,[4 5 2]);
    datem2=stock1(:,1:5);
    datem=stock1(:,1:3);
    stock1=stock1(:,6:10);
  else
    stock1=stgetdaa(name,'t',max([300 fix(2.4*dayl)]));
    %datem2=stock1(:,[4 5 2]);
    datem2=stock1(:,1:5);
    datem=stock1(:,1:3);
    stock1=stock1(:,6:10);
  end
end

if length(stock1)==0
  error('No data available for this stock, please check the symbol.');
end

if strcmp(WhereOrderFrom,'MPLG')
  fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
  fseek(fid1,-50,1); fprintf(fid1,[time,' MPGA: ',upper(mname),num2str(dayl),'-',upper(name),'\n']); fclose(fid1);
  clear fid1
elseif strcmp(WhereOrderFrom,'SLFE')
  fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
  fseek(fid1,-50,1); fprintf(fid1,[time,' SLFA: ',upper(mname),num2str(dayl),'-',upper(name),'\n']); fclose(fid1);
  clear fid1
elseif strcmp(WhereOrderFrom,'LINK')
  fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
  fseek(fid1,-50,1); fprintf(fid1,[time,' LNKA: ',upper(mname),'-',upper(name),'\n']); fclose(fid1);
  clear fid1 
end

bardayltd=140;

if length(stock1(:,1))<=min([300 2*dayl])
  error('There is not enough data history for this stock in our database. Sorry.');
else
  stock=stock1(:,4);
  dayp=max([10 fix(.3*dayl)]);
  dayl=max([dayl 10]);
  dayp=min([max([dayp 4]) fix(.3*dayl)+1]);

  if length(stock)<4*dayl
    dayl=22;
    dayp=7;
  end  

  Fig1=figure('visible','off','position',[2 5 635 433],'inverthardcopy','off','color','k'); hold off
  
  X=length(stock)-dayl+1:length(stock);
  x=stock(X);
  xmaxval=1;
  XXXxx=x;
  x=modelnor(1,.01,x);
  avex=mean(x);
  stdx=sqrt(sum((x-avex).*(x-avex)));
  xycor=zeros(1,length(stock)-fix(1.25*dayl)); % 1.5 before
  for loop=1:length(stock)-fix(1.25*dayl) % 1.5 before 1-15-96
    y=stock(loop:loop+dayl-1);
    y=modelnor(1,.01,y);
    avey=mean(y);
    stdy=sqrt(sum((y-avey).*(y-avey))); 
    xycor(loop)=sum((x-avex).*(y-avey))/stdx/stdy;
  end
  [grade place]=max(xycor);
  y=[grade place];
  %datem(place+dayl-1,:)
  x=XXXxx;
  clear XXXxx

  hy=stock(place:place+dayl-1);
  hy1=stock(place+dayl:place+dayl+dayp-1);
  hy2=hy;
  hy=[hy;hy1];
  hx=place:place+dayl+dayp-1; %historical x axis
  hx1=place:place+dayl-1;
  hy1p=hy1/hy(dayl);
  px=length(stock)-dayl+1:length(stock)-dayl+length(hx); %present x axis
  py=xmaxval*[x;x(dayl)*hy1p];
  hy1o=stock1(place+dayl:place+dayl+dayp-1,1)/stock1(place+dayl-1,4);
  hy1h=stock1(place+dayl:place+dayl+dayp-1,2)/stock1(place+dayl-1,4);
  hy1l=stock1(place+dayl:place+dayl+dayp-1,3)/stock1(place+dayl-1,4);
  hy1c=stock1(place+dayl:place+dayl+dayp-1,4)/stock1(place+dayl-1,4);
  hy1v=stock1(place+dayl:place+dayl+dayp-1,5)/stock1(place+dayl-1,4);
  stocke=stock1(length(stock),:);
  stockf1=[stocke(1)*hy1o stocke(2)*hy1h stocke(3)*hy1l stocke(4)*hy1c hy1v];
  stockf1(:,5)=-0*stockf1(:,5)-10;
  % prepare data for wsbarco to use different color
  stockf=[stock1;stockf1];
  if fpwanalogtd=='D'
    datem=[datem;wsfddate(datem(length(datem(:,1)),:),500)];
  else
    djb=(1:500)';
    djb3=[round(10*rem(djb/10,1))  round(10*rem(djb/10,1))  round(10*rem(djb/10,1)) fix(10*rem(djb/1000,1)) fix(10*rem(djb/100,1))];
    datem=[datem2;djb3]; clear djb djb3
  end
  clf

  zhua212=axes('position',[0.08 0.1100 .89 .3375]);
  zhua211=axes('position',[0.08 0.5825 .89 .3375]);

  subplot(zhua211)
  if dayl+dayp<bardayltd
    plot(1,stockf(px(3),4),'.k');hold on
    if fpwanalogtd=='D'
      wsbarcof(stockf(px',:),datem(px',:),0,'g','m','w');
    else
      wsbarcoft(stockf(px',:),datem(px',:),0,'g','m','w');
    end
    datemana1=datem(px',:);  
    datemana1=datemana1(3:length(datemana1(:,1)),:);
    stockana1=stockf(px',:);
    stockana1=stockana1(3:length(stockana1(:,1)),:);
    if fpwanalogtd=='D'
      chgst93(datemana1);
    else
      %datam=datemana1(:,[3 3 3 1 2]);
      chgst93(datemana1,1); 
    end
    analogkind=1;  
  else
    YY=length(px)-dayp:length(px);
    plot(px(YY),py(YY),'-r');
    hold on
    plot(X',x*xmaxval,'-g');
    plot(px(length(X')),py(length(X')),'*w');
    %chgst93(datem)
    if fpwanalogtd=='D'
      chgst93(datem);
    else
      %datam=datem(:,[3 3 3 1 2]);
      chgst93(datem,1); 
    end    
    analogkind=2;
    stockana1=stockf;
    %size(stockf)
    datemana1=datem;
  end
  title(['Present plus forecasting for ',upper(mname),'-',upper(name)]);
  %set(hhhhh,'color',[0.5 0.5 0.5],'fontsize',9);
  set(gca,'color',get(gcf,'color'));
  set(get(gca,'title'),'color',[0.6 0.6 0.6],'fontsize',10);
  grid; set(gca,'Xcolor',[0.5 0.5 0.5]);
  set(gca,'Ycolor',[0.5 0.5 0.5]);
  ylabel('Price');
  hold off

  subplot(zhua212)
  if dayl+dayp<bardayltd
    plot(dayl-2,stock1(place+dayl-1,4),'*w');hold on
    if fpwanalogtd=='D'
      wsbarcof(stockf(hx',:),datem(hx',:),0,'g','g','w');
    else
      wsbarcoft(stockf(hx',:),datem(hx',:),0,'g','g','w'); 
    end
    datemana2=datem(hx',:);
    datemana2=datemana2(3:length(datemana2(:,1)),:);
    stockana2=stockf(hx',:);
    stockana2=stockana2(3:length(stockana2(:,1)),:);
    %chgst93(datemana2);
    if fpwanalogtd=='D'
      chgst93(datemana2);
    else
      %datam=datemana2(:,[3 3 3 1 2]);
      chgst93(datemana2,1); 
    end  
  else
    plot(hx,hy,'-g');hold on
    plot(place+dayl-1,stock(place+dayl-1),'*w');
    if fpwanalogtd=='D'
      chgst93(datem);
    else
      %datam=datem(:,[3 3 3 1 2]);
      chgst93(datem,1); 
    end  
    stockana2=stockf;
    datemana2=datem;
  end
  title(['historical data with maximum correlation period'])
  set(gca,'color',get(gcf,'color'));
  set(get(gca,'title'),'color',[0.6 0.6 0.6],'fontsize',10);
  grid; set(gca,'Xcolor',[0.5 0.5 0.5]);
  set(gca,'Ycolor',[0.5 0.5 0.5]);  
  ylabel('Price');
  xlabel(['correlative strength: ',num2str(grade),', place: ',date2str(datem(place+dayl-1,:))]);
  hold off
  ftzn=figtext(0.02,0.03,['Copyright ',datestr(now,10),' WSQSI, http://www.WSQSI.com/']);
  set(ftzn,'color',[0.5 0.5 0.5],'fontsize',7);
  ftzn=figtext(0.86,0.03,time);
  set(ftzn,'color',[0.65 0.65 0.65],'fontsize',8);
  
  set(Fig1,'PaperPosition',[.25 .25 7 5.5]);
  cd([fpwserverplace,fpwclientdirectory,fpwusername,'\stock']);
  Plotfileh=[fpwclientdirectory,fpwusername,'\stock\wbstanalog.jpeg'];
  drawnow;
  wsprintjpeg(Fig1,'wbstanalog.jpeg');
  close(Fig1);
  s.Analogjpeg=Plotfileh; 
end
  s.fpwusername=fpwusername;
  s.fpwusername4=fpwusername4;
  s.FSfpwfstype=mname;
  s.FSfpwanalogp=num2str(dayl);
  s.FSfpwsymbol=name;
  s.FSfpwanalogtd=fpwanalogtd;
  eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\fpwstanalog s']);
else
  if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\stock\fpwstanalog.mat'])==2
     eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\fpwstanalog']);
  else
    s.fpwusername=fpwusername;
    s.fpwusername4=fpwusername4;
    s.Analogjpeg=[fpwclientdirectory,fpwusername,'\stock\wbstanalog.jpeg'];
    s.FSfpwfstype='S';
    s.FSfpwanalogp='63';
    s.FSfpwsymbol='UrSymbol';
    s.FSfpwanalogtd='D';
  end
end 
s.fpwulvl=instruct.fpwulvl;
s.fpwusername=fpwusername;
s.fpwusername4=fpwusername4;

cd(fpwserverplace);
cids=fpwloginstatus(fpwusername,clock);
if ~(strcmp(upper(fpwusername(1:4)),'USER'))
  templatefile = which('wbstanalog.html');
else
  templatefile = which('wbstanalog_nlink.html');
end
s.fpwcurrentm=[s.FSfpwfstype,s.FSfpwsymbol];
if (nargin == 1)
  retstr = htmlrep(s, templatefile);
elseif (nargin == 2)
  retstr = htmlrep(s, templatefile, outfile);
end    
end