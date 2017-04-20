function retstr = wbstockqd(instruct, outfile)

% Author(s): N. Zhu, 11-15-2003
% This is a WB (Web-Based) mirror program to <stockqd.m> in desktop version

wbfpwbasic;
cd(fpwserverplace);
retstr = char('');
fpwusername=instruct.mlid{1};
fpwCPAL=0;
fpwloginIP='192.168.2.8';
fpwcheckil;

if fpwcheckilpass==1

if isfield(instruct,'WhereOrderFrom')
  if strcmp(instruct.WhereOrderFrom,'STQD')
    instruct.mlmfvar=['S' upper(noempty(instruct.QCbx72))];
    instruct.fpwcurrentm=instruct.mlmfvar; 
    instruct.WhereOrderFrom='LINK';
  end
end
    
if ~strcmp(instruct.mlmfvar,'leavemealone')
  WhereOrderFrom='LINK';
else    
  WhereOrderFrom=instruct.WhereOrderFrom;
end

if strcmp(WhereOrderFrom,'MPLG')
  eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbdzhinput instruct']); 
end

cd([Wherematlab,'stock']);

if strcmp(WhereOrderFrom,'MPLG')
  namez=noempty(instruct.zsobx72);
elseif strcmp(WhereOrderFrom,'LINK')    
  namez=noempty(instruct.mlmfvar);
  namez=namez(2:length(namez));
end    

if (length(namez)==0)|(length(namez)>6)
  error('Entered wrong symbol.');
end

namez=lower(namez);
names=namez;
[stockday,market,sub,name]=stgetdat(names);
testdata=stgetdaa(names,'t',1);

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

if (length(stockday)>0)|(length(testdata)>0)
  stocktick=stgetdaa(names,'t',195);
  load nlt namelist
  stocknameph=checknow(namelist,names,'$'); 
  if stocknameph>0
    %!copy x:\stock\fpwnltlast.mat c:\matlab\stock
    %load x:\stock\fpwnltlast timevaluea fpwnltlast
    load fpwnltlast timevaluea fpwnltlast
    stocktick=[stocktick;[timevaluea fpwnltlast(stocknameph(1),7:11)]];
    if tradinghours==1
      stockday=[stockday;[timevaluea(1:3) fpwnltlast(stocknameph(1),1:5)]]; %plus today's data
    end
  end
  
  if length(stocktick(:,1))<196
    addtickbarsnums=196-length(stocktick(:,1));
    addtickbars=[];
    for i=1:addtickbarsnums
       addtickbars=[addtickbars;[stocktick(1,1:5) [1 1 1 1]*stocktick(1,6) 0]];  
    end
    stocktick=[addtickbars;stocktick];
  end  
  
  if length(stockday(:,1))<128
    adddaybarsnums=128-length(stockday(:,1));
    adddaybars=[];
    for i=1:adddaybarsnums
       adddaybars=[adddaybars;[stockday(1,1:3) [1 1 1 1]*stockday(1,4) 0]];  
    end
    stockday=[adddaybars;stockday];
  end
  
  if strcmp(WhereOrderFrom,'MPLG')
    fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
    fseek(fid1,-50,1); fprintf(fid1,[time,' MPGP: ',upper(namez),'\n']); fclose(fid1);
    clear fid1  
  elseif strcmp(WhereOrderFrom,'LINK') 
    fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
    fseek(fid1,-50,1); fprintf(fid1,[time,' LNKP: ',upper(namez),'\n']); fclose(fid1);
    clear fid1  
  end
  
  % intraday chart
  datem=stocktick(:,1:5);
  stock=stocktick(:,6:10);
  Fig3=figure('visible','off','posi',[2 3 600 180],'inverthardcopy','off');
  zhu27r=axes('position',[0.091 0.11 .89 .81]); 
  yrs=length(stock(:,1))-1;
  x=[1:yrs];
  closeh=stock(:,4);high=stock(:,2);low=stock(:,3);
  open=stock(:,1);vol=stock(:,5)+.0001;
  X1=1:yrs;
  X2=X1-.35;
  X3=X1+.35;
  X(1:yrs,1:2)=[X1' X1'];
  X4(1:yrs,1:2)=[X2' X1'];
  X5(1:yrs,1:2)=[X1' X3'];
  line(1:yrs,1:2)=[low(2:yrs+1) high(2:yrs+1)];
  line1(1:yrs,1:2)=[closeh(2:yrs+1) closeh(2:yrs+1)];
  line2(1:yrs,1:2)=[open(2:yrs+1) open(2:yrs+1)];
  plot(x(1),closeh(2),'g');hold on;
  intradayc='g';daychangep=1;
  for I=1:yrs
    if datem(I+1,2)~=datem(I,2); daychangep=I; end
    if datem(I+1,4)~=datem(I,4)
      intradayc='w';        
    else
      intradayc='g';        
    end
    plot(X(I,:),line(I,:),intradayc);
    plot(X4(I,:),line2(I,:),intradayc)
    plot(X5(I,:),line1(I,:),intradayc)    
  end
  plot([1 yrs],[line1(daychangep-1,1) line1(daychangep-1,1)],'--r');grid;
  set(gca,'Xcolor',[0.5 0.5 0.5]);
  set(gca,'Ycolor',[0.5 0.5 0.5]); 
  price=num2str(closeh(length(closeh)));
  net=num2str(stocktick(length(stocktick(:,1)),9)-stockday(length(stockday(:,1))-1,7));
  %xlabel([' Last: ',price,',  Net of Today: ',net]);
  ylabel('Price');
  title(['Today''s Last: ',price,',  Net of Today: ',net]);
  set(get(gca,'title'),'color',[0.65 0.65 0.65]);
  set(get(gca,'xlabel'),'fontsize',11);set(get(gca,'ylabel'),'fontsize',11);
  chgst93(datem(2:length(datem(:,1)),:),1); hold off
  ftzn=figtext(0.02,0.03,['Copyright ',datestr(now,10),' WSQSI, http://www.WSQSI.com/']);
  set(ftzn,'color',[0.5 0.5 0.5],'fontsize',7);
  pos=get(gcf,'position');
  pos(3)=600; pos(4)=180;
  set(gcf,'Position',pos,'PaperPosition',[.25 .25 8.05 3.2]);
  cd([fpwserverplace,fpwclientdirectory,fpwusername,'\stock']);
  Plotfileh=[fpwclientdirectory,fpwusername,'\stock\wbstockqd3.jpeg'];
  drawnow;
  wsprintjpeg(Fig3,'wbstockqd3.jpeg');
  close(Fig3);
  %s.GraphFileName3=Plotfileh;
  clear Fig3 X1 X2 X3 X4 X5 X open high low closeh vol yrs x datem stock
    
  sq195RawData='';
  for i=194:-1:0
    t195=length(stocktick(:,1))-i;
    sq195RawData=[sq195RawData,date2str(stocktick(t195,1:5),1),'-',sprintf('%8.2f',stocktick(t195,6)),'-',sprintf('%8.2f',stocktick(t195,7)),'-',sprintf('%8.2f',stocktick(t195,8)),'-',sprintf('%8.2f',stocktick(t195,9)),'-',sprintf('%6.0f',stocktick(t195,10)),'K|'];    
    if i==0
      sq195last=['   Time:  ',date2str(stocktick(t195,1:5),1),'   Open:',sprintf('%8.2f',stocktick(t195,6)),'   High:',sprintf('%8.2f',stocktick(t195,7)),'   Low:',sprintf('%8.2f',stocktick(t195,8)),'   Last:',sprintf('%8.2f',stocktick(t195,9)),'   Volume: ',sprintf('%6.0f',stocktick(t195,10)),'K'];  
    end
  end
  sq195.sq195RawData=sq195RawData;
  sq195.sq195GraphFileName=Plotfileh;
  sq195.sq195last=sq195last;
  cd(fpwserverplace);
  templatefile = which('wbfpwchart195.html');  
  str = htmlrep(sq195, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\twbfpwchart195.html'],'noheader');
  s.sq195Page=[fpwclientdirectory,fpwusername,'\stock\twbfpwchart195.html'];
  cd([Wherematlab,'stock']);
  
  % last half year chart
  Fig2=figure('visible','off','posi',[2 3 600 300],'inverthardcopy','off');
  zhu27r=axes('position',[0.091 0.11 .89 .81]); 
  
  if (strcmp(upper(fpwusername),'NINGZHU'))
    %MA20line1=ma(stockday(:,7),20);
    %MA60line1=ma(stockday(:,7),60);
    %MA200line1=ma(stockday(:,7),200);
    MA20line=ma(msum(stockday(:,7).*stockday(:,8),20)./msum(stockday(:,8),20),1);
    MA60line=ma(msum(stockday(:,7).*stockday(:,8),50)./msum(stockday(:,8),50),1);
    MA200line=ma(msum(stockday(:,7).*stockday(:,8),200)./msum(stockday(:,8),200),1);
    MA200MAi=ma(stockday(:,7),200,0);
    %MA20line=(MA20line1+MA20line2)/2;
    %MA60line=(MA60line1+MA60line2)/2;
    %MA200line=(MA200line1+MA200line2)/2;
    MA20line=MA20line(max([1 length(MA20line)-126]):length(MA20line));
    MA60line=MA60line(max([1 length(MA60line)-126]):length(MA60line));
    MA200line=MA200line(max([1 length(MA200line)-126]):length(MA200line));
  end 
  
  datem=stockday(max([1 length(stockday)-127]):length(stockday),1:3);
  stock=stockday(max([1 length(stockday)-127]):length(stockday),4:8);
  yrs=length(stock(:,1))-1;
  x=[1:yrs];
  closeh=stock(:,4);high=stock(:,2);low=stock(:,3);
  open=stock(:,1);vol=stock(:,5)*100+.0001;
  X1=1:yrs;
  X2=X1-.35;
  X3=X1+.35;
  X(1:yrs,1:2)=[X1' X1'];
  X4(1:yrs,1:2)=[X2' X1'];
  X5(1:yrs,1:2)=[X1' X3'];
  line(1:yrs,1:2)=[low(2:yrs+1) high(2:yrs+1)];
  line1(1:yrs,1:2)=[closeh(2:yrs+1) closeh(2:yrs+1)];
  line2(1:yrs,1:2)=[open(2:yrs+1) open(2:yrs+1)];
  plot(x(1),closeh(2),'g');hold on;
  for I=1:yrs
    if dn(datem(I+1,:))~=5
      plot(X(I,:),line(I,:),'-g');
      plot(X4(I,:),line2(I,:),'-g');
      plot(X5(I,:),line1(I,:),'-g');
    else
      plot(X(I,:),line(I,:),'-w');
      plot(X4(I,:),line2(I,:),'-w');
      plot(X5(I,:),line1(I,:),'-w');      
    end
  end
  if (strcmp(upper(fpwusername),'NINGZHU'))
    if MA20line(length(MA20line))-MA20line(length(MA20line)-1)>0
      plot(MA20line,'-y');
    else
      plot(MA20line,'-c');
    end
    plot(length(MA20line)-19,MA20line(length(MA20line)-19),'w.','linewidth',15);
    
    if MA60line(length(MA60line))-MA60line(length(MA60line)-1)>0
      plot(MA60line,'-w');
    else
      plot(MA60line,'-m');
    end
    plot(length(MA60line)-49,MA60line(length(MA60line)-49),'w.','linewidth',15);
    
    if MA200line(length(MA200line))-MA200line(length(MA200line)-1)>0
      plot(MA200line,'-g');
    else
      plot(MA200line,'-r');
    end
  end   
  grid;
  set(gca,'Xcolor',[0.5 0.5 0.5]);
  set(gca,'Ycolor',[0.5 0.5 0.5]); 
  price=num2str(closeh(length(closeh)));
  net=num2str(closeh(length(closeh))-closeh(length(closeh)-1));
  %xlabel([' Last: ',price,',  Net of today: ',net]);
  ylabel('Price');
  set(get(gca,'xlabel'),'fontsize',11);set(get(gca,'ylabel'),'fontsize',11);
  stock1=stockday(:,4:8);
  nowstock=stock1(max([1 length(stock1(:,1))-30]):length(stock1(:,1)),:);
  balance=num2str(fix(sum(sign(mtm(nowstock(:,4),1)).*nowstock(:,5))/mean(nowstock(:,5))*100)/100);
  if ~(strcmp(upper(fpwusername),'NINGZHU'))
    title([fpwname(namez),', 6 wk vol-bias: ',balance]);
  else
    title([fpwname(namez),', 6 wk vol-bias: ',balance,', SW200: ',noempty(sprintf('%20.2f',MA200MAi)),' / ',noempty(sprintf('%20.2f',MA200line(length(MA200line))))]);
  end
  set(get(gca,'title'),'color',[0.65 0.65 0.65]);
  clear nowstock balance stockl
  chgst93(datem(2:length(datem(:,1)),:)); hold off
  ftzn=figtext(0.89,0.942,date2str(timevaluea));
  set(ftzn,'color',[0.65 0.65 0.65],'fontsize',8);
  ftzn=figtext(0.02,0.03,['Copyright ',datestr(now,10),' WSQSI, http://www.WSQSI.com/']);
  set(ftzn,'color',[0.5 0.5 0.5],'fontsize',7);
  pos=get(gcf,'position');
  pos(3)=600; pos(4)=300;
  set(gcf,'Position',pos,'PaperPosition',[.25 .25 8.05 3.2]);
  cd([fpwserverplace,fpwclientdirectory,fpwusername,'\stock']);
  Plotfileh=[fpwclientdirectory,fpwusername,'\stock\wbstockqd2.jpeg'];
  drawnow;
  wsprintjpeg(Fig2,'wbstockqd2.jpeg');
  close(Fig2);
  %s.GraphFileName2=Plotfileh;
  clear Fig2 X1 X2 X3 X4 X5 X open high low closeh vol yrs x datem stock
    
  sq127RawData='';
  for i=126:-1:0
    t127=length(stockday(:,1))-i;
    sq127RawData=[sq127RawData,date2str(stockday(t127,1:3)),'-',sprintf('%8.2f',stockday(t127,4)),'-',sprintf('%8.2f',stockday(t127,5)),'-',sprintf('%8.2f',stockday(t127,6)),'-',sprintf('%8.2f',stockday(t127,7)),'-',sprintf('%8.0f',stockday(t127,8)*100),'K|'];    
    if i==0
      sq127last=['   Date:  ',date2str(stockday(t127,1:3)),'   Open:',sprintf('%8.2f',stockday(t127,4)),'   High:',sprintf('%8.2f',stockday(t127,5)),'   Low:',sprintf('%8.2f',stockday(t127,6)),'   Last:',sprintf('%8.2f',stockday(t127,7)),'   Volume:',sprintf('%8.0f',stockday(t127,8)*100),'K'];  
    end
  end
  sq127.sq127RawData=sq127RawData;
  sq127.sq127GraphFileName=Plotfileh;
  sq127.sq127last=sq127last;
  cd(fpwserverplace);
  templatefile = which('wbfpwchart127.html');  
  str = htmlrep(sq127, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\twbfpwchart127.html'],'noheader');
  s.sq127Page=[fpwclientdirectory,fpwusername,'\stock\twbfpwchart127.html'];
  cd([Wherematlab,'stock']);
  
  %Database historical chart
  Fig1=figure('visible','off','posi',[2 3 600 180],'inverthardcopy','off');
  zhu27r=axes('position',[0.091 0.11 .89 .81]);  
  datem=stockday(:,1:3);
  stock=stockday(:,4:8);
  closeh=stock(:,4);
  plot(closeh,'g');
  grid; set(gca,'Xcolor',[0.5 0.5 0.5]);
  set(gca,'Ycolor',[0.5 0.5 0.5]); 
  price=num2str(closeh(length(closeh)-1));
  net=num2str(closeh(length(closeh)-1)-closeh(length(closeh)-2));
  title([' Last Trading Day Close: ',price,', Last Trading Day Net: ',net]);
  set(get(gca,'title'),'color',[0.65 0.65 0.65]);
  ylabel('Price');
  set(get(gca,'xlabel'),'fontsize',11);set(get(gca,'ylabel'),'fontsize',11);
  chgst93(datem);
  ftzn=figtext(0.02,0.03,['Copyright ',datestr(now,10),' WSQSI, http://www.WSQSI.com/']);
  set(ftzn,'color',[0.5 0.5 0.5],'fontsize',7);
  pos=get(gcf,'position');
  pos(3)=600; pos(4)=180;
  set(gcf,'Position',pos,'PaperPosition',[.25 .25 8.05 3.2]);
  cd([fpwserverplace,fpwclientdirectory,fpwusername,'\stock']);
  Plotfileh=[fpwclientdirectory,fpwusername,'\stock\wbstockqd1.jpeg'];
  drawnow;
  wsprintjpeg(Fig1,'wbstockqd1.jpeg');
  close(Fig1);
  s.GraphFileName1=Plotfileh;
else
  error('No data available for this stock, please check the symbol.');
end  
s.FDQCbx72=upper(name);

cd(fpwserverplace);
cids=fpwloginstatus(fpwusername,clock);
templatefile = which('wbstockqd.html');
s.fpwcurrentm=['S',name];
s.fpwusername=fpwusername;
s.fpwusername4=fpwusername4;
s.fpwulvl=instruct.fpwulvl;
if (nargin == 1)
  retstr = htmlrep(s, templatefile);
elseif (nargin == 2)
  retstr = htmlrep(s, templatefile, outfile);
end
end