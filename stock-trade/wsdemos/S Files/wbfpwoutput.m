function retstr = wbfpwoutput(instruct, outfile)
          
% Author(s): N. Zhu, 11-15-2003
% This is a WB (Web-Based) mirror program to <wsozc3*> and more in desktop version
                
wbfpwbasic;
cd(fpwserverplace);
                 
retstr = char('');
global fpwusername fpwusername4
fpwusername=instruct.mlid{1};
%if isfield(instruct,'outrunindex')
%  if (strcmp(instruct.outrunindex,'91'))|(strcmp(instruct.outrunindex,'71'))|(strcmp(instruct.outrunindex,'51'))|(strcmp(instruct.outrunindex,'31'))|...
%    ((strcmp(instruct.outrunindex,'61'))&(strcmp(instruct.hdfpwpttype,'R')))|((strcmp(instruct.outrunindex,'81'))&(strcmp(instruct.hdfpwpttype,'R')))
   % fpwCPAL=4;
    %  end
    %else
  fpwCPAL=3;
  %end
fpwloginIP='192.168.2.8';
fpwcheckil;

% To Change PaperPosition, one needs to change 5 m-files:
% wbfpwoutput, wbfpwsimu, wbfpwport, wbdzhputmi and fpwfsmarket.
%MyPaperPosiH=[.25 .25 4.4 4.25]; % old small one, used before 2016-07-14
MyPaperPosiH=[.25 .25 8.259 4.355];

if fpwcheckilpass==1
                
  WhereOrderFrom=instruct.WhereOrderFrom;
  if (strcmp(WhereOrderFrom,'SLFE'))
    urbanwords='';      
    [fpwscpass2,whereban2,whatban2]=wbcheckbanw('OUTPTNAME',instruct.outptname);
    if fpwscpass2~=1
      urbanwords=[urbanwords,whereban2,': ',whatban2,'; '];
      fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
      fseek(fid1,-50,1); fprintf(fid1,[time,' FAIL: ',urbanwords,'\n']); fclose(fid1);
      clear fid1    
      WhereOrderFrom='SCFL'
      sfpw.urbanwords=urbanwords;
    end
    clear urbanwords fpwscpass2 whereban2 whatban2
  end
  
  cd([Wherematlab,'pattern']);
  if (strcmp(WhereOrderFrom,'SLFE'))
    if (isfield(instruct,'outAnyD')) % to drop added extra info by wbfpwport.m and fpwozc3.m
      outAnyDstr=instruct.outAnyD;
      if (length(strfind(outAnyDstr,' L - '))>0)|(length(strfind(outAnyDstr,'   M'))>0)        
        if (length(strfind(outAnyDstr,' L - '))>0)
          outAnyDstri=strfind(outAnyDstr,' L - ');
        else
          outAnyDstri=strfind(outAnyDstr,'   M');
        end
        instruct.outAnyD=outAnyDstr(1:outAnyDstri(1)-1);
        clear outAnyDstri
      end  
      clear outAnyDstr
    end
    if (isfield(instruct,'outAnyU'))
      if length(strfind(instruct.outAnyU,'...'))>0
        dotsplacei=strfind(instruct.outAnyU,'...');
        instruct.outAnyU=[instruct.outAnyU(1:dotsplacei(1)-1) instruct.outAnyD];
        instruct.outAnyD='0.05';
        clear dotsplacei
      end
      if fpwsecucheck([instruct.outAnyU,instruct.outAnyD])>0
        error(' Hei! Not allowed content found, are you seriously trying to .... Sorry, change it.');
      end
    end
  end
  if (strcmp(WhereOrderFrom,'SLFE'))
              
    fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
    fseek(fid1,-50,1); fprintf(fid1,[time,' SO',instruct.outrunindex,'\n']); fclose(fid1);
    clear fid1
    outrunindex=instruct.outrunindex;
    fpwsource=instruct.fpwsource;
    
    if strcmp(outrunindex(1),'1')
                
      if strcmp(outrunindex,'11')
        % chart and statistics without save
        cd([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\']);
        eval(['load ',fpwsource,'.mat']);
        % find zhu52 and zhu54
        outFdate=instruct.outFdate;
        slplace=find(outFdate=='/');
        if length(slplace)~=2
          slplace=find(outFdate=='-');
          if length(slplace)~=2
            error('Entered a wrong start F date');
          end
        end
        startd=[str2num(outFdate(1:slplace(1)-1)) str2num(outFdate(slplace(1)+1:slplace(2)-1)) str2num(outFdate(slplace(2)+1:length(outFdate)))];
        datecheck(startd,1);
        
        outTdate=instruct.outTdate;    
        slplace=find(outTdate=='/');
        if length(slplace)~=2
          slplace=find(outTdate=='-');
          if length(slplace)~=2
            error('Entered a wrong start T date');
          end
        end
        endd=[str2num(outTdate(1:slplace(1)-1)) str2num(outTdate(slplace(1)+1:slplace(2)-1)) str2num(outTdate(slplace(2)+1:length(outTdate)))];
        datecheck(endd,1); 
        outchartft(1)=datef2(startd,fpwout.datem);
        outchartft(2)=datef2(endd,fpwout.datem);
        if outchartft(1)>outchartft(2)
          outchartft=outchartft([2 1]);
        end
        fpwout.zhu52=num2str(outchartft(1));
        fpwout.zhu54=num2str(length(fpwout.net)-outchartft(2)+1);
        
        if sum(abs(fpwout.net1(outchartft(1):outchartft(2))))>0
        %if length(find((fpwout.tradeh(:,3)>=outchartft(1))&(fpwout.tradeh(:,3)<=outchartft(2))))>0
          fpwoutwindow=21;
          cd([Wherematlab,'\pattern']);
          fpwout.outonoff=instruct.hdoutonoff;
          fpwout.fpwsource=fpwsource;
          fpwout.outchartft1=outchartft(1);
          fpwout1=fpwozc3(fpwout);
          fpwout1.fpwsource=fpwsource;
          fpwout1.fpwusername=fpwusername;
          fpwout1.fpwusername4=fpwusername4;
          fpwout1.fpwulvl=instruct.fpwulvl;
          fpwout1.outrunindex='11';
          if strcmp(fpwsource,'fpwoutput')
            fpwout1.outDSM='1';
          elseif strcmp(fpwsource,'fpwoutf2')
            fpwout1.outDSM='2';
          elseif strcmp(fpwsource,'fpwoutft')|strcmp(fpwsource,'fpwany300')
            fpwout1.outDSM='3';  
          elseif strcmp(fpwsource,'fpwany100')
            fpwout1.outDSM='4';
          elseif strcmp(fpwsource,'fpwany200')
            fpwout1.outDSM='5';
          end
          
          fpwout1.outAnyU=instruct.outAnyU;
          %fpwout1.outAnyD=instruct.outAnyD;        
          fpwout1.outAnyS=instruct.outAnyS;
          fpwout1.outGOsm=instruct.outGOsm;
                       
          set(fpwout1.fpwoutfig,'PaperPosition',MyPaperPosiH);
          cd([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern']);
          drawnow;
          wsprintjpeg(fpwout1.fpwoutfig,'fpwoutjpeg.jpeg');
          close(fpwout1.fpwoutfig);
          cd([Wherematlab,'pattern']);
          fpwout1.fpwoutjpeg=[fpwclientdirectory,fpwusername,'\pattern\fpwoutjpeg.jpeg']; 
                       
          sfpw1.StatusReport=[' This is the zoom-in picture of your front showing simulation output. ',time];
          templatefile = which('MPsimulationR1.html');
          str = htmlrep(sfpw1, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\twbfpwoutputR1.html'],'noheader');      
          fpwout1.FPWoutstatus=strrep([fpwclientdirectory,fpwusername,'\pattern\twbfpwoutputR1.html'],'\','/');    
        else
          fpwoutwindow=24;
          fpwout1.fpwusername=fpwusername;
          fpwout1.fpwusername4=fpwusername4;
          fpwout1.fpwulvl=instruct.fpwulvl;
          fpwout1.outrunindex='11';               
        end            
      end
      
      if strcmp(outrunindex,'12')
        % statistics time
        eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwfrontout']);
        tradeh=fpwout.tradeh;
        fpwout1.oC11='Time';
        fpwout1.oC21='$Net';
        fpwout1.oC31='Win';
        fpwout1.oC41='Loss';
        fpwout1.oC12='<10:10';
        fpwout1.oC13='<10:50';
        fpwout1.oC14='<11:30';
        fpwout1.oC15='<12:10';
        fpwout1.oC16='<12:50';
                   
        wsC22=tradeh(find(tradeh(:,9)<10.16),6);
        wsC23=tradeh(find((tradeh(:,9)>=10.16)&(tradeh(:,9)<10.83)),6);
        wsC24=tradeh(find((tradeh(:,9)>=10.83)&(tradeh(:,9)<11.50)),6);
        wsC25=tradeh(find((tradeh(:,9)>=11.50)&(tradeh(:,9)<12.16)),6);
        wsC26=tradeh(find((tradeh(:,9)>=12.16)&(tradeh(:,9)<12.83)),6);
           
        fpwout1.oC22=sprintf('%6.0f',sum(wsC22));
        fpwout1.oC23=sprintf('%6.0f',sum(wsC23));
        fpwout1.oC24=sprintf('%6.0f',sum(wsC24));
        fpwout1.oC25=sprintf('%6.0f',sum(wsC25));
        fpwout1.oC26=sprintf('%6.0f',sum(wsC26));
        fpwout1.oC32=int2str(length(find(wsC22-.00001>0)));
        fpwout1.oC33=int2str(length(find(wsC23-.00001>0)));
        fpwout1.oC34=int2str(length(find(wsC24-.00001>0)));
        fpwout1.oC35=int2str(length(find(wsC25-.00001>0)));
        fpwout1.oC36=int2str(length(find(wsC26-.00001>0)));
        fpwout1.oC42=int2str(length(find(wsC22-.00001<=0)));
        fpwout1.oC43=int2str(length(find(wsC23-.00001<=0)));
        fpwout1.oC44=int2str(length(find(wsC24-.00001<=0)));
        fpwout1.oC45=int2str(length(find(wsC25-.00001<=0)));
        fpwout1.oC46=int2str(length(find(wsC26-.00001<=0)));
                   
        dtr1=tradeh(find(tradeh(:,9)<12.83),6);dwnr1=length(dtr1(find(dtr1-.00001>0)));
        fpwout1.oC21=sprintf('%6.0f',sum(dtr1));
        fpwout1.oC31=int2str(dwnr1);
        fpwout1.oC41=int2str(length(dtr1)-dwnr1);
                         
        fpwout1.oD11='Time C';
        fpwout1.oD21='$Net';
        fpwout1.oD31='Win';
        fpwout1.oD41='Loss';
        fpwout1.oD12='<13:30';
        fpwout1.oD13='<14:10';
        fpwout1.oD14='<14:50';
        fpwout1.oD15='<15:30';
        fpwout1.oD16='>=15:30';
            
        wsC22=tradeh(find((tradeh(:,9)>=12.83)&(tradeh(:,9)<13.50)),6);
        wsC23=tradeh(find((tradeh(:,9)>=13.50)&(tradeh(:,9)<14.16)),6);
        wsC24=tradeh(find((tradeh(:,9)>=14.16)&(tradeh(:,9)<14.83)),6);
        wsC25=tradeh(find((tradeh(:,9)>=14.83)&(tradeh(:,9)<15.50)),6);
        wsC26=tradeh(find(tradeh(:,9)>=15.50),6);
            
        fpwout1.oD22=sprintf('%6.0f',sum(wsC22));
        fpwout1.oD23=sprintf('%6.0f',sum(wsC23));
        fpwout1.oD24=sprintf('%6.0f',sum(wsC24));
        fpwout1.oD25=sprintf('%6.0f',sum(wsC25));
        fpwout1.oD26=sprintf('%6.0f',sum(wsC26));
        fpwout1.oD32=int2str(length(find(wsC22-.00001>0)));
        fpwout1.oD33=int2str(length(find(wsC23-.00001>0)));
        fpwout1.oD34=int2str(length(find(wsC24-.00001>0)));
        fpwout1.oD35=int2str(length(find(wsC25-.00001>0)));
        fpwout1.oD36=int2str(length(find(wsC26-.00001>0)));
        fpwout1.oD42=int2str(length(find(wsC22-.00001<=0)));
        fpwout1.oD43=int2str(length(find(wsC23-.00001<=0)));
        fpwout1.oD44=int2str(length(find(wsC24-.00001<=0)));
        fpwout1.oD45=int2str(length(find(wsC25-.00001<=0)));
        fpwout1.oD46=int2str(length(find(wsC26-.00001<=0)));
                        
        dtr1=tradeh(find(tradeh(:,9)>=12.83),6);dwnr1=length(dtr1(find(dtr1-.00001>0)));
        fpwout1.oD21=sprintf('%6.0f',sum(dtr1));
        fpwout1.oD31=int2str(dwnr1);
        fpwout1.oD41=int2str(length(dtr1)-dwnr1);
                      
        fpwout1.fpwsource=instruct.fpwsource;
        fpwout1.fpwusername=fpwusername;
        fpwout1.fpwusername4=fpwusername4;
        fpwout1.fpwulvl=instruct.fpwulvl;
        fpwout1.outrunindex=instruct.outrunindex;
        fpwout1.fpwoutjpeg=[fpwclientdirectory,fpwusername,'\pattern\fpwoutjpeg.jpeg']; 
                      
        sfpw1.StatusReport=[' This is the time distribution of the showing simulation section. ',time];
        templatefile = which('MPsimulationR1.html');
        str = htmlrep(sfpw1, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\twbfpwoutputR1.html'],'noheader');      
        fpwout1.FPWoutstatus=strrep([fpwclientdirectory,fpwusername,'\pattern\twbfpwoutputR1.html'],'\','/');       
         
        fpwoutwindow=21;
      end
                         
      if strcmp(outrunindex,'13')
        % trade list
        eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwfrontout']);
        name=fpwout.name;
        mname=fpwout.mname;
        datem=fpwout.datem;
        tradeh=fpwout.tradeh; 
        if ~strcmp(upper(name),'ZZXY')
          % below is going to find when is the exact exit time
          TradeET=0*tradeh(:,1)+2;
          TradeETi=0;
          if (isfield(fpwout,'dayorintra'))
            if fpwout.dayorintra==0
              instruct.hdoutonoff='0'; % No exact time info for non-intraday simulation
            end
          end
          
          if 1 % in case no intraday data to leave a way to run normally
            if (isfield(fpwout,'tradeh3'))
              tradeh3=fpwout.tradeh3;
              if (length(tradeh3(1,:))>171)
                if tradeh3(1,172)~=0
                  TradeET=tradeh3(:,172);
                  TradeETi=1;
                end
              end
            end
            
            if (TradeETi==0)&(strcmp(instruct.hdoutonoff,'1'))
              TradeETi=1;
              for i=1:length(tradeh(:,1))
                if rem(tradeh(i,7),10)==1
                  TradeET(i)=2;
                elseif rem(tradeh(i,7),10)==3
                  if fpwout.ESOchosen(1)=='1'
                    if fpwout.zhu04s=='D'
                      TradeET(i)=str2num(fpwout.zhu200);
                    else
                      wsnumticET=wsnumtme(datem(tradeh(i,3),:),tradeh(i,9),str2num(fpwout.zhu200),[mname,name]);
                      if wsnumticET(1)<=str2num(fpwout.zhu61)
                        TradeET(i)=wsnumticET(2);
                      else
                        if strcmp(upper([mname,name]),'FPY')
                          TradeET(i)=16;
                        else
                          TradeET(i)=20;
                        end
                      end
                    end
                  else
                    if strcmp(upper([mname,name]),'FPY')
                      TradeET(i)=16;
                    else
                      TradeET(i)=20;
                    end
                  end
                else % The time may not be right if the SEO price is moving/changing during a day
                  if tradeh(i,3)==tradeh(i,5)
                    myfromtimeh=tradeh(i,9);
                  else
                    myfromtimeh=2;
                  end
                  if fix(tradeh(i,7)/10)==1 % stopped out
                    TradeET2=wsgettp([mname,name],datem(tradeh(i,5),:),-tradeh(i,2),1,tradeh(i,4),myfromtimeh);    
                  else
                    TradeET2=wsgettp([mname,name],datem(tradeh(i,5),:),tradeh(i,2),1,tradeh(i,4),myfromtimeh);
                  end
                  if 0 %upper(mname)=='F'
                    TradeET(i)=TradeET2(1)+1; %wsgettp already has the correct time output.
                  else
                    TradeET(i)=TradeET2(1);
                  end
                end
              end
            end
          end
          
          if (TradeETi==1)&(strcmp(instruct.hdoutonoff,'0'))
            instruct.hdoutonoff='1'; %Once got the ExitTime data, force to show them.
          end
          
          % find TradeD:
          traded=[datem(tradeh(:,3),[3 1 2]) datem(tradeh(:,5),[3 1 2])];
          traded(find(traded(:,1)<100),1)=traded(find(traded(:,1)<100),1)+1900;
          traded(find(traded(:,1)<1950),1)=traded(find(traded(:,1)<1950),1)+100;
          traded(find(traded(:,4)<100),4)=traded(find(traded(:,4)<100),4)+1900;
          traded(find(traded(:,4)<1950),4)=traded(find(traded(:,4)<1950),4)+100;     
          TradeD=[datem(tradeh(:,3),1:3) datenum(traded(:,1:3)) datem(tradeh(:,5),1:3) datenum(traded(:,4:6))];
        else  
          runnamelist=fpwout.runnamelist;
          TradeD=fpwout.TradeD;
        end
        tradename=setstr(zeros(length(tradeh(:,1)),8)+32);
        for i=1:length(tradeh(:,1))
          if ~strcmp(upper(name),'ZZXY')
            tradename(i,1:2)=[mname,'-'];
            tradename(i,3:2+length(name))=upper(name);
          else
            if length(mname)>1
              tradename(i,1:2)=[mname(tradeh(i,13)),'-']; 
            else
              tradename(i,1:2)=[mname,'-']; 
            end   
            tradename(i,3:2+length(runnamelist{tradeh(i,13)}))=upper(runnamelist{tradeh(i,13)});
          end
        end
                      
        if instruct.hdoutonoff=='1' 
          % in the order of time, otherwise in the order of market
          [qww qiw]=sort(TradeD(:,4)+tradeh(:,9)/24);
          tradeh=tradeh(qiw,:);
          TradeD=TradeD(qiw,:);
          tradename=tradename(qiw,:);
        end
        % <a href="javascript: onclicknum(''%d'');">thenum</a>
        j=1;
        for i=1:100
          eval(['fpwoutli.TL',num2str(i),'='' '';']);
        end
        if ~((strcmp(upper(name),'ZZXY'))|(instruct.hdoutonoff=='0'))
          if tradeh(1,9)==4
            for i=length(tradeh(:,1)):-1:1 %1:length(tradeh(:,1))
              TradeETs=sprintf('%02d:%02d',fix(TradeET(i)),round(rem(TradeET(i),1)*60));
              if sign(tradeh(i,6))==1  % sign(tradeh(i,2))==1 for direction
                if sign(tradeh(i,2))==1
                  apstr=sprintf('<font color="blue"><b><a href="javascript: onclicknum(''%d'');">%04d</a>&nbsp;&nbsp;&nbsp;Buy&nbsp;&nbsp;%8s&nbsp;%5s&nbsp;&nbsp;%011.5f&nbsp;&nbsp;Exit&nbsp;%10s&nbsp;&nbsp;%5s&nbsp;&nbsp;%011.5f&nbsp;&nbsp;%2d&nbsp;&nbsp;Net&nbsp;%12.2f<br></b></font>',i,i,upper(tradename(i,:)),date2str(TradeD(i,1:3)),tradeh(i,1),date2str(TradeD(i,5:7)),TradeETs,tradeh(i,[4 7 6]));
                else
                  apstr=sprintf('<font color="blue"><b><a href="javascript: onclicknum(''%d'');">%04d</a>&nbsp;&nbsp;Sell&nbsp;&nbsp;%8s&nbsp;%5s&nbsp;&nbsp;%011.5f&nbsp;&nbsp;Exit&nbsp;%10s&nbsp;&nbsp;%5s&nbsp;&nbsp;%011.5f&nbsp;&nbsp;%2d&nbsp;&nbsp;Net&nbsp;%12.2f<br></b></font>',i,i,upper(tradename(i,:)),date2str(TradeD(i,1:3)),tradeh(i,1),date2str(TradeD(i,5:7)),TradeETs,tradeh(i,[4 7 6]));
                end
              else
                if sign(tradeh(i,2))==1
                  apstr=sprintf('<font color="red"><b><a href="javascript: onclicknum(''%d'');">%04d</a>&nbsp;&nbsp;&nbsp;Buy&nbsp;&nbsp;%8s&nbsp;%5s&nbsp;&nbsp;%011.5f&nbsp;&nbsp;Exit&nbsp;%10s&nbsp;&nbsp;%5s&nbsp;&nbsp;%011.5f&nbsp;&nbsp;%2d&nbsp;&nbsp;Net&nbsp;%12.2f<br></b></font>',i,i,upper(tradename(i,:)),date2str(TradeD(i,1:3)),tradeh(i,1),date2str(TradeD(i,5:7)),TradeETs,tradeh(i,[4 7 6]));
                else
                  apstr=sprintf('<font color="red"><b><a href="javascript: onclicknum(''%d'');">%04d</a>&nbsp;&nbsp;Sell&nbsp;&nbsp;%8s&nbsp;%5s&nbsp;&nbsp;%011.5f&nbsp;&nbsp;Exit&nbsp;%10s&nbsp;&nbsp;%5s&nbsp;&nbsp;%011.5f&nbsp;&nbsp;%2d&nbsp;&nbsp;Net&nbsp;%12.2f<br></b></font>',i,i,upper(tradename(i,:)),date2str(TradeD(i,1:3)),tradeh(i,1),date2str(TradeD(i,5:7)),TradeETs,tradeh(i,[4 7 6]));
                end                
              end     
              if length(tradeh(i,:))>12
                addstrb=[' ',sprintf('%03d',fix(tradeh(i,13))),' '];
              else
                addstrb='';
              end
              eval(['fpwoutli.TL',num2str(j),'=[fpwoutli.TL',num2str(j),',addstrb,apstr];']);
              if rem(i,250)==0 
                j=min([100 j+1]);  
              end
            end
          else  
            for i=length(tradeh(:,1)):-1:1 %1:length(tradeh(:,1))
              TradeETs=sprintf('%02d:%02d',fix(TradeET(i)),round(rem(TradeET(i),1)*60));
              if sign(tradeh(i,6))==1  % sign(tradeh(i,2))==1 for direction
                if sign(tradeh(i,2))==1  % sign(tradeh(i,2))==1 for direction
                  apstr=sprintf('<font color="blue"><b><a href="javascript: onclicknum(''%d'');">%04d</a>&nbsp;&nbsp;&nbsp;Buy&nbsp;&nbsp;%8s&nbsp;%5s&nbsp;%7s&nbsp;&nbsp;%011.5f&nbsp;&nbsp;Exit&nbsp;%10s&nbsp;&nbsp;%5s&nbsp;&nbsp;%011.5f&nbsp;&nbsp;%2d&nbsp;&nbsp;Net&nbsp;%12.2f<br></b></font>',i,i,upper(tradename(i,:)),date2str(TradeD(i,1:3)),datestr(tradeh(i,9)/24,15),tradeh(i,1),date2str(TradeD(i,5:7)),TradeETs,tradeh(i,[4 7 6]));
                else
                  apstr=sprintf('<font color="blue"><b><a href="javascript: onclicknum(''%d'');">%04d</a>&nbsp;&nbsp;Sell&nbsp;&nbsp;%8s&nbsp;%5s&nbsp;%7s&nbsp;&nbsp;%011.5f&nbsp;&nbsp;Exit&nbsp;%10s&nbsp;&nbsp;%5s&nbsp;&nbsp;%011.5f&nbsp;&nbsp;%2d&nbsp;&nbsp;Net&nbsp;%12.2f<br></b></font>',i,i,upper(tradename(i,:)),date2str(TradeD(i,1:3)),datestr(tradeh(i,9)/24,15),tradeh(i,1),date2str(TradeD(i,5:7)),TradeETs,tradeh(i,[4 7 6]));
                end                   
              else
                if sign(tradeh(i,2))==1  % sign(tradeh(i,2))==1 for direction
                  apstr=sprintf('<font color="red"><b><a href="javascript: onclicknum(''%d'');">%04d</a>&nbsp;&nbsp;&nbsp;Buy&nbsp;&nbsp;%8s&nbsp;%5s&nbsp;%7s&nbsp;&nbsp;%011.5f&nbsp;&nbsp;Exit&nbsp;%10s&nbsp;&nbsp;%5s&nbsp;&nbsp;%011.5f&nbsp;&nbsp;%2d&nbsp;&nbsp;Net&nbsp;%12.2f<br></b></font>',i,i,upper(tradename(i,:)),date2str(TradeD(i,1:3)),datestr(tradeh(i,9)/24,15),tradeh(i,1),date2str(TradeD(i,5:7)),TradeETs,tradeh(i,[4 7 6]));
                else
                  apstr=sprintf('<font color="red"><b><a href="javascript: onclicknum(''%d'');">%04d</a>&nbsp;&nbsp;Sell&nbsp;&nbsp;%8s&nbsp;%5s&nbsp;%7s&nbsp;&nbsp;%011.5f&nbsp;&nbsp;Exit&nbsp;%10s&nbsp;&nbsp;%5s&nbsp;&nbsp;%011.5f&nbsp;&nbsp;%2d&nbsp;&nbsp;Net&nbsp;%12.2f<br></b></font>',i,i,upper(tradename(i,:)),date2str(TradeD(i,1:3)),datestr(tradeh(i,9)/24,15),tradeh(i,1),date2str(TradeD(i,5:7)),TradeETs,tradeh(i,[4 7 6]));
                end 
              end              
              if length(tradeh(i,:))>12
                addstrb=[' ',sprintf('%03d',fix(tradeh(i,13))),' '];
              else
                addstrb='';
              end
              eval(['fpwoutli.TL',num2str(j),'=[fpwoutli.TL',num2str(j),',addstrb,apstr];']);
              if rem(i,250)==0 
                j=min([100 j+1]);  
              end
            end          
          end
        else
          if tradeh(1,9)==4
            for i=length(tradeh(:,1)):-1:1 %1:length(tradeh(:,1))
              if sign(tradeh(i,6))==1  % sign(tradeh(i,2))==1 for direction
                if sign(tradeh(i,2))==1
                  apstr=sprintf('<font color="blue"><b><a href="javascript: onclicknum(''%d'');">%04d</a>&nbsp;&nbsp;&nbsp;Buy&nbsp;&nbsp;%8s&nbsp;%5s&nbsp;&nbsp;%011.5f&nbsp;&nbsp;Exit&nbsp;%10s&nbsp;&nbsp;%011.5f&nbsp;&nbsp;%2d&nbsp;&nbsp;Net&nbsp;%12.2f<br></b></font>',i,i,upper(tradename(i,:)),date2str(TradeD(i,1:3)),tradeh(i,1),date2str(TradeD(i,5:7)),tradeh(i,[4 7 6]));
                else
                  apstr=sprintf('<font color="blue"><b><a href="javascript: onclicknum(''%d'');">%04d</a>&nbsp;&nbsp;Sell&nbsp;&nbsp;%8s&nbsp;%5s&nbsp;&nbsp;%011.5f&nbsp;&nbsp;Exit&nbsp;%10s&nbsp;&nbsp;%011.5f&nbsp;&nbsp;%2d&nbsp;&nbsp;Net&nbsp;%12.2f<br></b></font>',i,i,upper(tradename(i,:)),date2str(TradeD(i,1:3)),tradeh(i,1),date2str(TradeD(i,5:7)),tradeh(i,[4 7 6]));
                end
              else
                if sign(tradeh(i,2))==1
                  apstr=sprintf('<font color="red"><b><a href="javascript: onclicknum(''%d'');">%04d</a>&nbsp;&nbsp;&nbsp;Buy&nbsp;&nbsp;%8s&nbsp;%5s&nbsp;&nbsp;%011.5f&nbsp;&nbsp;Exit&nbsp;%10s&nbsp;&nbsp;%011.5f&nbsp;&nbsp;%2d&nbsp;&nbsp;Net&nbsp;%12.2f<br></b></font>',i,i,upper(tradename(i,:)),date2str(TradeD(i,1:3)),tradeh(i,1),date2str(TradeD(i,5:7)),tradeh(i,[4 7 6]));
                else
                  apstr=sprintf('<font color="red"><b><a href="javascript: onclicknum(''%d'');">%04d</a>&nbsp;&nbsp;Sell&nbsp;&nbsp;%8s&nbsp;%5s&nbsp;&nbsp;%011.5f&nbsp;&nbsp;Exit&nbsp;%10s&nbsp;&nbsp;%011.5f&nbsp;&nbsp;%2d&nbsp;&nbsp;Net&nbsp;%12.2f<br></b></font>',i,i,upper(tradename(i,:)),date2str(TradeD(i,1:3)),tradeh(i,1),date2str(TradeD(i,5:7)),tradeh(i,[4 7 6]));
                end                
              end              
              if length(tradeh(i,:))>12
                addstrb=[' ',sprintf('%03d',fix(tradeh(i,13))),' '];
              else
                addstrb='';
              end
              eval(['fpwoutli.TL',num2str(j),'=[fpwoutli.TL',num2str(j),',addstrb,apstr];']);
              if rem(i,250)==0 
                j=min([100 j+1]);  
              end
            end
          else  
            for i=length(tradeh(:,1)):-1:1 %1:length(tradeh(:,1))
              if sign(tradeh(i,6))==1  % sign(tradeh(i,2))==1 for direction
                if sign(tradeh(i,2))==1  % sign(tradeh(i,2))==1 for direction
                  apstr=sprintf('<font color="blue"><b><a href="javascript: onclicknum(''%d'');">%04d</a>&nbsp;&nbsp;&nbsp;Buy&nbsp;&nbsp;%8s&nbsp;%5s&nbsp;%7s&nbsp;&nbsp;%011.5f&nbsp;&nbsp;Exit&nbsp;%10s&nbsp;&nbsp;%011.5f&nbsp;&nbsp;%2d&nbsp;&nbsp;Net&nbsp;%12.2f<br></b></font>',i,i,upper(tradename(i,:)),date2str(TradeD(i,1:3)),datestr(tradeh(i,9)/24,15),tradeh(i,1),date2str(TradeD(i,5:7)),tradeh(i,[4 7 6]));
                else
                  apstr=sprintf('<font color="blue"><b><a href="javascript: onclicknum(''%d'');">%04d</a>&nbsp;&nbsp;Sell&nbsp;&nbsp;%8s&nbsp;%5s&nbsp;%7s&nbsp;&nbsp;%011.5f&nbsp;&nbsp;Exit&nbsp;%10s&nbsp;&nbsp;%011.5f&nbsp;&nbsp;%2d&nbsp;&nbsp;Net&nbsp;%12.2f<br></b></font>',i,i,upper(tradename(i,:)),date2str(TradeD(i,1:3)),datestr(tradeh(i,9)/24,15),tradeh(i,1),date2str(TradeD(i,5:7)),tradeh(i,[4 7 6]));
                end                   
              else
                if sign(tradeh(i,2))==1  % sign(tradeh(i,2))==1 for direction
                  apstr=sprintf('<font color="red"><b><a href="javascript: onclicknum(''%d'');">%04d</a>&nbsp;&nbsp;&nbsp;Buy&nbsp;&nbsp;%8s&nbsp;%5s&nbsp;%7s&nbsp;&nbsp;%011.5f&nbsp;&nbsp;Exit&nbsp;%10s&nbsp;&nbsp;%011.5f&nbsp;&nbsp;%2d&nbsp;&nbsp;Net&nbsp;%12.2f<br></b></font>',i,i,upper(tradename(i,:)),date2str(TradeD(i,1:3)),datestr(tradeh(i,9)/24,15),tradeh(i,1),date2str(TradeD(i,5:7)),tradeh(i,[4 7 6]));
                else
                  apstr=sprintf('<font color="red"><b><a href="javascript: onclicknum(''%d'');">%04d</a>&nbsp;&nbsp;Sell&nbsp;&nbsp;%8s&nbsp;%5s&nbsp;%7s&nbsp;&nbsp;%011.5f&nbsp;&nbsp;Exit&nbsp;%10s&nbsp;&nbsp;%011.5f&nbsp;&nbsp;%2d&nbsp;&nbsp;Net&nbsp;%12.2f<br></b></font>',i,i,upper(tradename(i,:)),date2str(TradeD(i,1:3)),datestr(tradeh(i,9)/24,15),tradeh(i,1),date2str(TradeD(i,5:7)),tradeh(i,[4 7 6]));
                end 
              end         
              if length(tradeh(i,:))>12
                addstrb=[' ',sprintf('%03d',fix(tradeh(i,13))),' '];
              else
                addstrb='';
              end
              eval(['fpwoutli.TL',num2str(j),'=[fpwoutli.TL',num2str(j),',addstrb,apstr];']);
              if rem(i,250)==0 
                j=min([100 j+1]);  
              end
            end          
          end
        end
        fpwoutli.outMXI=int2str(length(tradeh(:,1)));
        fpwoutwindow=2;
      end
                     
      if strcmp(outrunindex,'14')
        % Forward simulation
        eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwfrontout']);
        global mname name stock datem
        name=fpwout.name;   mname=fpwout.mname;
        datem=fpwout.datem; tradeh=fpwout.tradeh; stock=fpwout.stock; 
        if strcmp(upper(name),'ZZXY')
          runnamelist=fpwout.runnamelist;
          TradeD=fpwout.TradeD;
        else   
          TradeD=datem(tradeh(:,3),1:3);         
        end
              
        outFSspan=instruct.outFSspan;
        unitnet=wsun(name);
        Mname1=mname; Name1=name;
        if strcmp(outFSspan,'DD')
          %th=tradeh(:,[1 2 3 9]); %[enp dire enw entime] % limited to 10000
          thn=35;
          ostg=zeros(min([100000 length(tradeh(:,1))]),2*length(thn)); %[ML MW first Final];for win first: first=1;
          rnli=0;
          for i=1:min([100000 length(tradeh(:,1))])
            if ~strcmp(upper(name),'ZZXY')
              tradeh(i,13)=0;
            end
            if tradeh(i,13)~=rnli
              unitnet=wsun(noempty(runnamelist{tradeh(i,13)}));
              if length(mname)==1  
                marketrun=noempty(runnamelist{tradeh(i,13)});
                if strcmp(fpwout.MMFS,'Future')
                  if length(marketrun)==1
                    marketrun(2)='_';
                  end        
                  if strcmp(fpwout.MM12,'No.1')
                    eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data4\',marketrun,'output']);
                  elseif strcmp(fpwout.MM12,'No.2')
                    eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data5\',marketrun,'output']);
                  else
                    eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data0\',marketrun,'output']);        
                  end
                else
                  if strcmp(fpwout.MM12,'No.1')
                    eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\stock1\rts',marketrun]);
                  elseif strcmp(fpwout.MM12,'No.2')
                    eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\stock2\rts',marketrun]);
                  else
                    eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\stockd1\rts',marketrun]);        
                  end         
                end  
              else
                eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data21\fpwoutput',num2str(tradeh(i,13))]);  
              end
              stock=fpwout.stock;
              rnli=tradeh(i,13);
            end
                
            if tradeh(i,3)+thn-1<=length(stock(:,1))
              if tradeh(i,2)==1
                ostg(i,[1:2:2*thn-1])=unitnet*[0 (stock(tradeh(i,3)+1:tradeh(i,3)+thn-1,1)-tradeh(i,1))'];
                ostg(i,[2:2:2*thn])=unitnet*(stock(tradeh(i,3):tradeh(i,3)+thn-1,4)-tradeh(i,1))';
              else
                ostg(i,[1:2:2*thn-1])=unitnet*[0 (tradeh(i,1)-stock(tradeh(i,3)+1:tradeh(i,3)+thn-1,1))'];
                ostg(i,[2:2:2*thn])=unitnet*(tradeh(i,1)-stock(tradeh(i,3):tradeh(i,3)+thn-1,4))';
              end
            else
              ostg(i,:)=ostg(i,:)-1; 
            end
          end
          ostg=ostg(find(ostg(:,1)==0),2:2*thn);
          for i=1:2*thn-1
            heretstat(i,1)=tstat(ostg(:,i));
          end
          stockmean=(mean(ostg))';
          stockstd=(std(ostg))';
          stock=[stockmean stockmean+stockstd/2 stockmean-stockstd/2 stockmean heretstat];
          if ~strcmp(upper(name),'ZZXY')
            tdsim=[(fix((1:length(stock(:,1)))/2)+1)' fix(stockmean*100/unitnet) fix(stockstd*100/unitnet) fix(stockmean) stock(:,5)];
            fpwfs.outfsform='Evol-Length&nbsp;&nbsp;&nbsp;Mean*100&nbsp;&nbsp;&nbsp;Std*100&nbsp;&nbsp;&nbsp;DollarValue&nbsp;&nbsp;&nbsp;T-Stat*100';
          else  
            tdsim=[(fix((1:length(stock(:,1)))/2)+1)' fix(stockmean) fix(stockstd) fix(stockmean) stock(:,5)];   
            fpwfs.outfsform='Evol-Length&nbsp;&nbsp;&nbsp;DollarValueMean&nbsp;&nbsp;&nbsp;DollarValueStd&nbsp;&nbsp;&nbsp;T-Stat*100';
          end
        else
          %th=tradeh(:,[1 2 3 9]); %[enp dire enw entime]
          thn=15;tdN='T';
          if strcmp(outFSspan,'T60')
            lele2=12; lele1='60';
          elseif strcmp(outFSspan,'T30')
            lele2=6; lele1='30';
          elseif strcmp(outFSspan,'T15')
            lele2=3; lele1='15';
          elseif strcmp(outFSspan,'T05')
            lele2=1; lele1='05';
          end
          ostg=zeros(min([100000 length(tradeh(:,1))]),99);
          rnli=0;
          for i=1:min([100000 length(tradeh(:,1))])
            if ~strcmp(upper(Name1),'ZZXY')
              tradeh(i,13)=0;
            end
            if tradeh(i,13)~=rnli
              if length(Mname1)==1  
                name=noempty(runnamelist{tradeh(i,13)});
              else
                mname=Mname1(tradeh(i,13));
                name=noempty(runnamelist{tradeh(i,13)});
              end
              unitnet=wsun(name);
              rnli=tradeh(i,13);
            end              
                
            ticd=wsgetdan(TradeD(i,1:3),tradeh(i,9),lele2*100,[mname,name]);
            if length(ticd)==0
              [ticd1 ticd2 ticd3]=wsgetdat(TradeD(i,1:3),2,24);
              if length(ticd3)>0
                ticd4=ticd3(length(ticd3(:,1)),4)+ticd3(length(ticd3(:,1)),5)/60;
                if tradeh(i,9)>ticd4
                  ticd=wsgetdan(TradeD(i,1:3),ticd4,lele2*100,[mname,name]);
                end
              end
            end
            
            if length(ticd)>0
              if length(ticd(:,1))>=lele2*100
                if strcmp(outFSspan,'T60')
                  ostg(i,:)=(ticd(1:12:12*99,4))';
                elseif strcmp(outFSspan,'T30')
                  ostg(i,:)=(ticd(1:6:6*99,4))';
                elseif strcmp(outFSspan,'T15')
                  ostg(i,:)=(ticd(1:3:3*99,4))';
                elseif strcmp(outFSspan,'T05')
                  ostg(i,:)=(ticd(1:99,4))';
                end
                if tradeh(i,2)==1
                  ostg(i,:)=unitnet*(ostg(i,:)-tradeh(i,1));
                else
                  ostg(i,:)=unitnet*(tradeh(i,1)-ostg(i,:));
                end
              else
                ostg(i,1)=31234;
              end
            else
              ostg(i,1)=31234;  
            end 
          end
          
          ostg=ostg(find(ostg(:,1)~=31234),:);
          if length(ostg)==0
            error('No tick data available for this forward simulation.');
          end
           
          for i=1:99
            heretstat(i,1)=tstat(ostg(:,i));
          end
          stockmean=(mean(ostg))';
          stockstd=(std(ostg))';
          stock=[stockmean stockmean+stockstd/2 stockmean-stockstd/2 stockmean heretstat];
          if ~strcmp(upper(Name1),'ZZXY')
            tdsim=[(1:length(stock(:,1)))' fix(stockmean*100/unitnet) fix(stockstd*100/unitnet) fix(stockmean) stock(:,5)];
            fpwfs.outfsform='Evol-Length&nbsp;&nbsp;&nbsp;Mean*100&nbsp;&nbsp;&nbsp;Std*100&nbsp;&nbsp;&nbsp;DollarValue&nbsp;&nbsp;&nbsp;T-Stat*100';
          else
            tdsim=[(1:length(stock(:,1)))' fix(stockmean) fix(stockstd) fix(stockmean) stock(:,5)];
            fpwfs.outfsform='Evol-Length&nbsp;&nbsp;&nbsp;DollarValueMean&nbsp;&nbsp;&nbsp;DollarValueStd&nbsp;&nbsp;&nbsp;T-Stat*100';
          end
        end 
                  
        fpwfs.outfsstat='';
        for i=1:length(tdsim(:,1))
          if ~strcmp(upper(Name1),'ZZXY')
            if ~strcmp(outFSspan,'DD')
              fpwfs.outfsstat=[fpwfs.outfsstat,sprintf(['      On No.%3d   -   ',num2str(str2num(outFSspan(2:3))),' Minutes close          %6d         %6d         %6d          %6.2f\n'],tdsim(i,1:5))];  
            else
              if rem(i,2)==0
                fpwfs.outfsstat=[fpwfs.outfsstat,sprintf('      On No.%3d  day''s Open           %6d         %6d         %6d          %6.2f\n',tdsim(i,1:5))]; 
              else
                fpwfs.outfsstat=[fpwfs.outfsstat,sprintf('      On No.%3d-  day''s Close           %6d         %6d         %6d          %6.2f\n',tdsim(i,1:5))]; 
              end  
            end
          else
            if ~strcmp(outFSspan,'DD')
              fpwfs.outfsstat=[fpwfs.outfsstat,sprintf(['      On No.%3d   -   ',num2str(str2num(outFSspan(2:3))),' Minutes close          %6d         %6d          %6.2f\n'],tdsim(i,[1 2 3 5]))];  
            else
              if rem(i,2)==0
                fpwfs.outfsstat=[fpwfs.outfsstat,sprintf('      On No.%3d  day''s Open           %6d         %6d          %6.2f\n',tdsim(i,[1 2 3 5]))]; 
              else
                fpwfs.outfsstat=[fpwfs.outfsstat,sprintf('      On No.%3d  day''s Close           %6d         %6d          %6.2f\n',tdsim(i,[1 2 3 5]))]; 
              end  
            end
          end
        end
                     
        Fig1=figure('pos',[2 4 635 434],'color','k','visible','off');
        zhu27r=axes('position',[0.091 0.353 .89 .62]);
        zhu28r=axes('position',[0.091 0.061 .89 .25]);        
        subplot(zhu27r)
        hold off
        stock=[stock(1,:);stock/1000];
        yrs=length(stock(:,1))-1;  x=[1:yrs];
        closeh=stock(:,4); high=stock(:,2); low=stock(:,3); open=stock(:,1); vol=stock(:,5)*1000;
        X1=1:yrs; X2=X1-.35; X3=X1+.35;
        X(1:yrs,1:2)=[X1' X1']; X4(1:yrs,1:2)=[X2' X1']; X5(1:yrs,1:2)=[X1' X3'];
        line(1:yrs,1:2)=[low(2:yrs+1) high(2:yrs+1)];
        line1(1:yrs,1:2)=[closeh(2:yrs+1) closeh(2:yrs+1)];
        line2(1:yrs,1:2)=[open(2:yrs+1) open(2:yrs+1)];
        plot(x(1),closeh(2),'k');hold on;
        for I=1:yrs
          plot(X(I,:),line(I,:),'g','linewidth',.125);
          plot(X4(I,:),line2(I,:),'-w','linewidth',.125)
          plot(X5(I,:),line1(I,:),'-w','linewidth',.125)    
        end
        ylabel('close: Mean, range: STD in K$');
        grid; set(gca,'Xcolor',[0.5 0.5 0.5]);
        set(gca,'Ycolor',[0.5 0.5 0.5]);        
                    
        subplot(zhu28r)
        hold off
        vol=stock(:,5)*1000+.0001;
        barg(([vol(2:length(vol))]));
        ylabel('T-Stat');
        if strcmp(outFSspan,'DD')
          chgstday;
        end
        grid; set(gca,'Xcolor',[0.5 0.5 0.5]);
        set(gca,'Ycolor',[0.5 0.5 0.5]);        
                    
        set(zhu27r,'color',get(gcf,'color'));
        set(zhu28r,'color',get(gcf,'color'));
        %set(zhu27r,'xcolor','w');
        xlo=get(zhu27r,'Xtick');
        for i=1:length(xlo);
          xln(i)=' ';    
        end
        set(zhu27r,'XTickLabel',xln);
                     
        %set(zhu27r,'ycolor','w');
        %set(zhu28r,'xcolor','w');
        %set(zhu28r,'ycolor','w');  
        set(Fig1,'inverthardcopy','off'); hold off
        set(Fig1,'PaperPosition',[.25 .25 6 4]);
        cd([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern']);
        drawnow;
        wsprintjpeg(Fig1,'outfsjpeg.jpeg'); 
        close(Fig1);
        fpwfs.outfsjpeg=[fpwclientdirectory,fpwusername,'\pattern\outfsjpeg.jpeg'];
        fpwfs.outfsspan=outFSspan;
        fpwoutwindow=5;
      end        
                    
      if strcmp(outrunindex,'16')
        % the big Any; goals for this section is to find fpwout1.oCxx and oDxx
        eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwfrontout']);   
        global mname name stock datem PatSeed PatWeight MyPat
        name=fpwout.name; mname=fpwout.mname; Mname1=mname; Name1=name; 
        datem=fpwout.datem; stock=fpwout.stock; sj=datem;
        tradeh=fpwout.tradeh; tradeo=fpwout.tradeo; tradeeach=fpwout.tradeeach;
        if isfield(fpwout,'tradelots')
          tradelots=fpwout.tradelots;
        end
        
        if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwpatseed.mat'])==2
          eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwpatseed PatSeed']);
          PatSeed=PatSeed;
        else
          PatSeed=zeros(20,50)+10;
        end
        PatWeight=PatSeed(1,:);
        MyPat=PatSeed(2,:);
        
        if isfield(fpwout,'DDw')
          DDw=fpwout.DDw;
          DDwj=fpwout.DDwj;
        else
          DDw=[];
          DDwj=[];
        end
        load c:\matlab\pattern\tradehsizes.mat
        if isfield(fpwout,'tradeh2')
          tradeh2=fpwout.tradeh2;
          if length(tradeh2(1,:))<TradehSizes(1)
            tradeh2=[tradeh2 0*tradeh2(:,1:(TradehSizes(1)-length(tradeh2(1,:))))]; % add D and R items for earlier simulation outputs
          end
        else
          tradeh2=[];
        end
        if isfield(fpwout,'tradeh3')
          tradeh3=fpwout.tradeh3;
          if length(tradeh3(1,:))<TradehSizes(2)
            tradeh3=[tradeh3 0*tradeh3(:,1:(TradehSizes(2)-length(tradeh3(1,:))))]; % add D and R items for earlier simulation outputs
          end
        else
          tradeh3=[];
        end
        net=fpwout.net; net1=fpwout.net1; lotshis=fpwout.lotshis;
        if strcmp(upper(name),'ZZXY')
          runnamelist=fpwout.runnamelist;
          TradeD=fpwout.TradeD;
          if length(Mname1)==1 
            MMFS=fpwout.MMFS; MM12=fpwout.MM12;    
          end
        else   
          TradeD=datem(tradeh(:,3),1:3);          
        end
        unitnet=wsun(name);  
        tickstep=wsts(name); t=tickstep;
        tickchg=0;
        wafw=instruct.outAnyU;
        watw=instruct.outAnyD;        
        wti=str2num(instruct.outAnyS);
        Wti=wti;wti=abs(wti);          
        if wti>10000
          tickstep=wti/100-100; t=tickstep;
          wti=10; tickchg=1;
        end   
        wsro=zeros(length(tradeh(:,2)),1);
        TrT=wsro; TD=TradeD; TDT=[TD(:,1:3) tradeh(:,9)];
        
        if ((length(findstr(wafw,'LABAC'))>0)|(length(findstr(watw,'LABAC'))>0))+...
          ((length(findstr(upper(wafw),'VCRAF'))>0)|(length(findstr(upper(watw),'VCRAF'))>0))+...
          ((length(findstr(upper(wafw),'STATOUT'))>0)|(length(findstr(upper(watw),'STATOUT'))>0))>1
          error('  VCRAF, STATOUT and LABAC could not work at the same time.');
        end        
        
        if (length(findstr(wafw,'LABAC'))>0)|(length(findstr(watw,'LABAC'))>0)
          [LABAC LABACONH]=lotsabac(tradeh,datem);
        end
        HMSTCEii=0; % not use for anything so far
        ruleoutT=[]; BugPlace=[]; wafwOri=0;
        
        % to make a over night limit to work, use string 'LABAC(ii,3)<=XXX' in wafw (upper area)
        % once find noempy(wafw) contains LABAC(ii,3)<=, will do following:
        if length(findstr(noempty(wafw),'LABAC(ii,3)'))>0
          if length(findstr(wafw,'='))==0
            error(' The right format is "LABAC(ii,3)<=XXX" in the upper area.');    
          end            
          MyONL=str2num(wafw(findstr(wafw,'=')+1:length(wafw)));
          wafwOri=1;
          %wafw='1';
          %watw='0.05'; % basically to disable lower area.
          % below are codes to limit overnight position to MyONL
          % It will effect: tradeh, tradeo. tradeeach, net, net1, lotshis, LABAC and LABACONH
          MySC15=str2num(fpwout.zhu75);
          if isfield(fpwout,'zhusc75')
            zhusc75=fpwout.zhusc75;
          else
            zhusc75=[];
          end
          HMSTCEi=0; % indicator for How Many Surplus Trades Closed Earlier, or risk reduced.
          tradeh_original=tradeh;
          for Onlhi=1:length(tradeh(:,1))
            if tradeh(Onlhi,5)>tradeh(Onlhi,3)
              if (abs(LABAC(Onlhi,3))>MyONL)&(abs(LABACONH(tradeh(Onlhi,3),2))>MyONL) 
                % surplus over night position that needs to close at the close
                LABACONH(tradeh(Onlhi,3):tradeh(Onlhi,5)-1,2)=LABACONH(tradeh(Onlhi,3):tradeh(Onlhi,5)-1,2)-tradeh(Onlhi,2);
                lotshis(tradeh(Onlhi,3):tradeh(Onlhi,5)-1,tradeh(Onlhi,12))=lotshis(tradeh(Onlhi,3):tradeh(Onlhi,5)-1,tradeh(Onlhi,12))-tradeh(Onlhi,2);
                if tradeh(Onlhi,3)==tradeeach(tradeh(Onlhi,10))
                  if 2*(tradeh(Onlhi,5)-tradeh(Onlhi,3)+1)~=tradeh(Onlhi,11)-tradeh(Onlhi,10)+1
                    if length(tradeh(1,:))>=13
                      BugPlace=[BugPlace; Onlhi 1 tradeh(Onlhi,12:13)];
                    else
                      BugPlace=[BugPlace; Onlhi 1];
                    end
                    if length(BugPlace(:,1))<=1
                      save c:\matlab\pattern\mybug20160514.mat tradeh tradeeach lotshis stock datem BugPlace
                    else
                      save -append c:\matlab\pattern\mybug20160514.mat BugPlace
                    end
                    if 0
                      if length(tradeh(1,:))>=13
                        error([' tradeh and tradeeach not match! -2, ',int2str(zhusc75(tradeh(Onlhi,13)))]);
                      else
                        error(' tradeh and tradeeach not match! -2');
                      end
                    end
                  end    
                  % This is only right for one day overnight signals!
                  % for more accurate, one needs to know exact PosiBook that day.
                  tradeeachi=[tradeh(Onlhi,10) fix(mean(tradeh(Onlhi,10:11)))];
                  tradeeachi=[tradeeachi tradeeachi(2)+1 tradeh(Onlhi,11)];
                  lotshis(tradeh(Onlhi,3),tradeh(Onlhi,12))=lotshis(tradeh(Onlhi,3),tradeh(Onlhi,12))+tradeh(Onlhi,2);
                  if length(tradeh(1,:))>=13
                    NewNet=tradeeach(tradeeachi(3))-zhusc75(tradeh(Onlhi,13));
                  else
                    NewNet=tradeeach(tradeeachi(3))-MySC15;
                  end
                  net1(tradeh(Onlhi,3))=net1(tradeh(Onlhi,3))-tradeh(Onlhi,6)+NewNet; %(count at signal day only)             
                  tradeh(Onlhi,6)=NewNet;
                  tradeo(Onlhi,:)=[tradeh(Onlhi,3) stock(tradeh(Onlhi,3),4) 23];                
                  net(tradeeach(tradeeachi(1):tradeeachi(2)))=net(tradeeach(tradeeachi(1):tradeeachi(2)))-...
                    tradeeach(tradeeachi(3):tradeeachi(4));
                  tradeeach(tradeeachi(3))=NewNet;
                  tradeeach(tradeeachi(3)+1:tradeeachi(4))=0*tradeeach(tradeeachi(3)+1:tradeeachi(4));
                  net(tradeeach(tradeeachi(1):tradeeachi(2)))=net(tradeeach(tradeeachi(1):tradeeachi(2)))+...
                    tradeeach(tradeeachi(3):tradeeachi(4));
                  tradeh(Onlhi,5)=tradeh(Onlhi,3);
                else % trigered at close, so simply as no trade
                  if 2*(tradeh(Onlhi,5)-tradeh(Onlhi,3))~=tradeh(Onlhi,11)-tradeh(Onlhi,10)+1
                    if length(tradeh(1,:))>=13
                      BugPlace=[BugPlace; Onlhi 2 tradeh(Onlhi,12:13)];
                    else
                      BugPlace=[BugPlace; Onlhi 2];
                    end
                    if length(BugPlace(:,1))<=1
                      save c:\matlab\pattern\mybug20160514.mat tradeh tradeeach lotshis stock datem BugPlace
                    else
                      save -append c:\matlab\pattern\mybug20160514.mat BugPlace
                    end
                    if 0
                      if length(tradeh(1,:))>=13
                        error([' tradeh and tradeeach not match! -2, ',int2str(zhusc75(tradeh(Onlhi,13)))]);
                      else
                        error(' tradeh and tradeeach not match! -2');
                      end
                    end
                  end  
                  tradeeachi=[tradeh(Onlhi,10) fix(mean(tradeh(Onlhi,10:11)))];
                  tradeeachi=[tradeeachi tradeeachi(2)+1 tradeh(Onlhi,11)];
                  NewNet=0;
                  net1(tradeh(Onlhi,3))=net1(tradeh(Onlhi,3))-tradeh(Onlhi,6)+NewNet; %(count at signal day only)             
                  tradeh(Onlhi,6)=NewNet;
                  tradeo(Onlhi,:)=[tradeh(Onlhi,3) stock(tradeh(Onlhi,3),4) 23];                
                  net(tradeeach(tradeeachi(1):tradeeachi(2)))=net(tradeeach(tradeeachi(1):tradeeachi(2)))-...
                    tradeeach(tradeeachi(3):tradeeachi(4));
                  tradeeach(tradeeachi(3))=NewNet;
                  tradeeach(tradeeachi(3)+1:tradeeachi(4))=0*tradeeach(tradeeachi(3)+1:tradeeachi(4));
                  net(tradeeach(tradeeachi(1):tradeeachi(2)))=net(tradeeach(tradeeachi(1):tradeeachi(2)))+...
                    tradeeach(tradeeachi(3):tradeeachi(4));
                  tradeh(Onlhi,5)=tradeh(Onlhi,3);
                  ruleoutT=[ruleoutT;Onlhi];
                end
                HMSTCEi=HMSTCEi+1;
                clear tradeeachi
              end          
            end
          end
          if HMSTCEi>0
            HMSTCEii=0;
          end
          clear MyONL MySC15 Onlhi
        end
        
        % to make a volatility risk limit to work, use string 'VCRAF<=XXX...' in wafw (upper area)
        % once find noempy(wafw) contains VCRAF<=, will do following:
        if length(findstr(noempty(upper(wafw)),'VCRAF'))>0
          if length(findstr(wafw,'='))==0
            error(' The right format is "VCRAF(ii)<=XXX..." or "VCRAF<=XXX..." in the upper area.');    
          end            
          MyONL=wafw(findstr(wafw,'=')+1:length(wafw));
          MyONLv=1;
          VCRAFi=1;
          wafwOri=2;
          %wafw='1';
          %watw='0.05'; % basically to disable lower area.
          % below are codes to limit volatility risk to MyONL
          % It will effect: tradeh, tradeeach, net, net1, lotshis
          
          HMSTCEi=0; % indicator for How Many Surplus Trades Closed Earlier, or risk reduced.
          tradeh_original=tradeh;
          o=stock(:,1); h=stock(:,2); l=stock(:,3); c=stock(:,4); v=stock(:,5); TH=tradeh;
          for ii=1:length(tradeh(:,1))
            i=tradeh(ii,3);
            eval(['MyONLv=',MyONL,';']);
            if vo(h,l,i-1,5)>MyONLv
              VCRAFi=round(100*MyONLv/vo(h,l,i-1,5))/100;
              % risk day find, trading volume need to reduce
              lotshis(tradeh(ii,3):tradeh(ii,5)-1,tradeh(ii,12))=VCRAFi*lotshis(tradeh(ii,3):tradeh(ii,5)-1,tradeh(ii,12));
              net1(tradeh(ii,3))=net1(tradeh(ii,3))-(1-VCRAFi)*tradeh(ii,6); %(count at signal day only)             
              tradeh(ii,6)=VCRAFi*tradeh(ii,6);
              tradeh(ii,2)=VCRAFi*tradeh(ii,2);
              tradeeachi=[tradeh(ii,10) fix(mean(tradeh(ii,10:11)))];
              tradeeachi=[tradeeachi tradeeachi(2)+1 tradeh(ii,11)];
              net(tradeeach(tradeeachi(1):tradeeachi(2)))=net(tradeeach(tradeeachi(1):tradeeachi(2)))-...
                (1-VCRAFi)*tradeeach(tradeeachi(3):tradeeachi(4));
              tradeeach(tradeeachi(3):tradeeachi(4))=VCRAFi*tradeeach(tradeeachi(3):tradeeachi(4));
              HMSTCEi=HMSTCEi+1;
              clear tradeeachi    
            end
          end
          clear MyONL MyONLv VCRAFi ii
        end
        
        % to avoid tick optimize function mistakely click:
        if (length(findstr(upper(wafw),'TICK'))>0)|...
          (length(findstr(upper(wafw),'NEW'))>0)|...
          (length(findstr(upper(wafw),'LONG'))>0)
          wafwOri=4; HMSTCEi=0;
        end      
        % To avoid view format operration mistakely click:
        if (length(findstr(upper(watw),'FORM'))>0)
          wafwOri=5; HMSTCEi=0;
        end     
        
        % to make a Sata Output, use string 'STATOUT==XXX...' in wafw (upper area)
        % once find noempy(wafw) contains STATOUT, will do following:
        if length(findstr(noempty(upper(wafw)),'STATOUT'))>0
          if length(findstr(wafw,':'))==0
            error(' The right format is "STATOUT:XXX..." in the upper area.');    
          end            
          MyONL=wafw(findstr(wafw,':')+1:length(wafw));
          wafwOri=3;
          %wafw='1';
          %watw='0.05'; % basically to disable lower area.
          % below are codes to limit volatility risk to MyONL
          % It will effect: tradeh, tradeeach, net, net1, lotshis
          
          HMSTCEi=0;
          tradeh_original=tradeh;
          o=stock(:,1); h=stock(:,2); l=stock(:,3); c=stock(:,4); v=stock(:,5); TH=tradeh;
          eval(['HMSTCEi=length(find(',MyONL,'));']);
          clear MyONL
        end
        
        % wsanystr begins here  
        if ~strcmp(upper(name),'ZZXY')
          datemws2=datem;
          t=tickstep;  ws2ws2ws2=0;
          %ruleoutT=[];
          if ~strcmp(instruct.outGOsm,'UrSym')
            namews2=noempty(instruct.outGOsm);
            if length(namews2)>1
              if ~strcmp(upper([mname name]),upper(namews2))
                if (upper(namews2(1))=='F')+(upper(namews2(1))=='S')==0
                  error(' - Secondary market name format: F/S then followed by future/stock symbol.');
                end
                [stock datem]=fsdaydat(namews2);
                if ~length(stock)
                  error(' - Secondary market is not existed, check symbol, please.');
                end
                for ws2loop=1:length(tradeh(:,1))
                  ws2loopj=dmatch(tradeh(ws2loop,3),datemws2,datem);    
                  if (length(ws2loopj)==1)
                    if (ws2loopj>14)
                      tradeh(ws2loop,3)=ws2loopj;
                    else
                      ruleoutT=[ruleoutT;ws2loop];
                    end
                  else
                    ruleoutT=[ruleoutT;ws2loop];
                  end
                  clear ws2loopj
                end
                ws2ws2ws2=1;
                mname=upper(namews2(1)); name=upper(namews2(2:length(namews2))); 
                if tickchg==0
                  tickstep=wsts(name);
                end
                clear ws2loop
              end
            else
              error(' - Did not enter a right secondary market symbol. Secondary market name format: F/S then followed by future/stock symbol.');  
            end
          end        
          % The above is only right when the entered secondary market is trading
          % when the signal is triggered for PM, and should close later than PM
          % trading hours, otherwise it could go wrong at open and close area
          % Important Notice: If there are more than one signal in the same day
          % this way may have wrong result 
          
          o=stock(:,1); h=stock(:,2); l=stock(:,3); c=stock(:,4); v=stock(:,5); TH=tradeh;
          if 1 % The below vectors variables can be directly used in any, like [o h l c v]
               % They re corresponding to 'NEW' and 'LONG' optimizing matix in fpwmodelpat, fpwanyot1 and ...
            if length(findstr(wafw,'Dadx'))+length(findstr(watw,'Dadx'))
              Dadx=adx(stock); Dadxm=mtm(Dadx,1); Dadxma3=ma(Dadx,3); Dadxma3m=mtm(Dadxma3,1);
            end
            if length(findstr(wafw,'Dcci'))+length(findstr(watw,'Dcci'))
              Dcci=cci(stock); Dccim=mtm(Dcci,1);
            end
            if length(findstr(wafw,'Dpsar'))+length(findstr(watw,'Dpsar'))
              Dpsar=psar(stock); Dpsard=Dpsar(:,2); Dpsar=Dpsar(:,1); Dpsardma3=ma(Dpsard,3);
            end
            if length(findstr(wafw,'wpr'))+length(findstr(watw,'wpr'))
              Dwpr=wpr(stock); Dwprm=mtm(Dwpr,1);
              Dwpr7=wpr(stock,0,7); Dwpr7m=mtm(Dwpr7,1);
              Dwpr14=Dwpr; Dwpr14m=Dwprm;
              Dwpr28=wpr(stock,0,28); Dwpr28m=mtm(Dwpr28,1);
              Dwpr50=wpr(stock,0,50); Dwpr50m=mtm(Dwpr50,1);
              Dwpr110=wpr(stock,0,110); Dwpr110m=mtm(Dwpr110,1);
              Dwpr220=wpr(stock,0,220); Dwpr220m=mtm(Dwpr220,1);
            end
            if length(findstr(wafw,'vri'))+length(findstr(watw,'vri'))
              Dvri=vri(stock); Dvri22=Dvri;
              Dvri5=vri(stock,0,5); Dvri10=vri(stock,0,10);
            end
            if length(findstr(wafw,'Dmfi'))+length(findstr(watw,'Dmfi'))
              Dmfi=mfi(stock); Dmfim=mtm(Dmfi,1);
            end
            if length(findstr(wafw,'Dtsi'))+length(findstr(watw,'Dtsi'))
              Dtsi=tsi(stock(:,4)); Dtsim=mtm(Dtsi,1);
            end
            if length(findstr(wafw,'Dpc'))+length(findstr(watw,'Dpc'))
              Dpc=pc(stock); Dpc1=Dpc(:,1); Dpc2=Dpc(:,2); Dpc3=Dpc(:,3); clear dpc
              Dpc2m=mtm(Dpc2,1); Dpc2ma3=ma(Dpc2,3); Dpc2ma3m=mtm(Dpc2ma3,1);
            end
            if length(findstr(wafw,'Dobv'))+length(findstr(watw,'Dobv'))
              Dobv=obv(stock);
              Dobv3h=maxv(Dobv,3); Dobv5h=maxv(Dobv,5); Dobv10h=maxv(Dobv,10); Dobv20h=maxv(Dobv,20); 
              Dobv3l=minv(Dobv,3); Dobv5l=minv(Dobv,5); Dobv10l=minv(Dobv,10); Dobv20l=minv(Dobv,20); 
            end
            if length(findstr(wafw,'Dvpt'))+length(findstr(watw,'Dvpt'))
              Dvpt=vpt(stock);
              Dvpt3h=maxv(Dvpt,3); Dvpt5h=maxv(Dvpt,5); Dvpt10h=maxv(Dvpt,10); Dvpt20h=maxv(Dvpt,20); 
              Dvpt3l=minv(Dvpt,3); Dvpt5l=minv(Dvpt,5); Dvpt10l=minv(Dvpt,10); Dvpt20l=minv(Dvpt,20);
            end
            if length(findstr(wafw,'Dmdhm'))+length(findstr(watw,'Dmdhm'))
              Dmdhm=macd(stock(:,4)); Dmdhmm=mtm(Dmdhm,1);
            end
            if length(findstr(wafw,'Dbb20'))+length(findstr(watw,'Dbb20'))
              Dbb20=bb(stock(:,4),20); Dbb20m=mtm(Dbb20(:,3)-Dbb20(:,1),1);
            end
            if length(findstr(wafw,'Dmaxh20'))+length(findstr(watw,'Dmaxh20'))
              Dmaxh20=maxv(stock(:,2),20);
            end
            if length(findstr(wafw,'Dmaxh50'))+length(findstr(watw,'Dmaxh50'))
              Dmaxh50=maxv(stock(:,2),50);
            end
            if length(findstr(wafw,'Dmaxh110'))+length(findstr(watw,'Dmaxh110'))
              Dmaxh110=maxv(stock(:,2),110);
            end
            if length(findstr(wafw,'Dmaxh220'))+length(findstr(watw,'Dmaxh220'))  
              Dmaxh220=maxv(stock(:,2),220);
            end
            if length(findstr(wafw,'Dminl20'))+length(findstr(watw,'Dminl20'))
              Dminl20=minv(stock(:,3),20);
            end
            if length(findstr(wafw,'Dminl50'))+length(findstr(watw,'Dminl50'))
              Dminl50=minv(stock(:,3),50);
            end
            if length(findstr(wafw,'Dminl110'))+length(findstr(watw,'Dminl110'))
              Dminl110=minv(stock(:,3),110);
            end
            if length(findstr(wafw,'Dminl220'))+length(findstr(watw,'Dminl220'))  
              Dminl220=minv(stock(:,3),220);
            end
          end
          
          if isfield(fpwout,'tipbin')
            TPH=fpwout.tipbin;
          else
            TPH=0*tradeh(:,1:2)+1;    
          end
          if isfield(fpwout,'CPS')
            CPS=fpwout.CPS;
            if length(CPS(:,1))~=length(tradeh(:,1))
              CPS=0*tradeh(:,1);
            end
          else
            CPS=0*tradeh(:,1);
          end
          if length(TH(1,:))<13
            TH(:,13)=0*TH(:,1); % means lost the info where they are from originally.
          end
          TM=TH(:,12:13);
          if length(DDw)>0
            [wop whi wlo wcl wvo]=wsov(DDw(:,4:8));
          end
          
          if length(findstr(wafw,'vf15m'))+length(findstr(watw,'vf15m'))
            vf15mi=1; % no more in use, changed to wstd350b and tradeh3(:,171)
                      % it is represented "Volume of First 15 Minutes"
          else
            vf15mi=0;
          end
          
          if (wafwOri==0)&(length(findstr(wafw,'h(i)'))+length(findstr(wafw,'l(i)'))+...
            length(findstr(watw,'h(i)'))+length(findstr(watw,'l(i)')))
            if length(findstr(wafw,'ICBD'))+length(findstr(watw,'ICBD'))
              ICBD=1;  % Including Current Bar Data
              if length(findstr(wafw,'ICBD')); wafw=strrep(wafw,'ICBD',' '); end
              if length(findstr(watw,'ICBD')); watw=strrep(watw,'ICBD',' '); end
            else
              ICBD=0;
            end
            for ii=1:length(tradeh(:,1))
              Orighii=h(tradeh(ii,3)); Origlii=l(tradeh(ii,3));
              if tradeh(ii,9)~=20
                if tradeh(ii,9)~=4
                  if wsfsn24([mname name])==0
                    goupih=wsgetdat(TradeD(ii,1:3),4,tradeh(ii,9)+ICBD/12);
                    ticdforany=wsohlcv(goupih);
                    if length(goupih(:,1))>1
                      ticdforany=wsohlcv(wsgetdat(TradeD(ii,1:3),4,tradeh(ii,9)-1/12+ICBD/12));
                    end
                  else
                    goupih=wsgetdat(TradeD(ii,1:3),0,tradeh(ii,9)+ICBD/12);
                    ticdforany=wsohlcv(goupih);
                    if length(goupih(:,1))>1
                      ticdforany=wsohlcv(wsgetdat(TradeD(ii,1:3),0,tradeh(ii,9)-1/12+ICBD/12));
                    end
                  end
                  if length(ticdforany)
                    h(tradeh(ii,3))=ticdforany(2);
                    l(tradeh(ii,3))=ticdforany(3);
                  else
                    ruleoutT=[ruleoutT;ii];
                  end
                else
                  h(tradeh(ii,3))=o(tradeh(ii,3));
                  l(tradeh(ii,3))=o(tradeh(ii,3));
                end
              end
              i=tradeh(ii,3);
              wstd350b;
              if length(findstr(wafw,'wpr'))+length(findstr(watw,'wpr'))
                dwpr7=Dwpr7(i-1); dwpr7m=Dwpr7m(i-1);
                dwpr14=Dwpr(i-1); dwpr14m=Dwprm(i-1);
                dwpr28=Dwpr28(i-1); dwpr28m=Dwpr28m(i-1);
                dwpr50=Dwpr50(i-1); dwpr50m=Dwpr50m(i-1);
                dwpr110=Dwpr110(i-1); dwpr110m=Dwpr110m(i-1);
                dwpr220=Dwpr220(i-1); dwpr220m=Dwpr220m(i-1);
              end
              if length(findstr(wafw,'vri'))+length(findstr(watw,'vri'))
                dvri5=Dvri5(i-1);dvri10=Dvri10(i-1);
                dvri=Dvri(i-1);dvri22=dvri; 
              end
              fpwmytest1;
              eval(['waf=',wafw,';']); eval(['wat=',watw,';']); TrT(ii)=(waf-wat)/tickstep;
              h(tradeh(ii,3))=Orighii; l(tradeh(ii,3))=Orighii;
            end
          else
            if wafwOri==0
              for ii=1:length(tradeh(:,1))
                i=tradeh(ii,3);
                wstd350b;
                if length(findstr(wafw,'wpr'))+length(findstr(watw,'wpr'))
                  dwpr7=Dwpr7(i-1); dwpr7m=Dwpr7m(i-1);
                  dwpr14=Dwpr(i-1); dwpr14m=Dwprm(i-1);
                  dwpr28=Dwpr28(i-1); dwpr28m=Dwpr28m(i-1);
                  dwpr50=Dwpr50(i-1); dwpr50m=Dwpr50m(i-1);
                  dwpr110=Dwpr110(i-1); dwpr110m=Dwpr110m(i-1);
                  dwpr220=Dwpr220(i-1); dwpr220m=Dwpr220m(i-1);
                end
                if length(findstr(wafw,'vri'))+length(findstr(watw,'vri'))
                  dvri5=Dvri5(i-1);dvri10=Dvri10(i-1);
                  dvri=Dvri(i-1);dvri22=dvri; 
                end
                fpwmytest1; % simply introduce a new any variable yhl2 (Yesterday High-Low at 2 indicator)
                eval(['waf=',wafw,';']); eval(['wat=',watw,';']); TrT(ii)=(waf-wat)/tickstep;
              end
            else
              TrT=0*TH(:,1)+(1-0.05)/tickstep;
            end
          end
          
          for ii=1:length(tradeh(:,1))
            %i=tradeh(ii,3); eval(['waf=',wafw,';']); eval(['wat=',watw,';']); trt=(waf-wat)/tickstep;
            trt=TrT(ii);
            if trt>=0
              if trt<wti
                wsro(ii)=1;
              elseif (trt>=wti)&(trt<2*wti)
                wsro(ii)=2;
              elseif (trt>=2*wti)&(trt<3*wti)
                wsro(ii)=3;
              elseif (trt>=3*wti)&(trt<4*wti)
                wsro(ii)=4;
              else
                wsro(ii)=5;
              end
            else
              trt=-trt;
              if trt<wti
                wsro(ii)=-1;
              elseif (trt>=wti)&(trt<2*wti)
                wsro(ii)=-2;
              elseif (trt>=2*wti)&(trt<3*wti)
                wsro(ii)=-3;
              elseif (trt>=3*wti)&(trt<4*wti)
                wsro(ii)=-4;
              else
                wsro(ii)=-5;
              end
            end
          end
          
          if length(ruleoutT)>0
            wsro(ruleoutT)=0*ruleoutT-1;
            tradeh(ruleoutT,:)=tradeh_original(ruleoutT,:); % in order to list at the lower part
          end
          
          if Wti>0                                 
            fpwout1.oC11='Up'; fpwout1.oC21='$Net'; fpwout1.oC31='Win'; fpwout1.oC41='Loss';
            fpwout1.oD11='Down'; fpwout1.oD21='$Net'; fpwout1.oD31='Win'; fpwout1.oD41='Loss';
                      
            fpwout1.oC12=sprintf('<%5.2f',1*wti*tickstep);
            fpwout1.oC13=sprintf('<%5.2f',2*wti*tickstep);
            fpwout1.oC14=sprintf('<%5.2f',3*wti*tickstep);
            fpwout1.oC15=sprintf('<%5.2f',4*wti*tickstep);
            fpwout1.oC16=sprintf('>=%5.2f',4*wti*tickstep);
                   
            fpwout1.oD12=sprintf('<%5.2f',1*wti*tickstep);
            fpwout1.oD13=sprintf('<%5.2f',2*wti*tickstep);
            fpwout1.oD14=sprintf('<%5.2f',3*wti*tickstep);
            fpwout1.oD15=sprintf('<%5.2f',4*wti*tickstep);
            fpwout1.oD16=sprintf('>=%5.2f',4*wti*tickstep);
               
            dtr1=tradeh(find(wsro==1),6);dwnr1=length(find(dtr1-.00001>0));
            dtr2=tradeh(find(wsro==2),6);dwnr2=length(find(dtr2-.00001>0));
            dtr3=tradeh(find(wsro==3),6);dwnr3=length(find(dtr3-.00001>0));
            dtr4=tradeh(find(wsro==4),6);dwnr4=length(find(dtr4-.00001>0));
            dtr5=tradeh(find(wsro==5),6);dwnr5=length(find(dtr5-.00001>0));
            fpwout1.oC22=sprintf('%6.0f',sum(dtr1));
            fpwout1.oC23=sprintf('%6.0f',sum(dtr2));
            fpwout1.oC24=sprintf('%6.0f',sum(dtr3));
            fpwout1.oC25=sprintf('%6.0f',sum(dtr4));
            fpwout1.oC26=sprintf('%6.0f',sum(dtr5));
            fpwout1.oC32=int2str(dwnr1);
            fpwout1.oC33=int2str(dwnr2);
            fpwout1.oC34=int2str(dwnr3);
            fpwout1.oC35=int2str(dwnr4);
            fpwout1.oC36=int2str(dwnr5);
            fpwout1.oC42=int2str(length(dtr1)-dwnr1);
            fpwout1.oC43=int2str(length(dtr2)-dwnr2);
            fpwout1.oC44=int2str(length(dtr3)-dwnr3);
            fpwout1.oC45=int2str(length(dtr4)-dwnr4);
            fpwout1.oC46=int2str(length(dtr5)-dwnr5);
                 
            dtr1=tradeh(find(wsro>0),6);dwnr1=length(dtr1(find(dtr1-.00001>0)));
            fpwout1.oC21=sprintf('%6.0f',sum(dtr1));
            fpwout1.oC31=int2str(dwnr1);
            fpwout1.oC41=int2str(length(dtr1)-dwnr1);
                 
            dtr1=tradeh(find(wsro==-1),6);dwnr1=length(find(dtr1-.00001>0));
            dtr2=tradeh(find(wsro==-2),6);dwnr2=length(find(dtr2-.00001>0));
            dtr3=tradeh(find(wsro==-3),6);dwnr3=length(find(dtr3-.00001>0));
            dtr4=tradeh(find(wsro==-4),6);dwnr4=length(find(dtr4-.00001>0));
            dtr5=tradeh(find(wsro==-5),6);dwnr5=length(find(dtr5-.00001>0));
            fpwout1.oD22=sprintf('%6.0f',sum(dtr1));
            fpwout1.oD23=sprintf('%6.0f',sum(dtr2));
            fpwout1.oD24=sprintf('%6.0f',sum(dtr3));
            fpwout1.oD25=sprintf('%6.0f',sum(dtr4));
            fpwout1.oD26=sprintf('%6.0f',sum(dtr5));
            fpwout1.oD32=int2str(dwnr1);
            fpwout1.oD33=int2str(dwnr2);
            fpwout1.oD34=int2str(dwnr3);
            fpwout1.oD35=int2str(dwnr4);
            fpwout1.oD36=int2str(dwnr5);
            fpwout1.oD42=int2str(length(dtr1)-dwnr1);
            fpwout1.oD43=int2str(length(dtr2)-dwnr2);
            fpwout1.oD44=int2str(length(dtr3)-dwnr3);
            fpwout1.oD45=int2str(length(dtr4)-dwnr4);
            fpwout1.oD46=int2str(length(dtr5)-dwnr5);
                  
            dtr1=tradeh(find(wsro<0),6);dwnr1=length(dtr1(find(dtr1-.00001>0)));
            fpwout1.oD21=sprintf('%6.0f',sum(dtr1));
            fpwout1.oD31=int2str(dwnr1);
            fpwout1.oD41=int2str(length(dtr1)-dwnr1);
               
            fpwout1.fpwsource=instruct.fpwsource;
            fpwout1.outAnyS=instruct.outAnyS;
            fpwout1.outAnyU=instruct.outAnyU;          
            fpwout1.outAnyD=instruct.outAnyD;
            fpwout1.outGOsm=instruct.outGOsm;
            fpwout1.outDSM=instruct.outDSM;
            fpwout1.fpwusername=fpwusername;
            fpwout1.fpwusername4=fpwusername4;
            fpwout1.fpwulvl=instruct.fpwulvl;
            fpwout1.outrunindex=instruct.outrunindex;
            fpwout1.fpwoutjpeg=[fpwclientdirectory,fpwusername,'\pattern\fpwoutjpeg.jpeg']; 
            
            if exist('HMSTCEi')~=1
              sfpw1.StatusReport=[' This is the ''Any'' distribution of the showing simulation section. ',time];
            else
              if wafwOri==1
                if length(BugPlace)>0
                  BugPlacei=int2str(length(BugPlace(:,1)));
                else
                  BugPlacei='0';
                end
                sfpw1.StatusReport=[' ',int2str(HMSTCEi),'(',int2str(length(ruleoutT)),...
                '-',BugPlacei,') would be cut short due to the overnight limitation. ',time];
              elseif wafwOri==2
                sfpw1.StatusReport=[' ',int2str(HMSTCEi),' trades would be volume-reduced due to volatility limitation. ',time];
              elseif wafwOri==3
                sfpw1.StatusReport=[' Number in this group would be: ',int2str(HMSTCEi),'. ',time];
              elseif wafwOri==4
                sfpw1.StatusReport=[' Want to do tick genetic analysis? Please click ''1'' button on the left. ',time];
              elseif wafwOri==5
                sfpw1.StatusReport=[' Want to do View format? Please click ''View'' button on the left. ',time];
              end
            end              
            templatefile = which('MPsimulationR1.html');
            str = htmlrep(sfpw1, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\twbfpwoutputR1.html'],'noheader');      
            fpwout1.FPWoutstatus=strrep([fpwclientdirectory,fpwusername,'\pattern\twbfpwoutputR1.html'],'\','/');       
                      
            fpwoutwindow=21;          
                     
          else  %if Wti<=0
            howtocombineH=1; % 1 - rebuild, others - drop
            if howtocombineH==1
              lotshis=zeros(length(net),max(tradeh(:,12)));
              net=0*net; net1=net;
              NotMatchedTrades=[]; % someting might be wrong from earlier fpwport
            end
            for ii=1:length(tradeh(:,1))
              if howtocombineH~=1
                if wsro(ii)<0  % this is rule out way
                  dropitwp=tradeeach(tradeh(ii,10):tradeh(ii,11));
                  dropitwp=reshape(dropitwp,length(dropitwp)/2,2);
                  if exist('tradelots')~=1
                    if tradeh(ii,3)==tradeh(ii,5)
                      lotshis(tradeh(ii,3),tradeh(ii,12))=...
                      lotshis(tradeh(ii,3),tradeh(ii,12))-sign(tradeh(ii,2));
                    else
                      zhuws2=zeros(tradeh(ii,5)-tradeh(ii,3),1)+sign(tradeh(ii,2));
                      lotshis(tradeh(ii,3):tradeh(ii,5)-1,tradeh(ii,12))=...
                      lotshis(tradeh(ii,3):tradeh(ii,5)-1,tradeh(ii,12))-zhuws2;
                    end
                  else
                    dropitwpl=tradelots(tradeh(ii,10):tradeh(ii,11));
                    dropitwpl=reshape(dropitwpl,length(dropitwpl)/2,2);
                    if tradeeach(tradeh(ii,10))~=tradeh(ii,3)
                      lotshis(dropitwpl(:,1)-1,tradeh(ii,12))=...
                      lotshis(dropitwpl(:,1)-1,tradeh(ii,12))-sign(tradeh(ii,2))*dropitwpl(:,2);
                    else
                      lotshis(dropitwpl(:,1),tradeh(ii,12))=...
                      lotshis(dropitwpl(:,1),tradeh(ii,12))-sign(tradeh(ii,2))*dropitwpl(:,2);
                    end
                  end
                  net(dropitwp(:,1))=net(dropitwp(:,1))-dropitwp(:,2);
                  net1(tradeh(ii,3))=net1(tradeh(ii,3))-tradeh(ii,6);
                end
              else
                if wsro(ii)>=0 % this is rebuilding way
                  dropitwp=tradeeach(tradeh(ii,10):tradeh(ii,11));
                  dropitwp=reshape(dropitwp,length(dropitwp)/2,2);
                  if exist('tradelots')~=1
                    if tradeh(ii,3)==tradeh(ii,5)
                      lotshis(tradeh(ii,3),tradeh(ii,12))=...
                      lotshis(tradeh(ii,3),tradeh(ii,12))+sign(tradeh(ii,2));
                    else
                      zhuws2=zeros(tradeh(ii,5)-tradeh(ii,3),1)+sign(tradeh(ii,2));
                      lotshis(tradeh(ii,3):tradeh(ii,5)-1,tradeh(ii,12))=...
                      lotshis(tradeh(ii,3):tradeh(ii,5)-1,tradeh(ii,12))+zhuws2;
                    end
                  else
                    dropitwpl=tradelots(tradeh(ii,10):tradeh(ii,11));
                    dropitwpl=reshape(dropitwpl,length(dropitwpl)/2,2);
                    if tradeeach(tradeh(ii,10))~=tradeh(ii,3)
                      lotshis(dropitwpl(:,1)-1,tradeh(ii,12))=...
                      lotshis(dropitwpl(:,1)-1,tradeh(ii,12))+sign(tradeh(ii,2))*dropitwpl(:,2);
                    else
                      lotshis(dropitwpl(:,1),tradeh(ii,12))=...
                      lotshis(dropitwpl(:,1),tradeh(ii,12))+sign(tradeh(ii,2))*dropitwpl(:,2);
                    end
                  end
                  net(dropitwp(:,1))=net(dropitwp(:,1))+dropitwp(:,2);
                  if fix(1000*tradeh(ii,6))~=fix(1000*sum(dropitwp(:,2)))
                    NotMatchedTrades=[NotMatchedTrades;ii];
                  end
                  net1(tradeh(ii,3))=net1(tradeh(ii,3))+tradeh(ii,6);
                end
              end
            end
            if length(NotMatchedTrades)>0
              % This means something is wrong. The below file will help debug.
              save c:\matlab\pattern\mybug20170101.mat
            end
            clear zhuws2;
            tradeh=tradeh(find(wsro>=0),:);  
            tradeo=tradeo(find(wsro>=0),:); 
            if length(tradeh2)>0
              tradeh2=tradeh2(find(wsro>=0),:);
            end
            if length(tradeh3)>0
              tradeh3=tradeh3(find(wsro>=0),:);
            end
            CPS=CPS(find(wsro>=0),:);
            
            if length(tradeh)>0  
              [qww qiw]=sort(tradeh(:,3));
              tradeh=tradeh(qiw,:);
              tradeo=tradeo(qiw,:);     
              if length(tradeh2)>0
                tradeh2=tradeh2(qiw,:);
              end
              if length(tradeh3)>0
                tradeh3=tradeh3(qiw,:);
              end
              %net1=0*net;
              %net1(tradeh(:,3))=tradeh(:,6); % this is not right for muti-signal a day.
              if ws2ws2ws2==1
                net(1:tradeh(1,3)-1)=0*(1:tradeh(1,3)-1);
                net(tradeh(length(tradeh(:,1)),5)+1:length(net))=0*net(tradeh(length(tradeh(:,1)),5)+1:length(net));
                net(1)=sum(net1)-sum(net);
                lotshis(1:tradeh(1,3)-1,tradeh(1,12))=0*lotshis(1:tradeh(1,3)-1,tradeh(1,12));
                lotshis(tradeh(length(tradeh(:,1)),5)+1:length(net))=0*net(tradeh(length(tradeh(:,1)),5)+1:length(net));
                anycond=[namews2,'||',wafw,'||',watw];
              else
                anycond=['UrSym||',wafw,'||',watw]; 
              end
                      
              Fpwout=fpwout;
              if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwany100.mat'])==2
                eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwany100']);
                eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwany200 fpwout']);
              end
              fpwout=Fpwout; clear Fpwout;
              fpwout.anycond=anycond; fpwout.tradeeach=tradeeach;
              if exist('tradelots')==1
                fpwout.tradelots=tradelots;
              end
              fpwout.net=net; fpwout.net1=net1; fpwout.tradeh=tradeh;
              if length(tradeh2)>0
                fpwout.tradeh2=tradeh2;
              end
              if length(tradeh3)>0
                fpwout.tradeh3=tradeh3;
              end
              fpwout.tradeo=tradeo; fpwout.lotshis=lotshis;
              fpwout.CPS=CPS;
              eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwany100 fpwout']);
                    
              fpwoutwindow=21;
              cd([Wherematlab,'\pattern']);
              fpwout.outonoff=instruct.hdoutonoff;
              fpwout.fpwsource='fpwany100';
              fpwout1=fpwozc3(fpwout);    
              fpwout1.fpwsource='fpwany100';
              fpwout1.fpwusername=fpwusername;
              fpwout1.fpwusername4=fpwusername4;
              fpwout1.fpwulvl=instruct.fpwulvl;
              fpwout1.outrunindex='16';
              fpwout1.outDSM='4';
              fpwout1.outAnyS=num2str(abs(str2num(instruct.outAnyS)));
              fpwout1.outAnyU=instruct.outAnyU;          
              fpwout1.outAnyD=instruct.outAnyD; 
              fpwout1.outGOsm=instruct.outGOsm;
              
              set(fpwout1.fpwoutfig,'PaperPosition',MyPaperPosiH);
              cd([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern']);
              drawnow;
              wsprintjpeg(fpwout1.fpwoutfig,'fpwoutjpeg.jpeg');
              close(fpwout1.fpwoutfig);
              cd([Wherematlab,'pattern']);
              fpwout1.fpwoutjpeg=[fpwclientdirectory,fpwusername,'\pattern\fpwoutjpeg.jpeg']; 
                          
              if exist('HMSTCEi')~=1
                sfpw1.StatusReport=[' This is the zoom-in picture of your front showing simulation output. ',time];
              else
                if wafwOri==1
                  if length(BugPlace)>0
                    BugPlacei=int2str(length(BugPlace(:,1)));
                  else
                    BugPlacei='0';
                  end
                  sfpw1.StatusReport=[' ',int2str(HMSTCEi),'(',int2str(length(ruleoutT)),...
                  '-',BugPlacei,') have been cut short due to the overnight limitation. ',time];
                elseif wafwOri==2
                  sfpw1.StatusReport=[' ',int2str(HMSTCEi),' trades have been volume-reduced due to volatility limitation. ',time];
                elseif wafwOri==3
                  sfpw1.StatusReport=[' Number in this group is: ',int2str(HMSTCEi),'. ',time];
                elseif wafwOri==4
                  sfpw1.StatusReport=[' Want to do tick genetic analysis? Please click ''1'' button on the left. ',time];
                elseif wafwOri==5
                  sfpw1.StatusReport=[' Want to do View format? Please click ''View'' button on the left. ',time];
                end
              end
              templatefile = which('MPsimulationR1.html');
              str = htmlrep(sfpw1, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\twbfpwoutputR1.html'],'noheader');      
              fpwout1.FPWoutstatus=strrep([fpwclientdirectory,fpwusername,'\pattern\twbfpwoutputR1.html'],'\','/');    
            else
              fpwoutwindow=24;
              fpwout1.fpwusername=fpwusername;
              fpwout1.fpwusername4=fpwusername4;
              fpwout1.fpwulvl=instruct.fpwulvl;       
            end  
          end
          
        else % multi-market system
             
          Bdate=datem(str2num(fpwout.zhu52),1:3); Edate=datem(length(datem(:,1))-str2num(fpwout.zhu54)+1,1:3); 
          
          t=tickstep;  ws2ws2ws2=0; ruleoutT=[];
          
          [qww qiw]=sort(tradeh(:,13));
          tradeh=tradeh(qiw,:);
          tradeo=tradeo(qiw,:); 
          TradeD=TradeD(qiw,:);           
            
          if ~strcmp(instruct.outGOsm,'UrSym')
            namews2=noempty(instruct.outGOsm);
            if length(namews2)>1
              if (upper(namews2(1))=='F')+(upper(namews2(1))=='S')==0
                error(' - Secondary market name format: F/S then followed by future/stock symbol.');
              end
              [stock datem]=fsdaydat(namews2);
              if ~length(stock)
                error(' - Secondary market is not existed, check symbol, please.');
              end
              for ws2loop=1:length(tradeh(:,1))
                ws2loopj=find((datem(:,1)==TradeD(ws2loop,1))&(datem(:,2)==TradeD(ws2loop,2))&(datem(:,3)==TradeD(ws2loop,3)));
                if (length(ws2loopj)==1)   %some date data may have been disordered after MM combination.
                  if (ws2loopj(1)>14)
                    tradeh(ws2loop,3)=ws2loopj(1);
                  else
                    ruleoutT=[ruleoutT;ws2loop];
                  end
                else
                  ruleoutT=[ruleoutT;ws2loop];
                end
                clear ws2loopj
              end
              
              ws2ws2ws2=1;
              mname=upper(namews2(1)); name=upper(namews2(2:length(namews2)));
              if tickchg==0
                tickstep=wsts(name);  t=tickstep;
              end
              clear ws2loop

              o=stock(:,1); h=stock(:,2); l=stock(:,3); c=stock(:,4); v=stock(:,5); TH=tradeh;
               
              if length(findstr(wafw,'h(i)'))+length(findstr(wafw,'l(i)'))+...
                length(findstr(watw,'h(i)'))+length(findstr(watw,'l(i)'))
                if length(findstr(wafw,'ICBD'))+length(findstr(watw,'ICBD'))
                  ICBD=1;  
                  if length(findstr(wafw,'ICBD')); wafw=strrep(wafw,'ICBD',' '); end
                  if length(findstr(watw,'ICBD')); watw=strrep(watw,'ICBD',' '); end
                else
                  ICBD=0;
                end            
                for ii=1:length(tradeh(:,1))
                  Orighii=h(tradeh(ii,3)); Origlii=l(tradeh(ii,3));
                  if tradeh(ii,9)~=20
                    if tradeh(ii,9)~=4
                      if wsfsn24([mname,name])==0
                        ticdforany=wsohlcv(wsgetdat(TradeD(ii,1:3),4,tradeh(ii,9)-1/12+ICBD/12));
                      else
                        ticdforany=wsohlcv(wsgetdat(TradeD(ii,1:3),0,tradeh(ii,9)-1/12+ICBD/12));
                      end
                      if length(ticdforany)
                        h(tradeh(ii,3))=ticdforany(2);
                        l(tradeh(ii,3))=ticdforany(3);
                      else
                        ruleoutT=[ruleoutT;ii];
                      end
                    else
                      h(tradeh(ii,3))=o(tradeh(ii,3));
                      l(tradeh(ii,3))=o(tradeh(ii,3));
                    end
                  end
                  i=tradeh(ii,3); eval(['waf=',wafw,';']); eval(['wat=',watw,';']); TrT(ii)=(waf-wat)/tickstep;
                  h(tradeh(ii,3))=Orighii; l(tradeh(ii,3))=Orighii;
                end
              else
                for ii=1:length(tradeh(:,1))
                  i=tradeh(ii,3); eval(['waf=',wafw,';']); eval(['wat=',watw,';']); TrT(ii)=(waf-wat)/tickstep;
                end
              end
              for ii=1:length(tradeh(:,1))
                %i=tradeh(ii,3); eval(['waf=',wafw,';']); eval(['wat=',watw,';']); trt=(waf-wat)/tickstep;
                trt=TrT(ii);
                if trt>=0
                  if trt<wti
                    wsro(ii)=1;
                  elseif (trt>=wti)&(trt<2*wti)
                    wsro(ii)=2;
                  elseif (trt>=2*wti)&(trt<3*wti)
                    wsro(ii)=3;
                  elseif (trt>=3*wti)&(trt<4*wti)
                    wsro(ii)=4;
                  else
                    wsro(ii)=5;
                  end
                else
                  trt=-trt;
                  if trt<wti
                    wsro(ii)=-1;
                  elseif (trt>=wti)&(trt<2*wti)
                    wsro(ii)=-2;
                  elseif (trt>=2*wti)&(trt<3*wti)
                    wsro(ii)=-3;
                  elseif (trt>=3*wti)&(trt<4*wti)
                    wsro(ii)=-4;
                  else
                    wsro(ii)=-5;
                  end
                end
              end
          
              if length(ruleoutT)>0
                 wsro(ruleoutT)=0*ruleoutT-1; 
              end
            else
              error(' - Did not enter a right secondary market symbol. Secondary market name format: F/S then followed by future/stock symbol.');
            end
          end
          
          if ws2ws2ws2==0     
            rnli=0;
            for k=1:length(tradeh(:,1))
              if tradeh(k,13)~=rnli
                if length(Mname1)==1  
                  name=noempty(runnamelist{tradeh(k,13)});
                  marketrun=noempty(runnamelist{tradeh(k,13)});
                  if strcmp(MMFS,'Future')
                    if length(marketrun)==1
                      marketrun(2)='_';
                    end        
                    if strcmp(MM12,'No.1')
                      eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data4\',marketrun,'output']);
                    elseif strcmp(MM12,'No.2')
                      eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data5\',marketrun,'output']);
                    else
                      eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data0\',marketrun,'output']);        
                    end
                  else
                    if strcmp(MM12,'No.1')
                      eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\stock1\rts',marketrun]);
                    elseif strcmp(MM12,'No.2')
                      eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\stock2\rts',marketrun]);
                    else
                      eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\stockd1\rts',marketrun]);        
                    end                  
                  end  
                else
                  mname=Mname1(tradeh(k,13));
                  name=noempty(runnamelist{tradeh(k,13)});                  
                  eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data21\fpwoutput',num2str(tradeh(k,13))]);  
                end
                stock=fpwout.stock; datem=fpwout.datem;
                o=stock(:,1); h=stock(:,2); l=stock(:,3); c=stock(:,4); v=stock(:,5); TH=tradeh;  
                if (tickchg==0)
                  tickstep=wsts(noempty(runnamelist{tradeh(k,13)}));  t=tickstep;
                end                 
                needtochgp=find(tradeh(:,13)==tradeh(k,13));
                
                if length(findstr(wafw,'h(i)'))+length(findstr(wafw,'l(i)'))+...
                  length(findstr(watw,'h(i)'))+length(findstr(watw,'l(i)'))
                  if length(findstr(wafw,'ICBD'))+length(findstr(watw,'ICBD'))
                    ICBD=1;  
                    if length(findstr(wafw,'ICBD')); wafw=strrep(wafw,'ICBD',' '); end
                    if length(findstr(watw,'ICBD')); watw=strrep(watw,'ICBD',' '); end
                  else
                    ICBD=0;
                  end               
                  for j=1:length(needtochgp)
                    ii=needtochgp(j);
                    Orighii=h(tradeh(ii,3)); Origlii=l(tradeh(ii,3));
                    if tradeh(ii,9)~=20
                      if tradeh(ii,9)~=4
                        if wsfsn24([mname name])==0
                          ticdforany=wsohlcv(wsgetdat(TradeD(ii,1:3),4,tradeh(ii,9)-1/12+ICBD/12));
                        else
                          ticdforany=wsohlcv(wsgetdat(TradeD(ii,1:3),0,tradeh(ii,9)-1/12+ICBD/12));  
                        end
                        if length(ticdforany)
                          h(tradeh(ii,3))=ticdforany(2);
                          l(tradeh(ii,3))=ticdforany(3);
                        else
                          ruleoutT=[ruleoutT;ii];
                        end
                      else
                        h(tradeh(ii,3))=o(tradeh(ii,3));
                        l(tradeh(ii,3))=o(tradeh(ii,3));
                      end
                    end
                    i=tradeh(ii,3); eval(['waf=',wafw,';']); eval(['wat=',watw,';']); TrT(ii)=(waf-wat)/tickstep;
                    h(tradeh(ii,3))=Orighii; l(tradeh(ii,3))=Orighii;
                  end
                else
                  for j=1:length(needtochgp)
                    ii=needtochgp(j);
                    i=tradeh(ii,3); eval(['waf=',wafw,';']); eval(['wat=',watw,';']); TrT(ii)=(waf-wat)/tickstep;
                  end
                end
                for j=1:length(needtochgp)
                  ii=needtochgp(j);                
                  trt=TrT(ii);
                  if trt>=0
                    if trt<wti
                      wsro(ii)=1;
                    elseif (trt>=wti)&(trt<2*wti)
                      wsro(ii)=2;
                    elseif (trt>=2*wti)&(trt<3*wti)
                      wsro(ii)=3;
                    elseif (trt>=3*wti)&(trt<4*wti)
                      wsro(ii)=4;
                    else
                      wsro(ii)=5;
                    end
                  else
                    trt=-trt;
                    if trt<wti
                      wsro(ii)=-1;
                    elseif (trt>=wti)&(trt<2*wti)
                      wsro(ii)=-2;
                    elseif (trt>=2*wti)&(trt<3*wti)
                      wsro(ii)=-3;
                    elseif (trt>=3*wti)&(trt<4*wti)
                      wsro(ii)=-4;
                    else
                      wsro(ii)=-5;
                    end
                  end
                end                
                rnli=tradeh(k,13);
              end  
            end
            if length(ruleoutT)>0
              wsro(ruleoutT)=0*ruleoutT-1; 
            end
          end
           
          if Wti>=0
            fpwout1.oC11='Up'; fpwout1.oC21='$Net'; fpwout1.oC31='Win'; fpwout1.oC41='Loss';
            fpwout1.oD11='Down'; fpwout1.oD21='$Net'; fpwout1.oD31='Win'; fpwout1.oD41='Loss';
                
            if tickchg==0
                  
              fpwout1.oC12=sprintf('<%3dT',1*wti);
              fpwout1.oC13=sprintf('<%3dT',2*wti);
              fpwout1.oC14=sprintf('<%3dT',3*wti);
              fpwout1.oC15=sprintf('<%3dT',4*wti);
              fpwout1.oC16=sprintf('>=%3dT',4*wti);
                     
              fpwout1.oD12=sprintf('<%3dT',1*wti);
              fpwout1.oD13=sprintf('<%3dT',2*wti);
              fpwout1.oD14=sprintf('<%3dT',3*wti);
              fpwout1.oD15=sprintf('<%3dT',4*wti);
              fpwout1.oD16=sprintf('>=%3dT',4*wti);
          
            else
            
              fpwout1.oC12=sprintf('<%5.2f',1*wti*tickstep);
              fpwout1.oC13=sprintf('<%5.2f',2*wti*tickstep);
              fpwout1.oC14=sprintf('<%5.2f',3*wti*tickstep);
              fpwout1.oC15=sprintf('<%5.2f',4*wti*tickstep);
              fpwout1.oC16=sprintf('>=%5.2f',4*wti*tickstep);
                   
              fpwout1.oD12=sprintf('<%5.2f',1*wti*tickstep);
              fpwout1.oD13=sprintf('<%5.2f',2*wti*tickstep);
              fpwout1.oD14=sprintf('<%5.2f',3*wti*tickstep);
              fpwout1.oD15=sprintf('<%5.2f',4*wti*tickstep);
              fpwout1.oD16=sprintf('>=%5.2f',4*wti*tickstep);
          
            end            

            dtr1=tradeh(find(wsro==1),6);dwnr1=length(find(dtr1-.00001>0));
            dtr2=tradeh(find(wsro==2),6);dwnr2=length(find(dtr2-.00001>0));
            dtr3=tradeh(find(wsro==3),6);dwnr3=length(find(dtr3-.00001>0));
            dtr4=tradeh(find(wsro==4),6);dwnr4=length(find(dtr4-.00001>0));
            dtr5=tradeh(find(wsro==5),6);dwnr5=length(find(dtr5-.00001>0));
            fpwout1.oC22=sprintf('%6.0f',sum(dtr1));
            fpwout1.oC23=sprintf('%6.0f',sum(dtr2));
            fpwout1.oC24=sprintf('%6.0f',sum(dtr3));
            fpwout1.oC25=sprintf('%6.0f',sum(dtr4));
            fpwout1.oC26=sprintf('%6.0f',sum(dtr5));
            fpwout1.oC32=int2str(dwnr1);
            fpwout1.oC33=int2str(dwnr2);
            fpwout1.oC34=int2str(dwnr3);
            fpwout1.oC35=int2str(dwnr4);
            fpwout1.oC36=int2str(dwnr5);
            fpwout1.oC42=int2str(length(dtr1)-dwnr1);
            fpwout1.oC43=int2str(length(dtr2)-dwnr2);
            fpwout1.oC44=int2str(length(dtr3)-dwnr3);
            fpwout1.oC45=int2str(length(dtr4)-dwnr4);
            fpwout1.oC46=int2str(length(dtr5)-dwnr5);
                 
            dtr1=tradeh(find(wsro>0),6);dwnr1=length(dtr1(find(dtr1-.00001>0)));
            fpwout1.oC21=sprintf('%6.0f',sum(dtr1));
            fpwout1.oC31=int2str(dwnr1);
            fpwout1.oC41=int2str(length(dtr1)-dwnr1);
                 
            dtr1=tradeh(find(wsro==-1),6);dwnr1=length(find(dtr1-.00001>0));
            dtr2=tradeh(find(wsro==-2),6);dwnr2=length(find(dtr2-.00001>0));
            dtr3=tradeh(find(wsro==-3),6);dwnr3=length(find(dtr3-.00001>0));
            dtr4=tradeh(find(wsro==-4),6);dwnr4=length(find(dtr4-.00001>0));
            dtr5=tradeh(find(wsro==-5),6);dwnr5=length(find(dtr5-.00001>0));
            fpwout1.oD22=sprintf('%6.0f',sum(dtr1));
            fpwout1.oD23=sprintf('%6.0f',sum(dtr2));
            fpwout1.oD24=sprintf('%6.0f',sum(dtr3));
            fpwout1.oD25=sprintf('%6.0f',sum(dtr4));
            fpwout1.oD26=sprintf('%6.0f',sum(dtr5));
            fpwout1.oD32=int2str(dwnr1);
            fpwout1.oD33=int2str(dwnr2);
            fpwout1.oD34=int2str(dwnr3);
            fpwout1.oD35=int2str(dwnr4);
            fpwout1.oD36=int2str(dwnr5);
            fpwout1.oD42=int2str(length(dtr1)-dwnr1);
            fpwout1.oD43=int2str(length(dtr2)-dwnr2);
            fpwout1.oD44=int2str(length(dtr3)-dwnr3);
            fpwout1.oD45=int2str(length(dtr4)-dwnr4);
            fpwout1.oD46=int2str(length(dtr5)-dwnr5);
                  
            dtr1=tradeh(find(wsro<0),6);dwnr1=length(dtr1(find(dtr1-.00001>0)));
            fpwout1.oD21=sprintf('%6.0f',sum(dtr1));
            fpwout1.oD31=int2str(dwnr1);
            fpwout1.oD41=int2str(length(dtr1)-dwnr1);
               
            fpwout1.fpwsource=instruct.fpwsource;
            fpwout1.outAnyS=instruct.outAnyS;
            fpwout1.outAnyU=instruct.outAnyU;          
            fpwout1.outAnyD=instruct.outAnyD;
            fpwout1.outGOsm=instruct.outGOsm;
            fpwout1.outDSM=instruct.outDSM;
            fpwout1.fpwusername=fpwusername;
            fpwout1.fpwusername4=fpwusername4;
            fpwout1.fpwulvl=instruct.fpwulvl;
            fpwout1.outrunindex=instruct.outrunindex;
            fpwout1.fpwoutjpeg=[fpwclientdirectory,fpwusername,'\pattern\fpwoutjpeg.jpeg']; 
                     
            sfpw1.StatusReport=[' This is the ''Any'' distribution of the showing simulation section. ',time];
            templatefile = which('MPsimulationR1.html');
            str = htmlrep(sfpw1, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\twbfpwoutputR1.html'],'noheader');      
            fpwout1.FPWoutstatus=strrep([fpwclientdirectory,fpwusername,'\pattern\twbfpwoutputR1.html'],'\','/');       
                      
            fpwoutwindow=21;          
                     
          else  %if Wti<=0
            % current directory is [Wherematlab,'pattern']
            tradehdecom=tradeh(find(wsro>=0),:);  
            tradeodecom=tradeo(find(wsro>=0),:); 
            TradeDdecom=TradeD(find(wsro>=0),:);
            
            if length(Mname1)==1
              % save to data0 or stockd1 and used fpwfsmarket to call
              fpwsource='fpwany300';
              % load back what the managing rules are for this run save them with any condition to MM Decom place
              if strcmp(MMFS,'Future')     
                if strcmp(MM12,'No.1')
                  eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data4\marketlist']);
                elseif strcmp(MM12,'No.2')
                  eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data5\marketlist']);
                else
                  eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data0\marketlist']);
                end
              else
                if strcmp(MM12,'No.1')
                  eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\stock1\marketlist']);
                elseif strcmp(MM12,'No.2')
                  eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\stock2\marketlist']);
                else
                  eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\stockd1\marketlist']);
                end                  
              end                
                 
              if ws2ws2ws2==1
                Anycond=[namews2,'||',wafw,'||',watw];
              else
                Anycond=['UrSym||',wafw,'||',watw]; 
              end
              
              if Mname1=='F'
                if ~strcmp(MM12,'No.3')
                  eval(['delete ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data0\*.mat']);
                end
                eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data0\marketlist runnamelist fpwout1']);
                clear fpwout1
              else
                if ~strcmp(MM12,'No.3')
                  eval(['delete ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\stockd1\*.mat']); 
                end
                eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\stockd1\marketlist runnamelist fpwout1']);
                clear fpwout1
              end              
              
              for i=1:length(runnamelist)
                tradet=tradehdecom(find(tradehdecom(:,13)==i),9);     % enty time
                Traded=TradeDdecom(find(tradehdecom(:,13)==i),4);     % entry date's day number
                tradep=tradehdecom(find(tradehdecom(:,13)==i),4);     % use exit price to avoid info overlaped in entry time  
                
                marketrun=noempty(runnamelist{i});
                if strcmp(MMFS,'Future')
                  if length(marketrun)==1
                    marketrun(2)='_';
                  end        
                  if strcmp(MM12,'No.1')
                    eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data4\',marketrun,'output']);
                  elseif strcmp(MM12,'No.2')
                    eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data5\',marketrun,'output']);
                  else
                    eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data0\',marketrun,'output']);        
                  end
                else
                  if strcmp(MM12,'No.1')
                    eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\stock1\rts',marketrun]);
                  elseif strcmp(MM12,'No.2')
                    eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\stock2\rts',marketrun]);
                  else
                    eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\stockd1\rts',marketrun]);        
                  end                  
                end                  
                net=fpwout.net; net1=fpwout.net1; lotshis=fpwout.lotshis; tradeh=fpwout.tradeh; 
                tradeo=fpwout.tradeo; datem=fpwout.datem; stock=fpwout.stock; tradeeach=fpwout.tradeeach;  
                
                traded=datem(tradeh(:,3),[3 1 2]);
                traded(find(traded(:,1)<100),1)=traded(find(traded(:,1)<100),1)+1900;
                traded(find(traded(:,1)<1950),1)=traded(find(traded(:,1)<1950),1)+100;
                TradeD=datenum(traded(:,1:3));  
                
                tradepassed=0*tradeh(:,1);
                for j=1:length(tradet(:,1))
                  findsig=find(  (tradeh(:,4)==tradep(j)) & (tradeh(:,9)==tradet(j)) &  (TradeD==Traded(j))  );
                  if length(findsig)==1
                    tradepassed(findsig)=1; 
                  elseif length(findsig)>1
                    ZhuTMD=' - This should not happen!'    
                  end
                end

                for j=1:length(tradeh(:,1))
                  if tradepassed(j)==0; 
                    dropitwp=tradeeach(tradeh(j,10):tradeh(j,11));
                    dropitwp=reshape(dropitwp,length(dropitwp)/2,2);
                    if tradeh(j,3)==tradeh(j,5)
                      lotshis(tradeh(j,3),tradeh(j,12))=0;
                    else
                      zhuws2=lotshis(tradeh(j,3):tradeh(j,5)-1,tradeh(j,12));
                      lotshis(tradeh(j,3):tradeh(j,5)-1,tradeh(j,12))=0*zhuws2;
                      clear zhuws2;
                    end
                    net(dropitwp(:,1))=net(dropitwp(:,1))-dropitwp(:,2);
                  end
                end
                tradeh=tradeh(find(tradepassed==1),:);  
                tradeo=tradeo(find(tradepassed==1),:); 
                net1=0*net;
                if length(tradeh)>0          
                  net1(tradeh(:,3))=tradeh(:,6);
                else
                  net=net1; tradeeach=[]; lotshis=net; tradeh=zeros(1,12); tradeo=[0 0 0]; 
                end
                fpwout.net=net; fpwout.net1=net1; fpwout.lotshis=lotshis; fpwout.tradeh=tradeh; fpwout.tradeo=tradeo; fpwout.anycond=Anycond;
                if Mname1=='F'
                  eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data0\',runnamelist{i},'output fpwout']);
                else 
                  eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\stockd1\rts',runnamelist{i},' fpwout']);
                end
              end  
              
              % this is just copied from fpwfsmarket.m
              if strcmp(MMFS,'Future')
                directplaceh=[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data0\'];  
                outDSM='10';                
              else
                directplaceh=[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\stockd1\'];    
                outDSM='11';                
              end  
              cd(directplaceh);
              if exist('marketlist.mat')==2
                load marketlist
              else
                error(' - There is no data file inside this MM directory.');
              end 
              
              Datem=[];
              for i=1:length(runnamelist)
                if strcmp(MMFS,'Future')
                  eval(['load ',directplaceh,runnamelist{i},'output']);
                else
                  eval(['load ',directplaceh,'rts',runnamelist{i}]);
                end
                if length(Datem)~=0
                  datem=fpwout.datem;
                  if dnabs(datem(1,1:3))<dnabs(Datem(1,1:3))
                    dindex=datef2(Datem(1,1:3),datem);
                    Datem=[datem(1:dindex-1,1:3);Datem];
                  end
                  if dnabs(datem(length(datem(:,1)),1:3))>dnabs(Datem(length(Datem(:,1)),1:3))
                    dindex=datef2(Datem(length(Datem(:,1)),1:3),datem);
                    Datem=[Datem; datem(dindex+1:length(datem(:,1)),1:3)];
                  end        
                else
                  Datem=fpwout.datem;
                end
              end  
              datem=Datem;
                  
              NET=0*datem(:,1);
              NET1=NET;
              Lotshis1=NET;
              TradeH=[]; 
              TradeD=[];
              TradeO=[];
              stock=[0 0 0 0 0];
                     
              if strcmp(MMFS,'Future')
                for i=1:length(runnamelist)
                  if (length(noempty(runnamelist{i}))==1)
                     runnamelist{i}(2)='_';
                  end   
                  
                  if exist([runnamelist{i},'output.mat'])==2
                    eval(['load ',runnamelist{i},'output']);
                    net=fpwout.net; net1=fpwout.net1; tradeh=fpwout.tradeh; tradeo=fpwout.tradeo;
                    lotshis=fpwout.lotshis; stockmar=fpwout.stock; datemar=fpwout.datem;  
                    if length(lotshis(1,:))>1;  lotshis=(sum(lotshis'))'; end
                    if (dnabs(datemar(1,1:3))>dnabs(datem(length(datem(:,1)),1:3)))|(dnabs(datemar(length(datemar(:,1)),1:3))<dnabs(datem(1,1:3)))
                      %These is no time overlap area
                      tradeh(1,1)=0; 
                    end           
                  else
                    tradeh(1,1)=0;          
                  end
                  
                  if tradeh(1,1)~=0
                    if dnabs(datemar(length(datemar(:,1)),1:3))>dnabs(datem(length(datem(:,1)),1:3))
                      DayoffsetnumE=length(datemar(:,1))-datef2(datem(length(datem(:,1)),1:3),datemar);
                      datem=[datem;datemar(length(datemar(:,1))-DayoffsetnumE+1:length(datemar(:,1)),1:3)];
                      NET=[NET;0*datemar(length(datemar(:,1))-DayoffsetnumE+1:length(datemar(:,1)),1)];
                      NET1=[NET1;0*datemar(length(datemar(:,1))-DayoffsetnumE+1:length(datemar(:,1)),1)];
                      Lotshis1=[Lotshis1;0*datemar(length(datemar(:,1))-DayoffsetnumE+1:length(datemar(:,1)),1)];              
                    end
                    if dnabs(datemar(1,1:3))<dnabs(datem(1,1:3))
                      DayoffsetnumB=datef2(datem(1,1:3),datemar);
                      datem=[datemar(1:DayoffsetnumB-1,1:3);datem];
                      NET=[0*datemar(1:DayoffsetnumB-1,1);NET];
                      NET1=[0*datemar(1:DayoffsetnumB-1,1);NET1];
                      Lotshis1=[0*datemar(1:DayoffsetnumB-1,1);Lotshis1];
                    end
                  
                    DayoffsetnumRB=datef2(datemar(1,1:3),datem);
                    if length(datem(:,1))-DayoffsetnumRB+1<length(net)
                      NET=[NET;0*((1:length(net)-length(datem(:,1))+DayoffsetnumRB-1)')];
                      NET1=[NET1;0*((1:length(net)-length(datem(:,1))+DayoffsetnumRB-1)')];
                      Lotshis1=[Lotshis1;0*((1:length(net)-length(datem(:,1))+DayoffsetnumRB-1)')];
                      datem=[datem;[0*((1:length(net)-length(datem(:,1))+DayoffsetnumRB-1)')+datem(length(datem(:,1)),1),...
                      0*((1:length(net)-length(datem(:,1))+DayoffsetnumRB-1)')+datem(length(datem(:,1)),2),...
                      0*((1:length(net)-length(datem(:,1))+DayoffsetnumRB-1)')+datem(length(datem(:,1)),3)]];
                    end
                    Net=0*NET; Net1=Net; Lotshis=0*Lotshis1;
                    Net(DayoffsetnumRB:length(net)+DayoffsetnumRB-1)=net;
                    Net1(DayoffsetnumRB:length(net)+DayoffsetnumRB-1)=net1;
                    Lotshis(DayoffsetnumRB:length(net)+DayoffsetnumRB-1)=lotshis;
                    net=Net; net1=Net1; lotshis=Lotshis; 
                    clear Net Net1 Lotshis
                                    
                    traded=[datemar(tradeh(:,3),[3 1 2]) datemar(tradeh(:,5),[3 1 2])];
                    traded(find(traded(:,1)<100),1)=traded(find(traded(:,1)<100),1)+1900;
                    traded(find(traded(:,1)<1950),1)=traded(find(traded(:,1)<1950),1)+100;
                    traded(find(traded(:,4)<100),4)=traded(find(traded(:,4)<100),4)+1900;
                    traded(find(traded(:,4)<1950),4)=traded(find(traded(:,4)<1950),4)+100;     
                    TradeD=[TradeD;[datemar(tradeh(:,3),1:3) datenum(traded(:,1:3)) datemar(tradeh(:,5),1:3) datenum(traded(:,4:6))]];
                  
                    % after do our best about datem, just cook it!
                    % and fortunately, our analysis are not based on datem, all original info are carried by
                    % tradeh, tradeo, TradeD and tradeeach and its own datem and stock for each model,
                    % the datem in here is just used as best time table to show them together.
                    if length(net)>length(NET)
                      Net=0*net; Net1=net; Lotshis=0*net;
                      Net(length(net)-length(NET)+1:length(net))=NET;
                      Net1(length(net)-length(NET)+1:length(net))=NET1;
                      Lotshis(length(net)-length(NET)+1:length(net))=Lotshis1;
                      NET=Net; NET1=Net1; Lotshis1=Lotshis; 
                      clear Net Net1 Lotshis     
                      datem=datemar;
                    elseif length(NET)>length(net)
                      Net=0*NET; Net1=Net; Lotshis=0*Net;
                      Net(length(NET)-length(net)+1:length(NET))=net;
                      Net1(length(NET)-length(net)+1:length(NET))=net1;
                      Lotshis(length(NET)-length(net)+1:length(NET))=lotshis;
                      net=Net; net1=Net1; lotshis=Lotshis; 
                      clear Net Net1 Lotshis   
                    end                  
                          
                    tradeh(:,13)=i*ones(size(tradeh(:,1)));
                    NET=NET+net;
                    NET1=NET1+net1;
                    Lotshis1=Lotshis1+lotshis;
                    TradeH=[TradeH;tradeh];
                    TradeO=[TradeO;tradeo];
                  end
                end
              else
                for i=1:length(runnamelist)
                            
                  if exist(['rts',runnamelist{i},'.mat'])==2
                    eval(['load rts',runnamelist{i}]);
                    net=fpwout.net; net1=fpwout.net1; tradeh=fpwout.tradeh; tradeo=fpwout.tradeo;
                    lotshis=fpwout.lotshis; stockmar=fpwout.stock; datemar=fpwout.datem; 
                    if length(lotshis(1,:))>1;  lotshis=(sum(lotshis'))'; end
                    if (dnabs(datemar(1,1:3))>dnabs(datem(length(datem(:,1)),1:3)))|(dnabs(datemar(length(datemar(:,1)),1:3))<dnabs(datem(1,1:3)))
                      %These is no time overlap area
                      tradeh(1,1)=0; 
                    end           
                  else
                    tradeh(1,1)=0;          
                  end
                      
                  if tradeh(1,1)~=0
                    if dnabs(datemar(length(datemar(:,1)),1:3))>dnabs(datem(length(datem(:,1)),1:3))
                      DayoffsetnumE=length(datemar(:,1))-datef2(datem(length(datem(:,1)),1:3),datemar);
                      datem=[datem;datemar(length(datemar(:,1))-DayoffsetnumE+1:length(datemar(:,1)),1:3)];
                      NET=[NET;0*datemar(length(datemar(:,1))-DayoffsetnumE+1:length(datemar(:,1)),1)];
                      NET1=[NET1;0*datemar(length(datemar(:,1))-DayoffsetnumE+1:length(datemar(:,1)),1)];
                      Lotshis1=[Lotshis1;0*datemar(length(datemar(:,1))-DayoffsetnumE+1:length(datemar(:,1)),1)];              
                    end
                    if dnabs(datemar(1,1:3))<dnabs(datem(1,1:3))
                      DayoffsetnumB=datef2(datem(1,1:3),datemar);
                      datem=[datemar(1:DayoffsetnumB-1,1:3);datem];
                      NET=[0*datemar(1:DayoffsetnumB-1,1);NET];
                      NET1=[0*datemar(1:DayoffsetnumB-1,1);NET1];
                      Lotshis1=[0*datemar(1:DayoffsetnumB-1,1);Lotshis1];
                    end
                    
                    DayoffsetnumRB=datef2(datemar(1,1:3),datem);
                    if length(datem(:,1))-DayoffsetnumRB+1<length(net)
                      NET=[NET;0*((1:length(net)-length(datem(:,1))+DayoffsetnumRB-1)')];
                      NET1=[NET1;0*((1:length(net)-length(datem(:,1))+DayoffsetnumRB-1)')];
                      Lotshis1=[Lotshis1;0*((1:length(net)-length(datem(:,1))+DayoffsetnumRB-1)')];
                      datem=[datem;[0*((1:length(net)-length(datem(:,1))+DayoffsetnumRB-1)')+datem(length(datem(:,1)),1),...
                      0*((1:length(net)-length(datem(:,1))+DayoffsetnumRB-1)')+datem(length(datem(:,1)),2),...
                      0*((1:length(net)-length(datem(:,1))+DayoffsetnumRB-1)')+datem(length(datem(:,1)),3)]];
                    end
                    Net=0*NET; Net1=Net; Lotshis=0*Lotshis1;
                    Net(DayoffsetnumRB:length(net)+DayoffsetnumRB-1)=net;
                    Net1(DayoffsetnumRB:length(net)+DayoffsetnumRB-1)=net1;
                    Lotshis(DayoffsetnumRB:length(net)+DayoffsetnumRB-1)=lotshis;
                    net=Net; net1=Net1; lotshis=Lotshis; 
                    clear Net Net1 Lotshis
                    
                    traded=[datemar(tradeh(:,3),[3 1 2]) datemar(tradeh(:,5),[3 1 2])];
                    traded(find(traded(:,1)<100),1)=traded(find(traded(:,1)<100),1)+1900;
                    traded(find(traded(:,1)<1950),1)=traded(find(traded(:,1)<1950),1)+100;
                    traded(find(traded(:,4)<100),4)=traded(find(traded(:,4)<100),4)+1900;
                    traded(find(traded(:,4)<1950),4)=traded(find(traded(:,4)<1950),4)+100;     
                    TradeD=[TradeD;[datemar(tradeh(:,3),1:3) datenum(traded(:,1:3)) datemar(tradeh(:,5),1:3) datenum(traded(:,4:6))]];          
             
                    % after do our best about datem, just cook it!
                    % and fortunately, our analysis are not based on datem, all original info are carried by
                    % tradeh, tradeo, TradeD and tradeeach and its own datem and stock for each model,
                    % the datem in here is just used as best time table to show them together.
                    if length(net)>length(NET)
                      Net=0*net; Net1=net; Lotshis=0*net;
                      Net(length(net)-length(NET)+1:length(net))=NET;
                      Net1(length(net)-length(NET)+1:length(net))=NET1;
                      Lotshis(length(net)-length(NET)+1:length(net))=Lotshis1;
                      NET=Net; NET1=Net1; Lotshis1=Lotshis; 
                      clear Net Net1 Lotshis     
                      datem=datemar;
                    elseif length(NET)>length(net)
                      Net=0*NET; Net1=Net; Lotshis=0*Net;
                      Net(length(NET)-length(net)+1:length(NET))=net;
                      Net1(length(NET)-length(net)+1:length(NET))=net1;
                      Lotshis(length(NET)-length(net)+1:length(NET))=lotshis;
                      net=Net; net1=Net1; lotshis=Lotshis; 
                      clear Net Net1 Lotshis   
                    end            
                    
                    tradeh(:,13)=i*ones(size(tradeh(:,1)));
                    NET=NET+net;
                    NET1=NET1+net1;
                    Lotshis1=Lotshis1+lotshis;
                    TradeH=[TradeH;tradeh];
                    TradeO=[TradeO;tradeo];
                  end
                end
              end
          
              net=NET;net1=NET1;lotshis=Lotshis1;tradeh=TradeH; tradeo=TradeO; 
              clear i NET NET1 Lotshis1 tradeH stockmar datemar wheremar traded
              
              if tradeh(1,1)~=0
                fpwoutwindow=21; 
                fpwout.TradeD=TradeD;
                fpwout.net=net; fpwout.net1=net1; fpwout.tradeh=tradeh; fpwout.tradeo=tradeo;
                fpwout.runnamelist=runnamelist; fpwout.lotshis=lotshis; fpwout.datem=datem;
                fpwout.MM12='No.3'; fpwout.MMFS=MMFS;  fpwout.mname=Mname1;
                fpwout.name='ZZXY'; fpwout.stock=stock; % fpwout.tradeeach=tradeeach;
                fpwout.zhu52=num2str(datef2(Bdate,datem));
                fpwout.zhu54=num2str(length(datem(:,1))-datef2(Edate,datem)+1);                 
                fpwout.wsscale=1; fpwout.outonoff='0';
                eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwany300 fpwout']);
                
                fpwout.fpwsource='fpwany300';              
                fpwout.outonoff='0';
                fpwout1=fpwozc3(fpwout); 
                fpwout1.fpwsource='fpwany300';
                fpwout1.fpwusername=fpwusername;
                fpwout1.fpwusername4=fpwusername4;
                fpwout1.fpwulvl=instruct.fpwulvl;
                fpwout1.outrunindex='16';
                fpwout1.outDSM=outDSM;   
                fpwout1.outGOsm=instruct.outGOsm;
                fpwout1.outAnyU=instruct.outAnyU;
                fpwout1.outAnyD=instruct.outAnyD;
                fpwout1.outAnyS=num2str(abs(str2num(instruct.outAnyS)));               
                         
                set(fpwout1.fpwoutfig,'PaperPosition',MyPaperPosiH);
                cd([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern']);
                drawnow;
                wsprintjpeg(fpwout1.fpwoutfig,'fpwoutjpeg.jpeg');
                close(fpwout1.fpwoutfig);
                cd([Wherematlab,'pattern']);
                fpwout1.fpwoutjpeg=[fpwclientdirectory,fpwusername,'\pattern\fpwoutjpeg.jpeg']; 
                               
                sfpw1.StatusReport=[' Decomposed MM simulation output,  saved in ',mname,' - 3. ',time];
                templatefile = which('MPsimulationR1.html');
                str = htmlrep(sfpw1, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\twbfpwoutputR1.html'],'noheader');      
                fpwout1.FPWoutstatus=strrep([fpwclientdirectory,fpwusername,'\pattern\twbfpwoutputR1.html'],'\','/');  
              else
                fpwoutwindow=24;
                fpwout1.fpwusername=fpwusername;
                fpwout1.fpwusername4=fpwusername4;
                fpwout1.fpwulvl=instruct.fpwulvl;
                fpwout1.outrunindex='00';               
              end    
              
              % this is the original one
              %fpwoutwindow=22;
              %cd([Wherematlab,'\pattern']);
              %fpwout1.fpwusername=fpwusername;
              %fpwout1.fpwusername4=fpwusername4;
              %fpwout1.fpwulvl=instruct.fpwulvl;  
              %fpwout1.outGOsm=instruct.outGOsm;
              %fpwout1.outAnyU=instruct.outAnyU;
              %fpwout1.outAnyD=instruct.outAnyD;
              %fpwout1.outAnyS=instruct.outAnyS;                
              %for i=1:108
              %  if i<=length(runnamelist)
              %    YLFN=upper(noempty(runnamelist{i}));
              %    stringtofill=sprintf(['<input type="checkbox" value="1" name="mrkT',num2str(i),'"><input style="width: 45px" type="button" name="',YLFN,...
              %    '" onmouseover="window.status=''To output the simulation results of this market.''" value="',YLFN,...
              %    '" onmouseout="window.status=''Done''" onclick="javascript: mfsForm.marketrun.value=''',YLFN,...
              %    '''; mfsForm.submit();">']); 
              %    eval(['fpwout1.mfs',num2str(i),'=stringtofill;']);
              %  else
              %    eval(['fpwout1.mfs',num2str(i),'='' '';']);              
              %  end
              %end
              %fpwout1.marketMXL=int2str(length(runnamelist));
              
            else % length(Mname1)>1 i.e. for twoo different two market to combine
    
              fpwsource='fpwany300';
              %cd([Wherematlab,'pattern']);
              %error('Go, do it.');
              %save fpwtempfile     
              %error(' to stop running here')
              
              for i=1:2
                tradet=tradehdecom(find(tradehdecom(:,13)==i),9);     % enty time
                Traded=TradeDdecom(find(tradehdecom(:,13)==i),4);     % entry date's day number
                tradep=tradehdecom(find(tradehdecom(:,13)==i),4);     % use exit price to avoid info overlaped in entry place  
                
                eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data21\fpwoutput',num2str(i)]);
                net=fpwout.net; net1=fpwout.net1; lotshis=fpwout.lotshis; tradeh=fpwout.tradeh; 
                tradeo=fpwout.tradeo; datem=fpwout.datem; stock=fpwout.stock; tradeeach=fpwout.tradeeach;  
                
                traded=datem(tradeh(:,3),[3 1 2]);
                traded(find(traded(:,1)<100),1)=traded(find(traded(:,1)<100),1)+1900;
                traded(find(traded(:,1)<1950),1)=traded(find(traded(:,1)<1950),1)+100;
                TradeD=datenum(traded(:,1:3));  
                
                tradepassed=0*tradeh(:,1);
                for j=1:length(tradet(:,1))
                  findsig=find(  (tradeh(:,4)==tradep(j)) & (tradeh(:,9)==tradet(j)) &  (TradeD==Traded(j))  );
                  if length(findsig)>0
                    tradepassed(findsig)=1; 
                    if length(findsig)>1
                      ZhuTMD=' - Strange! You have two signals are exactly same! We took them, but check them please.'    
                    end
                  end
                end

                for j=1:length(tradeh(:,1))
                  if tradepassed(j)==0; 
                    dropitwp=tradeeach(tradeh(j,10):tradeh(j,11));
                    dropitwp=reshape(dropitwp,length(dropitwp)/2,2);
                    if tradeh(j,3)==tradeh(j,5)
                      lotshis(tradeh(j,3),tradeh(j,12))=0;
                    else
                      zhuws2=lotshis(tradeh(j,3):tradeh(j,5)-1,tradeh(j,12));
                      lotshis(tradeh(j,3):tradeh(j,5)-1,tradeh(j,12))=0*zhuws2;
                      clear zhuws2;
                    end
                    net(dropitwp(:,1))=net(dropitwp(:,1))-dropitwp(:,2);
                  end
                end
                tradeh=tradeh(find(tradepassed==1),:);  
                tradeo=tradeo(find(tradepassed==1),:); 
                net1=0*net;
                if length(tradeh)>0          
                  net1(tradeh(:,3))=tradeh(:,6);
                else
                  net=net1; tradeeach=[]; lotshis=net; tradeh=zeros(1,12); tradeo=[0 0 0]; 
                end
                fpwout.net=net; fpwout.net1=net1; fpwout.lotshis=lotshis; fpwout.tradeh=tradeh; fpwout.tradeo=tradeo;
                if ws2ws2ws2==1
                  fpwout.anycond=[namews2,'||',wafw,'||',watw];
                else
                  fpwout.anycond=['UrSym||',wafw,'||',watw]; 
                end
                eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data21\fpwoutput',num2str(i),' fpwout']);
                if i==1
                  NET=fpwout.net; NET1=fpwout.net1; Lotshis1=fpwout.lotshis; Tradeh=fpwout.tradeh; 
                  Tradeo=fpwout.tradeo; datem=fpwout.datem; stock=fpwout.stock; Tradeeach=fpwout.tradeeach;datemo1=datem;
                else
                  net=fpwout.net; net1=fpwout.net1; lotshis=fpwout.lotshis; tradeh=fpwout.tradeh; 
                  tradeo=fpwout.tradeo; datemar=fpwout.datem; stockmar=fpwout.stock; tradeeach=fpwout.tradeeach;
                end
              end                   
              
              datem=datemo1;
              TradeD=[];
              if length(lotshis(1,:))>1;  lotshis=(sum(lotshis'))'; end
              if Tradeh(1,1)~=0
                traded=[datem(Tradeh(:,3),[3 1 2]) datem(Tradeh(:,5),[3 1 2])];
                traded(find(traded(:,1)<100),1)=traded(find(traded(:,1)<100),1)+1900;
                traded(find(traded(:,1)<1950),1)=traded(find(traded(:,1)<1950),1)+100;
                traded(find(traded(:,4)<100),4)=traded(find(traded(:,4)<100),4)+1900;
                traded(find(traded(:,4)<1950),4)=traded(find(traded(:,4)<1950),4)+100;     
                TradeD=[datem(Tradeh(:,3),1:3) datenum(traded(:,1:3)) datem(Tradeh(:,5),1:3) datenum(traded(:,4:6))];
              else
                TradeD=[];    
              end
              if length(Lotshis1(1,:))>1;  Lotshis1=(sum(Lotshis1'))'; end
                        
              if tradeh(1,1)~=0
                if dnabs(datemar(length(datemar(:,1)),1:3))>dnabs(datem(length(datem(:,1)),1:3))
                  DayoffsetnumE=length(datemar(:,1))-datef2(datem(length(datem(:,1)),1:3),datemar);
                  datem=[datem;datemar(length(datemar(:,1))-DayoffsetnumE+1:length(datemar(:,1)),1:3)];
                  NET=[NET;0*datemar(length(datemar(:,1))-DayoffsetnumE+1:length(datemar(:,1)),1)];
                  NET1=[NET1;0*datemar(length(datemar(:,1))-DayoffsetnumE+1:length(datemar(:,1)),1)];
                  Lotshis1=[Lotshis1;0*datemar(length(datemar(:,1))-DayoffsetnumE+1:length(datemar(:,1)),1)];              
                end
                if dnabs(datemar(1,1:3))<dnabs(datem(1,1:3))
                  DayoffsetnumB=datef2(datem(1,1:3),datemar);
                  datem=[datemar(1:DayoffsetnumB-1,1:3);datem];
                  NET=[0*datemar(1:DayoffsetnumB-1,1);NET];
                  NET1=[0*datemar(1:DayoffsetnumB-1,1);NET1];
                  Lotshis1=[0*datemar(1:DayoffsetnumB-1,1);Lotshis1];
                end
                 
                DayoffsetnumRB=datef2(datemar(1,1:3),datem);
                if length(datem(:,1))-DayoffsetnumRB+1<length(net)
                  NET=[NET;0*((1:length(net)-length(datem(:,1))+DayoffsetnumRB-1)')];
                  NET1=[NET1;0*((1:length(net)-length(datem(:,1))+DayoffsetnumRB-1)')];
                  Lotshis1=[Lotshis1;0*((1:length(net)-length(datem(:,1))+DayoffsetnumRB-1)')];
                  datem=[datem;[0*((1:length(net)-length(datem(:,1))+DayoffsetnumRB-1)')+datem(length(datem(:,1)),1),...
                  0*((1:length(net)-length(datem(:,1))+DayoffsetnumRB-1)')+datem(length(datem(:,1)),2),...
                  0*((1:length(net)-length(datem(:,1))+DayoffsetnumRB-1)')+datem(length(datem(:,1)),3)]];
                end
                Net=0*NET; Net1=Net; Lotshis=0*Lotshis1;
                Net(DayoffsetnumRB:length(net)+DayoffsetnumRB-1)=net;
                Net1(DayoffsetnumRB:length(net)+DayoffsetnumRB-1)=net1;
                Lotshis(DayoffsetnumRB:length(net)+DayoffsetnumRB-1)=lotshis;
                net=Net; net1=Net1; lotshis=Lotshis; 
                clear Net Net1 Lotshis
                
                traded=[datemar(tradeh(:,3),[3 1 2]) datemar(tradeh(:,5),[3 1 2])];
                traded(find(traded(:,1)<100),1)=traded(find(traded(:,1)<100),1)+1900;
                traded(find(traded(:,1)<1950),1)=traded(find(traded(:,1)<1950),1)+100;
                traded(find(traded(:,4)<100),4)=traded(find(traded(:,4)<100),4)+1900;
                traded(find(traded(:,4)<1950),4)=traded(find(traded(:,4)<1950),4)+100;   
                TradeD=[TradeD;[datemar(tradeh(:,3),1:3) datenum(traded(:,1:3)) datemar(tradeh(:,5),1:3) datenum(traded(:,4:6))]]; 
                
                if length(net)>length(NET)
                  Net=0*net; Net1=Net; Lotshis=0*Net;
                  Net(length(net)-length(NET)+1:length(net))=NET;
                  Net1(length(net)-length(NET)+1:length(net))=NET1;
                  Lotshis(length(net)-length(NET)+1:length(net))=Lotshis1;
                  NET=Net; NET1=Net1; Lotshis1=Lotshis; 
                  clear Net Net1 Lotshis   
                  datem=datemar;
                elseif length(NET)>length(net)
                  Net=0*NET; Net1=Net; Lotshis=0*Net;
                  Net(length(NET)-length(net)+1:length(NET))=net;
                  Net1(length(NET)-length(net)+1:length(NET))=net1;
                  Lotshis(length(NET)-length(net)+1:length(NET))=lotshis;
                  net=Net; net1=Net1; lotshis=Lotshis; 
                  clear Net Net1 Lotshis   
                end

                if Tradeh(1,1)~=0
                  Tradeh(:,13)=0*Tradeh(:,11)+1;
                end
                tradeh(:,13)=0*tradeh(:,11)+2;
                net=NET+net;
                net1=NET1+net1;
                lotshis=[Lotshis1 lotshis];
                if Tradeh(1,1)~=0                
                  tradeh=[Tradeh;tradeh];
                  tradeo=[Tradeo;tradeo];
                end      
                fpwout.net=net; fpwout.net1=net1; fpwout.lotshis=lotshis; fpwout.datem=datem; 
                fpwout.wsscale=1; fpwout.zhu52='1';  fpwout.zhu54='1'; fpwout.TradeD=TradeD;
                fpwout.tradeh=tradeh; fpwout.tradeo=tradeo; fpwout.name='ZZXY'; 
                fpwout.mname=upper(Mname1);
                fpwout.runnamelist=runnamelist;
                %all others are still useing original fpwoutput parameters
                eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwany300 fpwout']);                    
              else  
                Tradeh(:,13)=0*Tradeh(:,11)+1;
                net=NET;
                net1=NET1;
                lotshis=Lotshis1;
                tradeh=Tradeh;
                tradeo=Tradeo;
                        
                fpwout.net=net; fpwout.net1=net1; fpwout.lotshis=lotshis; fpwout.datem=datem; 
                fpwout.wsscale=1; fpwout.TradeD=TradeD;
                fpwout.zhu52=num2str(datef2(Bdate,datem));
                fpwout.zhu54=num2str(length(datem(:,1))-datef2(Edate,datem)+1);
                fpwout.tradeh=tradeh; fpwout.tradeo=tradeo; fpwout.name='ZZXY'; 
                fpwout.mname=upper(Mname1);
                fpwout.runnamelist=runnamelist;
                %all others are still useing original fpwoutput parameters
                eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwany300 fpwout']);                 
              end                  
              
              if tradeh(1,1)~=0  
                fpwoutwindow=21;
                cd([Wherematlab,'\pattern']);
                fpwout.outonoff='0';
                fpwout.fpwsource='fpwany300';
                fpwout1=fpwozc3(fpwout);    
                fpwout1.fpwsource='fpwany300';
                fpwout1.fpwusername=fpwusername;
                fpwout1.fpwusername4=fpwusername4;
                fpwout1.fpwulvl=instruct.fpwulvl;
                fpwout1.outrunindex='16';
                fpwout1.outDSM='3';
                fpwout1.outAnyS=num2str(abs(str2num(instruct.outAnyS)));
                fpwout1.outAnyU=instruct.outAnyU;          
                fpwout1.outAnyD=instruct.outAnyD; 
                fpwout1.outGOsm=instruct.outGOsm; 
                 
                set(fpwout1.fpwoutfig,'PaperPosition',MyPaperPosiH);
                cd([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern']);
                drawnow;
                wsprintjpeg(fpwout1.fpwoutfig,'fpwoutjpeg.jpeg');
                close(fpwout1.fpwoutfig);
                cd([Wherematlab,'pattern']);
                fpwout1.fpwoutjpeg=[fpwclientdirectory,fpwusername,'\pattern\fpwoutjpeg.jpeg']; 
                            
                sfpw1.StatusReport=[' Decomposed MM simulation output of the front showing one. ',time];
                templatefile = which('MPsimulationR1.html');
                str = htmlrep(sfpw1, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\twbfpwoutputR1.html'],'noheader');      
                fpwout1.FPWoutstatus=strrep([fpwclientdirectory,fpwusername,'\pattern\twbfpwoutputR1.html'],'\','/');    
              else
                fpwoutwindow=24;
                fpwout1.fpwusername=fpwusername;
                fpwout1.fpwusername4=fpwusername4;
                fpwout1.fpwulvl=instruct.fpwulvl;       
              end     
            end
          end          
        end  
      end      
      
      %elseif strcmp(outrunindex(1),'2')
      % Genetic optimizers
     % if strcmp(outrunindex,'21')
        % level I
          
        %end
      
      %if strcmp(outrunindex,'22')
        % Level II
        
        %end
    
      %if strcmp(outrunindex,'23')
        % Level III
        
        %end

      %if strcmp(outrunindex,'24')
        % Hybrid Level II
          
        %end
      
      %if strcmp(outrunindex,'25')
        % Hybrid Level III
          
        %end         
    elseif strcmp(outrunindex(1),'3')
      if strcmp(outrunindex,'31')
        % Run simu, decom, mm .. for load from home
        outDSM=str2num(instruct.outDSM);
        if outDSM<6
          if outDSM==1
            if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwoutput.mat'])==2
              eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwoutput']);
            else
              error(' - The file is not existed yet, run simulation first.');
            end
            fpwsource='fpwoutput';
          elseif outDSM==2
            if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwoutf2.mat'])==2
              eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwoutf2']);
            else
              error(' - The file is not existed yet, run simulation first.');
            end
            fpwsource='fpwoutf2';
          elseif outDSM==3
            if (exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwoutput.mat'])==2)&...
              (exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwoutf2.mat'])==2)
              eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwoutf2']);
            else
              error(' - At least one of the two files is not existed yet, run simulation first.');
            end
            tickcomb23=1;
            Fpwout=fpwout;Mname1=fpwout.mname;
            eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data21\fpwoutput2 fpwout']);
            runnamelist{1}=' ';
            runnamelist{2}=fpwout.name;
            eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwoutput']);
            runnamelist{1}=fpwout.name;
            load c:\matlab\pattern\tradehsizes.mat
            if strcmp(noempty(upper([fpwout.mname,fpwout.name])),noempty(upper([Fpwout.mname,Fpwout.name])))
              fpwsource='fpwoutft';
              net=Fpwout.net; net1=Fpwout.net1; lotshis=Fpwout.lotshis; tradeh=Fpwout.tradeh; 
              if isfield(Fpwout,'tradeh2')
                tradeh2=Fpwout.tradeh2; tradeh3=Fpwout.tradeh3;
                if length(tradeh2(1,:))<TradehSizes(1)
                  tradeh2=[tradeh2 0*tradeh2(:,1:(TradehSizes(1)-length(tradeh2(1,:))))]; 
                end
                if length(tradeh3(1,:))<TradehSizes(2)
                  tradeh3=[tradeh3 0*tradeh3(:,1:(TradehSizes(2)-length(tradeh3(1,:))))]; 
                end
              else
                tickcomb23=0;
              end
              CPSi=1;
              if isfield(Fpwout,'CPS')
                CPS=Fpwout.CPS;
                if length(CPS(:,1))~=length(tradeh(:,1))
                  CPS=0*tradeh(:,1); CPSi=0;
                end
              else
                CPS=0*tradeh(:,1); CPSi=0;
              end
              tradeo=Fpwout.tradeo; datemar=Fpwout.datem; stockmar=Fpwout.stock; tradeeach=Fpwout.tradeeach;
              tradeD=datemar(tradeh(:,3),1:3);
              if length(lotshis(1,:))>1;  lotshis=(sum(lotshis'))'; end
              %clear Fpwout
              NET=fpwout.net; NET1=fpwout.net1; Lotshis1=fpwout.lotshis; Tradeh=fpwout.tradeh; 
              if tickcomb23==1
                if isfield(fpwout,'tradeh2')
                  Tradeh2=fpwout.tradeh2; Tradeh3=fpwout.tradeh3;
                  if length(Tradeh2(1,:))<TradehSizes(1)
                    Tradeh2=[Tradeh2 0*Tradeh2(:,1:(TradehSizes(1)-length(Tradeh2(1,:))))]; 
                  end
                  if length(Tradeh3(1,:))<TradehSizes(2)
                    Tradeh3=[Tradeh3 0*Tradeh3(:,1:(TradehSizes(2)-length(Tradeh3(1,:))))]; 
                  end
                else
                  tickcomb23=0;
                end
              end
              if (isfield(fpwout,'CPS'))&(CPSi==1) % assuming both simulation with the same CPS assignment! Otherwise it's meaningless.
                CPSc=fpwout.CPS;
                if length(CPSc(:,1))~=length(Tradeh(:,1))
                  CPSc=0*Tradeh(:,1);
                end
              else
                CPSc=0*Tradeh(:,1);
              end
              Tradeo=fpwout.tradeo; datem=fpwout.datem; stock=fpwout.stock; Tradeeach=fpwout.tradeeach;
              TradeD=datem(Tradeh(:,3),1:3);
              if length(Lotshis1(1,:))>1;  Lotshis1=(sum(Lotshis1'))'; end
              if (dnabs(datemar(1,1:3))>dnabs(datem(length(datem(:,1)),1:3)))|(dnabs(datemar(length(datemar(:,1)),1:3))<dnabs(datem(1,1:3)))
                error(' - There is no time ovelape period, it''s meaningless to combine these two.');
              end           
              if tradeh(1,1)~=0
                                 
                if dnabs(datemar(length(datemar(:,1)),1:3))>dnabs(datem(length(datem(:,1)),1:3))
                  DayoffsetnumE=length(datemar(:,1))-datef2(datem(length(datem(:,1)),1:3),datemar);
                  datem=[datem;datemar(length(datemar(:,1))-DayoffsetnumE+1:length(datemar(:,1)),1:3)];
                  stock=[stock;stockmar(length(stockmar(:,1))-DayoffsetnumE+1:length(stockmar(:,1)),1:5)];
                  NET=[NET;0*datemar(length(datemar(:,1))-DayoffsetnumE+1:length(datemar(:,1)),1)];
                  NET1=[NET1;0*datemar(length(datemar(:,1))-DayoffsetnumE+1:length(datemar(:,1)),1)];
                  Lotshis1=[Lotshis1;0*datemar(length(datemar(:,1))-DayoffsetnumE+1:length(datemar(:,1)),1)];              
                end
                if dnabs(datemar(1,1:3))<dnabs(datem(1,1:3))
                  DayoffsetnumB=datef2(datem(1,1:3),datemar);
                  datem=[datemar(1:DayoffsetnumB-1,1:3);datem];
                  stock=[stockmar(1:DayoffsetnumB-1,1:5);stock];
                  for i=1:length(Tradeh(:,3))
                    Tradeeach(Tradeh(i,10):(Tradeh(i,10)+Tradeh(i,11)-1)/2)=...
                    Tradeeach(Tradeh(i,10):(Tradeh(i,10)+Tradeh(i,11)-1)/2)+DayoffsetnumB-1;
                  end
                  Tradeh(:,3)=Tradeh(:,3)+DayoffsetnumB-1;
                  Tradeh(:,5)=Tradeh(:,5)+DayoffsetnumB-1;
                  Tradeo(:,1)=Tradeo(:,1)+DayoffsetnumB-1;
                  NET=[0*datemar(1:DayoffsetnumB-1,1);NET];
                  NET1=[0*datemar(1:DayoffsetnumB-1,1);NET1];
                  Lotshis1=[0*datemar(1:DayoffsetnumB-1,1);Lotshis1];
                end
                
                DayoffsetnumRB=datef2(datemar(1,1:3),datem);
                if length(datem(:,1))-DayoffsetnumRB+1<length(net)
                  zhuTMD=length(net)-length(datem(:,1))+DayoffsetnumRB-1
                  zhuTMD=' The above number shows how much shifted each other during the simulation history between'
                  zhuTMD=' the expected two exactly same time serial for the SAME market. Should not happen. '
                  zhuTMD=' one or even both are out dated file, better run them again, then combine them after that.  Thanks.'
                  % this should not be happened as long as one's using same serial data
                  NET=[NET;0*((1:length(net)-length(datem(:,1))+DayoffsetnumRB-1)')];
                  NET1=[NET1;0*((1:length(net)-length(datem(:,1))+DayoffsetnumRB-1)')];
                  Lotshis1=[Lotshis1;0*((1:length(net)-length(datem(:,1))+DayoffsetnumRB-1)')];
                  datem=[datem;[0*((1:length(net)-length(datem(:,1))+DayoffsetnumRB-1)')+datem(length(datem(:,1)),1),...
                  0*((1:length(net)-length(datem(:,1))+DayoffsetnumRB-1)')+datem(length(datem(:,1)),2),...
                  0*((1:length(net)-length(datem(:,1))+DayoffsetnumRB-1)')+datem(length(datem(:,1)),3)]];
                  stock=[stock;[0*((1:length(net)-length(stock(:,1))+DayoffsetnumRB-1)')+stock(length(stock(:,1)),1),...
                  0*((1:length(net)-length(stock(:,1))+DayoffsetnumRB-1)')+stock(length(stock(:,1)),2),...
                  0*((1:length(net)-length(stock(:,1))+DayoffsetnumRB-1)')+stock(length(stock(:,1)),3),...
                  0*((1:length(net)-length(stock(:,1))+DayoffsetnumRB-1)')+stock(length(stock(:,1)),4),...                  
                  0*((1:length(net)-length(stock(:,1))+DayoffsetnumRB-1)')+stock(length(stock(:,1)),5)]];      
                end                
                  
                Net=0*NET; Net1=Net; Lotshis=0*Lotshis1;
                Net(DayoffsetnumRB:length(net)+DayoffsetnumRB-1)=net;
                Net1(DayoffsetnumRB:length(net)+DayoffsetnumRB-1)=net1;
                Lotshis(DayoffsetnumRB:length(net)+DayoffsetnumRB-1)=lotshis;
                net=Net; net1=Net1; lotshis=Lotshis; 
                clear Net Net1 Lotshis
                for i=1:length(tradeh(:,1))
                  BBBMAAA=tradeh(i,3);
                  tradeh(i,3)=dmatch(tradeh(i,3),datemar,datem); 
                  BBBMAAA=tradeh(i,3)-BBBMAAA;
                  tradeeach(tradeh(i,10):(tradeh(i,10)+tradeh(i,11)-1)/2)=...
                  tradeeach(tradeh(i,10):(tradeh(i,10)+tradeh(i,11)-1)/2)+BBBMAAA; 
                  tradeh(i,5)=dmatch(tradeh(i,5),datemar,datem); 
                end
                
                lotshis=[Lotshis1 lotshis];  
                    %The only place to add lotshis this way, all others are just simply add to one vector
                Tradeh(:,12)=0*Tradeh(:,11)+1;
                tradeh(:,12)=0*tradeh(:,11)+2;
                tradeh(:,10)=tradeh(:,10)+length(Tradeeach);
                tradeh(:,11)=tradeh(:,11)+length(Tradeeach);
                tradeh=[Tradeh;tradeh];
                CPS=[CPSc;CPS];
                tradeo=[Tradeo;tradeo];
                TradeD=[TradeD;tradeD];
                if tickcomb23==1
                  if 0  
                    if length(Tradeh2(1,:))>length(tradeh2(1,:))
                      tradeh2=[tradeh2 zeros(length(tradeh2(:,1)),length(Tradeh2(1,:))-length(tradeh2(1,:)))];
                    elseif length(tradeh2(1,:))>length(Tradeh2(1,:))
                      Tradeh2=[Tradeh2 zeros(length(Tradeh2(:,1)),length(tradeh2(1,:))-length(Tradeh2(1,:)))];
                    end
                    if length(Tradeh3(1,:))>length(tradeh3(1,:))
                      tradeh3=[tradeh3 zeros(length(tradeh3(:,1)),length(Tradeh3(1,:))-length(tradeh3(1,:)))];
                    elseif length(tradeh3(1,:))>length(Tradeh3(1,:))
                      Tradeh3=[Tradeh3 zeros(length(Tradeh3(:,1)),length(tradeh3(1,:))-length(Tradeh3(1,:)))];
                    end
                  else
                    load c:\matlab\pattern\tradehsizes.mat
                    if length(tradeh2(1,:))~=TradehSizes(1)
                      tradeh2=[tradeh2 zeros(length(tradeh2(:,1)),TradehSizes(1)-length(tradeh2(1,:)))];
                    end
                    if length(tradeh3(1,:))~=TradehSizes(2)
                      tradeh3=[tradeh3 zeros(length(tradeh3(:,1)),TradehSizes(2)-length(tradeh3(1,:)))];
                    end
                    if length(Tradeh2(1,:))~=TradehSizes(1)
                      Tradeh2=[Tradeh2 zeros(length(Tradeh2(:,1)),TradehSizes(1)-length(Tradeh2(1,:)))];
                    end
                    if length(Tradeh3(1,:))~=TradehSizes(2)
                      Tradeh3=[Tradeh3 zeros(length(Tradeh3(:,1)),TradehSizes(2)-length(Tradeh3(1,:)))];
                    end
                  end
                  tradeh2=[Tradeh2;tradeh2]; fpwout.tradeh2=tradeh2;
                  tradeh3=[Tradeh3;tradeh3]; fpwout.tradeh3=tradeh3;
                end
                net=NET+net;
                net1=NET1+net1;
                [qww qiw]=sort(tradeh(:,3));
                tradeh=tradeh(qiw,:);
                tradeo=tradeo(qiw,:);
                TradeD=TradeD(qiw,:);
                CPS=CPS(qiw,:);
                tradeeach=[Tradeeach;tradeeach];
                fpwout.net=net; fpwout.net1=net1; fpwout.lotshis=lotshis; fpwout.datem=datem; fpwout.stock=stock;
                fpwout.tradeh=tradeh; fpwout.tradeo=tradeo; fpwout.tradeeach=tradeeach; fpwout.TradeD=TradeD;
                fpwout.wsscale=1; fpwout.zhu52='1';  fpwout.zhu54='1';
                fpwout.CPS=CPS;
                % all others are still useing original fpwoutput parameters
                eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwoutft fpwout']);
              else  
                fpwsource='fpwoutput';                    
              end         
            else
              fpwsource='fpwany300';
              net=Fpwout.net; net1=Fpwout.net1; lotshis=Fpwout.lotshis; tradeh=Fpwout.tradeh; 
              tradeo=Fpwout.tradeo; datemar=Fpwout.datem; stockmar=Fpwout.stock; tradeeach=Fpwout.tradeeach;
              CPSi=1;
              if isfield(Fpwout,'CPS')
                CPS=Fpwout.CPS;
                if length(CPS(:,1))~=length(tradeh(:,1))
                  CPS=0*tradeh(:,1); CPSi=0;
                end
              else
                CPS=0*tradeh(:,1); CPSi=0;
              end
              if length(lotshis(1,:))>1;  lotshis=(sum(lotshis'))'; end
              eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data21\fpwoutput1 fpwout']);
              clear Fpwout
              NET=fpwout.net; NET1=fpwout.net1; Lotshis1=fpwout.lotshis; Tradeh=fpwout.tradeh; 
              if (isfield(fpwout,'CPS'))&(CPSi==1) % assuming both simulation with the same CPS assignment! Otherwise it's meaningless.
                CPSc=fpwout.CPS;
                if length(CPSc(:,1))~=length(Tradeh(:,1))
                  CPSc=0*Tradeh(:,1);
                end
              else
                CPSc=0*Tradeh(:,1);
              end
              Tradeo=fpwout.tradeo; datem=fpwout.datem; stock=fpwout.stock; Tradeeach=fpwout.tradeeach;
              traded=[datem(Tradeh(:,3),[3 1 2]) datem(Tradeh(:,5),[3 1 2])];
              traded(find(traded(:,1)<100),1)=traded(find(traded(:,1)<100),1)+1900;
              traded(find(traded(:,1)<1950),1)=traded(find(traded(:,1)<1950),1)+100;
              traded(find(traded(:,4)<100),4)=traded(find(traded(:,4)<100),4)+1900;
              traded(find(traded(:,4)<1950),4)=traded(find(traded(:,4)<1950),4)+100;     
              TradeD=[datem(Tradeh(:,3),1:3) datenum(traded(:,1:3)) datem(Tradeh(:,5),1:3) datenum(traded(:,4:6))];
              if length(Lotshis1(1,:))>1;  Lotshis1=(sum(Lotshis1'))'; end
              if (dnabs(datemar(1,1:3))>dnabs(datem(length(datem(:,1)),1:3)))|(dnabs(datemar(length(datemar(:,1)),1:3))<dnabs(datem(1,1:3)))
                error(' - There is no time ovelape period, it''s meaningless to combine these two.');
              end           
              if tradeh(1,1)~=0

                if dnabs(datemar(length(datemar(:,1)),1:3))>dnabs(datem(length(datem(:,1)),1:3))
                  DayoffsetnumE=length(datemar(:,1))-datef2(datem(length(datem(:,1)),1:3),datemar);
                  datem=[datem;datemar(length(datemar(:,1))-DayoffsetnumE+1:length(datemar(:,1)),1:3)];
                  NET=[NET;0*datemar(length(datemar(:,1))-DayoffsetnumE+1:length(datemar(:,1)),1)];
                  NET1=[NET1;0*datemar(length(datemar(:,1))-DayoffsetnumE+1:length(datemar(:,1)),1)];
                  Lotshis1=[Lotshis1;0*datemar(length(datemar(:,1))-DayoffsetnumE+1:length(datemar(:,1)),1)];              
                end
                if dnabs(datemar(1,1:3))<dnabs(datem(1,1:3))
                  DayoffsetnumB=datef2(datem(1,1:3),datemar);
                  datem=[datemar(1:DayoffsetnumB-1,1:3);datem];
                  NET=[0*datemar(1:DayoffsetnumB-1,1);NET];
                  NET1=[0*datemar(1:DayoffsetnumB-1,1);NET1];
                  Lotshis1=[0*datemar(1:DayoffsetnumB-1,1);Lotshis1];
                end

                DayoffsetnumRB=datef2(datemar(1,1:3),datem);
                if length(datem(:,1))-DayoffsetnumRB+1<length(net)                 
                  NET=[NET;0*((1:length(net)-length(datem(:,1))+DayoffsetnumRB-1)')];
                  NET1=[NET1;0*((1:length(net)-length(datem(:,1))+DayoffsetnumRB-1)')];
                  Lotshis1=[Lotshis1;0*((1:length(net)-length(datem(:,1))+DayoffsetnumRB-1)')];
                  datem=[datem;[0*((1:length(net)-length(datem(:,1))+DayoffsetnumRB-1)')+datem(length(datem(:,1)),1),...
                  0*((1:length(net)-length(datem(:,1))+DayoffsetnumRB-1)')+datem(length(datem(:,1)),2),...
                  0*((1:length(net)-length(datem(:,1))+DayoffsetnumRB-1)')+datem(length(datem(:,1)),3)]];
                end
                Net=0*NET; Net1=Net; Lotshis=0*Lotshis1;
                Net(DayoffsetnumRB:length(net)+DayoffsetnumRB-1)=net;
                Net1(DayoffsetnumRB:length(net)+DayoffsetnumRB-1)=net1;
                Lotshis(DayoffsetnumRB:length(net)+DayoffsetnumRB-1)=lotshis;
                net=Net; net1=Net1; lotshis=Lotshis; 
                clear Net Net1 Lotshis

                traded=[datemar(tradeh(:,3),[3 1 2]) datemar(tradeh(:,5),[3 1 2])];
                traded(find(traded(:,1)<100),1)=traded(find(traded(:,1)<100),1)+1900;
                traded(find(traded(:,1)<1950),1)=traded(find(traded(:,1)<1950),1)+100;
                traded(find(traded(:,4)<100),4)=traded(find(traded(:,4)<100),4)+1900;
                traded(find(traded(:,4)<1950),4)=traded(find(traded(:,4)<1950),4)+100;     
                TradeD=[TradeD;[datemar(tradeh(:,3),1:3) datenum(traded(:,1:3)) datemar(tradeh(:,5),1:3) datenum(traded(:,4:6))]];  
                
                % after do our best about datem, just cook it!
                % and fortunately, our analysis are not based on datem, all original info are carried by
                % tradeh, tradeo and tradeeach and its own datem and stock for each model,
                % the datem in here is just used as best time table to show them together.
                if length(net)>length(NET)
                  Net=0*net; Net1=net; Lotshis=0*net;
                  Net(length(net)-length(NET)+1:length(net))=NET;
                  Net1(length(net)-length(NET)+1:length(net))=NET1;
                  Lotshis(length(net)-length(NET)+1:length(net))=Lotshis1;
                  NET=Net; NET1=Net1; Lotshis1=Lotshis; 
                  clear Net Net1 Lotshis     
                  datem=datemar;
                elseif length(NET)>length(net)
                  Net=0*NET; Net1=Net; Lotshis=0*Net;
                  Net(length(NET)-length(net)+1:length(NET))=net;
                  Net1(length(NET)-length(net)+1:length(NET))=net1;
                  Lotshis(length(NET)-length(net)+1:length(NET))=lotshis;
                  net=Net; net1=Net1; lotshis=Lotshis; 
                  clear Net Net1 Lotshis   
                end                

                Tradeh(:,13)=0*Tradeh(:,11)+1;
                tradeh(:,13)=0*tradeh(:,11)+2;
                net=NET+net;
                net1=NET1+net1;
                lotshis=Lotshis1+lotshis; 
                tradeh=[Tradeh;tradeh];
                CPS=[CPSc;CPS];
                tradeo=[Tradeo;tradeo];
                
                fpwout.net=net; fpwout.net1=net1; fpwout.lotshis=lotshis; fpwout.datem=datem; 
                fpwout.wsscale=1; fpwout.zhu52='1';  fpwout.zhu54='1'; fpwout.TradeD=TradeD;
                fpwout.tradeh=tradeh; fpwout.tradeo=tradeo; fpwout.name='ZZXY'; 
                fpwout.CPS=CPS;
                fpwout.mname=upper([fpwout.mname,Mname1]);
                fpwout.runnamelist=runnamelist;
                %all others are still useing original fpwoutput parameters
                eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwany300 fpwout']);
              else
                fpwsource='fpwoutput';                        
              end                  
            end
          elseif outDSM==4
            if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwany100.mat'])==2
              eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwany100']);
            else
              error(' - The file is not existed yet, run Decopsition simulation first.');
            end
            fpwsource='fpwany100';             
          elseif outDSM==5
            if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwany200.mat'])==2
              eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwany200']);
            else
              error(' - The file is not existed yet, run Decopsition simulation first.');
            end
            fpwsource='fpwany200'; 
          end
          
          if fpwout.tradeh(1,1)~=0
            fpwoutwindow=21;
            fpwout.outonoff='0';
            fpwout.fpwsource=fpwsource;
            fpwout1=fpwozc3(fpwout); 
            fpwout1.fpwsource=fpwsource;
            fpwout1.fpwusername=fpwusername;
            fpwout1.fpwusername4=fpwusername4;
            fpwout1.fpwulvl=instruct.fpwulvl;
            fpwout1.outrunindex=outrunindex;
            fpwout1.outDSM=instruct.outDSM;
                 
            set(fpwout1.fpwoutfig,'PaperPosition',MyPaperPosiH);
            cd([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern']);
            drawnow;
            wsprintjpeg(fpwout1.fpwoutfig,'fpwoutjpeg.jpeg');
            close(fpwout1.fpwoutfig);
            cd([Wherematlab,'pattern']);
            fpwout1.fpwoutjpeg=[fpwclientdirectory,fpwusername,'\pattern\fpwoutjpeg.jpeg']; 
            if outDSM<3
              sfpw1.StatusReport=[' This is the simulation output No. ',num2str(outDSM),', which saved in your database. ',time];
            elseif outDSM==3
              sfpw1.StatusReport=[' This is the simulation output of 2+1, which saved in your database. ',time];
            else
              sfpw1.StatusReport=[' This is the Decomposition output No. ',num2str(outDSM-3),', which saved in your database. ',time];
            end
            templatefile = which('MPsimulationR1.html');
            str = htmlrep(sfpw1, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\twbfpwoutputR1.html'],'noheader');      
            fpwout1.FPWoutstatus=strrep([fpwclientdirectory,fpwusername,'\pattern\twbfpwoutputR1.html'],'\','/');  
          else
            fpwoutwindow=24;
            fpwout1.fpwusername=fpwusername;
            fpwout1.fpwusername4=fpwusername4;
            fpwout1.fpwulvl=instruct.fpwulvl;
            fpwout1.outrunindex=outrunindex;               
          end  
        else
          if outDSM==6
            if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data4\marketlist.mat'])==2
              eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data4\marketlist']);
            else
              error(' - There are no output saved here yet.')
            end
            clear fpwout1; fpwout1.MMFS='Future'; fpwout1.MM12='No.1';
          elseif outDSM==7 
            if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data5\marketlist.mat'])==2
              eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data5\marketlist']);
            else
              error(' - There are no output saved here yet.')
            end    
            clear fpwout1; fpwout1.MMFS='Future'; fpwout1.MM12='No.2';
          elseif outDSM==8
            if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\stock1\marketlist.mat'])==2
              eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\stock1\marketlist']);
            else
              error(' - There are no output saved here yet.')
            end    
            clear fpwout1; fpwout1.MMFS='Stock'; fpwout1.MM12='No.1';
          elseif outDSM==9
            if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\stock2\marketlist.mat'])==2
              eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\stock2\marketlist']);
            else
              error(' - There are no output saved here yet.')
            end             
            clear fpwout1; fpwout1.MMFS='Stock'; fpwout1.MM12='No.2';
          elseif outDSM==10  
            if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data0\marketlist.mat'])==2
              eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data0\marketlist']);
            else
              error(' - There are no output saved here yet.')
            end  
            clear fpwout1; fpwout1.MMFS='Future'; fpwout1.MM12='No.3';
          elseif outDSM==11
            if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\stockd1\marketlist.mat'])==2
              eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\stockd1\marketlist']);
            else
              error(' - There are no output saved here yet.')
            end      
            clear fpwout1; fpwout1.MMFS='Stock'; fpwout1.MM12='No.3';
          end
              
          fpwoutwindow=22;
          cd([Wherematlab,'\pattern']);
          fpwout1.fpwusername=fpwusername;
          fpwout1.fpwusername4=fpwusername4;
          fpwout1.fpwulvl=instruct.fpwulvl; 
          
          fpwout1.outGOsm=instruct.outGOsm;
          fpwout1.outAnyU=instruct.outAnyU;
          fpwout1.outAnyD=instruct.outAnyD;
          fpwout1.outAnyS=instruct.outAnyS;
          
          for i=1:108
            if i<=length(runnamelist)
              YLFN=upper(noempty(runnamelist{i}));
              stringtofill=sprintf(['<input type="checkbox" value="1" name="mrkT',num2str(i),'"><input style="width: 45px" type="button" name="',YLFN,...
              '" onmouseover="window.status=''To output the simulation results of this market.''" value="',YLFN,...
              '" onmouseout="window.status=''Done''" onclick="javascript: mfsForm.marketrun.value=''',YLFN,...
              '''; mfsForm.submit();">']); 
              eval(['fpwout1.mfs',num2str(i),'=stringtofill;']);
            else
              eval(['fpwout1.mfs',num2str(i),'='' '';']);              
            end
          end
          fpwout1.marketMXL=int2str(length(runnamelist));
        end  
      end
      
      if strcmp(outrunindex,'32')
        fpwoutwindow=1;
        cd([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\']);
        if strcmp(instruct.outTW,'1')
          if exist('fpwoutf2.mat')==2
            load fpwoutf2
            Fpwout=fpwout;
          end
          if exist('fpwoutput.mat')==2
            load fpwoutput
            save fpwoutf2 fpwout
          end
          if exist('Fpwout')==1
            fpwout=Fpwout;
            clear Fpwout
            save fpwoutput fpwout
          end
          sfpw.StatusReport=[' Simu 1 <-> Simu 2 data exchanged successfully. ',time];
        elseif strcmp(instruct.outTW,'2')
          if exist('fpwany200.mat')==2
            load fpwany200
            Fpwout=fpwout;
          end
          if exist('fpwany100.mat')==2
            load fpwany100
            save fpwany200 fpwout
          end
          if exist('Fpwout')==1
            fpwout=Fpwout;
            clear Fpwout
            save fpwany100 fpwout
          end
          sfpw.StatusReport=[' Decom 1 <-> Decom 2 data exchanged successfully. ',time];  
        elseif strcmp(instruct.outTW,'3')
          if exist('fpwany100.mat')==2
            load fpwany100
            save fpwoutput fpwout
            sfpw.StatusReport=[' Decom 1 -> Simu 1 data transfered successfully. ',time];  
          else
            sfpw.StatusReport=[' Decom 1 not existed yet. ',time];                
          end
        elseif strcmp(instruct.outTW,'4')
          if exist('fpwany200.mat')==2
            load fpwany200
            save fpwoutput fpwout
            sfpw.StatusReport=[' Decom 2 -> Simu 1 data transfered successfully. ',time];  
          else
            sfpw.StatusReport=[' Decom 2 not existed yet. ',time];                
          end  
        elseif strcmp(instruct.outTW,'5')
          if exist('fpwoutput.mat')==2
            load fpwoutput
            save fpwany100 fpwout
            sfpw.StatusReport=[' Simu 1 -> Decom 1 data transfered successfully. ',time];  
          else
            sfpw.StatusReport=[' Simu 1 not existed at this time. ',time];                
          end          
        end 
      end
    
      if strcmp(outrunindex,'33')
        fpwoutwindow=1;
        % save to data2 under rule of fpwt + fsname + 1-207
        filenameforsimu=noempty(instruct.outptname);
        if length(filenameforsimu)>3
          if (upper(filenameforsimu(1))=='F')|(upper(filenameforsimu(1))=='S')
            if (abs(filenameforsimu(length(filenameforsimu)))>=48)&(abs(filenameforsimu(length(filenameforsimu)))<=57)&...
              (length(find((abs(filenameforsimu(1:length(filenameforsimu)-3))>=48)&(abs(filenameforsimu(1:length(filenameforsimu)-3))<=57)))==0)
              SaNui3=upper(filenameforsimu(length(filenameforsimu)-2));
              if (abs(SaNui3)>=48)&(abs(SaNui3)<=57)
                SaNui2=upper(filenameforsimu(length(filenameforsimu)-2));
                if (abs(SaNui3)<48)|(abs(SaNui3)>57)
                  sfpw.StatusReport=['Filename format: F/S+name+number, Number limited to 3 digits. ',time];
                else % 3 digits
                  %if str2num(filenameforsimu(length(filenameforsimu)-2:length(filenameforsimu)))<=207
                    fpwsource=instruct.fpwsource;
                    cd([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\']);
                    eval(['load ',fpwsource,'.mat']);
                    eval(['save data2\fpwt',filenameforsimu,' fpwout']);
                  if str2num(filenameforsimu(length(filenameforsimu)-2:length(filenameforsimu)))<=207
                    sfpw.StatusReport=[' Current simulation data saved to FPWT',upper(filenameforsimu),'.MAT. ',time];
                  else
                    %sfpw.StatusReport=['Filename format: F/S+name+number, Number must be within 1 - 207. ',time]; 
                    sfpw.StatusReport=['Since saving number > 207, may not showing in PM if no room left there, then using Load to review. ',time];
                  end
                end
              else % 1 or 2 digits
                fpwsource=instruct.fpwsource;
                cd([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\']);
                eval(['load ',fpwsource,'.mat']);
                eval(['save data2\fpwt',filenameforsimu,' fpwout']);
                sfpw.StatusReport=[' Current simulation data saved to FPWT',upper(filenameforsimu),'.MAT. ',time];
              end    
            else
              sfpw.StatusReport=['Filename format: F/S+name+number, Number must be within 1 - 999. It''d be better <= 207. ',time];            
            end
          else
            sfpw.StatusReport=[' Filename format error: first letter must be either ''F'' for futures or ''S'' for stocks. ',time];
          end
        else
          sfpw.StatusReport=[' Filename format: F/S+name++number, Number must be within 1 - 999. It''d be better <= 207. ',time];        
        end
      end

      if (strcmp(outrunindex,'34'))|(strcmp(outrunindex,'35'))
        % load from data2
        FPWMPfiletoopen = [fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data2\fpwt*.mat'];
        a=dir(FPWMPfiletoopen);
        outputtext={};
        filesinaline=4;
        if length(a)>0
          for i=1:length(a)
            outputtext{fix((i-1)/filesinaline)+1,rem(i-1,filesinaline)+1}=upper(a(i).name(5:length(a(i).name)-4));
          end
          if ((rem(i-1,filesinaline)+1)~=filesinaline)&(fix((i-1)/filesinaline)>0)
            for j=rem(i-1,filesinaline)+2:filesinaline
              outputtext{fix((i-1)/filesinaline)+1,j}='';
            end
          end
        else
          outputtext{1}='No available file.';
        end

        outstruct.MPfiletoshow=outputtext;
        outstruct.FDfpwusername=fpwusername;
        outstruct.FDfpwusername4=fpwusername4;
        cd(fpwserverplace);
        templatefile = which('MPopenfile1R.html');
        str = htmlrep(outstruct, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\tMPopenfile1R.html'],'noheader');
        outstruct.MPloadreport=[fpwclientdirectory,fpwusername,'\pattern\tMPopenfile1R.html'];
        if (strcmp(outrunindex,'34'))
          outstruct.FDfiletypeid=['outL',num2str(instruct.fpwulvl),fpwsource];
          fpwoutwindow=3;
        elseif (strcmp(outrunindex,'35'))
          outstruct.FDfiletypeid=['outD',num2str(instruct.fpwulvl),fpwsource];
          fpwoutwindow=4;          
        end
      end             

    %elseif strcmp(outrunindex(1),'4')
      %if strcmp(outrunindex,'41')
      %  Portfolio
      %end    
    end
  elseif (strcmp(WhereOrderFrom,'INDX'))
    fpwoutwindow=21;
    fpwoutiok=1;
    if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwoutput.mat'])==2
      eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwoutput']);
      wsftf=dirdet([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwoutput.mat']);
      fpwout.fpwsource='fpwoutput';
    else
      if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwoutf2.mat'])==2
        eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwoutf2']);
        wsftf=dirdet([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwoutf2.mat']);  
        fpwout.fpwsource='fpwoutf2';
      else
        fpwoutiok=0;
      end
    end
    if fpwoutiok==1
      wsftf=[wsftf([4 2 3 5 6]) 0];
      fpwout.outonoff='0';
      fpwout1=fpwozc3(fpwout);
      fpwout1.fpwsource=fpwout.fpwsource;
      fpwout1.fpwusername=fpwusername;
      fpwout1.fpwusername4=fpwusername4;
      fpwout1.fpwulvl=instruct.fpwulvl;
      fpwout1.outrunindex='00';
               
      set(fpwout1.fpwoutfig,'PaperPosition',MyPaperPosiH);
      cd([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern']);
      drawnow;
      wsprintjpeg(fpwout1.fpwoutfig,'fpwoutjpeg.jpeg');
      close(fpwout1.fpwoutfig);
      cd([Wherematlab,'pattern']);
      fpwout1.fpwoutjpeg=[fpwclientdirectory,fpwusername,'\pattern\fpwoutjpeg.jpeg']; 
                   
      sfpw1.StatusReport=[' This is the most recent simulation output saved in your file. ',time(wsftf)];
      templatefile = which('MPsimulationR1.html');
      str = htmlrep(sfpw1, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\twbfpwoutputR1.html'],'noheader');      
      fpwout1.FPWoutstatus=strrep([fpwclientdirectory,fpwusername,'\pattern\twbfpwoutputR1.html'],'\','/');      
    else
      error(' - You did not have simulation output results yet. Use PW to create your first one.')
    end  
  elseif (strcmp(WhereOrderFrom,'SCFL'))
    fpwoutwindow=99;
  end 
  
  cd(fpwserverplace);
  cids=fpwloginstatus(fpwusername,clock);

  if fpwoutwindow==21
    templatefile = which('wbfpwoutput.html');    
    fpwout1.fpwdailynet=[fpwclientdirectory,fpwusername,'\pattern\fpwdailynet.txt'];
    if ~strcmp(fpwout1.outGOsm,'UrSym')
      fpwout1.outGOsm=noempty(upper(fpwout1.outGOsm));
    end
    if (nargin == 1)
      retstr = htmlrep(fpwout1, templatefile);     
    elseif (nargin == 2)
      retstr = htmlrep(fpwout1, templatefile, outfile);
    end  
  elseif fpwoutwindow==22
    templatefile = which('fpwfsmarket.html');    
    if (nargin == 1)
      retstr = htmlrep(fpwout1, templatefile);     
    elseif (nargin == 2)
      retstr = htmlrep(fpwout1, templatefile, outfile);
    end
  elseif fpwoutwindow==24
    templatefile = which('fpwnotrade.html');    
    if (nargin == 1)
      retstr = htmlrep(fpwout1, templatefile);     
    elseif (nargin == 2)
      retstr = htmlrep(fpwout1, templatefile, outfile);
    end      
  elseif fpwoutwindow==1   % status report
    templatefile = which('MPsimulationR1.html');
    if (nargin == 1)
      str = htmlrep(sfpw, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\twbfpwoutputR1.html'],'noheader');      
      retstr = htmlrep(sfpw, templatefile);
    elseif (nargin == 2)
      retstr = htmlrep(sfpw, templatefile, outfile);
    end    
  elseif fpwoutwindow==2  % trades list
    templatefile = which('fpwtradelist.html');    
    fpwoutli.fpwusername=fpwusername;
    fpwoutli.fpwusername4=fpwusername4;
    fpwoutli.fpwulvl=instruct.fpwulvl;
    fpwoutli.fpwsource=instruct.fpwsource;
    if (nargin == 1)
      retstr = htmlrep(fpwoutli, templatefile);     
    elseif (nargin == 2)
      retstr = htmlrep(fpwoutli, templatefile, outfile);
    end
  elseif fpwoutwindow==3  % open an output file
    templatefile = which('fpwopenfile1.html');
    if (nargin == 1)
      retstr = htmlrep(outstruct, templatefile);   
    elseif (nargin == 2)
      retstr = htmlrep(outstruct, templatefile, outfile);
    end  
  elseif fpwoutwindow==4  % delete an output data file
    templatefile = which('fpwdeletefile1.html');
    if (nargin == 1)
      retstr = htmlrep(outstruct, templatefile);   
    elseif (nargin == 2)
      retstr = htmlrep(outstruct, templatefile, outfile);
    end      
  elseif fpwoutwindow==5  % forward simulation
    templatefile = which('fpwoutfs.html');
    if (nargin == 1)
      retstr = htmlrep(fpwfs, templatefile);   
    elseif (nargin == 2)
      retstr = htmlrep(fpwfs, templatefile, outfile);
    end  
  elseif fpwoutwindow==99  % used banned words
    templatefile = which('wbcheckbanw.html');
    sfpw.mpgfoutput=' ';
    if (nargin == 1)
      retstr = htmlrep(sfpw, templatefile);   
    elseif (nargin == 2)
      retstr = htmlrep(sfpw, templatefile, outfile);
    end      
  end
end