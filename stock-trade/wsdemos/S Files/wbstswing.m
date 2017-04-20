function retstr = wbstswing(instruct, outfile)

% Author(s): N. Zhu, 11-15-2003
% This is a WB (Web-Based) mirror program to <stswing.m> in desktop version

if 0
  cd('C:\Winword\Ongoing Projects\PW HTML files')
  pcode wbdzhckout.m;
  pcode wbdzhjust.m;
  pcode wbstswing.m;
  pcode wbstsnr.m;
  pcode wbstsea.m;
  pcode wbstrdata.m;
  pcode wbstquote.m;
  pcode wbstockqd.m;
  pcode wbstockqdv.m;
  pcode wbstmpsort.m;
  pcode wbstmmct.m;
  pcode wbstleadi.m;
  pcode wbstchart.m;
  pcode wbstanalog.m;
  pcode wbfpwmpstat.m;
  pcode wbfpwmpstatday.m;
  pcode wbdzhsdigi.m;
  pcode wbdzhptern.m;
end

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
    fpwswingp=1250;  
    fpwswingtd='D';
    fpwswingc=1;
    fpwswingnp='P';  
    fpwswingt=20;  
    fpwswingl=5;  
  elseif strcmp(WhereOrderFrom,'SLFE')
    name=noempty(instruct.fpwsymbol);
    global mname; 
    mname=instruct.fpwfstype;
    fpwswingp=str2num(instruct.fpwswingp);
    fpwswingtd=instruct.hdfpwswingtd;
    fpwswingc=str2num(instruct.fpwswingc);
    fpwswingnp=instruct.hdfpwswingnp;
    fpwswingt=fix(rem(str2num(instruct.fpwswingt),100));
    fpwswingl=str2num(instruct.fpwswingl);
  elseif strcmp(WhereOrderFrom,'LINK')
    name=noempty(instruct.mlmfvar);
    global mname;
    mname=upper(name(1));
    name=name(2:length(name)); 
    fpwswingp=1250;  
    fpwswingtd='D';
    fpwswingc=1;
    fpwswingnp='P';  
    fpwswingt=20;  
    fpwswingl=5;  
  end
  if (length(name)==0)|(length(name)>6)
    error('Entered wrong symbol.');
  end
  
  name=lower(name);
  if fpwswingtd=='D'
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
  else
    if mname=='F'
      [stock datem]=fsdaydat([mname,name]);
      loope=datem(max([1 length(datem(:,1))-40]),:);
      if wsfsn24(['f',name])==0
        stock=wsgettdn(loope,4,3500,[mname,name],0);
      else
        stock=wsgettdn(loope,0,3500,[mname,name],0);
      end
      %datem=stock(:,[4 5 2]);
      datem=stock(:,1:5);    
      stock=stock(:,6:10);    
    else
      stock=stgetdaa(name,'t',fix(3.3*fpwswingp));
      %datem=stock(:,[4 5 2]);
      datem=stock(:,1:5);    
      stock=stock(:,6:10);
    end 
  end
  
  if length(stock)==0
    error('No data available for this stock, please check the symbol.');
  end
  
  if strcmp(WhereOrderFrom,'MPLG')
    fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
    fseek(fid1,-50,1); fprintf(fid1,[time,' MPGW: ',upper(mname),num2str(fpwswingp),'-',upper(name),'\n']); fclose(fid1);
    clear fid1
  elseif strcmp(WhereOrderFrom,'SLFE')
    fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
    fseek(fid1,-50,1); fprintf(fid1,[time,' SLFW: ',upper(mname),num2str(fpwswingp),'-',upper(name),'\n']); fclose(fid1);
    clear fid1
  elseif strcmp(WhereOrderFrom,'LINK')
    fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
    fseek(fid1,-50,1); fprintf(fid1,[time,' LNKW: ',upper(mname),'-',upper(name),'\n']); fclose(fid1);
    clear fid1     
  end
  
  if length(stock(:,1))<=fpwswingp/3
    error('There is not that long data history for this one, try another short term run.');
  else
    stock=stock(max([1 length(stock(:,1))-fpwswingp+1]):length(stock(:,1)),:);
    datem=datem(max([1 length(datem(:,1))-fpwswingp+1]):length(datem(:,1)),:);
    wbfpw = [fpwserverplace,fpwclientdirectory,fpwusername,'\stock\'];
    if fpwswingc==1
      if fpwswingnp=='P'
        fpwfighandle=wbswzper(stock(:,2:4),100-fpwswingt,name,wbfpw);
      else
        fpwfighandle=wbswz(stock(:,2:4),100-fpwswingt,name,wbfpw);          
      end   
    elseif fpwswingc==2
      fpwfighandle=wbswso(stock(:,2:4),fpwswingl,name,wbfpw);       
    elseif fpwswingc==3
      fpwfighandle=wbswzn(stock(:,2:4),fpwswingl,3,3,name,datem,wbfpw);  
    end
    Plotfileh=[fpwclientdirectory,fpwusername,'\stock\wbstswing.jpeg'];
    set(fpwfighandle,'visible','off','position',[2 5 635 433],'inverthardcopy','off','color','k');
    set(fpwfighandle,'PaperPosition',[.25 .25 7 5.5]);
    cd([fpwserverplace,fpwclientdirectory,fpwusername,'\stock']);
    drawnow;
    wsprintjpeg(fpwfighandle,'wbstswing.jpeg');
    close(fpwfighandle);
    s.Swingjpeg=Plotfileh;
  end
  s.fpwusername=fpwusername;
  s.fpwusername4=fpwusername4;
  s.FSfpwfstype=mname;
  s.FSfpwswingp=num2str(fpwswingp);
  s.FSfpwsymbol=name;
  s.FSfpwswingtd=fpwswingtd;
  s.FSfpwswingc=num2str(fpwswingc);
  s.FSfpwswingnp=fpwswingnp;
  s.FSfpwswingt=num2str(fpwswingt);
  s.FSfpwswingl=num2str(fpwswingl);
  eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\fpwstswing s']);
else
  if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\stock\fpwstswing.mat'])==2
     eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\fpwstswing']);
  else
    s.fpwusername=fpwusername;
    s.Swingjpeg=[fpwclientdirectory,fpwusername,'\stock\wbstswing.jpeg'];
    s.FSfpwfstype='S';
    s.FSfpwswingp='1250';
    s.FSfpwsymbol='UrSymbol';
    s.FSfpwswingtd='D';
    s.FSfpwswingc='1';
    s.FSfpwswingnp='P';
    s.FSfpwswingt='20';
    s.FSfpwswingl='5';
  end
end 
s.fpwusername=fpwusername;
s.fpwusername4=fpwusername4;

cd(fpwserverplace);
cids=fpwloginstatus(fpwusername,clock);
if ~(strcmp(upper(fpwusername(1:4)),'USER'))
  templatefile = which('wbstswing.html');
else
  templatefile = which('wbstswing_nlink.html');
end
s.fpwcurrentm=[s.FSfpwfstype,s.FSfpwsymbol];
s.fpwulvl=instruct.fpwulvl;
if (nargin == 1)
  retstr = htmlrep(s, templatefile);
elseif (nargin == 2)
  retstr = htmlrep(s, templatefile, outfile);
end    
end