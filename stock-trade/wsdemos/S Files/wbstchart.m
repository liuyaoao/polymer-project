function retstr = wbstchart(instruct, outfile)

% Author(s): N. Zhu, 11-15-2003
% This is a WB (Web-Based) mirror program to <wsrawz*.m> in desktop version

wbfpwbasic;
% global name stock datem
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
      WhereCTPThere=str2num(instruct.WhereCTPT);
      if WhereCTPThere==0
        mnamehere=instruct.hdfpwfstype;  
      else
        if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwfrontout.mat'])==2
          eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwfrontout']);
        else
          error(' - You haven''t run any simulation yet.');    
        end
        mnamehere=fpwout.mname;
      end
      clear WhereCTPThere
    elseif strcmp(WhereOrderFromH,'LINK')    
      namehere=noempty(instruct.mlmfvar);
      mnamehere=upper(namehere(1));
      clear namehere
    elseif strcmp(WhereOrderFromH,'SETG') 
      setgoutdhere=str2num(instruct.setgoutd);
      if setgoutdhere==1
        mnamehere=upper(instruct.fpwmname1);
      elseif setgoutdhere==2
        mnamehere=upper(instruct.fpwmname2);
      elseif setgoutdhere==3
        mnamehere=upper(instruct.fpwmname3);
      elseif setgoutdhere==4
        mnamehere=upper(instruct.fpwmname4);
      end   
      clear setgoutdhere
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
    ToD='D';
    fpwchartspan='DD';
    fpwchartbase='V';
  elseif strcmp(WhereOrderFrom,'SLFE')
    WhereCTP=str2num(instruct.WhereCTP);
    WhereCTPT=str2num(instruct.WhereCTPT);
    if WhereCTPT==0
      name=noempty(instruct.fpwsymbol);
      global mname; 
      mname=instruct.hdfpwfstype;  
      FirstorS=str2num(instruct.FirstorS);
      fpwchartbase=instruct.fpwchartbase;
      fpwchartspan=instruct.fpwchartspan;
    else
      global mname
      if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwfrontout.mat'])==2
        eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwfrontout']);
      else
        error(' - You haven''t run any simulation yet.');    
      end
      
      name=upper(fpwout.name); mname=fpwout.mname;
      datem=fpwout.datem; tradeh=fpwout.tradeh;
      WhereCTP=min([length(tradeh(:,1)) max([1 WhereCTP+WhereCTPT])]);
      if WhereCTPT==1
        WhereCTP1=min([length(tradeh(:,1)) WhereCTP+1]);
      else
        WhereCTP1=max([1 WhereCTP-1]);        
      end
      Entime=tradeh(WhereCTP,9); % Entry Time
      
      if ~strcmp(upper(name),'ZZXY')    
        if ((strcmp(upper(fpwusername),'NINGZHU'))|(strcmp(upper(fpwusername),'AARONZHU')))&...
          (strcmp(instruct.fpwchartspan,'T03'))
          instruct.fpwFdate=date2str(datem(max([1 tradeh(WhereCTP,3)-1]),1:3));  % showing 1 days previous data
          instruct.fpwTdate=date2str(datem(max([1 tradeh(WhereCTP1,3)+1]),1:3)); % showing 1 days previous data
        else
          instruct.fpwFdate=date2str(datem(max([1 tradeh(WhereCTP,3)-2]),1:3));  % showing 2 days previous data
          instruct.fpwTdate=date2str(datem(max([1 tradeh(WhereCTP1,3)+2]),1:3)); % showing 2 days previous data
        end
      else 
        TradeD=fpwout.TradeD;
        [qww qiw]=sort(tradeh(:,3));
        tradeh=tradeh(qiw,:);
        TradeD=TradeD(qiw,:);         
        instruct.fpwFdate=date2str(TradeD(WhereCTP,1:3));
        instruct.fpwTdate=date2str(TradeD(WhereCTP1,1:3));          
        runnamelist=fpwout.runnamelist;
        name=upper(runnamelist{tradeh(WhereCTP,13)});
        if length(mname)>1
          mname=mname(tradeh(WhereCTP,13));
        end
      end        
      FirstorS=1;
      ToD='T';
      if ((strcmp(upper(fpwusername),'NINGZHU'))|(strcmp(upper(fpwusername),'AARONZHU')))&...
        (strcmp(instruct.fpwchartspan,'T03'))
        fpwchartspan='T03';
      else
        fpwchartspan='T25';
      end
      %fpwchartspan='T25'; % options: 'T05' - 1 day, 'T25' - 5 days, 'T15' 'T30' 'T60' - about 500 bars
      fpwchartbase='V';         
    end
  elseif strcmp(WhereOrderFrom,'LINK')    
    name=noempty(instruct.mlmfvar);
    global mname;
    mname=upper(name(1));
    name=name(2:length(name));
    FirstorS=0;
    ToD='D';
    fpwchartspan='DD';
    fpwchartbase='V';   
  elseif strcmp(WhereOrderFrom,'SETG') 
    setgoutd=str2num(instruct.setgoutd);
    global mname;
    if setgoutd==1
      mname=upper(instruct.fpwmname1);
      name=upper(instruct.fpwname1);
    elseif setgoutd==2
      mname=upper(instruct.fpwmname2);
      name=upper(instruct.fpwname2);
    elseif setgoutd==3
      mname=upper(instruct.fpwmname3);
      name=upper(instruct.fpwname3);
    elseif setgoutd==4
      mname=upper(instruct.fpwmname4);
      name=upper(instruct.fpwname4);
    end
    WhereCTP=str2num(instruct.zhu33gg)+setgoutd-1;
    if 1 % This is the first time from setup page.
      if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwfrontout.mat'])==2
        eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwfrontout']);
      else
        error(' - You haven''t run any simulation yet.');    
      end
      datem=fpwout.datem; tradeh=fpwout.tradeh;
      Entime=tradeh(WhereCTP,9);
      if (strcmp(upper(fpwusername),'NINGZHU'))|(strcmp(upper(fpwusername),'AARONZHU'))
        instruct.fpwFdate=date2str(datem(max([1 tradeh(WhereCTP,3)-1]),1:3));
        instruct.fpwTdate=date2str(datem(max([1 tradeh(WhereCTP,3)+1]),1:3));
      else
        instruct.fpwFdate=date2str(datem(max([1 tradeh(WhereCTP,3)-2]),1:3));
        instruct.fpwTdate=date2str(datem(max([1 tradeh(WhereCTP,3)+2]),1:3));
      end
    else  
      instruct.fpwFdate=instruct.setgdate;
      instruct.fpwTdate=instruct.setgdate;
    end
    FirstorS=1;
    ToD='T';
    if (strcmp(upper(fpwusername),'NINGZHU'))|(strcmp(upper(fpwusername),'AARONZHU'))
      fpwchartspan='T03';
    else
      fpwchartspan='T25';
    end
    fpwchartbase='V';      
  end
  
  if (length(name)==0)|(length(name)>6)
    error('Entered wrong symbol.');
  end
    
  global datem
  name=lower(name);
  [stock datem]=fsdaydat([mname,name]);
  if strcmp(upper(mname),'S')==1
    testdata=stgetdaa(name,'t',1);
  else
    testdata=[];
  end
  if (strcmp(upper(mname),'S')==1)&((length(stock)>0)|(length(testdata)>0))
    cd([Wherematlab,'stock']);
    tradinghours=0;
    timevalue=clock;
    markethourst;
    timecal=timevalue(4)+timevalue(5)/60;
    datetoday=[timevalue(2:3) timevalue(1)-2000];
    if (timecal>openhourt+1/200)&(timecal<closehourt+1/12)&(dn(datetoday)<=5)
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
        %stock=[stock;fpwnltlast(stocknameph(1),1:5)];
        stock=[stock;[fpwnltlast(stocknameph(1),1:4) fpwnltlast(stocknameph(1),5)*1000]];
      end
    end
    cd([Wherematlab,'pattern']);
  end
  
  if (FirstorS==0) % FirstorS is used to control scope range, reset to 0 by fpwsymbol on change, to 1 by GO button
    fpwchartspan='DD';
    fpwchartbase='V';    
    if length(stock)==0
      error('No data available for this stock, please check the symbol.');
    end
  
    if strcmp(WhereOrderFrom,'MPLG')
      fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
      fseek(fid1,-50,1); fprintf(fid1,[time,' MPGC: ',upper(mname),'-',upper(name),'\n']); fclose(fid1);
      clear fid1
    elseif strcmp(WhereOrderFrom,'SLFE')
      fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
      fseek(fid1,-50,1); fprintf(fid1,[time,' SLFC: ',upper(mname),'-',upper(name),'\n']); fclose(fid1);
      clear fid1
    elseif strcmp(WhereOrderFrom,'LINK')
      fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
      fseek(fid1,-50,1); fprintf(fid1,[time,' LNKC: ',upper(mname),'-',upper(name),'\n']); fclose(fid1);
      clear fid1      
    end
    fpwchartft=[1 length(datem(:,1))];
  else    
    %fpwchartft=[instruct.hdfpwfindex instruct.hdfpwtindex]; 
    % in case some one enters dates by hand
    fpwFdate=instruct.fpwFdate;
    slplace=find(fpwFdate=='/');
    if length(slplace)~=2
      slplace=find(fpwFdate=='-');
      if length(slplace)~=2
        error('Entered a wrong start F date');
      end
    end
    startd=[str2num(fpwFdate(1:slplace(1)-1)) str2num(fpwFdate(slplace(1)+1:slplace(2)-1)) str2num(fpwFdate(slplace(2)+1:length(fpwFdate)))];
    datecheck(startd,1);
    fpwTdate=instruct.fpwTdate;    
    slplace=find(fpwTdate=='/');
    if length(slplace)~=2
      slplace=find(fpwTdate=='-');
      if length(slplace)~=2
        error('Entered a wrong start T date');
      end
    end
    endd=[str2num(fpwTdate(1:slplace(1)-1)) str2num(fpwTdate(slplace(1)+1:slplace(2)-1)) str2num(fpwTdate(slplace(2)+1:length(fpwTdate)))];
    datecheck(endd,1); 
    
    fpwchartft(1)=datef2(startd,datem);
    fpwchartft(2)=datef2(endd,datem);
    if (fpwchartft(1)>fpwchartft(2))&(WhereCTPT==0)
        fpwchartft=fpwchartft([2 1]);
    end
  end
  Datem=datem;Stock=stock;
  
  % firstly find out the raw [stock datem]
  ToD=fpwchartspan(1);
  if ToD=='D'
    stock=stock(fpwchartft(1):fpwchartft(2),:);
    datem=datem(fpwchartft(1):fpwchartft(2),:);
    if fpwchartspan(2)=='W'
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
    elseif fpwchartspan(2)=='M'
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
    tickind=str2num(fpwchartspan(2:3));
    edate=datem(fpwchartft(1),:); %date from the 'From' date
    howmanybartoshowh=341;
    howmanybartoquot=tickind/5*howmanybartoshowh;  %115;
    if tickind==25
      howmanybartoquot=393;
    end
    if tickind==3
      howmanybartoquot=246;
    end
    stocklongdata=0;
    if howmanybartoquot==howmanybartoshowh % for 5 minute bar
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
        if (length(stock)>0)&(tradinghours==1)&(sum(abs(datetoday-datemends))==0) %&(strcmp(upper(fpwusername),'NINGZHU'))
          if (timevaluea(4)*3600+timevaluea(5)*60-(stock(length(stock(:,1)),4)*3600+stock(length(stock(:,1)),5)*60)<300)
            stock=[stock;[timevaluea fpwnltlast(stocknameph(1),7:11)]];            
          end
        end
      end
      if length(stock)>0
        if (strcmp(upper(fpwusername),'NINGZHU'))
          stockfthi=stock;
        end 
        datemT=stock(:,1:3);
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
              stock=stock(fffff(1):min([fffff(1)+tickind/5*howmanybartoshowh length(stock(:,1))]),:);
            else
              if (tickind~=25)&(tickind~=3)
                stock=stock(1:min([tickind/5*howmanybartoshowh length(stock(:,1))]),:); 
              else
                if (tickind==25)
                  stock=stock(1:min([393 length(stock(:,1))]),:);
                else
                  stock=stock(1:min([246 length(stock(:,1))]),:);
                end
              end
            end                  
            datemfroms=stock(1,1:3);    
            datemends=stock(length(stock(:,1)),1:3);            
          end
        end
        if (length(stock)>0)&(tradinghours==1)&(sum(abs(datetoday-datemends))==0) %&(strcmp(upper(fpwusername),'NINGZHU'))
          if timevaluea(4)*3600+timevaluea(5)*60-(stock(length(stock(:,1)),4)*3600+stock(length(stock(:,1)),5)*60)<300
            stock=[stock;[timevaluea fpwnltlast(stocknameph(1),7:11)]];            
          end
        end         
      end
        
      if (length(stock)>0)
        if (strcmp(upper(fpwusername),'NINGZHU'))
          stockfthi=stock;
        end  
        datemT=stock(:,1:3);
        if (tickind~=25)&(tickind~=3)
          if 0 % old one, no more use. it's not right for broken data serial
            stockt=[];datemt=[];indexf=1; DDdatemt=[];
            for i=2:length(stock(:,1))  
              if (strcmp(upper(fpwusername),'NINGZHU'))
                timestapm5ahead = stock(i,5)+0;
              end  
              if (rem(timestapm5ahead,tickind)==0)|(i==length(stock(:,1)))
                stockt=[stockt;wsohlcv(stock(indexf:i,6:10))];
                datemt=[datemt;[stock(i,4) stock(i,5) stock(i,2)]];
                DDdatemt=[DDdatemt;stock(i,1:3)];
                indexf=i+1;
              else
                if (stock(i-1,2)~=stock(i,2))&(indexf<i)
                  stockt=[stockt;wsohlcv(stock(indexf:i-1,6:10))];
                  datemt=[datemt;[stock(i-1,4) stock(i-1,5) stock(i-1,2)]];
                  DDdatemt=[DDdatemt;stock(i-1,1:3)];
                  indexf=i;
                end
              end
            end
          else
            stockt=wsstdata(stock,tickind);
            datemt=stockt(:,[4 5 2]);
            DDdatemt=stockt(:,1:3);
            stockt=stockt(:,6:10);
          end
        else
          if (tickind==25)
            stockt=stock(1:min([length(stock(:,1)) 393]),6:10);     
            datemt=[stock(1:min([length(stock(:,1)) 393]),4) stock(1:min([length(stock(:,1)) 393]),5) stock(1:min([length(stock(:,1)) 393]),2)];
            DDdatemt=[];DDdatemt=[DDdatemt;stock(:,1:3)];
          else
            stockt=stock(1:min([length(stock(:,1)) 246]),6:10);     
            datemt=[stock(1:min([length(stock(:,1)) 246]),4) stock(1:min([length(stock(:,1)) 246]),5) stock(1:min([length(stock(:,1)) 246]),2)];
            DDdatemt=[];DDdatemt=[DDdatemt;stock(:,1:3)];
          end
        end       
        
        datemt=[ones(2,3);datemt];
        DDdatemt=[ones(2,3);DDdatemt];
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
        if (tickind~=25)&(tickind~=3)
          stock=stgetdaa(name,'t',tickind/5*howmanybartoshowh);
        else
          if (tickind==25)
            stock=stgetdaa(name,'t',393);
          else
            stock=stgetdaa(name,'t',246);
          end
        end
        if length(stock)>0
          if (tradinghours==1)&(sum(abs(datetoday-stock(length(stock(:,1)),[4 5 2])))==0) %&(strcmp(upper(fpwusername),'NINGZHU'))
            if timevaluea(4)*3600+timevaluea(5)*60-(stock(length(stock(:,1)),4)*3600+stock(length(stock(:,1)),5)*60)<300
              stock=[stock;[timevaluea fpwnltlast(stocknameph(1),7:11)]];            
            end
          end             
          datemT=stock(:,1:3);
          datemt=[ones(2,3);stock(:,[4 5 2])];
          DDdatemt=[ones(2,3);stock(:,1:3)];
          stockt=[stock(1:2,6:10);stock(:,6:10)];
          stockt(:,5)=stockt(:,5);
          datemt=[datemt 0*datemt(:,1)];
        else
          error(' Tick Data not Available for the symbol you entered. S');
        end
      else 
        error(' Tick Data not Available for the symbol you entered. F');        
      end
    end
    stock=stockt;
    datem=datemt;
    
    %if (length(datem(:,1))>145)&(upper(mname)=='S')
    %  stock=stock(max([1 length(stock(:,1))-145]):length(stock(:,1)),:);
    %  datem=datem(max([1 length(datem(:,1))-145]):length(datem(:,1)),:); 
    %end    
  end
  
  % later to add more choise for tech tools
  % .....
  % ....
  
  % figure output
  Fig1=figure('pos',[2 4 635 434],'color','k','visible','off');
  zhu27r=axes('position',[0.091 0.353 .89 .62]);
  zhu28r=axes('position',[0.091 0.061 .89 .25]);
  if ToD=='D'
    stocktdfxp=[datem stock];  % for mouseout data
  end
  if ToD=='D'
    % wsrawz22
    subplot(zhu27r)
    hold off
    if length(stock(:,1))<396
      %wsbar(stock,datem);
      stock=[stock(1,:);stock];
      datem=[datem(1,:);datem];
      if (strcmp(upper(fpwusername),'NINGZHU'))&(tradinghours~=1)
        timeherenowe=clock;
        if rem(timeherenowe(5),2)==0
          stock=[stock;stock(length(stock(:,1)),:)];
          datem=[datem;datem(length(datem(:,1)),:)]; 
        end
      end
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
        % if length(dn(datem(I,:)))==0
        %   datem(I,:)
        %   dn(datem(I,:))
        % end
        % above four lines were ever used to locate bad date data
        if (dn(datem(I+1,:))~=5)|(fpwchartspan(2)~='D')
          intradayc='g';
          if (fpwchartspan(2)=='W')
            if weekfd(datem(I+1,:),1)==1
              intradayc='w';   
            else
              intradayc='g';               
            end
          elseif (fpwchartspan(2)=='M')
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
        plot(X4(I,:),line2(I,:),intradayc,'linewidth',.125);
        plot(X5(I,:),line1(I,:),intradayc,'linewidth',.125);   
      end    
      datem(1:length(datem(:,1))-1,:)=datem(2:length(datem(:,1)),:);
      maximumdatanumber=get(gca,'xtick'); % find out what is the maximum possible bar number
      maximumdatanumber=maximumdatanumber(length(maximumdatanumber));      
      chgst93(datem);
    else
      plot(stock(:,4),'g');
      maximumdatanumber=get(gca,'xtick'); % find out what is the maximum possible bar number
      maximumdatanumber=maximumdatanumber(length(maximumdatanumber));
      chgst93(datem);
    end
    ylabel('price');
    grid; set(gca,'Xcolor',[0.5 0.5 0.5]);
    set(gca,'Ycolor',[0.5 0.5 0.5]);
    
    if (strcmp(upper(fpwusername),'NINGZHU'))&(length(vol)>3)
      manums=[20 50 200];
      if fpwchartspan(2)=='W'
        manums=[4 10 41]; %manums/5;
      elseif fpwchartspan(2)=='M'
        manums=manums/20; 
      else
        if length(vol)>230
          manums=[20 50 200];
        else
          manums=[20 50 5];
        end
      end
      manums(1)=max([min([manums(1) length(vol)-2]) 1]);
      manums(2)=max([min([manums(2) length(vol)-2]) 1]);
      manums(3)=max([min([manums(3) length(vol)-2]) 1]);
      
      if 1 %length(vol)>manums(3)
        MA20line  = ma(msum(closeh.*vol,manums(1))./msum(vol,manums(1)),min([2 length(vol) manums(1)])); 
        MA60line  = ma(msum(closeh.*vol,manums(2))./msum(vol,manums(2)),min([2 length(vol) manums(2)])); 
        MA200line = ma(msum(closeh.*vol,manums(3))./msum(vol,manums(3)),min([2 length(vol) manums(3)])); 
        
        MA20line=MA20line(2:length(MA20line));
        MA60line=MA60line(2:length(MA60line));
        MA200line=MA200line(2:length(MA200line));
        
        if MA20line(length(MA20line))-MA20line(length(MA20line)-1)>0
          plot(manums(1):length(MA20line), MA20line(manums(1):length(MA20line)),'-y');
        else
          plot(manums(1):length(MA20line), MA20line(manums(1):length(MA20line)),'-c');
        end
        if MA60line(length(MA60line))-MA60line(length(MA60line)-1)>0
          plot(manums(2):length(MA60line), MA60line(manums(2):length(MA60line)),'-c');
        else
          plot(manums(2):length(MA60line), MA60line(manums(2):length(MA60line)),'-r');
        end
        if MA200line(length(MA200line))-MA200line(length(MA200line)-1)>0
          plot(manums(3):length(MA200line), MA200line(manums(3):length(MA200line)),'-r');
        else
          plot(manums(3):length(MA200line), MA200line(manums(3):length(MA200line)),'-c');
        end
        if length(closeh)>2*manums(1)
          plot(max([1 length(MA20line)-manums(1)+1]), MA20line(max([1 length(MA20line)-manums(1)+1])),'w.','linewidth',15);
        end
        if length(closeh)>2*manums(2)
          plot(max([1 length(MA60line)-manums(2)+1]), MA60line(max([1 length(MA60line)-manums(2)+1])),'w.','linewidth',15);
        end
        if length(closeh)>min([220 2*manums(3)])
          plot(max([1 length(MA200line)-manums(3)+1]), MA200line(max([1 length(MA200line)-manums(3)+1])),'w.','linewidth',15);
        end
      end
    end   
  
    subplot(zhu28r)
    hold off
    vol=stock(:,5)+.0001;
    if length(stock(:,1))<396
      barg(([vol(2:length(vol))])/1000);
      chgst93(datem);
    else
      dys=length(vol);  
      hold off
      if length(vol)<300
        X1=1:dys;
        X(1:dys,1:2)=[X1' X1'];
        line(1:dys,1:2)=[0*vol vol/1000];
        avg=fix(mean(vol(1:dys)))/1000;
        plot(1:dys,avg*ones(1,dys),'-y');
        hold on;
        avg=ma(vol(1:dys),20)/1000;
        plot(20:dys,avg(20:dys),'-w');
        for I=1:dys
          plot(X(I,:),line(I,:),'-g');
        end
        hold off
      else
        plot(vol/1000,'g');
      end
      chgst93(datem);      
    end
    if mname=='F'
      ylabel('Index or Vol in 100K')
    else
      ylabel('Index or Vol in 100K')
    end
    grid; set(gca,'Xcolor',[0.5 0.5 0.5]);
    set(gca,'Ycolor',[0.5 0.5 0.5]);
    hold off
  else
    % wsrawzt1
    if (tickind>5)
      if length(stock(:,1))>=396
        stock=stock(1:395,:);
        datem=datem(1:395,:);
      end
    end
    subplot(zhu27r)
    hold off
    if length(stock(:,1))<396  %149
      %wsbart1(stock,datem,tTry);
      yrs=length(stock(:,1))-1;
      stock(1:yrs,:)=stock(2:yrs+1,:);
      x=[1:yrs];
      closeh=stock(:,4); high=stock(:,2); low=stock(:,3);
      open=stock(:,1); 
      vol=stock(:,5)/1000+.01;
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
      %save c:\matlab\stocktemphere5
      for I=1:yrs-1
        if datem(I+1,3)~=datem(I+2,3); daychangep=I; end
        if (datem(I+1,numbercolumn)~=datem(max([1 I+2]),numbercolumn))&(I>1)
          intradayc='w';        
        else
          intradayc='g';        
        end   
        if (I>7)&((tickind==15)|(tickind==30)|(tickind==60)|(tickind==25))
          if DDdatemt(I,1)~=DDdatemt(I-1,1) % Change Month
            IIII=I-2;
            if 0.997*line(I-2,1)<min(line(I-6:I-3,1))
              if tickind~=25
                IIII=I-6;
              else
                IIII=max([1 I-11]);
              end
            elseif 0.997*line(I-2,1)<min(line(I-1:min([I+4 yrs-1]),1))
              IIII=min([I+1 yrs-3]); 
            end
            if (0.997*line(I-2,1)<min(line(I-6:I-3,1)))&(0.997*line(I-2,1)<min(line(I-1:min([I+4 yrs-1]),1)))
              IIII=I-2;
            end
            if tickind~=25
              plot(X5(I-2,1),0.9965*line(I-2,1),'w.','linewidth',15);
              text(X5(IIII,1)-1,0.991*line(I-2,1),[num2str(DDdatemt(I,1)),'/',num2str(DDdatemt(I,3))]);        
            else
              if 0.997*line(I-2,1)<min(line(:,1))
                plot(X5(I-2,1),0.999*line(I-2,1),'w.','linewidth',15);
                text(X5(IIII,1)-1,0.998*line(I-2,1),[num2str(DDdatemt(I,1)),'/',num2str(DDdatemt(I,3))]);
              else
                plot(X5(I-2,1),0.9985*line(I-2,1),'w.','linewidth',15);
                text(X5(IIII,1)-1,0.996*line(I-2,1),[num2str(DDdatemt(I,1)),'/',num2str(DDdatemt(I,3))]);       
              end
            end
            clear IIII;
          end
        end
        plot(X(I,:),line(I,:),intradayc,'linewidth',.125);
        plot(X4(I,:),line2(I,:),intradayc,'linewidth',.125);
        plot(X5(I,:),line1(I,:),intradayc,'linewidth',.125);   
      end       
      if (daychangep~=1)&(stocklongdata==1)
        timeherenoweav=clock;
        if timeherenoweav(3)~=datem(length(datem(:,1)),3)
          plot([1 yrs],[line1(I,1) line1(I,1)],'--r');
        else
          plot([1 yrs],[line1(daychangep-1,1) line1(daychangep-1,1)],'--r');
        end
      end
      
      %save c:\matlab\stock\mycheckpoint.mat
      if strcmp(upper(fpwusername),'NINGZHU')
        timeherenowe=clock;
        if (timeherenowe(4)+timeherenowe(5)/60>11.5)|(tradinghours~=1)
          timespanb=4;   %3
          timespanbm=3;
        else
          timespanb=4;
          timespanbm=3; %2
        end
        timeadjustspan=1;
        days5ma=0;
        if (tickind==25)|(tickind==5)
          WAVPLength=8*timespanb;
          WAVPLength2=8*(timespanb+timeadjustspan);
          if length(stock(:,1))>399
            days5ma=390;
            WAVP5days=msum(closeh.*vol,days5ma)./msum(vol,days5ma);
          end
        elseif tickind==15
          WAVPLength=3*timespanb;
          WAVPLength2=3*(timespanb+timeadjustspan);
          if length(stock(:,1))>135
            days5ma=135; 
            WAVP5days=msum(closeh.*vol,days5ma)./msum(vol,days5ma);
          end
        elseif tickind==30
          WAVPLength=2*timespanb;
          WAVPLength2=2*(timespanb+timeadjustspan);
          if length(stock(:,1))>70
            days5ma=70; 
            WAVP5days=msum(closeh.*vol,days5ma)./msum(vol,days5ma);
          end
        elseif tickind==60
          WAVPLength=timespanb;
          WAVPLength2=1*(timespanb+timeadjustspan);
          if length(stock(:,1))>40
            days5ma=40; 
            WAVP5days=msum(closeh.*vol,days5ma)./msum(vol,days5ma);
          end
        end
        
        if (length(vol)>WAVPLength2+5)
          VOLHere=vol;VOLHere2=vol;
          if (vol(length(vol))<vol(length(vol)-WAVPLength)/2)&(timeherenowe(5)<30)&(tradinghours==1)
            VOLHere(length(vol))=round(vol(length(vol)-WAVPLength)/2);
          end
          if (vol(length(vol))<vol(length(vol)-WAVPLength2)/2)&(timeherenowe(5)<30)&(tradinghours==1)
            VOLHere2(length(vol))=round(vol(length(vol)-WAVPLength2)/2);
          end
          WAVP=ma(msum(closeh.*VOLHere,WAVPLength)./msum(VOLHere,WAVPLength),max([2 timespanbm-1]));  
          WAVP2=ma(msum(closeh.*VOLHere2,WAVPLength2)./msum(VOLHere2,WAVPLength2),timespanbm); 
          WAVP=0.618*WAVP+0.382*WAVP2;
          if (length(stockfthi(:,1))>100)
            %WAVPfm=fix(mean(WAVP(WAVPLength+1:length(WAVP))));
            WAVPfm=floor(min(low)-fix(0.1*(max(high)-min(low))));
            if 0 % to use the FTH index
              WAVPsp=ma(wsfthfdi(stockfthi,tickind),2);
              if 0
                WAVPsp2=modelnor(1,-1,WAVP-polyval(polyfit((1:length(WAVP))',WAVP,4),(1:length(WAVP))'));
                if length(WAVPsp)>length(WAVPsp2)
                  WAVPsp = (WAVPsp(length(WAVPsp)-length(WAVPsp2)+1:length(WAVPsp)) + WAVPsp2)/2;
                else
                  WAVPsp = (WAVPsp2(length(WAVPsp2)-length(WAVPsp)+1:length(WAVPsp2)) + WAVPsp)/2;  
                end
              end
              WAVPsp=WAVPfm+WAVPsp;
            else % otherwise just use the sinple volume weighted average change
              timeplernum=150/tickind;
              if (tickind==25)|(tickind==5)
                timeplernum=2.5*timeplernum;  
              end
              WAVPsp=WAVPfm+ma(timeplernum*(0.618*mtm(WAVP,1)+0.382*ma(mtm(WAVP,1),2)),2);
              %WAVPsp=WAVPfm+msum(timeplernum*mtm(WAVP,1),30)/10;
            end
            WAVPspb=WAVPfm+0*WAVPsp;
          end
          if WAVP(length(WAVP))-WAVP(length(WAVP)-1)>0
            plot(WAVPLength-1:length(WAVP)-2,WAVP(WAVPLength+1:length(WAVP)),'-y');
            %plot(WAVPLength-1:length(WAVP)-1,[WAVP(WAVPLength+1:length(WAVP));WAVPadds],'-y');
            %plot(length(WAVP)-2:length(WAVP)-1,[WAVP(length(WAVP));WAVPadds],'-c');
          else
            plot(WAVPLength-1:length(WAVP)-2,WAVP(WAVPLength+1:length(WAVP)),'-c');
            %plot(WAVPLength-1:length(WAVP)-1,[WAVP(WAVPLength+1:length(WAVP));WAVPadds],'-c');
            %plot(length(WAVP)-2:length(WAVP)-1,[WAVP(length(WAVP));WAVPadds],'-y');
          end
          if (length(stockfthi(:,1))>100)
            %plot(WAVPLength-1:length(WAVP)-2,WAVPsp(WAVPLength+1:length(WAVP)),'-w');
            %plot(WAVPLength-1:length(WAVP)-2,WAVPspb(WAVPLength+1:length(WAVP)),'-w');
            if length(WAVPsp)-length(WAVPLength-1:length(WAVP)-2)+1>0
              plot(WAVPLength-1:length(WAVP)-2,WAVPsp(length(WAVPsp)-length(WAVPLength-1:length(WAVP)-2)+1:length(WAVPsp)),'-w');
              plot(WAVPLength-1:length(WAVP)-2,WAVPspb(length(WAVPsp)-length(WAVPLength-1:length(WAVP)-2)+1:length(WAVPsp)),'-w');
            else
              plot(length(WAVP)-length(WAVPsp)-2:length(WAVP)-2,WAVPsp,'-w');
              plot(length(WAVP)-length(WAVPsp)-2:length(WAVP)-2,WAVPspb,'-w');
            end
          end
          plot(length(WAVP)-WAVPLength2-1, WAVP(length(WAVP)-WAVPLength2+1),'w.','linewidth',15);
          plot(length(WAVP)-WAVPLength-1, WAVP(length(WAVP)-WAVPLength+1),'w.','linewidth',15);
          if days5ma~=0  
            if WAVP5days(length(WAVP5days))-WAVP5days(length(WAVP5days)-1)>0
              plot(days5ma-1:length(WAVP5days)-2,WAVP5days(days5ma+1:length(WAVP5days)),'-y');
            else
              plot(days5ma-1:length(WAVP5days)-2,WAVP5days(days5ma+1:length(WAVP5days)),'-c');
            end
            if length(closeh)>2*days5ma
              plot(length(WAVP5days)-days5ma-1, WAVP5days(length(WAVP5days)-days5ma+1),'w.','linewidth',15);
            end
          end
        end
      end
      
      datem(1:length(datem(:,1))-1,:)=datem(2:length(datem(:,1)),:);
      datem(1:length(datem(:,1))-1,:)=datem(2:length(datem(:,1)),:);
      
      if exist('WhereCTP')==1
        %save c:\matlab\pattern\mybug20160818.mat
        if (strcmp(fpwchartspan,'T03'))|(strcmp(fpwchartspan,'T25'))
          %Entime=tradeh(WhereCTP,9);
          enterytick=[fix(Entime) round(rem(Entime,1)*60) Datem(tradeh(WhereCTP,3),2)];
          enteryticki=find((datem(:,1)==enterytick(1))&(datem(:,2)==enterytick(2))&(datem(:,3)==enterytick(3)));
          if length(enteryticki)~=1
            enteryticki=find((datem(:,1)+datem(:,2)/60>=Entime)&(datem(:,3)==enterytick(3)));
          end
          if length(enteryticki)==0
            enteryticki=find((datem(:,1)+datem(:,2)/60<=Entime)&(datem(:,3)==enterytick(3)));
            enteryticki=enteryticki(length(enteryticki));
          end
          if length(enteryticki)==1
            plot(enteryticki(1),tradeh(WhereCTP,1),'wo');
          end
          
          Extime=fpwout.tradeh3(WhereCTP,172);
          if Extime~=0
            enterytick=[fix(Extime) round(rem(Extime,1)*60) Datem(tradeh(WhereCTP,5),2)];
            enteryticki=find((datem(:,1)==enterytick(1))&(datem(:,2)==enterytick(2))&(datem(:,3)==enterytick(3)));
            if length(enteryticki)==1
              if tradeh(WhereCTP,2)*(tradeh(WhereCTP,4)-tradeh(WhereCTP,1))>=0
                plot(enteryticki,tradeh(WhereCTP,4),'wo');
              else
                plot(enteryticki,tradeh(WhereCTP,4),'ro');
              end
            else
              enteryticki=find((datem(:,1)+datem(:,2)/60<=Extime)&(datem(:,3)==enterytick(3)));
              if length(enteryticki)>0 
                % otherwise it means that the holding period is longer than one overnight.
                % And it will out of this chart, so not drawing it.
                if tradeh(WhereCTP,2)*(tradeh(WhereCTP,4)-tradeh(WhereCTP,1))>=0
                  plot(enteryticki(length(enteryticki)),tradeh(WhereCTP,4),'wo');
                else
                  plot(enteryticki(length(enteryticki)),tradeh(WhereCTP,4),'ro');
                end   
              end
            end
          end
        end
      end  
      
      maximumdatanumber=get(gca,'xtick'); % find out what is the maximum possible bar number
      maximumdatanumber=maximumdatanumber(length(maximumdatanumber));  
      stocktdfxp=[datem(:,1:3) stock];
      if length(stocktdfxp(:,1))<3
        error('Data not enough now.')    
      else
        stocktdfxpt(:,1:3)=stocktdfxp(1:length(stocktdfxp(:,1))-2,1:3);
        stocktdfxpt(:,4:8)=stocktdfxp(2:length(stocktdfxp(:,1))-1,4:8);
        stocktdfxp(1:length(stocktdfxp(:,1))-2,:)=stocktdfxpt; clear stocktdfxpt
      end    
      chgstt1(datem);
    else    
      plot(stock(:,4),'g');
      maximumdatanumber=get(gca,'xtick'); % find out what is the maximum possible bar number
      maximumdatanumber=maximumdatanumber(length(maximumdatanumber));  
      stocktdfxp=[datem stock];
      chgstt1(datem)
    end
    ylabel('price');
    grid; set(gca,'Xcolor',[0.5 0.5 0.5]);
    set(gca,'Ycolor',[0.5 0.5 0.5]);
    
    subplot(zhu28r)
    hold off
    vol=stock(:,5)+.0001;
    if length(stock(:,1))<396 %149
      if upper(mname)=='F'
        axis([0 length(vol) 0 1.1*max(vol/10000)]);
        barg(([vol(2:length(vol)-1)])/10000);  
      else        
        axis([0 length(vol) 0 1.1*max(vol/1000)]);
        barg(([vol(2:length(vol)-1)])/1000);      
      end
      ylabel('Index or Vol in K')
      hold off
    else
      dys=length(vol);  
      hold off
      if length(vol)<500 %300
        X1=1:dys;
        X(1:dys,1:2)=[X1' X1'];
        if upper(mname)=='F'
          line(1:dys,1:2)=[0*vol vol/10000];
          axis([0 dys 0 1.1*max(vol/10000)]);
          avg=fix(mean(vol(1:dys)))/10000;
        else
          line(1:dys,1:2)=[0*vol vol/1000];
          axis([0 dys 0 1.1*max(vol/1000)]);
          avg=fix(mean(vol(1:dys)))/1000;
        end
        plot(1:dys,avg*ones(1,dys),'-w');
        if upper(mname)=='F'
          avg=ma(vol(1:dys),20)/10000; 
        else
          avg=ma(vol(1:dys),20)/1000;
        end
        plot(20:dys,avg(20:dys),'-w');
        hold on;
        for I=1:dys
          plot(X(I,:),line(I,:),'-g');
        end
        hold off
      else
        hold off   
        if upper(mname)=='F'
          plot(vol/10000,'g');  
        else
          plot(vol/1000,'g');
        end
        hold on
      end
      ylabel('Index or Vol in K')
    end
    chgstt1(datem);
    grid; set(gca,'Xcolor',[0.5 0.5 0.5]);
    set(gca,'Ycolor',[0.5 0.5 0.5]);
  end
  set(zhu27r,'color',get(gcf,'color'));
  set(zhu28r,'color',get(gcf,'color')); 
  ftzn=figtext(0.02,0.012,['Copyright ',datestr(now,10),' WSQSI, http://www.WSQSI.com/']);
  set(ftzn,'color',[0.5 0.5 0.5],'fontsize',7);
  ftzn=figtext(0.89,0.012,time1);
  set(ftzn,'color',[0.5 0.5 0.5],'fontsize',7);
  if (strcmp(upper(fpwusername),'NINGZHU'))&(ToD~='D')&(exist('WAVP')==1)
    ftzn=figtext(0.907,0.335,sprintf('%6.2f  %5.2f %5.2f',[WAVP(length(WAVP)) WAVP(length(WAVP))-WAVP(length(WAVP)-1) abs(closeh(length(closeh))-WAVP(length(WAVP)))]));
    set(ftzn,'color',[0.5 0.5 0.5],'fontsize',7);      
  end
  
  set(Fig1,'inverthardcopy','off'); hold off
  set(Fig1,'PaperPosition',[.25 .25 9.5 5.75]);
  cd([fpwserverplace,fpwclientdirectory,fpwusername,'\stock']);
  Plotfileh=[fpwclientdirectory,fpwusername,'\stock\wbstchart.jpeg'];
  drawnow;
  wsprintjpeg(Fig1,'wbstchart.jpeg');
  close(Fig1);
  %s.Chartjpeg=Plotfileh;
  
  % find each bar's x-position by fpwbarxp
  xbegin=83;
  xend=895;
  spacing=(xend-xbegin)/maximumdatanumber; % unit spacing = x-span / maximum data number
  for i=1:length(stocktdfxp(:,1)) % add here how many bars to display
    xppt(i)= xbegin + fix(i*spacing);
  end
  % find what is the best pacing for the map:
  minispace=max([1 round(min(mtm(xppt,1,2:length(xppt)))/2)]);
  if (minispace==1); minispacel=0; minispacer=1; end
  if (minispace>1)&(minispace<=3); minispacel=minispace-1; minispacer=minispace; end
  if (minispace>3)&(minispace<=8); minispacel=minispace-2; minispacer=minispace-1; end
  if (minispace>8)&(minispace<=15); minispacel=minispace-3; minispacer=minispace-3; end
  if (minispace>15); minispacel=12; minispacer=12; end
  
  xpleft=xppt-minispacel;
  xpright=xppt+minispacer;
  
  % choose the real data for any length
  if length(stocktdfxp(:,1))<396
    i=length(stocktdfxp(:,1))-1:-1:0;
  else
    %then only to choose 395 out evenly
    i=-sort(-round(0:(length(stocktdfxp(:,1))/395):length(stocktdfxp(:,1))-1));
  end
  
  % filte out what the real data will use
  xpleft=xpleft(-(i-length(stocktdfxp(:,1))));
  xpright=xpright(-(i-length(stocktdfxp(:,1))));
  stocktdfxp=stocktdfxp(-(i-length(stocktdfxp(:,1))),:);  
  for k=1:length(i)
    if k~=length(i)
      xppth=sprintf('%3d,15,%3d',xpleft(k),xpright(k));
    else
      xppth=sprintf('%3d,15,%3d',xpleft(k),xend);
    end
    eval(['sq195.xpl0r',sprintf('%03d',k),'=xppth;']);
  end
  if length(i)<395
    for k=length(i)+1:395
      eval(['sq195.xpl0r',sprintf('%03d',k),'=''1,0,81'';']);  
    end
  end
  
  sq195RawData='';
  for t195=1:length(i)
    %t195=length(stocktdfxp(:,1))-i(j);
    if ToD=='D'
      sq195RawData=[sq195RawData,date2str(stocktdfxp(t195,1:3)),'-',sprintf('%8.2f',stocktdfxp(t195,4)),'-',sprintf('%8.2f',stocktdfxp(t195,5)),'-',sprintf('%8.2f',stocktdfxp(t195,6)),'-',sprintf('%8.2f',stocktdfxp(t195,7)),'-',sprintf('%6.0f',stocktdfxp(t195,8)/10),'K|'];    
      if i==0
        sq195last=[' Date: ',date2str(stocktdfxp(t195,1:3)),', Open:',sprintf('%8.2f',stocktdfxp(t195,4)),', High:',sprintf('%8.2f',stocktdfxp(t195,5)),', Low:',sprintf('%8.2f',stocktdfxp(t195,6)),', Last:',sprintf('%8.2f',stocktdfxp(t195,7)),', Volume: ',sprintf('%6.0f',stocktdfxp(t195,8)/10),'K'];  
      end        
    else
      if upper(mname(1))=='F'
        sq195RawData=[sq195RawData,timedays(stocktdfxp(t195,1:3)),'-',sprintf('%8.2f',stocktdfxp(t195,4)),'-',sprintf('%8.2f',stocktdfxp(t195,5)),'-',sprintf('%8.2f',stocktdfxp(t195,6)),'-',sprintf('%8.2f',stocktdfxp(t195,7)),'-',sprintf('%6.0f',stocktdfxp(t195,8)/10),'|'];    
        if i==0
          sq195last=[' Time: ',timedays(stocktdfxp(t195,1:3)),', Open:',sprintf('%8.2f',stocktdfxp(t195,4)),', High:',sprintf('%8.2f',stocktdfxp(t195,5)),', Low:',sprintf('%8.2f',stocktdfxp(t195,6)),', Last:',sprintf('%8.2f',stocktdfxp(t195,7)),', Volume: ',sprintf('%6.0f',stocktdfxp(t195,5)/10)];  
        end
      else
        sq195RawData=[sq195RawData,timedays(stocktdfxp(t195,1:3)),'-',sprintf('%8.2f',stocktdfxp(t195,4)),'-',sprintf('%8.2f',stocktdfxp(t195,5)),'-',sprintf('%8.2f',stocktdfxp(t195,6)),'-',sprintf('%8.2f',stocktdfxp(t195,7)),'-',sprintf('%6.0f',stocktdfxp(t195,8)/1000),'K|'];    
        if i==0
          sq195last=[' Time: ',timedays(stocktdfxp(t195,1:3)),', Open:',sprintf('%8.2f',stocktdfxp(t195,4)),', High:',sprintf('%8.2f',stocktdfxp(t195,5)),', Low:',sprintf('%8.2f',stocktdfxp(t195,6)),', Last:',sprintf('%8.2f',stocktdfxp(t195,7)),', Volume: ',sprintf('%6.0f',stocktdfxp(t195,5)/1000),'K'];  
        end
      end
    end
  end
  sq195.sq195RawData=sq195RawData;
  sq195.sq195length=int2str(length(i)-1);
  
  sq195.sq195GraphFileName=Plotfileh;
  sq195.sq195last=sq195last;
  
  if upper(mname(1))=='F'
    sq195.sqFullName=['Futures: ',upper(name)];
    sq195.sqSymbol=upper(name);
    sq195.sqSymbolpr='http://www.WSQSI.com/fpwfslistf.html';
  else
    cd([Wherematlab,'stock']);
    sqFullName=fpwname(name);
    sqFullName=sqFullName(1:min([48 length(sqFullName)]));
    sq195.sqFullName=sqFullName;
    sq195.sqSymbol=upper(name);
    sq195.sqSymbolpr=['http://finance.yahoo.com/q/pr?s=',upper(name)];      
  end
  
  cd(fpwserverplace);
  templatefile = which('wbfpwchartany.html');  
  str = htmlrep(sq195, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\twbfpwchartany.html'],'noheader');
  s.sq195Page=[fpwclientdirectory,fpwusername,'\stock\twbfpwchartany.html'];
  cd([Wherematlab,'stock']);
  
  s.fpwusername=fpwusername;
  s.fpwusername4=fpwusername4;
  s.FSfpwfstype=mname;
  s.FSfpwsymbol=upper(name);
  s.FSFirstorS='1';
  
  %save c:\matlab\stock\mywbstchartbug.mat
  if ToD=='T' 
    datemstrh2=datemT(length(datemT(:,1)),:);
  end
  if stocklongdata==1 
    s.FSfpwFdate=date2str(datemfroms);
    s.FSfpwTdate=date2str(datemends);            
  else
    s.FSfpwFdate=date2str(Datem(fpwchartft(1),:));
    if ToD=='T'
      s.FSfpwTdate=date2str(datemstrh2); % date2str(Datem(fpwchartft(2),:));
    else
      s.FSfpwTdate=date2str(Datem(fpwchartft(2),:));
    end
  end
  s.FSfpwchartbase=fpwchartbase;
  s.FSfpwchartspan=fpwchartspan; 
  datestringout=[];
  for i=1:length(Datem(:,1))
    datestringout=[datestringout,sprintf('%02d%02d%02d',Datem(i,1:3))];
  end
  s.FSchartdatem=datestringout;
  s.FSfpwfindex=num2str(fpwchartft(1));
  if ToD=='T'
    s.FSfpwtindex=datef2(datemstrh2,Datem);    %num2str(fpwchartft(2));
  else
    s.FSfpwtindex=num2str(fpwchartft(2));
  end
  s.fpwMXI=num2str(length(Datem(:,1))); 
  if exist('WhereCTP')==1
    s.WhereCTP=num2str(WhereCTP);
  else
    s.WhereCTP='1';
  end
  eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\fpwstchart s stock datem']);
else
  if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\stock\fpwstchart.mat'])==2
    eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\fpwstchart']);
  else
    s.fpwusername=fpwusername;
    s.fpwusername4=fpwusername4;
    s.FSfpwfstype='S';
    s.FSfpwsymbol='UrSym';  
    s.FSFirstorS='0';
    %s.Chartjpeg=[fpwclientdirectory,fpwusername,'\stock\wbstchart.jpeg'];
    s.sq195Page=[fpwclientdirectory,fpwusername,'\stock\twbfpwchartany.html'];
    s.FSfpwFdate='01/03/90';
    s.FSfpwTdate='09/11/01';
    s.FSfpwchartbase='V';
    s.FSfpwchartspan='DD';
    s.FSchartdatem='010101010201010301010401010501010601070101';
    s.FSfpwfindex='1';
    s.FSfpwtindex='1';
    s.fpwMXI='1';
    s.WhereCTP='1';
  end
end 
s.fpwusername=fpwusername;
s.fpwusername4=fpwusername4;

cids=fpwloginstatus(fpwusername,clock);
cd(fpwserverplace);
if ~(strcmp(upper(fpwusername(1:4)),'USER'))
  templatefile = which('wbstchart.html');
else
  templatefile = which('wbstchart_nlink.html');
end
s.fpwcurrentm=[s.FSfpwfstype,s.FSfpwsymbol];
s.fpwulvl=instruct.fpwulvl;
if (nargin == 1)
  retstr = htmlrep(s, templatefile);
elseif (nargin == 2)
  retstr = htmlrep(s, templatefile, outfile);
end 
end