function retstr = wbstleadi(instruct, outfile)

% Author(s): N. Zhu, 11-15-2003
% This is a WB (Web-Based) mirror program to <wsmr*.m> in desktop version

wbfpwbasic;
cd(fpwserverplace);
retstr = char('');
fpwusername=instruct.mlid{1};
fpwCPAL=0;
fpwloginIP='192.168.2.8';
fpwcheckil;

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
    if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\stock\fpwstleadi.mat'])==2
      eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\fpwstleadi']);
      lifstype21=s.FSlifstype21;  lisymbol21=noempty(s.FSlisymbol21);    
      lifstype22=s.FSlifstype22;  lisymbol22=noempty(s.FSlisymbol22);
      lifstype23=s.FSlifstype23;  lisymbol23=noempty(s.FSlisymbol23);
      lifstype24=s.FSlifstype24;  lisymbol24=noempty(s.FSlisymbol24);
      lifstype25=s.FSlifstype25;  lisymbol25=noempty(s.FSlisymbol25);
      lifstype26=s.FSlifstype26;  lisymbol26=noempty(s.FSlisymbol26);
      lifstype27=s.FSlifstype27;  lisymbol27=noempty(s.FSlisymbol27);      
      lifstype='S';      lisymbol=noempty(instruct.zsobx72);
      lifsindex=0;       lirunindex=4;
      lifutany='Any';    Mrefnum=4;
      licorl=100;        lichartspan=95;
      clear s
    else      
      lifstype='S';      lisymbol=noempty(instruct.zsobx72);
      lifsindex=0;       lirunindex=4;
      lifutany='Any';    Mrefnum=4;
      licorl=100;        lichartspan=95;
      lifstype21='S';    lisymbol21='UrSym';
      lifstype22='S';    lisymbol22='UrSym';
      lifstype23='S';    lisymbol23='UrSym';
      lifstype24='S';    lisymbol24='UrSym';
      lifstype25='S';    lisymbol25='UrSym';
      lifstype26='S';    lisymbol26='UrSym';
      lifstype27='S';    lisymbol27='UrSym'; 
    end
  elseif strcmp(WhereOrderFrom,'SLFE')
    lifstype=instruct.hdlifstype;      lisymbol=noempty(instruct.lisymbol);
    lifstype21=instruct.hdlifstype21;  lisymbol21=noempty(instruct.lisymbol21);    
    lifstype22=instruct.hdlifstype22;  lisymbol22=noempty(instruct.lisymbol22);
    lifstype23=instruct.hdlifstype23;  lisymbol23=noempty(instruct.lisymbol23);
    lifstype24=instruct.hdlifstype24;  lisymbol24=noempty(instruct.lisymbol24);
    lifstype25=instruct.hdlifstype25;  lisymbol25=noempty(instruct.lisymbol25);
    lifstype26=instruct.hdlifstype26;  lisymbol26=noempty(instruct.lisymbol26);
    lifstype27=instruct.hdlifstype27;  lisymbol27=noempty(instruct.lisymbol27);
    licorl=str2num(instruct.licorl);   lichartspan=str2num(instruct.lichartspan);
    lifutany=instruct.hdlifutany;      lifsindex=str2num(instruct.lifsindex);  
    Mrefnum=str2num(instruct.Mrefnum); lirunindex=str2num(instruct.lirunindex);
  elseif strcmp(WhereOrderFrom,'LINK')
    lisymbol=noempty(instruct.mlmfvar);
    lifstype=upper(lisymbol(1));
    lisymbol=lisymbol(2:length(lisymbol));       
    lifsindex=0;       lirunindex=4;
    lifutany='Any';    Mrefnum=4;
    licorl=100;        lichartspan=95;
    lifstype21=lifstype;    lisymbol21='UrSym';
    lifstype22=lifstype;    lisymbol22='UrSym';
    lifstype23=lifstype;    lisymbol23='UrSym';
    lifstype24=lifstype;    lisymbol24='UrSym';
    lifstype25=lifstype;    lisymbol25='UrSym';
    lifstype26=lifstype;    lisymbol26='UrSym';
    lifstype27=lifstype;    lisymbol27='UrSym';              
  end
  global mname
  name=lisymbol; mname=lifstype;    

  if (length(name)==0)|(length(name)>6); error('Entered wrong symbol.'); end
  if (length(lisymbol21)==0)|(length(lisymbol21)>6); lisymbol21='UrSym'; end  
  if (length(lisymbol22)==0)|(length(lisymbol22)>6); lisymbol22='UrSym'; end    
  if (length(lisymbol23)==0)|(length(lisymbol23)>6); lisymbol23='UrSym'; end    
  if (length(lisymbol24)==0)|(length(lisymbol24)>6); lisymbol24='UrSym'; end    
  if (length(lisymbol25)==0)|(length(lisymbol25)>6); lisymbol25='UrSym'; end    
  if (length(lisymbol26)==0)|(length(lisymbol26)>6); lisymbol26='UrSym'; end    
  if (length(lisymbol27)==0)|(length(lisymbol27)>6); lisymbol27='UrSym'; end    
    
  if strcmp(WhereOrderFrom,'MPLG')
    fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
    fseek(fid1,-50,1); fprintf(fid1,[time,' MPGL: ',upper(mname),'-',upper(name),'\n']); fclose(fid1);
    clear fid1
  elseif strcmp(WhereOrderFrom,'SLFE')
    fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
    fseek(fid1,-50,1); fprintf(fid1,[time,' SLFL: ',upper(mname),'-',upper(name),'\n']); fclose(fid1);
    clear fid1
  elseif strcmp(WhereOrderFrom,'LINK')
    fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
    fseek(fid1,-50,1); fprintf(fid1,[time,' LNKL: ',upper(mname),'-',upper(name),'\n']); fclose(fid1);
    clear fid1     
  end

  if ((lirunindex==1)|((lifsindex==0)&(lirunindex==4)))
    % wsmrshow
    if lifsindex==0
      name=lower(name);
      [stock datem]=fsdaydat([mname,name]);        
    else
      eval(['name=lower(lisymbol2',num2str(lifsindex),');']);
      eval(['[stock datem]=fsdaydat([lifstype2',num2str(lifsindex),',name]);']);     
      mname=noempty(eval(['lifstype2',num2str(lifsindex)]));
    end
    if length(stock)==0
      error('Wrong symbol entered, not data available.');    
    end
    
    cd([Wherematlab,'stock']);
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
    cd([Wherematlab,'pattern']);

    stock=stock(max([1 length(stock(:,1))-lichartspan+1]):length(stock(:,1)),:);
    datem=datem(max([1 length(datem(:,1))-lichartspan+1]):length(datem(:,1)),:);   
    Fig1=figure('pos',[2 4 635 434],'color','k','visible','off'); 
    stock=[stock(1,:);stock];
    datem=[datem(1,:);datem];
    yrs=length(stock(:,1))-1;
    x=[1:yrs];
    closeh=stock(:,4);
    high=stock(:,2);
    low=stock(:,3);
    open=stock(:,1);
    vol=stock(:,5)/1000+.01;
    X1=1:yrs;
    X2=X1-.35;
    X3=X1+.35;
    X(1:yrs,1:2)=[X1' X1'];
    X4(1:yrs,1:2)=[X2' X1'];
    X5(1:yrs,1:2)=[X1' X3'];
    line(1:yrs,1:2)=[low(2:yrs+1) high(2:yrs+1)];
    line1(1:yrs,1:2)=[closeh(2:yrs+1) closeh(2:yrs+1)];
    line2(1:yrs,1:2)=[open(2:yrs+1) open(2:yrs+1)];
    plot(x(1),closeh(2),'k');hold on;
    for I=1:length(line(:,1))
      if dn(datem(I+1,:))~=5
        plot(X(I,:),line(I,:),'g','linewidth',.125);
        plot(X4(I,:),line2(I,:),'-g','linewidth',.125)
        plot(X5(I,:),line1(I,:),'-g','linewidth',.125)    
      else
        plot(X(I,:),line(I,:),'w','linewidth',.125);
        plot(X4(I,:),line2(I,:),'-w','linewidth',.125)
        plot(X5(I,:),line1(I,:),'-w','linewidth',.125)    
      end
    end
    datem(1:length(datem(:,1))-1,:)=datem(2:length(datem(:,1)),:);
    chgst93(datem);  
    grid; set(gca,'Xcolor',[0.5 0.5 0.5]);
    set(gca,'Ycolor',[0.5 0.5 0.5]);
    set(gca,'color',get(gcf,'color'));
    ylabel([upper(name),' - Price']);
    %ftzn=figtext(0.02,0.012,['Copyright ',datestr(now,10),' WSQSI, http://www.WSQSI.com/']);
    %set(ftzn,'color',[0.5 0.5 0.5],'fontsize',7);
    set(Fig1,'inverthardcopy','off'); hold off
    set(Fig1,'PaperPosition',[.25 .25 6.94 2.52]);
    cd([fpwserverplace,fpwclientdirectory,fpwusername,'\stock']);
    if lifsindex==0
      Plotfileh=[fpwclientdirectory,fpwusername,'\stock\wbstleadiu.jpeg'];
      drawnow;
      wsprintjpeg(Fig1,'wbstleadiu.jpeg');
      close(Fig1);
    else
      Plotfileh=[fpwclientdirectory,fpwusername,'\stock\wbstleadid.jpeg'];
      drawnow;
      wsprintjpeg(Fig1,'wbstleadid.jpeg');
      close(Fig1);    
    end
    s.Leadijpeg=Plotfileh;   
    cd(fpwserverplace);
    templatefile=which('wbstleadiR.html');    
    if (lirunindex==4)|(lifsindex==0)
      str = htmlrep(s, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbstleadiRu.html'],'noheader');
    else
      str = htmlrep(s, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbstleadiRd.html'],'noheader');
    end    
  elseif lirunindex==2
    % wsmrcalc;
    Mrname=lower(name);
    [Mrstock Mrdatem]=fsdaydat([mname,Mrname]);        
    if length(Mrstock)==0
      error('Wrong primary market symbol entered, not data available.');    
    end
    Mrlength=min([licorl fix(length(Mrstock(:,2))/1.5)]);
    Mrnumber=Mrefnum;
    load wsfbasic;
    futnames=futnames(1:40,:);
    Mrdef=lifutany;
    
    if Mrdef(1)=='A'
      mrmatrix=ones(40,40);
    else
      load mrmatrix.txt -ascii;
    end
    for i=1:40; mrmatrix(i,i)=0; end
    if Mrname(2)==' '; Mrname(2)='_';  end
    Mrplace=find((futnames(:,1)==lower(Mrname(1)))&(futnames(:,2)==lower(Mrname(2))));
    Mrplacei=mrmatrix(Mrplace,:);
    clear Mrplace Mrdef
    Mrcor=0*(1:length(futnames));
    Mrcor=[Mrcor' Mrcor'];
    for j=1:length(futnames)
      if (futnames(j,1)~=Mrname(1))&(futnames(j,2)~=Mrname(2))&(Mrplacei(j)~=2)
        Mrstock2=fsdaydat(lower(['F',futnames(j,:)]));
        if length(Mrstock2)>0
        if length(Mrstock2(:,1))>=round(1.5*Mrlength)
          Mrsiglex=Mrstock(length(Mrstock(:,1))-Mrlength+1:length(Mrstock(:,1)),4);
          Mrsiglex=modelnor(1,0,Mrsiglex);
          for i=1:min([80 fix(Mrlength/2)])
             Mrsigley=Mrstock2(length(Mrstock2(:,1))-i+1-Mrlength+1:length(Mrstock2(:,1))-i+1,4);
             Mrsigley=modelnor(1,0,Mrsigley);
             Mrsigle(i)=ccoef(Mrsiglex,Mrsigley);
          end
          [Mrsiglec Mrsiglei]=max(abs(Mrsigle));
          Mrsiglec=round(Mrsigle(Mrsiglei)*100);
          Mrsiglex=Mrstock2(length(Mrstock2(:,1))-Mrlength+1:length(Mrstock2(:,1)),4);
          Mrsiglex=modelnor(1,0,Mrsiglex);
          for i=1:min([80 fix(Mrlength/2)])
             Mrsigley=Mrstock(length(Mrstock(:,1))-i+1-Mrlength+1:length(Mrstock(:,1))-i+1,4);
             Mrsigley=modelnor(1,0,Mrsigley);
             Mrsigleor(i)=ccoef(Mrsiglex,Mrsigley);
          end
          [Mrsiglecor Mrsigleior]=max(abs(Mrsigleor));
          Mrsiglecor=round(Mrsigleor(Mrsigleior)*100);

          if abs(Mrsiglecor)>abs(Mrsiglec)
            Mrcor(j,1:2)=[300+Mrsiglecor Mrsigleior-1];
          else
            Mrcor(j,1:2)=[Mrsiglec Mrsiglei-1];
          end
        end
        end
      end
    end
    
    Mrmarkcan=find((Mrcor(:,1)<200)&(Mrcor(:,2)>0));
    if length(Mrmarkcan)>0
      for i=1:7
        eval(['lifstype2',int2str(i),'=','''F''',';']);
      end
      Mrfutnames=futnames(Mrmarkcan,:);
      MrcorL=Mrcor(Mrmarkcan,:);
      [Mrvalue Mrorder]=sort(-abs(MrcorL(:,1)));
      Mrvalue=MrcorL(Mrorder,:);
      Mrnames=Mrfutnames(Mrorder,:);
      Mrnames=Mrnames(1:min([length(Mrmarkcan) Mrnumber]),:);
      clear Mrstock2
      for i=1:min([length(Mrmarkcan) 7])
        eval(['lisymbol2',int2str(i),'=upper(Mrfutnames(Mrorder(i),:));']);
      end
      if i<7
        for I=i+1:7
          eval(['lisymbol2',int2str(I),'=''UrSym'';']);
        end
      end
      clear i I
      Mrll=min(Mrvalue(1:min([length(Mrmarkcan) Mrnumber]),2));
      if lisymbol21(2)=='_'; lisymbol21(2)==' '; end  
      if lisymbol22(2)=='_'; lisymbol22(2)==' '; end
      if lisymbol23(2)=='_'; lisymbol23(2)==' '; end    
      if lisymbol24(2)=='_'; lisymbol24(2)==' '; end    
      if lisymbol25(2)=='_'; lisymbol25(2)==' '; end
      if lisymbol26(2)=='_'; lisymbol26(2)==' '; end
      if lisymbol27(2)=='_'; lisymbol27(2)==' '; end 
      if (length(noempty(lisymbol21))==0); lisymbol21='UrSym'; end  
      if (length(noempty(lisymbol22))==0); lisymbol22='UrSym'; end    
      if (length(noempty(lisymbol23))==0); lisymbol23='UrSym'; end    
      if (length(noempty(lisymbol24))==0); lisymbol24='UrSym'; end    
      if (length(noempty(lisymbol25))==0); lisymbol25='UrSym'; end    
      if (length(noempty(lisymbol26))==0); lisymbol26='UrSym'; end    
      if (length(noempty(lisymbol27))==0); lisymbol27='UrSym'; end        

      % prepare Leading Indicator
      MrindiH=(0*(1:lichartspan-2))';
      MrindiL=zeros(lichartspan-2,min([length(Mrmarkcan) Mrnumber]));
      MrindiLi=[3 4 5 6 7 8 9];
      MrindiHi=MrindiLi(min([length(Mrmarkcan) Mrnumber]):-1:1);
      
      for i=1:min([length(Mrmarkcan) Mrnumber])
        Mrstock2=fsdaydat(lower(['F',Mrnames(i,:)]));
        Mrlength=length(MrindiL);
        Mrlengthaj=Mrvalue(i,2)-Mrll;
        Mryy=Mrstock2(length(Mrstock2(:,4))-Mrlength+1-Mrlengthaj:length(Mrstock2(:,4))-Mrlengthaj,4);
        if Mrvalue(i,1)>0
          MrindiL(:,i)=MrindiHi(i)*modelnor(1,0,Mryy);
          MrindiH=MrindiH+MrindiL(:,i);
        else
          MrindiL(:,i)=MrindiHi(i)*(1-modelnor(1,0,Mryy));
          MrindiH=MrindiH+MrindiL(:,i);
        end
      end

      Fig1=figure('pos',[2 4 635 434],'color','k','visible','off'); 
      MrindiH=(MrindiH)/sum(MrindiHi(1:min([length(Mrmarkcan) Mrnumber])));
      highnornow=max(Mrstock(length(Mrstock(:,1))-length(MrindiH)+1:length(Mrstock(:,1)),2));
      lownornow=min(Mrstock(length(Mrstock(:,1))-length(MrindiH)+1:length(Mrstock(:,1)),3));
      MrindiL=modelnor(highnornow,lownornow,MrindiH);
      plot(MrindiL,'g');
      hold on;
      mrbbb=plot(MrindiL,'.r');
      set(mrbbb,'Markersize',10);
      plot(length(MrindiL)-Mrll,MrindiL(length(MrindiH)-Mrll),'*w');
      hold off;
      Mrrange=length(Mrdatem(:,1))-lichartspan+3:length(Mrdatem(:,1));
      chgst(Mrdatem(Mrrange,:));
      ylabel(['LI, S:',int2str(mean(abs(Mrvalue(1:min([length(Mrmarkcan) Mrnumber]),1)))),'    L:',int2str(Mrll)]);
      set(get(gca,'Ylabel'),'FontSize',11);
      grid; set(gca,'Xcolor',[0.5 0.5 0.5]);
      set(gca,'Ycolor',[0.5 0.5 0.5]);
      set(gca,'color',get(gcf,'color'));
      %ftzn=figtext(0.02,0.015,['Copyright ',datestr(now,10),' WSQSI, http://www.WSQSI.com/']);
      %set(ftzn,'color',[0.5 0.5 0.5],'fontsize',7);
      set(Fig1,'inverthardcopy','off'); hold off
      set(Fig1,'PaperPosition',[.25 .25 6.94 2.52]);
      cd([fpwserverplace,fpwclientdirectory,fpwusername,'\stock']);
      Plotfileh=[fpwclientdirectory,fpwusername,'\stock\wbstleadid.jpeg'];
      drawnow;
      wsprintjpeg(Fig1,'wbstleadid.jpeg');
      close(Fig1);    
    else
      Fig1=figure('pos',[2 4 635 434],'color','k','visible','off'); 
      handleh=figtext(0.3,0.65,'Not found LI.');
      set(handleh,'color','g','fontsize',30);
      handleh=text(0.3,0.5,'Not correlated enough or no leading markets.');
      set(handleh,'color','g','fontsize',14);
      set(Fig1,'inverthardcopy','off'); hold off
      set(Fig1,'PaperPosition',[.25 .25 6.94 2.52]);
      cd([fpwserverplace,fpwclientdirectory,fpwusername,'\stock']);
      Plotfileh=[fpwclientdirectory,fpwusername,'\stock\wbstleadid.jpeg'];
      drawnow;
      wsprintjpeg(Fig1,'wbstleadid.jpeg');
      close(Fig1);    
    end
    cd(fpwserverplace);
    s.Leadijpeg=Plotfileh;    
    templatefile=which('wbstleadiR.html');
    str = htmlrep(s, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbstleadiRd.html'],'noheader');    
  elseif lirunindex==3
    % wsmrok
    Mrname=lower(name);
    [Mrstock Mrdatem]=fsdaydat([mname,Mrname]);        
    if length(Mrstock)==0
      error('Wrong primary market symbol entered, not data available.');    
    end
    Mrlength=min([licorl fix(length(Mrstock(:,2))/1.5)]);
    Mrnumber=Mrefnum;

    Mrcor=0*(1:7);
    Mrcor=[Mrcor' Mrcor'];
    futnames=str2mat([lifstype21 lisymbol21],[lifstype22 lisymbol22],[lifstype23 lisymbol23],[lifstype24 lisymbol24],...
        [lifstype25 lisymbol25],[lifstype26 lisymbol26],[lifstype27 lisymbol27]);
    futnames=upper(futnames);
    
    for j=1:length(futnames)
      if (~strcmp(upper(noempty([mname,name])),'FURSYM'))&(~strcmp(upper(noempty([mname,name])),noempty(futnames(j,:))))
        Mrstock2=fsdaydat(noempty(futnames(j,:)));
        if length(Mrstock2)>0
        if length(Mrstock2(:,1))>=round(1.5*Mrlength)
          Mrsiglex=Mrstock(length(Mrstock(:,1))-Mrlength+1:length(Mrstock(:,1)),4);
          Mrsiglex=modelnor(1,0,Mrsiglex);
          for i=1:min([80 fix(Mrlength/2)])
            Mrsigley=Mrstock2(length(Mrstock2(:,1))-i+1-Mrlength+1:length(Mrstock2(:,1))-i+1,4);
            Mrsigley=modelnor(1,0,Mrsigley);
            Mrsigle(i)=ccoef(Mrsiglex,Mrsigley);
          end
          [Mrsiglec Mrsiglei]=max(abs(Mrsigle));
          Mrsiglec=round(Mrsigle(Mrsiglei)*100);
          Mrsiglex=Mrstock2(length(Mrstock2(:,1))-Mrlength+1:length(Mrstock2(:,1)),4);
          Mrsiglex=modelnor(1,0,Mrsiglex);
          for i=1:min([80 fix(Mrlength/2)])
            Mrsigley=Mrstock(length(Mrstock(:,1))-i+1-Mrlength+1:length(Mrstock(:,1))-i+1,4);
            Mrsigley=modelnor(1,0,Mrsigley);
            Mrsigleor(i)=ccoef(Mrsiglex,Mrsigley);
          end
          [Mrsiglecor Mrsigleior]=max(abs(Mrsigleor));
          Mrsiglecor=round(Mrsigleor(Mrsigleior)*100);
            
          if abs(Mrsiglecor)>abs(Mrsiglec)
            Mrcor(j,1:2)=[300+Mrsiglecor Mrsigleior-1];
          else
            Mrcor(j,1:2)=[Mrsiglec Mrsiglei-1];
          end
        end
        end
      end
    end
          
    Mrmarkcan=find((Mrcor(:,1)<200)&(Mrcor(:,2)>0));
    if length(Mrmarkcan)>0
      Mrfutnames=futnames(Mrmarkcan,:);
      MrcorL=Mrcor(Mrmarkcan,:);
      [Mrvalue Mrorder]=sort(-abs(MrcorL(:,1)));
      Mrvalue=MrcorL(Mrorder,:);
      Mrnames=Mrfutnames(Mrorder,:);
      Mrnames=Mrnames(1:min([length(Mrmarkcan) Mrnumber]),:);
      clear Mrstock2
      for i=1:min([length(Mrmarkcan) 7])
        eval(['lisymbol2',int2str(i),'=noempty(upper(Mrfutnames(Mrorder(i),2:length(futnames(1,:)))));']);
        eval(['lifstype2',int2str(i),'=upper(Mrfutnames(Mrorder(i),1));']);        
      end
      if i<7
        for I=i+1:7
          eval(['lisymbol2',int2str(I),'=''UrSym'';']);
        end
      end     

      if (length(noempty(lisymbol21))==0); lisymbol21='UrSym'; end  
      if (length(noempty(lisymbol22))==0); lisymbol22='UrSym'; end    
      if (length(noempty(lisymbol23))==0); lisymbol23='UrSym'; end    
      if (length(noempty(lisymbol24))==0); lisymbol24='UrSym'; end    
      if (length(noempty(lisymbol25))==0); lisymbol25='UrSym'; end    
      if (length(noempty(lisymbol26))==0); lisymbol26='UrSym'; end    
      if (length(noempty(lisymbol27))==0); lisymbol27='UrSym'; end 
      Mrll=min(Mrvalue(1:min([length(Mrmarkcan) Mrnumber]),2));
      
      % prepare Leading Indicator
      MrindiH=(0*(1:lichartspan-2))';
      MrindiL=zeros(lichartspan-2,min([length(Mrmarkcan) Mrnumber]));
      MrindiLi=[3 4 5 6 7 8 9];
      MrindiHi=MrindiLi(min([length(Mrmarkcan) Mrnumber]):-1:1);
      
      for i=1:min([length(Mrmarkcan) Mrnumber])
        Mrstock2=fsdaydat(Mrnames(i,:));
        Mrlength=length(MrindiL);
        Mrlengthaj=Mrvalue(i,2)-Mrll;
        Mryy=Mrstock2(length(Mrstock2(:,4))-Mrlength+1-Mrlengthaj:length(Mrstock2(:,4))-Mrlengthaj,4);
        if Mrvalue(i,1)>0
          MrindiL(:,i)=MrindiHi(i)*modelnor(1,0,Mryy);
          MrindiH=MrindiH+MrindiL(:,i);
        else
          MrindiL(:,i)=MrindiHi(i)*(1-modelnor(1,0,Mryy));
          MrindiH=MrindiH+MrindiL(:,i);
        end
      end
      Fig1=figure('pos',[2 4 635 434],'color','k','visible','off'); 
      MrindiH=(MrindiH)/sum(MrindiHi(1:min([length(Mrmarkcan) Mrnumber])));
      highnornow=max(Mrstock(length(Mrstock(:,1))-length(MrindiH)+1:length(Mrstock(:,1)),2));
      lownornow=min(Mrstock(length(Mrstock(:,1))-length(MrindiH)+1:length(Mrstock(:,1)),3));
      MrindiL=modelnor(highnornow,lownornow,MrindiH);
      plot(MrindiL,'g');
      hold on;
      mrbbb=plot(MrindiL,'.r');
      set(mrbbb,'Markersize',10);
      plot(length(MrindiL)-Mrll,MrindiL(length(MrindiH)-Mrll),'*w');
      hold off;
      Mrrange=length(Mrdatem(:,1))-lichartspan+3:length(Mrdatem(:,1));
      chgst(Mrdatem(Mrrange,:));
      ylabel(['LI, S:',int2str(mean(abs(Mrvalue(1:min([length(Mrmarkcan) Mrnumber]),1)))),'    L:',int2str(Mrll)]);
      set(get(gca,'Ylabel'),'FontSize',11);
      grid; set(gca,'Xcolor',[0.5 0.5 0.5]);
      set(gca,'Ycolor',[0.5 0.5 0.5]);
      set(gca,'color',get(gcf,'color'));
      set(Fig1,'inverthardcopy','off'); hold off
      set(Fig1,'PaperPosition',[.25 .25 6.94 2.52]);
      cd([fpwserverplace,fpwclientdirectory,fpwusername,'\stock']);
      Plotfileh=[fpwclientdirectory,fpwusername,'\stock\wbstleadid.jpeg'];
      drawnow;
      wsprintjpeg(Fig1,'wbstleadid.jpeg');
      close(Fig1);    
    else
      Fig1=figure('pos',[2 4 635 434],'color','k','visible','off'); 
      handleh=figtext(0.3,0.65,'Not found LI.');
      set(handleh,'color','g','fontsize',30);
      handleh=text(0.3,0.5,'Not correlated enough or no leading markets.');
      set(handleh,'color','g','fontsize',14);
      set(Fig1,'inverthardcopy','off'); hold off
      set(Fig1,'PaperPosition',[.25 .25 6.94 2.52]);
      cd([fpwserverplace,fpwclientdirectory,fpwusername,'\stock']);
      Plotfileh=[fpwclientdirectory,fpwusername,'\stock\wbstleadid.jpeg'];
      drawnow;
      wsprintjpeg(Fig1,'wbstleadid.jpeg');
      close(Fig1);       
    end
    cd(fpwserverplace);
    s.Leadijpeg=Plotfileh;
    templatefile=which('wbstleadiR.html');
    str = htmlrep(s, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbstleadiRd.html'],'noheader');     
  elseif lirunindex==4
    % wsmrdef
    if lifstype=='F'
      load wsmrdefa
      Mrname=lower(name);
      if length(Mrname)==1;
        Mrname(2)='_';
      end
      i=find((wsmrdefa(:,22)==Mrname(1))&(wsmrdefa(:,23)==Mrname(2)));
      for j=1:7
        eval(['lisymbol2',int2str(j),'=upper(wsmrdefa(i,(j-1)*3+1:j*3-1));']);
        eval(['lifstype2',int2str(j),'=','''F''',';']);
      end
      if lisymbol21(2)=='_'; lisymbol21(2)==' '; end  
      if lisymbol22(2)=='_'; lisymbol22(2)==' '; end
      if lisymbol23(2)=='_'; lisymbol23(2)==' '; end    
      if lisymbol24(2)=='_'; lisymbol24(2)==' '; end    
      if lisymbol25(2)=='_'; lisymbol25(2)==' '; end
      if lisymbol26(2)=='_'; lisymbol26(2)==' '; end
      if lisymbol27(2)=='_'; lisymbol27(2)==' '; end 
      if (length(noempty(lisymbol21))==0); lisymbol21='UrSym'; end  
      if (length(noempty(lisymbol22))==0); lisymbol22='UrSym'; end    
      if (length(noempty(lisymbol23))==0); lisymbol23='UrSym'; end    
      if (length(noempty(lisymbol24))==0); lisymbol24='UrSym'; end    
      if (length(noempty(lisymbol25))==0); lisymbol25='UrSym'; end    
      if (length(noempty(lisymbol26))==0); lisymbol26='UrSym'; end    
      if (length(noempty(lisymbol27))==0); lisymbol27='UrSym'; end   
      clear i wsmrdefa Mrname
    end    
  end
  s.fpwusername=fpwusername;  
  s.fpwusername4=fpwusername4;
  s.wbstleadiu=[fpwclientdirectory,fpwusername,'\stock\wbstleadiRu.html'];    
  s.wbstleadid=[fpwclientdirectory,fpwusername,'\stock\wbstleadiRd.html'];
  s.FSlifutany=lifutany;      s.FSMrefnum=num2str(Mrefnum);
  s.FSlicorl=num2str(licorl); s.FSlichartspan=num2str(lichartspan);
  s.FSlifstype=lifstype;      s.FSlisymbol=lisymbol;
  s.FSlifstype21=lifstype21;  s.FSlisymbol21=lisymbol21;
  s.FSlifstype22=lifstype22;  s.FSlisymbol22=lisymbol22;
  s.FSlifstype23=lifstype23;  s.FSlisymbol23=lisymbol23;
  s.FSlifstype24=lifstype24;  s.FSlisymbol24=lisymbol24;
  s.FSlifstype25=lifstype25;  s.FSlisymbol25=lisymbol25;
  s.FSlifstype26=lifstype26;  s.FSlisymbol26=lisymbol26;
  s.FSlifstype27=lifstype27;  s.FSlisymbol27=lisymbol27;
  eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\fpwstleadi s']);
else
  if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\stock\fpwstleadi.mat'])==2
    eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\fpwstleadi']);
  else
    s.fpwusername=fpwusername;
    s.fpwusername4=fpwusername4;
    s.wbstleadiu=[fpwclientdirectory,fpwusername,'\stock\wbstleadiRu.html'];    
    s.wbstleadid=[fpwclientdirectory,fpwusername,'\stock\wbstleadiRd.html'];
    s.FSlifutany='Any';    s.FSMrefnum='4';
    s.FSlicorl='100';      s.FSlichartspan='95';
    s.FSlifstype='S';      s.FSlisymbol='UrSym';
    s.FSlifstype21='S';    s.FSlisymbol21='UrSym';
    s.FSlifstype22='S';    s.FSlisymbol22='UrSym';
    s.FSlifstype23='S';    s.FSlisymbol23='UrSym';
    s.FSlifstype24='S';    s.FSlisymbol24='UrSym';
    s.FSlifstype25='S';    s.FSlisymbol25='UrSym';
    s.FSlifstype26='S';    s.FSlisymbol26='UrSym';
    s.FSlifstype27='S';    s.FSlisymbol27='UrSym';
  end
  lirunindex=4;
end 
s.fpwusername=fpwusername;
s.fpwusername4=fpwusername4;

cd(fpwserverplace);
cids=fpwloginstatus(fpwusername,clock); 
if ~(strcmp(upper(fpwusername(1:4)),'USER'))
  templatefile = which('wbstleadi.html');
else
  templatefile = which('wbstleadi_nlink.html');
end
s.fpwcurrentm=[s.FSlifstype,s.FSlisymbol];
s.fpwulvl=instruct.fpwulvl;
if (nargin == 1)
  retstr = htmlrep(s, templatefile);     
elseif (nargin == 2)
  retstr = htmlrep(s, templatefile, outfile);
end 
end