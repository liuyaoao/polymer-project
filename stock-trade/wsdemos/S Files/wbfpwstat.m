function retstr = wbfpwstat(instruct, outfile)

% Author(s): N. Zhu, 11-15-2003
% This is a WB (Web-Based) mirror program to <wsozc3*> and more in desktop version

wbfpwbasic;
cd(fpwserverplace);

retstr = char('');
global fpwusername fpwusername4
fpwusername=instruct.mlid{1};
fpwCPAL=4;
fpwloginIP='192.168.2.8';
fpwcheckil;

if fpwcheckilpass==1
  if ~strcmp(instruct.WhereOrderFrom,'SOSR')
    fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
    fseek(fid1,-50,1); fprintf(fid1,[time,' STAT\n']); fclose(fid1);
    clear fid1
    fpwulvl=str2num(instruct.fpwulvl);
    global mname name stock datem   
    eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwfrontout']);
    name=fpwout.name; mname=fpwout.mname; Mname1=mname; Name1=name; datem=fpwout.datem;
    stock=fpwout.stock; tradeh=fpwout.tradeh;
       
    if strcmp(instruct.WhereOrderFrom,'SLFE')
      outrunindex=instruct.outrunindex;
      fpwsource=instruct.fpwsource;
    else
      outrunindex='42';
      fpwsource=fpwout.fpwsource;
    end
    clear fpwout fpwout1
    
    if strcmp(name,'ZZXY')
      error(' - Note: This web-based program has been designed for single market models only.')    
    end
    
    if isfield(instruct,'hdAzhuAA')
      AzhuAA=instruct.hdAzhuAA;
      AzhuTD=instruct.hdAzhuTD;  
      AzhuTE=instruct.AzhuTE;
      Azhus2=instruct.Azhus2;
    else
      AzhuAA='C';
      AzhuTD='T';  
      AzhuTE='0';
      Azhus2='1';  
    end
    cd([Wherematlab,'\pattern']);
    %save fpwtempfile
    
    if strcmp(outrunindex,'42')
      %puer statistics - wssetsta
      % carry by fpwstat.* to same page style
      if tradeh(1,9)~=4
        wsbs=stock(tradeh(:,3),1:4);wsas=wsbs;
      else
        wsbs=stock(tradeh(:,3)-1,1:4);wsas=wsbs;
      end
      wsss=zeros(23,5)-1;wssn=length(tradeh(:,2));
      
      hmd=str2num(Azhus2);
      hmdmax=length(stock)-tradeh(length(tradeh(:,1)),3);
      if hmd>hmdmax
        hmd=hmdmax;
        Azhus2=num2str(hmd);
      end
      if AzhuAA=='D'
        if tradeh(1,9)~=4 
          wsbs=stock(tradeh(:,3)+hmd-1,1:4);
          wsas=stock(tradeh(:,3)+hmd,1:4);
        else
          wsbs=stock(tradeh(:,3)+hmd-2,1:4);
          wsas=stock(tradeh(:,3)+hmd-1,1:4);
        end
      else
        if tradeh(1,9)~=4 
          wsas(:,1)=stock(tradeh(:,3)+1,1);
          wsas(:,4)=stock(tradeh(:,3)+hmd,4);
          for i=1:wssn
            wsas(i,2)=max(stock(tradeh(i,3)+1:tradeh(i,3)+hmd,2));
            wsas(i,3)=min(stock(tradeh(i,3)+1:tradeh(i,3)+hmd,3));
          end
        else
          wsas(:,1)=stock(tradeh(:,3),1);
          wsas(:,4)=stock(tradeh(:,3)+hmd-1,4);
          for i=1:wssn
            wsas(i,2)=max(stock(tradeh(i,3):tradeh(i,3)+hmd-1,2));
            wsas(i,3)=min(stock(tradeh(i,3):tradeh(i,3)+hmd-1,3));
          end
        end
      end
      wsoc=wsas(:,4)-wsas(:,1);
      wscc=wsas(:,4)-wsbs(:,4);
      wsocu=find(wsoc>0);
      wsocd=find(wsoc<0);
      wsccu=find(wscc>0);
      wsccd=find(wscc<0);
      
      wsss(1,1)=length(wsocu);
      wsss(1,2)=length(wsocd);
      wsss(1,4)=length(wsccu);
      wsss(1,5)=length(wsccd);
      wsstrs1=['Up',sprintf(' %3d %4.0f',wsss(1,1),wsss(1,1)/wssn*100),'%'];
      wsstrs2=['Dn',sprintf(' %3d %4.0f',wsss(1,2),wsss(1,2)/wssn*100),'%'];
      wsstrs4=['Up',sprintf(' %3d %4.0f',wsss(1,4),wsss(1,4)/wssn*100),'%'];
      wsstrs5=['Dn',sprintf(' %3d %4.0f',wsss(1,5),wsss(1,5)/wssn*100),'%'];
      fpwstat.sA11=wsstrs1; fpwstat.sA12=wsstrs2;
      fpwstat.sA14=wsstrs4; fpwstat.sA15=wsstrs5;
      fpwstat.sA13=['<font color="white">',upper([mname name]),'</font>',' - Total <font color="white">',int2str(wssn),'</font> Events'];
      
      wsss(2,1)=length(find(wsas(wsocu,4)>wsas(wsocu,1)));
      wsss(3,1)=length(find(wsas(wsocu,4)<wsas(wsocu,1)));
      wsss(2,2)=length(find(wsas(wsocd,4)>wsas(wsocd,1)));
      wsss(3,2)=length(find(wsas(wsocd,4)<wsas(wsocd,1)));
      wsss(2,4)=length(find(wsas(wsccu,4)>wsas(wsccu,1)));
      wsss(3,4)=length(find(wsas(wsccu,4)<wsas(wsccu,1)));
      wsss(2,5)=length(find(wsas(wsccd,4)>wsas(wsccd,1)));
      wsss(3,5)=length(find(wsas(wsccd,4)<wsas(wsccd,1)));
      
      wsss(4,1)=length(find(wsas(wsocu,4)>wsbs(wsocu,4)));
      wsss(5,1)=length(find(wsas(wsocu,4)<wsbs(wsocu,4)));
      wsss(4,2)=length(find(wsas(wsocd,4)>wsbs(wsocd,4)));
      wsss(5,2)=length(find(wsas(wsocd,4)<wsbs(wsocd,4)));
      wsss(4,4)=length(find(wsas(wsccu,4)>wsbs(wsccu,4)));
      wsss(5,4)=length(find(wsas(wsccu,4)<wsbs(wsccu,4)));
      wsss(4,5)=length(find(wsas(wsccd,4)>wsbs(wsccd,4)));
      wsss(5,5)=length(find(wsas(wsccd,4)<wsbs(wsccd,4)));
      
      wsss(6,1)=length(find(wsas(wsocu,1)>wsbs(wsocu,4)));
      wsss(7,1)=length(find(wsas(wsocu,1)<wsbs(wsocu,4)));
      wsss(6,2)=length(find(wsas(wsocd,1)>wsbs(wsocd,4)));
      wsss(7,2)=length(find(wsas(wsocd,1)<wsbs(wsocd,4)));
      wsss(6,4)=length(find(wsas(wsccu,1)>wsbs(wsccu,4)));
      wsss(7,4)=length(find(wsas(wsccu,1)<wsbs(wsccu,4)));
      wsss(6,5)=length(find(wsas(wsccd,1)>wsbs(wsccd,4)));
      wsss(7,5)=length(find(wsas(wsccd,1)<wsbs(wsccd,4)));
     
      wsss(8,1)=length(find(wsas(wsocu,2)>wsbs(wsocu,2)));
      wsss(9,1)=length(find(wsas(wsocu,2)<wsbs(wsocu,2)));
      wsss(8,2)=length(find(wsas(wsocd,2)>wsbs(wsocd,2)));
      wsss(9,2)=length(find(wsas(wsocd,2)<wsbs(wsocd,2)));
      wsss(8,4)=length(find(wsas(wsccu,2)>wsbs(wsccu,2)));
      wsss(9,4)=length(find(wsas(wsccu,2)<wsbs(wsccu,2)));
      wsss(8,5)=length(find(wsas(wsccd,2)>wsbs(wsccd,2)));
      wsss(9,5)=length(find(wsas(wsccd,2)<wsbs(wsccd,2)));
      
      wsss(10,1)=length(find(wsas(wsocu,3)>wsbs(wsocu,3)));
      wsss(11,1)=length(find(wsas(wsocu,3)<wsbs(wsocu,3)));
      wsss(10,2)=length(find(wsas(wsocd,3)>wsbs(wsocd,3)));
      wsss(11,2)=length(find(wsas(wsocd,3)<wsbs(wsocd,3)));
      wsss(10,4)=length(find(wsas(wsccu,3)>wsbs(wsccu,3)));
      wsss(11,4)=length(find(wsas(wsccu,3)<wsbs(wsccu,3)));
      wsss(10,5)=length(find(wsas(wsccd,3)>wsbs(wsccd,3)));
      wsss(11,5)=length(find(wsas(wsccd,3)<wsbs(wsccd,3)));
      
      if length(wsocu)>0
        wsss(13,1)=max(wsas(wsocu,2)-wsas(wsocu,1));
        wsss(14,1)=mean(wsas(wsocu,2)-wsas(wsocu,1));
      end
      if length(wsocd)>0
        wsss(13,2)=max(wsas(wsocd,2)-wsas(wsocd,1));
        wsss(14,2)=mean(wsas(wsocd,2)-wsas(wsocd,1));
      end
      if length(wsccu)>0
        wsss(13,4)=max(wsas(wsccu,2)-wsas(wsccu,1));
        wsss(14,4)=mean(wsas(wsccu,2)-wsas(wsccu,1));
      end
      if length(wsccd)>0
        wsss(13,5)=max(wsas(wsccd,2)-wsas(wsccd,1));
        wsss(14,5)=mean(wsas(wsccd,2)-wsas(wsccd,1));
      end
      
      if length(wsocu)>0
        wsss(16,1)=max(wsas(wsocu,1)-wsas(wsocu,3));
        wsss(17,1)=mean(wsas(wsocu,1)-wsas(wsocu,3));
      end
      if length(wsocd)>0
        wsss(16,2)=max(wsas(wsocd,1)-wsas(wsocd,3));
        wsss(17,2)=mean(wsas(wsocd,1)-wsas(wsocd,3));
      end
      if length(wsccu)>0
        wsss(16,4)=max(wsas(wsccu,1)-wsas(wsccu,3));
        wsss(17,4)=mean(wsas(wsccu,1)-wsas(wsccu,3));
      end
      if length(wsccd)>0
        wsss(16,5)=max(wsas(wsccd,1)-wsas(wsccd,3));
        wsss(17,5)=mean(wsas(wsccd,1)-wsas(wsccd,3));
      end
      
      if length(wsocu)>0
        wsss(19,1)=max(wsas(wsocu,2)-wsas(wsocu,4));
        wsss(20,1)=mean(wsas(wsocu,2)-wsas(wsocu,4));
      end
      if length(wsocd)>0
        wsss(19,2)=max(wsas(wsocd,2)-wsas(wsocd,4));
        wsss(20,2)=mean(wsas(wsocd,2)-wsas(wsocd,4));
      end
      if length(wsccu)>0
        wsss(19,4)=max(wsas(wsccu,2)-wsas(wsccu,4));
        wsss(20,4)=mean(wsas(wsccu,2)-wsas(wsccu,4));
      end
      if length(wsccd)>0
        wsss(19,5)=max(wsas(wsccd,2)-wsas(wsccd,4));
        wsss(20,5)=mean(wsas(wsccd,2)-wsas(wsccd,4));
      end
      
      if length(wsocu)>0
        wsss(22,1)=max(wsas(wsocu,4)-wsas(wsocu,3));
        wsss(23,1)=mean(wsas(wsocu,4)-wsas(wsocu,3));
      end
      if length(wsocd)>0
        wsss(22,2)=max(wsas(wsocd,4)-wsas(wsocd,3));
        wsss(23,2)=mean(wsas(wsocd,4)-wsas(wsocd,3));
      end
      if length(wsccu)>0
        wsss(22,4)=max(wsas(wsccu,4)-wsas(wsccu,3));
        wsss(23,4)=mean(wsas(wsccu,4)-wsas(wsccu,3));
      end
      if length(wsccd)>0
        wsss(22,5)=max(wsas(wsccd,4)-wsas(wsccd,3));
        wsss(23,5)=mean(wsas(wsccd,4)-wsas(wsccd,3));
      end
      
      for i=2:11
        for j=1:5
          if wsss(i,j)>=0
            eval(['fpwstat.sA',int2str(i),int2str(j),'=',int2str(wsss(i,j)),';']);
          end
        end
      end
     
      for i=13:23
        for j=1:5
          if wsss(i,j)>=0
            stringherestat=sprintf('%8.2f',wsss(i,j));
            eval(['fpwstat.sA',int2str(i),int2str(j),'=',stringherestat,';']);
          else
            eval(['fpwstat.sA',int2str(i),int2str(j),'=''NA'';']);
          end
        end
      end
      fpwstat.NewoRew='New Run';
      fpwstat.AzhuAA=AzhuAA;
      fpwstat.AzhuTD=AzhuTD;  
      fpwstat.AzhuTE=AzhuTE;
      fpwstat.Azhus2=Azhus2;
  
    elseif strcmp(outrunindex,'421')
      % run SEO - new page
      if strcmp(instruct.hdNewoRew(1:3),'New')
        th=tradeh(:,[1 2 3 9]); %[enp dire enw entime]
        thn=str2num(Azhus2);
        tdN=AzhuTD;
        ostg=zeros(length(th(:,1)),4); %[ML MW first Final];for win first: first=1;
        
        delaynumthn=str2num(AzhuTE); % preset is 0
        for i=1:length(th(:,1))
          % load and link tic data
          ticd=[];
          if tdN=='T' 
            ticd=wsgetdat(th(i,3),th(i,4)+delaynumthn/12,20);
            if length(ticd)>0
              if length(ticd(:,1))>1
                ticd=ticd(2:length(ticd(:,1)),:);  % to exclude the entry bar
              end
            end
            if thn>1 % here is the only different place to count day number in this
              % and wssetseo programs; 1 means 1 day, not as usual to include next day.
              for j=1:thn-1
                if wsfsn24([mname,name])==0
                  ticd=[ticd;wsgetdat(th(i,3)+j,4,20)];
                else
                  ticd=[ticd;wsgetdat(th(i,3)+j,0,24)];
                end
              end
            end
          else
            if th(i,4)~=4 % means not buy at open
                  % during simulation, program automatically set entry time
                  % as 4 if buy at open, and 20 for entry on close
                  % but for daily bar analysis here we perform, it is 
                  % impossible to deal with intraday entry, so It begins 
                  % its analysis from next day
              ticd=stock(min([length(stock(:,1)) th(i,3)+1+delaynumthn]):min([th(i,3)+thn+delaynumthn length(stock(:,1))]),:);
            else
              ticd=stock(min([length(stock(:,1)) th(i,3)+delaynumthn]):min([th(i,3)+thn-1+delaynumthn length(stock(:,1))]),:);
            end
          end
          ticd=th(i,2)*(ticd-th(i,1));
          % cal statistics
          if th(i,2)==1
            [Y1,I1]=min(ticd(:,3));
            [Y2,I2]=max(ticd(:,2));
            ostg(i,:)=[Y1 Y2 sign(I1-I2) ticd(length(ticd(:,1)),4)];
          else
            [Y1,I1]=min(ticd(:,2));
            [Y2,I2]=max(ticd(:,3));
            ostg(i,:)=[Y1 Y2 sign(I1-I2) ticd(length(ticd(:,1)),4)];
          end
        end
        %save -v4 tempseo thn delaynumthn tdN ostg
        fpwseo.thn=thn; fpwseo.delaynumthn=delaynumthn; fpwseo.tdN=tdN; fpwseo.ostg=ostg;
          
        % For all trades
        Fig1=figure('pos',[2 4 636/2 434/2],'color','w','visible','off');
        subplot(211)
        if sum(ostg(:,4))>0
          FFF=plot(ostg(:,1),ostg(:,4),'b.');
          set(FFF,'LineWidth',3)
          set(FFF,'Markersize',15)
        else
          FFF=plot(ostg(:,1),ostg(:,4),'r.');
          set(FFF,'LineWidth',3)
          set(FFF,'Markersize',15)
        end
        set(gca,'xcolor','b');
        set(gca,'ycolor','b');
        [ostgof1 ostgof2]=sort(-ostg(:,1));
        ostgof=ostg(ostgof2,:);
        ostgof3=cumsum(ostgof(:,4));
        [Z dddddd]=max(ostgof3);
        maxstopv=['Suggest Best Stop: ',num2str(-ostgof(dddddd,1))];
        hold on
        ddd=plot([ostgof(dddddd,1) ostgof(dddddd,1)],[max(ostg(:,4)) min(ostg(:,4))],'-r');
        set(ddd,'linewidth',3);
        hold off
        grid;
        set(gca,'color',get(gcf,'color'));
        title(['MDD Vs FE  ',num2str(length(ostg(:,1)))]);
        xlabel(['Max Draw Down in points; ',maxstopv,blanks(35)]);
        ylabel('FInal Equity in points');
        set(get(gca,'title'),'color','b');
        set(get(gca,'xlabel'),'color','b');
        set(get(gca,'ylabel'),'color','b');
           
        subplot(212)
        if sum(ostg(:,4))>0
          FFF=plot(ostg(:,2),ostg(:,4),'b.');
          set(FFF,'LineWidth',3)
          set(FFF,'Markersize',15)
        else
          FFF=plot(ostg(:,2),ostg(:,4),'r.');
          set(FFF,'LineWidth',3)
          set(FFF,'Markersize',15)
        end
        set(gca,'xcolor','b');
        set(gca,'ycolor','b');
        grid;
        set(gca,'color',get(gcf,'color'));
        title([blanks(100),'MP Vs FE ',num2str(length(ostg(:,1)))]);
        xlabel('Best Profit in points');
        ylabel('Final Equity in points');
        set(get(gca,'title'),'color','b');
        set(get(gca,'xlabel'),'color','b');
        set(get(gca,'ylabel'),'color','b');
            
        set(Fig1,'inverthardcopy','off'); hold off
        set(Fig1,'PaperPosition',[.25 .25 7.7 5]);
        cd([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern']);
        drawnow;
        wsprintjpeg(Fig1,'seojpeg1.jpeg'); 
        close(Fig1);
        clear th thn ostg ticd I1 I2 Y1 Y2 numsr tdN FFF
            
        % For Max first trades
        Fig2=figure('pos',[2 4 636/2 434/2],'color','w','visible','off');
        thn=fpwseo.thn; delaynumthn=fpwseo.delaynumthn; tdN=fpwseo.tdN; ostg=fpwseo.ostg;
        subplot(211)
        ostg1=ostg(find(ostg(:,3)==1),:);
        if sum(ostg1(:,4))>0
          FFF=plot(ostg1(:,1),ostg1(:,4),'b.');
          set(FFF,'LineWidth',3)
          set(FFF,'Markersize',15)
        else
          FFF=plot(ostg1(:,1),ostg1(:,4),'r.');
          set(FFF,'LineWidth',3)
          set(FFF,'Markersize',15)
        end
        set(gca,'color',get(gcf,'color'));
        grid;
        set(gca,'xcolor','b');
        set(gca,'ycolor','b');
        title(['Worst Drawndown hit First: ',num2str(length(ostg1(:,1)))]);
        xlabel(['Worst drawdown in points',blanks(35)]);ylabel('Final Equity in points');
        set(get(gca,'title'),'color','b');
        set(get(gca,'xlabel'),'color','b');
        set(get(gca,'ylabel'),'color','b');
                 
        subplot(212)
        if sum(ostg1(:,4))>0
          FFF=plot(ostg1(:,1),ostg1(:,2),'b.');
          set(FFF,'LineWidth',3)
          set(FFF,'Markersize',15)
        else
          FFF=plot(ostg1(:,1),ostg1(:,2),'r.');
          set(FFF,'LineWidth',3)
          set(FFF,'Markersize',15)
        end
        set(gca,'color',get(gcf,'color'));
        grid;
        set(gca,'xcolor','b');
        set(gca,'ycolor','b');
        title([blanks(100),'Worst Drawndown hit First: ',num2str(length(ostg1(:,1)))]);
        xlabel('Worst drawndown in points');ylabel('Best profit');
        set(get(gca,'title'),'color','b');
        set(get(gca,'xlabel'),'color','b');
        set(get(gca,'ylabel'),'color','b');
        
        set(Fig2,'inverthardcopy','off'); hold off
        set(Fig2,'PaperPosition',[.25 .25 7.7 5]);
        cd([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern']);
        drawnow;
        wsprintjpeg(Fig2,'seojpeg2.jpeg'); 
        close(Fig2);
        clear th thn ostg ostg1 ticd I1 I2 Y1 Y2 numsr tdN FFF
    
        % For Max first trades
        Fig3=figure('pos',[2 4 636/2 434/2],'color','w','visible','off');
        thn=fpwseo.thn; delaynumthn=fpwseo.delaynumthn; tdN=fpwseo.tdN; ostg=fpwseo.ostg;     
        subplot(211)
        ostg1=ostg(find(ostg(:,3)==-1),:);
        if sum(ostg1(:,4))>0
          FFF=plot(ostg1(:,2),ostg1(:,4),'b.');
          set(FFF,'LineWidth',3)
          set(FFF,'Markersize',15)
        else
          FFF=plot(ostg1(:,2),ostg1(:,4),'r.');
          set(FFF,'LineWidth',3)
          set(FFF,'Markersize',15)
        end
        set(gca,'color',get(gcf,'color'));
        grid;
        set(gca,'xcolor','b');
        set(gca,'ycolor','b');
        title(['Best Profit hit First: ',num2str(length(ostg1(:,1)))]);
        xlabel(['Best profit in points',blanks(35)]);ylabel('Final Equity in points');
        set(get(gca,'title'),'color','b');
        set(get(gca,'xlabel'),'color','b');
        set(get(gca,'ylabel'),'color','b');
        
        subplot(212)
        if sum(ostg1(:,4))>0
          FFF=plot(ostg1(:,2),ostg1(:,1),'b.');
          set(FFF,'LineWidth',3)
          set(FFF,'Markersize',15)
        else
          FFF=plot(ostg1(:,2),ostg1(:,1),'r.');
          set(FFF,'LineWidth',3)
          set(FFF,'Markersize',15)
        end
        set(gca,'color',get(gcf,'color'));
        grid;
        set(gca,'xcolor','b');
        set(gca,'ycolor','b');
        title([blanks(100),'Best Profit hit First: ',num2str(length(ostg1(:,1)))]);
        xlabel('Best profit in points');ylabel('Worst drawndown in points');
        set(get(gca,'title'),'color','b');
        set(get(gca,'xlabel'),'color','b');
        set(get(gca,'ylabel'),'color','b');
        
        set(Fig3,'inverthardcopy','off'); hold off
        set(Fig3,'PaperPosition',[.25 .25 7.7 5]);
        cd([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern']);
        drawnow;
        wsprintjpeg(Fig3,'seojpeg3.jpeg'); 
        close(Fig3);
        clear th thn ostg ostg1 ticd I1 I2 Y1 Y2 numsr tdN FFF
      end
      fpwstat.seojpeg1=[fpwclientdirectory,fpwusername,'\pattern\seojpeg1.jpeg'];
      fpwstat.seojpeg2=[fpwclientdirectory,fpwusername,'\pattern\seojpeg2.jpeg'];
      fpwstat.seojpeg3=[fpwclientdirectory,fpwusername,'\pattern\seojpeg3.jpeg'];
      if str2num(AzhuTE)>1
        fpwstat.delaynumthn=[AzhuTE,' bars'];
      elseif str2num(AzhuTE)==1
        fpwstat.delaynumthn='1 bar';   
      elseif str2num(AzhuTE)==0
        fpwstat.delaynumthn='no bar';       
      end
      fpwstat.ZZxy=['Market ',upper([mname,name])];
      if AzhuTD=='T'
        fpwstat.tdN='Tick';
      else
        fpwstat.tdN='Daily';
      end
      fpwstat.NewoRew=instruct.hdNewoRew;
      
    elseif strcmp(outrunindex,'422')
      % run SO Mesh - new page
      if strcmp(instruct.hdNewoRew(1:3),'New')
        th=tradeh(:,[1 2 3 9]); %[enp dire enw entime]
        thn=str2num(Azhus2);
        tdN=AzhuTD;
        tickstep=wsts(name);unitnet=wsun(name);
        %wsstgo=tickstep*([20:2:40,45:5:75,80:10:140,150:25:200]);
        wsstgo=2*tickstep*([20:2:40,45:5:75,80:10:140,150:25:200]);
        wsstgs=tickstep*([10:2:30,35:5:65,70:10:130,140:25:190]);
        ostg=zeros(length(wsstgo),length(wsstgs)); 
        delaynumthn=str2num(AzhuTE); % preset is 0
        for i=1:length(th(:,1))
          % load-link tic data
          ticd=[];
          if tdN=='T' 
            ticd=wsgetdat(th(i,3),th(i,4)+delaynumthn/12,20);
         
            if length(ticd)>0
              if length(ticd(:,1))>1
                ticd=ticd(2:length(ticd(:,1)),:);  % to exclude the entry bar
              end    
            end
            if thn>1 % here is the only different place to count day number in this
                 % and wssetstg programs; 1 means 1 day, not as usual to include next day.
              for j=1:thn-1
                if wsfsn24([mname,name])==0
                  ticd=[ticd;wsgetdat(th(i,3)+j,4,20)];
                else
                  ticd=[ticd;wsgetdat(th(i,3)+j,0,24)];
                end                  
              end
            end
          else
            if th(i,4)~=4
              ticd=stock(min([length(stock(:,1)) th(i,3)+1+delaynumthn]):min([th(i,3)+thn+delaynumthn length(stock(:,1))]),:);
            else
              ticd=stock(min([length(stock(:,1)) th(i,3)+delaynumthn]):min([th(i,3)+thn-1+delaynumthn length(stock(:,1))]),:);
            end
          end
          ticd=th(i,2)*(ticd-th(i,1));
          % cal statistics
          for k=1:length(wsstgo)
            for l=1:length(wsstgs)
              if th(i,2)==1
                 
                I1=find(ticd(2:length(ticd(:,1)),2)-wsstgo(k)>=0);
                I2=find(ticd(2:length(ticd(:,1)),3)+wsstgs(l)<=0);
                   
                if length(I1)~=0
                  Y1=I1(1)+1;
                else
                  Y1=length(ticd(:,1))+1;
                end
                if length(I2)~=0
                  Y2=I2(1)+1;
                else
                  Y2=length(ticd(:,1))+1;
                end
                      
                if (Y2>Y1)
                  ostg(k,l)=max([ticd(Y1,1) wsstgo(k)])+ostg(k,l);
                elseif (Y2<Y1)
                  ostg(k,l)=min([ticd(Y2,1) -wsstgs(l)])+ostg(k,l);
                elseif (Y2==Y1)
                  if Y1~=length(ticd(:,1))+1;
                    ostg(k,l)=min([ticd(Y2,1) -wsstgs(l)])+ostg(k,l);
                  else
                    ostg(k,l)=ticd(length(ticd(:,1)),4)+ostg(k,l);
                  end
                end
                 
              else
                 
                I1=find(ticd(2:length(ticd(:,1)),3)-wsstgo(k)>=0);
                I2=find(ticd(2:length(ticd(:,1)),2)+wsstgs(l)<=0);
                   
                if length(I1)~=0
                  Y1=I1(1)+1;
                else
                  Y1=length(ticd(:,1))+1;
                end
                if length(I2)~=0
                  Y2=I2(1)+1;
                else
                  Y2=length(ticd(:,1))+1;
                end
                   
                if (Y2>Y1)
                  ostg(k,l)=max([ticd(Y1,1) wsstgo(k)])+ostg(k,l);
                elseif (Y2<Y1)
                  ostg(k,l)=min([ticd(Y2,1) -wsstgs(l)])+ostg(k,l);
                elseif (Y2==Y1)
                  if Y1~=length(ticd(:,1))+1;
                    ostg(k,l)=min([ticd(Y2,1) -wsstgs(l)])+ostg(k,l);
                  else
                    ostg(k,l)=ticd(length(ticd(:,1)),4)+ostg(k,l);
                  end
                end
              end
            end
          end
        end
        ostg=(ostg*unitnet-75*length(tradeh(:,1)))/1000;bestpi=maxmat(ostg);
        bestp=sprintf('MFE:%8.3f, Obje:%6.3f, Stop:%6.3f',[bestpi(1),wsstgo(bestpi(2)),wsstgs(bestpi(3))]);
        
        fpwsos.wsstgo=wsstgo; fpwsos.wsstgs=wsstgs; fpwsos.ostg=ostg; fpwsos.thn=thn; 
        fpwsos.delaynumthn=delaynumthn; fpwsos.tdN=tdN; fpwsos.bestp=bestp;
        eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwsosdat fpwsos']);
        
        Fig1=figure('pos',[2 4 635 434],'color','w','visible','off');
        mesh(wsstgo,wsstgs,ostg);%grid;
        view(-37,30);
        xlabel('objective');
        ylabel('stop');
        zlabel('final equity in K');
        set(gca,'xcolor','b');
        set(gca,'ycolor','b');
        set(gca,'zcolor','b');
        set(get(gca,'xlabel'),'color','b');
        set(get(gca,'ylabel'),'color','b');
        set(get(gca,'zlabel'),'color','b');
        clear th thn ostg ticd I1 I2 Y1 Y2 numsr i j k l bestpi wsstgo wsstgs delaynumthn tdN
        set(gcf,'color','w');
        set(gca,'color','w');
        set(Fig1,'inverthardcopy','off'); hold off
        set(Fig1,'PaperPosition',[.25 .25 7.7 5]);
        cd([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern']);
        drawnow;
        wsprintjpeg(Fig1,'sosjpeg1.jpeg'); 
        close(Fig1);
        
        fpwstat.sosjpeg1=[fpwclientdirectory,fpwusername,'\pattern\sosjpeg1.jpeg'];
        fpwstat.AZ='-37';
        fpwstat.EL='30';     
        fpwstat.bestp=bestp;
        if str2num(AzhuTE)>1
          fpwstat.delaynumthn=[AzhuTE,' bars'];
        elseif str2num(AzhuTE)==1
          fpwstat.delaynumthn='1 bar';   
        elseif str2num(AzhuTE)==0
          fpwstat.delaynumthn='no bar';       
        end
        fpwstat.ZZxy=['Market ',upper([mname,name])];
        if AzhuTD=='T'
          fpwstat.tdN='Tick';
        else
          fpwstat.tdN='Daily';
        end
        fpwstat.NewoRew=instruct.hdNewoRew;
      else
        fpwstat.sosjpeg1=[fpwclientdirectory,fpwusername,'\pattern\sosjpeg1.jpeg'];
        fpwstat.AZ='-37';
        fpwstat.EL='30'; 
        eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwsosdat']);
        wsstgo=fpwsos.wsstgo; wsstgs=fpwsos.wsstgs; ostg=fpwsos.ostg; thn=fpwsos.thn; 
        delaynumthn=fpwsos.delaynumthn; tdN=fpwsos.tdN; bestp=fpwsos.bestp;
        Fig1=figure('pos',[2 4 635 434],'color','w','visible','off');
        mesh(wsstgo,wsstgs,ostg);%grid;
        view(str2num(fpwstat.AZ),str2num(fpwstat.EL));
        xlabel('objective');
        ylabel('stop');
        zlabel('final equity in K');
        set(gca,'xcolor','b');
        set(gca,'ycolor','b');
        set(gca,'zcolor','b');
        set(get(gca,'xlabel'),'color','b');
        set(get(gca,'ylabel'),'color','b');
        set(get(gca,'zlabel'),'color','b');
        set(gcf,'color','w');
        set(gca,'color','w');
        set(Fig1,'inverthardcopy','off'); hold off
        set(Fig1,'PaperPosition',[.25 .25 7.7 5]);
        cd([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern']);
        drawnow;
        wsprintjpeg(Fig1,'sosjpeg1.jpeg'); 
        close(Fig1);
        
        fpwstat.bestp=bestp;
        fpwstat.delaynumthn=fpwsos.delaynumthn;       
        fpwstat.ZZxy=['Market ',upper([mname,name])];
        if tdN=='T'
          fpwstat.tdN='Tick';
        else
          fpwstat.tdN='Daily';
        end
        fpwstat.NewoRew=instruct.hdNewoRew;                 
      end
    end
  else
    eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwsosdat']);
    wsstgo=fpwsos.wsstgo; wsstgs=fpwsos.wsstgs; ostg=fpwsos.ostg; thn=fpwsos.thn; 
    delaynumthn=fpwsos.delaynumthn; tdN=fpwsos.tdN; bestp=fpwsos.bestp;
    
    Fig1=figure('pos',[2 4 635 434],'color','w','visible','off');
    mesh(wsstgo,wsstgs,ostg);%grid;
    view(str2num(instruct.AZ),str2num(instruct.EL));
    xlabel('objective');
    ylabel('stop');
    zlabel('final equity in K');
    set(gca,'xcolor','b');
    set(gca,'ycolor','b');
    set(gca,'zcolor','b');
    set(get(gca,'xlabel'),'color','b');
    set(get(gca,'ylabel'),'color','b');
    set(get(gca,'zlabel'),'color','b');
    set(gcf,'color','w');
    set(gca,'color','w');
    set(Fig1,'inverthardcopy','off'); hold off
    set(Fig1,'PaperPosition',[.25 .25 7.7 5]);
    cd([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern']);
    drawnow;
    wsprintjpeg(Fig1,'sosjpeg1.jpeg'); 
    close(Fig1);
        
    fpwstat.sosjpeg1=[fpwclientdirectory,fpwusername,'\pattern\sosjpeg1.jpeg'];
    fpwstat.delaynumthn=instruct.delaynumthn;
    fpwstat.ZZxy=instruct.ZZxy;
    fpwstat.tdN=instruct.tdN;
    fpwstat.NewoRew=instruct.NewoRew;    
    fpwsource=instruct.fpwsource;
    outrunindex=instruct.outrunindex;
    fpwstat.AZ=instruct.AZ;
    fpwstat.EL=instruct.EL;  
    fpwstat.bestp=bestp;
  end
  fpwstat.fpwusername=fpwusername;
  fpwstat.fpwusername4=fpwusername4;
  fpwstat.fpwulvl=instruct.fpwulvl;
  fpwstat.fpwsource=fpwsource;
  fpwstat.outrunindex=outrunindex;

  cd(fpwserverplace);
  cids=fpwloginstatus(fpwusername,clock);
  
  if strcmp(outrunindex,'42')      
    templatefile = which('wbfpwstat.html');    
    if (nargin == 1)
      retstr = htmlrep(fpwstat, templatefile);     
    elseif (nargin == 2)
      retstr = htmlrep(fpwstat, templatefile, outfile);
    end 
  elseif strcmp(outrunindex,'421')      
    templatefile = which('wbfpwseo.html');    
    if (nargin == 1)
      retstr = htmlrep(fpwstat, templatefile);     
    elseif (nargin == 2)
      retstr = htmlrep(fpwstat, templatefile, outfile);
    end 
  elseif strcmp(outrunindex,'422')      
    templatefile = which('wbfpwsomesh.html');    
    if (nargin == 1)
      retstr = htmlrep(fpwstat, templatefile);     
    elseif (nargin == 2)
      retstr = htmlrep(fpwstat, templatefile, outfile);
    end 
  end
end