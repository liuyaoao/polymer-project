function retstr = wbstmmct(instruct, outfile)

% Author(s): N. Zhu, 11-15-2003
% This is a WB (Web-Based) mirror program to <wsrzc2.m> in desktop version

wbfpwbasic;
cd(fpwserverplace);
retstr = char('');
fpwusername=instruct.mlid{1};
fpwCPAL=0;
fpwloginIP='192.168.2.8';
fpwcheckil;

if fpwcheckilpass==1

WhereOrderFrom=instruct.WhereOrderFrom;

fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
fseek(fid1,-50,1); fprintf(fid1,[time,' MMCT: \n']); fclose(fid1);
clear fid1

cd([Wherematlab,'pattern']);

if ~(strcmp(WhereOrderFrom,'INDX'))

  if strcmp(WhereOrderFrom,'SLFE')
    name1=noempty(instruct.fpwsymbol1);
    name2=noempty(instruct.fpwsymbol2);
    name3=noempty(instruct.fpwsymbol3);
    name4=noempty(instruct.fpwsymbol4);
    mname1=instruct.hdfpwfstype1;  
    mname2=instruct.hdfpwfstype2;  
    mname3=instruct.hdfpwfstype3;  
    mname4=instruct.hdfpwfstype4;  
    FirstorS=str2num(instruct.FirstorS);
    fpwmmctspan=instruct.fpwmmctspan;
  end

  global mname datem
  j=0;
  for i=1:4
    j=j+1;
    eval(['name=name',num2str(i),';']);   
    eval(['mname=mname',num2str(i),';']); 
    if (length(name)==0)|(length(name)>6)
      j=j-1;  
    else
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
        j=j-1;  
      else
        eval(['stock',num2str(j),'=stock;']);
        eval(['datem',num2str(j),'=datem;']);     
        eval(['name',num2str(j),'=name;']);    
        eval(['mname',num2str(j),'=mname;']);            
      end
    end
  end
  if j>1
    for i=2:j    
      eval(['stock5=stock',int2str(i),';']); eval(['datem5=datem',int2str(i),';']);
      if length(stock5(:,1))>length(stock1(:,1))
        stock5=stock5(length(stock5(:,1))-length(stock1(:,1))+1:length(stock5(:,1)),:);
        datem5=datem5(length(datem5(:,1))-length(datem1(:,1))+1:length(datem5(:,1)),:);
      elseif length(stock5(:,1))<length(stock1(:,1))
        stock5=[ones(length(stock1(:,1))-length(stock5(:,1)),5)*stock5(1,4);stock5];
        datem5=[[ones(length(datem1(:,1))-length(datem5(:,1)),1)*datem5(1,1) ones(length(datem1(:,1))-length(datem5(:,1)),1)*datem5(1,2) ones(length(datem1(:,1))-length(datem5(:,1)),1)*datem5(1,3)];datem5];
      end
      eval(['stock',int2str(i),'=stock5;']); eval(['datem',int2str(i),'=datem5;'])
    end
    clear stock5 datem5
  end
  
  if j==0
    error(' No right symbol entered.')   
  end

  if j<4
    uniname='UrSym';      
    for k=j+1:4
      eval(['mname',num2str(k),'=mname1;']);
      eval(['name',num2str(k),'=uniname;']);
    end
    clear uniname
  end
  
  if (FirstorS==0) % FirstorS is used to control scope range, reset to 0 by fpwsymbol on change, to 1 by GO button
    fpwmmctspan='DD';
    fpwmmctft1=[1 length(datem1(:,1))];
  else    
    fpwFdate=instruct.fpwFdate;
    slplace=find(fpwFdate=='/');
    if length(slplace)~=2
      slplace=find(fpwFdate=='-');
      if length(slplace)~=2
        error(' Entered a wrong start F date');
      end
    end
    startd=[str2num(fpwFdate(1:slplace(1)-1)) str2num(fpwFdate(slplace(1)+1:slplace(2)-1)) str2num(fpwFdate(slplace(2)+1:length(fpwFdate)))];
    datecheck(startd,1);
    fpwTdate=instruct.fpwTdate;    
    slplace=find(fpwTdate=='/');
    if length(slplace)~=2
      slplace=find(fpwTdate=='-');
      if length(slplace)~=2
        error(' Entered a wrong start T date');
      end
    end
    endd=[str2num(fpwTdate(1:slplace(1)-1)) str2num(fpwTdate(slplace(1)+1:slplace(2)-1)) str2num(fpwTdate(slplace(2)+1:length(fpwTdate)))];
    datecheck(endd,1); 
    
    fpwmmctft1(1)=datef2(startd,datem1);
    fpwmmctft1(2)=datef2(endd,datem1);
    if fpwmmctft1(1)>fpwmmctft1(2)
      fpwmmctft1=fpwmmctft1([2 1]);
    end
  end
  
  if j>1
    for i=2:j
      eval(['startth=datef2(datem1(fpwmmctft1(1),:),datem',num2str(i),');']);      
      eval(['endth=datef2(datem1(fpwmmctft1(2),:),datem',num2str(i),');']);
      eval(['fpwmmctft',num2str(i),'=[startth endth];']);
      %eval(['datem',num2str(i),'=datem',num2str(i),'(startth:endth,:);']);
      %eval(['stock',num2str(i),'=stock',num2str(i),'(startth:endth,:);']);      
    end    
  end
  Datem=datem1;

  % firstly find out the raw [stock datem]
  ToD=fpwmmctspan(1);
  for k=1:j
    eval(['mname=mname',num2str(k),';']);
    eval(['name=name',num2str(k),';']);
    eval(['stock=stock',num2str(k),';']);
    eval(['datem=datem',num2str(k),';']);
    eval(['fpwmmctft=fpwmmctft',num2str(k),';']);
    if ToD=='D'
      stock=stock(fpwmmctft(1):fpwmmctft(2),:);
      datem=datem(fpwmmctft(1):fpwmmctft(2),:);
      if fpwmmctspan(2)=='W'
        datetemp=daynum1(datem(1,:));
        stocktemp=stock(1,:);
        stockNEW=[];datemNEW=[];
        for i=2:length(stock(:,1))
          WrNEW=daynum1(datem(i,:)); 
          if WrNEW>datetemp
            stocktemp=[stocktemp;stock(i,:)];
          else
            datemNEW=[datemNEW;datem(i-1,:)];
            stockNEW=[stockNEW;wsohlcv(stocktemp)];
            stocktemp=stock(i,:);
          end
          datetemp=WrNEW;
        end
        datemNEW=[datemNEW;datem(i,:)];
        stockNEW=[stockNEW;wsohlcv(stocktemp)];
        stock=stockNEW;datem=datemNEW;
        clear datemNEW stockNEW datetemp stocktemp i WrNEW
      elseif fpwmmctspan(2)=='M'
        datetemp=datem(1,:);
        stocktemp=stock(1,:);
        stockNEW=[];datemNEW=[];
        for i=2:length(stock(:,1))
          if (datetemp(1)==datem(i,1))&(datetemp(3)==datem(i,3))
            stocktemp=[stocktemp;stock(i,:)];
          else
            datemNEW=[datemNEW;datem(i-1,:)];
            stockNEW=[stockNEW;wsohlcv(stocktemp)];
            datetemp=datem(i,:);
            stocktemp=stock(i,:);
          end
        end
        datemNEW=[datemNEW;datem(i,:)];
        stockNEW=[stockNEW;wsohlcv(stocktemp)];
        stock=stockNEW;datem=datemNEW;
        clear datemNEW stockNEW datetemp stocktemp i
      end   
    else
      tickind=str2num(fpwmmctspan(2:3));
      edate=datem(fpwmmctft(1),:);
      if (k~=1)&(strcmp(name,name1))
        edate=datem(fpwmmctft1(2),:);       
      end
      howmanybartoquot=tickind/5*115;
      stocklongdata=0;
      if howmanybartoquot==115
        if upper(mname)=='F'
          if wsfsn24(['f',name])==0
            stock=wsgettdt(edate,2,20,['f',name],0);
          else
            stock=wsgettdt(edate,0,24,['f',name],0);    
          end
        else
          if wsfsn24(['s',name])==0
            stock=wsgettdt(edate,2,20,['s',name],0);
          else
            stock=wsgettdt(edate,0,24,['s',name],0);    
          end
          if length(stock)==0
            stock=stgetdaa(name,'t'); %,tickind/5*142);
            stocklongdata=1;    
            if length(stock)>0
              fffff=find((stock(:,1)==edate(1))&(stock(:,2)==edate(2))&(stock(:,3)==edate(3)));
              if length(fffff)>0
                datemfroms=stock(fffff(1),1:3);
                stock=stock(max([fffff(1)-30 1]):min([fffff(length(fffff))+30 length(stock(:,1))]),:);
              else
                stock=stock(1:min([tickind/5*142 length(stock(:,1))]),:); 
                datemfroms=stock(1,1:3);
              end    
              datemends=stock(length(stock(:,1)),1:3);
            end          
          end
        end
        if length(stock)>0
          datemt=[ones(2,3);[stock(:,4) stock(:,5) stock(:,2)]];
          stockt=[stock(1:2,6:10);stock(:,6:10)];
          datemt=[datemt 0*datemt(:,1)];
          stockt(:,5)=stockt(:,5)*1000;
        end 
      else
        if upper(mname)=='F'
          if wsfsn24(['f',name])==0
            stock=wsgettdn(edate,2,howmanybartoquot,['f',lower(name)],0);
          else
            stock=wsgettdn(edate,0,howmanybartoquot,['f',lower(name)],0);
          end
        else
          if wsfsn24(['s',name])==0
            stock=wsgettdn(edate,2,howmanybartoquot,['s',lower(name)],0);
          else
            stock=wsgettdn(edate,0,howmanybartoquot,['s',lower(name)],0);
          end
          if length(stock)==0
            stock=stgetdaa(name,'t'); %,tickind/5*142);
            stocklongdata=1;
            if length(stock)>0
              fffff=find((stock(:,1)==edate(1))&(stock(:,2)==edate(2))&(stock(:,3)==edate(3)));
              if length(fffff)>0
                stock=stock(fffff(1):min([fffff(1)+tickind/5*142 length(stock(:,1))]),:);
              else
                stock=stock(1:min([tickind/5*142 length(stock(:,1))]),:); 
              end                  
              datemfroms=stock(1,1:3);    
              datemends=stock(length(stock(:,1)),1:3);            
            end
          end
        end
        if length(stock)>0
          stockt=[];datemt=[];indexf=1;
          for i=2:length(stock(:,1))  
            if (rem(stock(i,5),tickind)==0)
              stockt=[stockt;wsohlcv(stock(indexf:i,6:10))];
              datemt=[datemt;[stock(i,4) stock(i,5) stock(i,2)]];
              indexf=i+1;
            else
              if (stock(i-1,2)~=stock(i,2))&(indexf<i)
                stockt=[stockt;wsohlcv(stock(indexf:i-1,6:10))];
                datemt=[datemt;[stock(i-1,4) stock(i-1,5) stock(i-1,2)]];
                indexf=i;
              end
            end
          end
          datemt=[ones(2,3);datemt];
          stockt=[stockt(1:2,:);stockt];
          datemt=[datemt 0*datemt(:,1)];
          indexf=0;
          for i=4:length(datemt(:,1))
            if datemt(i,3)~=datemt(i-1,3)
              indexf=indexf+1;
            end
            datemt(i,4)=indexf;
          end
          stockt(:,5)=stockt(:,5)*1000;
        end
      end
      if length(stock)==0
        if upper(mname)=='S'
          stock=stgetdaa(name,'t',tickind/5*115);
          if length(stock)>0
            datemt=[ones(2,3);stock(:,[4 5 2])];
            stockt=[stock(1:2,6:10);stock(:,6:10)];
            stockt(:,5)=stockt(:,5)*100;
            datemt=[datemt 0*datemt(:,1)];
          else
            error(' Tick Data not Available for the symbol you entered.');
          end
        else 
          error(' Tick Data not Available for the symbol you entered.');        
        end
      end
      stock=stockt;
      datem=datemt;
    end
    eval(['stock',num2str(k),'=stock;']);
    eval(['datem',num2str(k),'=datem;']);
  end
  
  % figure output
  Fig1=figure('pos',[2 4 635 434],'color','k','visible','off');
  zhum1r=axes('position',[0.091 0.530 0.89 0.40]);
  zhum2r=axes('position',[0.091 0.061 0.89 0.40]);
  zhum3r=axes('position',[0.0001 0.0001 .00001 .00001]);
  zhum4r=axes('position',[0.0001 0.0001 .00001 .00001]);
  if j==4
    set(zhum1r,'position',[0.075 0.750 0.9 0.22]);
    set(zhum2r,'position',[0.075 0.512 0.9 0.185]);
    set(zhum3r,'position',[0.075 0.275 0.9 0.185]);
    set(zhum4r,'position',[0.075 0.041 0.9 0.185]);
  elseif j==3
    set(zhum1r,'position',[0.075 0.690 0.9 0.28]);
    set(zhum2r,'position',[0.075 0.381 0.9 0.25]);
    set(zhum3r,'position',[0.075 0.061 0.9 0.25]);
    set(zhum4r,'position',[0.0001 0.0001 .00001 .00001]);
  elseif j==2
    set(zhum1r,'position',[0.075 0.530 0.9 0.44]);
    set(zhum2r,'position',[0.075 0.061 0.9 0.40]);
    set(zhum3r,'position',[0.0001 0.0001 .00001 .00001]);
    set(zhum4r,'position',[0.0001 0.0001 .00001 .00001]);
  elseif j==1
    set(zhum1r,'position',[0.075 0.0610 0.9 0.91]);
    set(zhum2r,'position',[0.0001 0.9999 .00001 .00001]);
    set(zhum3r,'position',[0.0001 0.0001 .00001 .00001]);
    set(zhum4r,'position',[0.0001 0.0001 .00001 .00001]);
  end

  for k=1:j
    eval(['mname=mname',num2str(k),';']);
    eval(['name=name',num2str(k),';']);
    eval(['stock=stock',num2str(k),';']);
    eval(['datem=datem',num2str(k),';']); 
    eval(['subplot(zhum',num2str(k),'r);']);
    hold off;
    if ToD=='D'
      if length(stock(:,1))<146
        %wsbar(stock,datem);
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
        for I=1:yrs
        % above four lines were ever used to locate bad date data
          if (dn(datem(I,:))~=5)|(fpwmmctspan(2)~='D')
            intradayc='g';
            if (fpwmmctspan(2)=='W')
              if weekfd(datem(I+1,:),1)==1
                intradayc='w';   
              else
                intradayc='g';               
              end
            elseif (fpwmmctspan(2)=='M')
              if datem(I,3)~=datem(I+1,3)
                intradayc='w';   
              else
                intradayc='g';               
              end
            end
          else
            intradayc='w';        
          end           
          plot(X(I,:),line(I,:),intradayc,'linewidth',.125);
          plot(X4(I,:),line2(I,:),intradayc,'linewidth',.125)
          plot(X5(I,:),line1(I,:),intradayc,'linewidth',.125)  
        end
        datem(1:length(datem(:,1))-1,:)=datem(2:length(datem(:,1)),:);
        chgst93(datem);
      else
        plot(stock(:,4),'g');
        chgst93(datem);
      end
      ylabel([upper(name),' - Price']);
      %grid; set(gca,'Xcolor',[0.5 0.5 0.5]);
      %set(gca,'Ycolor',[0.5 0.5 0.5]);
    else
      if length(stock(:,1))<149*2
        %wsbart1(stock,datem,tTry);
        yrs=length(stock(:,1))-1;
        stock(1:yrs,:)=stock(2:yrs+1,:);
        x=[1:yrs];
        closeh=stock(:,4); high=stock(:,2); low=stock(:,3);
        open=stock(:,1); vol=stock(:,5)/1000+.01;
        X1=1:yrs; X2=X1-.35; X3=X1+.35;
        X(1:yrs,1:2)=[X1' X1']; X4(1:yrs,1:2)=[X2' X1']; X5(1:yrs,1:2)=[X1' X3'];
        line(1:yrs,1:2)=[low(2:yrs+1) high(2:yrs+1)];
        line1(1:yrs,1:2)=[closeh(2:yrs+1) closeh(2:yrs+1)];
        line2(1:yrs,1:2)=[open(2:yrs+1) open(2:yrs+1)];
        plot(x(1),closeh(2),'k');hold on;
        intradayc='g';daychangep=1;
        if tickind==5
          numbercolumn=1; 
        else
          numbercolumn=4; 
        end
        %save temphere datem 
        for I=1:yrs-1
          if datem(I+1,3)~=datem(I+2,3); daychangep=I; end
          if (datem(I+1,numbercolumn)~=datem(max([1 I+2]),numbercolumn))&(I>1)
            intradayc='w';        
          else
            intradayc='g';        
          end           
          plot(X(I,:),line(I,:),intradayc,'linewidth',.125);
          plot(X4(I,:),line2(I,:),intradayc,'linewidth',.125)
          plot(X5(I,:),line1(I,:),intradayc,'linewidth',.125)           
        end 
        datem(1:length(datem(:,1))-1,:)=datem(2:length(datem(:,1)),:);
        datem(1:length(datem(:,1))-1,:)=datem(2:length(datem(:,1)),:);
        chgstt1(datem);
      else    
        plot(stock(:,4),'g');chgstt1(datem)
      end
      ylabel([upper(name),' - Price']);
    end
    if k==1
      set(zhum1r,'color',get(gcf,'color'));
      grid;
      set(zhum1r,'xcolor',[0.5 0.5 0.5]);
      set(zhum1r,'ycolor',[0.5 0.5 0.5]);
    end
    if k==2
      set(zhum2r,'color',get(gcf,'color'));
      grid;
      set(zhum2r,'xcolor',[0.5 0.5 0.5]);
      set(zhum2r,'ycolor',[0.5 0.5 0.5]);
    end    
    if k==3
      set(zhum3r,'color',get(gcf,'color'));
      grid;
      set(zhum3r,'xcolor',[0.5 0.5 0.5]);
      set(zhum3r,'ycolor',[0.5 0.5 0.5]);
    end    
    if k==4
      set(zhum4r,'color',get(gcf,'color'));
      grid;
      set(zhum4r,'xcolor',[0.5 0.5 0.5]);
      set(zhum4r,'ycolor',[0.5 0.5 0.5]);
    end    
  end
  ftzn=figtext(0.7,0.982,['Copyright ',datestr(now,10),' WSQSI, http://www.WSQSI.com/']);
  set(ftzn,'color',[0.5 0.5 0.5],'fontsize',7);  
  set(Fig1,'inverthardcopy','off'); hold off
  set(Fig1,'PaperPosition',[.25 .25 7.5 5.5]);
  cd([fpwserverplace,fpwclientdirectory,fpwusername,'\stock']);
  Plotfileh=[fpwclientdirectory,fpwusername,'\stock\wbstmmct.jpeg'];
  drawnow;
  wsprintjpeg(Fig1,'wbstmmct.jpeg');
  close(Fig1);
  s.MMChartjpeg=Plotfileh; 
  s.fpwusername=fpwusername;
  s.fpwusername4=fpwusername4;
  s.FSfpwfstype1=mname1;
  s.FSfpwsymbol1=name1;
  s.FSfpwfstype2=mname2;
  s.FSfpwsymbol2=name2;
  s.FSfpwfstype3=mname3;
  s.FSfpwsymbol3=name3;
  s.FSfpwfstype4=mname4;
  s.FSfpwsymbol4=name4;
  s.FSFirstorS='1';
  %if stocklongdata==1 
  %  s.FSfpwFdate=date2str(datemfroms);
  %  s.FSfpwTdate=date2str(datemends);            
  %else
    s.FSfpwFdate=date2str(Datem(fpwmmctft1(1),:));
    s.FSfpwTdate=date2str(Datem(fpwmmctft1(2),:));
  %end
  s.FSfpwmmctspan=fpwmmctspan; 
  datestringout=[];
  for i=1:length(Datem(:,1))
    datestringout=[datestringout,sprintf('%02d%02d%02d',Datem(i,1:3))];
  end
  s.FSmmctdatem=datestringout;
  s.FSfpwfindex=num2str(fpwmmctft1(1));
  s.FSfpwtindex=num2str(fpwmmctft1(2));
  s.fpwMXI=num2str(length(Datem(:,1)));  
  eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\fpwstmmct s stock datem']);
else
  if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\stock\fpwstmmct.mat'])==2
    eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\fpwstmmct']);
  else
    s.fpwusername=fpwusername;
    s.fpwusername4=fpwusername4;
    s.FSfpwfstype1='S';
    s.FSfpwsymbol1='UrSym'; 
    s.FSfpwfstype2='S';
    s.FSfpwsymbol2='UrSym';  
    s.FSfpwfstype3='S';
    s.FSfpwsymbol3='UrSym';  
    s.FSfpwfstype4='S';
    s.FSfpwsymbol4='UrSym';      
    s.FSFirstorS='0';
    s.MMChartjpeg=[fpwclientdirectory,fpwusername,'\stock\wbstmmct.jpeg'];
    s.FSfpwFdate='01/03/90';
    s.FSfpwTdate='09/11/01';
    s.FSfpwmmctspan='DD';
    s.FSmmctdatem='010101010201010301010401010501010601070101';
    s.FSfpwfindex='1';
    s.FSfpwtindex='1';
    s.fpwMXI='1';
  end
end 
s.FDTimeh=time;
s.fpwusername=fpwusername;
s.fpwusername4=fpwusername4;
s.fpwulvl=instruct.fpwulvl;

cd(fpwserverplace);
cids=fpwloginstatus(fpwusername,clock);
if ~(strcmp(upper(fpwusername(1:4)),'USER'))
  templatefile = which('wbstmmct.html');
else
  templatefile = which('wbstmmct_nlink.html');
end
if (nargin == 1)
  retstr = htmlrep(s, templatefile);
elseif (nargin == 2)
  retstr = htmlrep(s, templatefile, outfile);
end 
end