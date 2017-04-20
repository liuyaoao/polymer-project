function retstr = wbstsea(instruct, outfile)

% Author(s): N. Zhu, 11-15-2003
% This is a WB (Web-Based) mirror program to <stsea.m> in desktop version

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

cd([Wherematlab,'pattern']);

if ~(strcmp(WhereOrderFrom,'INDX'))

  if strcmp(WhereOrderFrom,'MPLG')
    name=noempty(instruct.zsobx72);
    global mname; 
    mname='S';
    FirstorS=0;
  elseif strcmp(WhereOrderFrom,'SLFE')
    name=noempty(instruct.fpwsymbol);
    global mname; 
    mname=instruct.fpwfstype;  
    FirstorS=str2num(instruct.FirstorS);
  elseif strcmp(WhereOrderFrom,'LINK')
    name=noempty(instruct.mlmfvar);
    global mname;
    mname=upper(name(1));
    name=name(2:length(name));      
    FirstorS=0;      
  end
    
  if (length(name)==0)|(length(name)>6)
    error('Entered wrong symbol.');
  end
    
  if (FirstorS==0)
    name=lower(name);
    [stock datem]=fsdaydat([mname,name]);
    
    if strcmp(upper(mname),'S')==1
      testdata=stgetdaa(name,'t',1);
    end
    if ((length(stock)>0)|(length(testdata)>0))&(strcmp(upper(mname),'S')==1)
      cd([Wherematlab,'stock']);
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
      cd([Wherematlab,'pattern']);
    end  
    
    if length(stock)==0
      error('No data available for this stock, please check the symbol.');
    end
  
    if strcmp(WhereOrderFrom,'MPLG')
      fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
      fseek(fid1,-50,1); fprintf(fid1,[time,' MPGS: ',upper(mname),'-',upper(name),'\n']); fclose(fid1);
      clear fid1
    elseif strcmp(WhereOrderFrom,'SLFE')
      fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
      fseek(fid1,-50,1); fprintf(fid1,[time,' SLFS: ',upper(mname),'-',upper(name),'\n']); fclose(fid1);
      clear fid1
    elseif strcmp(WhereOrderFrom,'LINK')
      fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
      fseek(fid1,-50,1); fprintf(fid1,[time,' LNKS: ',upper(mname),'-',upper(name),'\n']); fclose(fid1);
      clear fid1       
    end
    
    load datez
    find0p=find(datem(:,3)<50);
    if length(find0p)>0
      datem(find0p,3)=datem(find0p,3)+100;
    end
    datem(:,3)=datem(:,3)+1900;

    yearf=datem(1,3);
    yeare=datem(length(datem(:,1)),3);
    stock=stock(:,4);

    if yeare-yearf<=2
      error('The data history is too short to do season analysis for your chosen symbol.');
    end
    yearr=yearf+1:yeare;
    yeari=[];
    for i=max([yearf+1 yeare-41]):yeare
      indexsea=find(datem(:,3)==i);
      yeari=[yeari;[indexsea(1) indexsea(length(indexsea))]];
    end
    stocksea=zeros(length(datez(:,1))+1,length(yearr));
    stocksea(1,:)=(stock((yeari(:,1)-1)))';
    for j=1:length(yeari(:,1))
      datem1=datem(yeari(j,1):yeari(j,2),:);
      stock1=stock(yeari(j,1):yeari(j,2));
      for i=1:length(datez(:,1))       
        indexsea1=find((datem1(:,1)==datez(i,1))&(datem1(:,2)==datez(i,2)));
        if length(indexsea1)>0
          stocksea(i+1,j)=stock1(indexsea1(1));
        else
          stocksea(i+1,j)=stocksea(i,j);
        end
      end
    end
    indexsea1=find((datez(:,1)==datem1(length(datem1(:,1)),1))&(datez(:,2)==datem1(length(datem1(:,1)),2)));
    stocksea(indexsea1+2:i+1,j)=zeros(length(indexsea1+2:i+1),1)-99*stocksea(1,j);
    yearr=yearr(length(yearr):-1:1);
    stocksea=stocksea(:,length(yearr):-1:1);
    for i=1:length(yearr)
      stocksea(:,i)=100*(stocksea(:,i)-stocksea(1,i))/stocksea(1,i);
    end
    %yearr1=zeros(1,41);yearr1(1:length(yearr))=yearr; yearr=yearr1; clear yearr1
    if length(yearr)>41
      yearr=yearr(1:41);
      stocksea=stocksea(:,1:41);
    end
  
    for i=11:50
      if i<length(yearr)+10  
        stringtofill=sprintf('<input type="checkbox" name="sy%02d" value="%02d" checked><font color="blue" size="2" face="Arial">%4d</font>',i,i,yearr(i-10+1));
      else
        stringtofill=sprintf('<input type="checkbox" name="sy%02d" value="0"><font color="white" size="2" face="Arial">%2s</font>',i,'na');
      end  
      eval(['s.s',num2str(i),'=stringtofill;']); 
    end
    
    eval(['save -v4 ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbwssea datez stocksea yearr']);
  else
    eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbwssea.mat']);      
    yearchosen=1;
    for i=11:50
      if i<length(yearr)+10
        if (isfield(instruct,['sy',sprintf('%2d',i)]))
          yearchosen=[yearchosen i-10+1];
          stringtofill=sprintf('<input type="checkbox" name="sy%02d" value="%02d" checked><font color="blue" size="2" face="Arial">%4d</font>',i,i,yearr(i-10+1));
        else
          stringtofill=sprintf('<input type="checkbox" name="sy%02d" value="%02d"><font color="blue" size="2" face="Arial">%4d</font>',i,i,yearr(i-10+1));
        end  
      else
        stringtofill=sprintf('<input type="checkbox" name="sy%02d" value="0"><font color="white" size="2" face="Arial">%2s</font>',i,'na');
      end  
      eval(['s.s',num2str(i),'=stringtofill;']);     
    end
    stocksea=stocksea(:,yearchosen);
  end
  if FirstorS>0
    stocksea1=stocksea(:,2:min([length(stocksea(1,:)) FirstorS+1]));
  else
    stocksea1=stocksea(:,2:length(stocksea(1,:)));
  end
  stockseaf=0*stocksea(:,1);
  stockseaf(1,1)=0;
  for i=2:length(stocksea1(:,1))
    stockseaf(i,1)=mean(stocksea1(i,:));    
  end
  stocksea3=[0;stocksea(:,1)];
  stockseaf1=stocksea(find(stocksea(:,1)>-9900),1);
  datez=[[1 1;1 1];datez];
  Fig1=figure('visible','off','position',[2 5 635 433],'inverthardcopy','off','color','k'); hold off
  plot(stockseaf,'-y') 
  hold on
  plot(stockseaf1,'-g')
  chgstsea(datez)
  set(gca,'xcolor',[0.5 0.5 0.5]);
  set(gca,'ycolor',[0.5 0.5 0.5]);
  title(['Seasonal - ',num2str(length(stocksea1(1,:))),' years']); 
  ylabel('Net in Percentage');
  set(gca,'color',get(gcf,'color'));
  set(get(gca,'title'),'color',[0.65 0.65 0.65],'fontsize',9);
  %set(get(gca,'xlabel'),'color','w');
  set(get(gca,'ylabel'),'color',[0.65 0.65 0.65],'fontsize',9);
  hold off
  grid;
  ftzn=figtext(0.8,0.96,time);
  set(ftzn,'color',[0.65 0.65 0.65],'fontsize',8);
  ftzn=figtext(0.02,0.02,['Copyright ',datestr(now,10),' WSQSI, http://www.WSQSI.com/']);
  set(ftzn,'color',[0.5 0.5 0.5],'fontsize',7); 
  set(Fig1,'PaperPosition',[.25 .25 7 4]);
  cd([fpwserverplace,fpwclientdirectory,fpwusername,'\stock']);
  Plotfileh=[fpwclientdirectory,fpwusername,'\stock\wbstsea.jpeg'];
  drawnow;
  wsprintjpeg(Fig1,'wbstsea.jpeg');
  close(Fig1);
  s.Seasonjpeg=Plotfileh; 
  s.fpwusername=fpwusername;
  s.fpwusername4=fpwusername4;
  s.FSfpwfstype=mname;
  s.FSfpwsymbol=name;
  eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\fpwstsea s datez stocksea yearr']);
else
  if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\stock\fpwstsea.mat'])==2
     eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\fpwstsea']);
  else
    s.fpwusername=fpwusername;
    s.fpwusername4=fpwusername4;
    s.FSfpwfstype='S';
    s.FSfpwsymbol='UrSymbol';    
    s.Seasonjpeg=[fpwclientdirectory,fpwusername,'\stock\wbstsea.jpeg'];
  end
end 
s.fpwusername=fpwusername;
s.fpwusername4=fpwusername4;

cd(fpwserverplace);
cids=fpwloginstatus(fpwusername,clock);
if ~(strcmp(upper(fpwusername(1:4)),'USER'))
  templatefile = which('wbstsea.html');
else
  templatefile = which('wbstsea_nlink.html');
end
s.fpwcurrentm=[s.FSfpwfstype,s.FSfpwsymbol];
s.fpwulvl=instruct.fpwulvl;

if (nargin == 1)
  retstr = htmlrep(s, templatefile);
elseif (nargin == 2)
  retstr = htmlrep(s, templatefile, outfile);
end 
end