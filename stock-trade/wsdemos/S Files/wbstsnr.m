function retstr = wbstsnr(instruct, outfile)

% Author(s): N. Zhu, 11-15-2003
% This is a WB (Web-Based) mirror program to <stsnr.m> in desktop version

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
  global mname; 
  mname='S';
  dayl=500;
  fpwsnrsf=5;
  fpwsnrtd='D';
elseif strcmp(WhereOrderFrom,'SLFE')
  name=noempty(instruct.fpwsymbol);
  global mname; 
  mname=instruct.fpwfstype;    
  dayl=str2num(instruct.fpwsnrp);  
  fpwsnrsf=fix(str2num(instruct.fpwsnrsf));
  fpwsnrtd=instruct.hdfpwsnrtd;
elseif strcmp(WhereOrderFrom,'LINK')  
  name=noempty(instruct.mlmfvar);
  global mname;
  mname=upper(name(1));
  name=name(2:length(name));    
  dayl=500;
  fpwsnrsf=5;
  fpwsnrtd='D';        
end
if (length(name)==0)|(length(name)>6)
  error('Entered wrong symbol.');
end

name=lower(name);
if fpwsnrtd=='D'
  [stock datem]=fsdaydat([mname,name]);
  if strcmp(upper(mname),'S')==1
    testdata=stgetdaa(name,'t',1);
  end
  if ((length(stock)>0)|(length(testdata)>0))&(strcmp(upper(mname),'S')==1)
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
        stock=[stock;fpwnltlast(stocknameph(1),1:5)];
      end
    end
  end  
else
  if mname=='F'
    [stock datem]=fsdaydat([mname,name]);
    loope=datem(max([1 length(datem(:,1))-40]),:);
    if wsfsn24(['f',name])==0
      stock=wsgettdn(loope,4,3500,[mname,name],0)
    else
      stock=wsgettdn(loope,0,3500,[mname,name],0)      
    end
    %datem=stock(:,[4 5 2]);
    datem=stock(:,1:5);    
    stock=stock(:,6:10);    
  else
    stock=stgetdaa(name,'t',dayl);
    %datem=stock(:,[4 5 2]);
    datem=stock(:,1:5);    
    stock=stock(:,6:10);
  end  
end

if length(stock)==0
  error('No data available for this stock, please check the symbol.');
else
  stock=stock(max([1 length(stock(:,1))-dayl+1]):length(stock(:,1)),:);
  datem=datem(max([1 length(datem(:,1))-dayl+1]):length(datem(:,1)),:);
end

if strcmp(WhereOrderFrom,'MPLG')
  fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
  fseek(fid1,-50,1); fprintf(fid1,[time,' MPGN: ',upper(mname),num2str(dayl),'-',upper(name),'\n']); fclose(fid1);
  clear fid1
elseif strcmp(WhereOrderFrom,'SLFE')
  fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
  fseek(fid1,-50,1); fprintf(fid1,[time,' SLFN: ',upper(mname),'-',upper(name),'\n']); fclose(fid1);
  clear fid1
elseif strcmp(WhereOrderFrom,'LINK')
  fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
  fseek(fid1,-50,1); fprintf(fid1,[time,' LNKN: ',upper(mname),'-',upper(name),'\n']); fclose(fid1);
  clear fid1   
end

if length(stock(:,1))<=fix(dayl/3)
  error(['There is not enough data for this symbol as you wanted, only ',num2str(length(stock(:,1))),' bars available.']);
else
  wssignal=abs(mtm((stock(:,4))',1));
  wsnoise=0*wssignal;
  wsnoise(1)=(stock(1,2)-stock(1,3))/2;
  for i=2:length(stock(:,1))
    if stock(i,4)>=stock(i,1)
      wsnoise(i)=((stock(i,2)-stock(i,4))+(stock(i,1)-stock(i,3)))/2;
    else
      wsnoise(i)=((stock(i,2)-stock(i,1))+(stock(i,4)-stock(i,3)))/2;
    end
  end
  wsnoise=abs(wsnoise);

  aa=mean(wssignal);
  index1=find(wssignal>5*aa);
  if length(index1)>0
    wssignal(index1)=5*aa*ones(1,length(index1));
  end
  bb=mean(wsnoise);
  index2=find(wsnoise>5*bb);
  if length(index2)>0
    wsnoise(index2)=5*bb*ones(1,length(index2));
  end

  aa=ma(wssignal,50);
  index1=find((wssignal-3.5*aa)>0);
  if length(index1)>0
    wssignal(index1)=aa(index1);
  end
  bb=ma(wsnoise,fpwsnrsf);
  index2=find((wsnoise-3.5*bb)>0);
  if length(index2)>0
    wsnoise(index2)=bb(index2);  
  end

  aa=ma(wssignal,fpwsnrsf);
  index1=find((wssignal-3.5*aa)>0);
  if length(index1)>0
    wssignal(index1)=aa(index1);
  end
  bb=ma(wsnoise,fpwsnrsf);
  index2=find((wsnoise-3.5*bb)>0);
  if length(index2)>0
    wsnoise(index2)=bb(index2);
  end
  
  Fig1=figure('visible','off','position',[2 5 635 433],'inverthardcopy','off','color','k'); hold off 
  subplot(211);
  plot(wssignal,'-g');
  if fpwsnrtd=='D'
    chgst93(datem);
  else
    chgst93(datem,1);
  end
  grid; set(gca,'Xcolor',[0.5 0.5 0.5]);
  set(gca,'Ycolor',[0.5 0.5 0.5]);  
  hold on
  ddd=plot(aa,'-r');
  set(ddd,'linewidth',2.5);
  hold off
  title([upper(mname),num2str(fpwsnrsf),'-',upper(name),': Average Signal Level : ',num2str(aa(length(aa))),',  Latest SNR = ',num2str(aa(length(aa))/bb(length(bb)))]);
  ylabel('Daily Signal');
  set(gca,'color',get(gcf,'color'));
  set(get(gca,'title'),'color',[0.65 0.65 0.65],'fontsize',8);
  %set(get(gca,'xlabel'),'color','w');
  %grid; set(gca,'Xcolor',[0.5 0.5 0.5]);
  set(gca,'Ycolor',[0.5 0.5 0.5]);  
  
  subplot(212)
  plot(wsnoise,'-r');
  if fpwsnrtd=='D'
    chgst93(datem);
  else
    chgst93(datem,1);
  end
  grid; set(gca,'Xcolor',[0.5 0.5 0.5]);
  set(gca,'Ycolor',[0.5 0.5 0.5]);  
  hold on
  ddd=plot(bb,'-g');
  set(ddd,'linewidth',2.5);
  hold off
  %title(['Average Noise Level : ',int2str(mean(wsnoise))]);
  ylabel('Daily Noise');
  %xlabel('Whenever SNR > 2 with strong average signal level, it is good time to start short term trade.');
  set(gca,'color',get(gcf,'color'));
  %set(get(gca,'title'),'color','w');
  set(gca,'Xcolor',[0.5 0.5 0.5]);
  set(gca,'Ycolor',[0.5 0.5 0.5]);   
  ftzn=figtext(0.98,0.02,['Copyright ',datestr(now,10),' WSQSI, http://www.WSQSI.com/']);
  set(ftzn,'color',[0.5 0.5 0.5],'fontsize',7,'rotation',90); 
  set(Fig1,'PaperPosition',[.25 .25 7 2.75]);
  cd([fpwserverplace,fpwclientdirectory,fpwusername,'\stock']);
  Plotfileh=[fpwclientdirectory,fpwusername,'\stock\wbstsnr1.jpeg'];
  drawnow;
  wsprintjpeg(Fig1,'wbstsnr1.jpeg');
  close(Fig1);
  s.SNRjpeg1=Plotfileh; 
  cd([Wherematlab,'stock']);

  Fig2=figure('visible','off','position',[2 5 635 433],'inverthardcopy','off','color','k'); hold off   
  snrdaily=wssignal./wsnoise;
  index2=find(snrdaily>5);
  if length(index2)>0
    snrdaily(index2)=5*ones(1,length(index2));
  end
  snrdailys=aa./bb;
  index2=find(snrdailys>5);
  if length(index2)>0 
    snrdailys(index2)=5*ones(1,length(index2));
  end

  plot(snrdailys,'-g');grid; hold on;
  %plot(snrdaily,'-r');hold off;
  %title('SNR history');
  ylabel('SNR'); 
  if fpwsnrtd=='D'
    chgst93(datem);
  else
    chgst93(datem,1);
  end
  set(gca,'Xcolor',[0.5 0.5 0.5]);
  set(gca,'Ycolor',[0.5 0.5 0.5]);  
  set(gca,'color',get(gcf,'color'));
  %set(get(gca,'title'),'color','w');
  %set(get(gca,'xlabel'),'color','w');
  %set(get(gca,'ylabel'),'color','w');
  ftzn=figtext(0.98,0.02,'http://www.WSQSI.com/');
  set(ftzn,'color',[0.5 0.5 0.5],'fontsize',7,'rotation',90);   
  set(Fig2,'PaperPosition',[.25 .25 7 2]);
  cd([fpwserverplace,fpwclientdirectory,fpwusername,'\stock']);
  Plotfileh=[fpwclientdirectory,fpwusername,'\stock\wbstsnr2.jpeg'];
  drawnow;
  wsprintjpeg(Fig2,'wbstsnr2.jpeg');
  close(Fig2);
  s.SNRjpeg2=Plotfileh; 
  cd([Wherematlab,'stock']);  
  
  Fig3=figure('visible','off','position',[2 5 635 433],'inverthardcopy','off','color','k'); hold off  
  subplot(121);
  histp(wssignal,50,1,'g')
  set(gca,'Xcolor',[0.5 0.5 0.5]);
  set(gca,'Ycolor',[0.5 0.5 0.5]);  
  hold on
  ddd=plot(ones(1,2)*mean(wssignal),[1 max(get(gca,'Ytick'))-3],'-r');
  set(ddd,'linewidth',2.5);
  hold off
  ylabel('Signal Numbers');
  title(['Signale distribution: ',num2str(mean(wssignal))]);
  set(gca,'color',get(gcf,'color'));
  set(get(gca,'title'),'color',[0.65 0.65 0.65],'fontsize',8);
  grid; set(gca,'Xcolor',[0.5 0.5 0.5]);
  set(gca,'Ycolor',[0.5 0.5 0.5]);  
  
  subplot(122)
  histp(wsnoise,50,1,'r')
  set(gca,'Xcolor',[0.5 0.5 0.5]);
  set(gca,'Ycolor',[0.5 0.5 0.5]);  
  hold on
  ddd=plot(ones(1,2)*mean(wsnoise),[1 max(get(gca,'Ytick'))-3],'-g');
  set(ddd,'linewidth',2.5);
  hold off
  ylabel('Noise Numbers');
  title(['Noise distribution: ',num2str(mean(wsnoise))]);
  set(gca,'color',get(gcf,'color'));
  set(get(gca,'title'),'color',[0.65 0.65 0.65],'fontsize',8);
  grid; set(gca,'Xcolor',[0.5 0.5 0.5]);
  set(gca,'Ycolor',[0.5 0.5 0.5]);  
  ftzn=figtext(0.98,0.02,['Copyright ',datestr(now,10),' WSQSI, http://www.WSQSI.com/']);
  set(ftzn,'color',[0.5 0.5 0.5],'fontsize',7,'rotation',90); 
  set(Fig3,'PaperPosition',[.25 .25 7 2.75]);
  cd([fpwserverplace,fpwclientdirectory,fpwusername,'\stock']);
  Plotfileh=[fpwclientdirectory,fpwusername,'\stock\wbstsnr3.jpeg'];
  drawnow;
  wsprintjpeg(Fig3,'wbstsnr3.jpeg');
  close(Fig3);
  s.SNRjpeg3=Plotfileh;  
end
  s.fpwusername=fpwusername;
  s.fpwusername4=fpwusername4;
  s.FSfpwfstype=mname;
  s.FSfpwsnrp=num2str(dayl);
  s.FSfpwsymbol=name;
  s.FSfpwsnrsf=fpwsnrsf;
  s.FSfpwsnrtd=fpwsnrtd;  
  eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\fpwstsnr s']);
else
  if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\stock\fpwstsnr.mat'])==2
     eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\fpwstsnr']);
  else
    s.fpwusername=fpwusername;
    s.fpwusername4=fpwusername4;
    s.FSfpwfstype='S';
    s.FSfpwsnrp='500';
    s.FSfpwsymbol='UrSymbol';    
    s.FSfpwsnrsf=5;
    s.FSfpwsnrtd='D';  
    s.SNRjpeg1=[fpwclientdirectory,fpwusername,'\stock\wbstsnr1.jpeg'];
    s.SNRjpeg2=[fpwclientdirectory,fpwusername,'\stock\wbstsnr2.jpeg'];
    s.SNRjpeg3=[fpwclientdirectory,fpwusername,'\stock\wbstsnr3.jpeg'];  
  end
end 
s.fpwusername=fpwusername;
s.fpwusername4=fpwusername4;
    
cd(fpwserverplace);
cids=fpwloginstatus(fpwusername,clock);
if ~(strcmp(upper(fpwusername(1:4)),'USER'))
  templatefile = which('wbstsnr.html');
else
  templatefile = which('wbstsnr_nlink.html');
end
s.fpwcurrentm=[s.FSfpwfstype,s.FSfpwsymbol];
s.fpwulvl=instruct.fpwulvl;
s.FDTimeh=time;

if (nargin == 1)
  retstr = htmlrep(s, templatefile);
elseif (nargin == 2)
  retstr = htmlrep(s, templatefile, outfile);
end 
end