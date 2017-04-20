function retstr = wbstmpsort(instruct, outfile)

% Author(s): N. Zhu, 11-15-2003
% This is a WB (Web-Based) mirror program to <dzhjust.m> in desktop version

wbfpwbasic;
cd(fpwserverplace);
retstr = char('');
fpwusername=instruct.mlid{1};
fpwCPAL=1;
fpwloginIP='192.168.2.8';
fpwcheckil;

if fpwcheckilpass==1

  eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\tMarketpulseRe.mat']); 
  
  cd([Wherematlab,'stock']);
  sortkind=str2num(instruct.mlmfvar2);
  wbdzhsid=sortkind; eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\wbdzhsort wbdzhsid']);

  tradinghours=0;
  timevalue=clock;
  markethourst;
  timecal=timevalue(4)+timevalue(5)/60;
  datetoday=[timevalue(2:3) timevalue(1)-2000];
  tradingdays=0;
  if (closehourt>openhourt)&(dn(datetoday)<=5)
    tradingdays=1; 
  end  
  if (timecal>openhourt+1/12)&(timecal<closehourt+1/12)&(dn(datetoday)<=5)
    if closehourt>openhourt
      tradinghours=1;
    end
  end
  
  % The next two lines are exclusively for column 13 and 14 only (index and company full name).
  load fpwnlt namelistd namelist market
  namelistd=fpwnamelist(namelistd);
  
  if (tradinghours==1)|((timecal>=4)&(timecal<=20)&(tradingdays==1))
    load stchour1 pvolume % ohlcvn
    %!copy x:\stock\fpwnltlast.mat c:\matlab\stock
    load fpwnltlast
    ohlcvn=fpwnltlast(:,1:6);
    ohlcvn(:,2)=(max((ohlcvn(:,1:4))'))';
    ohlcvn(:,3)=(min((ohlcvn(:,1:4))'))';
  else
    load dayfnum
    eval(['load ',tickdayplacesc,'D',sprintf('%07d',dailyfilenumber-1),' ohlcvn']);  
  end

  if sortkind==1
    [priceherev priceherei]=sort(ip);
  end
  
  if sortkind==2
    pricehere=ohlcvn(ip,4);
    [priceherev priceherei]=sort(pricehere);
  end
    
  if sortkind==3
    pricehere=ohlcvn(ip,6);
    [priceherev priceherei]=sort(-abs(pricehere));
  end
  
  if sortkind==4
    pricehere=ohlcvn(ip,5);
    [priceherev priceherei]=sort(-pricehere);
  end
  
  if sortkind==6
    pricehere=PeCaSe(:,1);
    [priceherev priceherei]=sort(pricehere);
    % find pe>0 place
    i=1;
    while priceherev(i)<=0
      i=i+1; 
    end
    if i>1
      priceherei=[priceherei(i:length(priceherei)); priceherei(1:i-1)];
    end
  end
  
  if sortkind==7
    pricehere=PeCaSe(:,2);
    [priceherev priceherei]=sort(-pricehere);
  end
  
  if sortkind==8
    pricehere=PeCaSe(:,3);
    [priceherev priceherei]=sort(pricehere);
  end  
  
  if sortkind~=5
    ip=ip(priceherei);
    if ~ischar(wbfilter(1))
      wbfilter=wbfilter(priceherei);
    end
    PeCaSe=PeCaSe(priceherei,:);
    PE=PeCaSe(:,1);
    CAP=PeCaSe(:,2);
    sectorind=PeCaSe(:,3);
    clear pricehere priceherev priceherei
  else
    PE=PeCaSe(:,1);
    CAP=PeCaSe(:,2);
    sectorind=PeCaSe(:,3);
  end
  
  y={};i=0;
  if ohlcvn(ip(1),6)<0
    y{1,1}=sprintf('<font color="blue" size="2" face="Arial"><b>%5s</b></font>',[y11cell,num2str(length(ip))]); 
    y{1,2}=sprintf('<font color="blue" size="2" face="Arial"><b>%5s</b></font>','M'); 
    y{1,3}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''1''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="blue" size="2" face="Arial"><b>%5s</b></font></a>','SYMB');  
    y{1,4}=sprintf('<font color="blue" size="2" face="Arial"><b>%5s</b></font>','OPEN');  
    y{1,5}=sprintf('<font color="blue" size="2" face="Arial"><b>%5s</b></font>','HIGH');  
    y{1,6}=sprintf('<font color="blue" size="2" face="Arial"><b>%5s</b></font>','LOW');  
    y{1,7}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''2''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="blue" size="2" face="Arial"><b>%5s</b></font></a>','LAST');  
    y{1,8}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''3''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="blue" size="2" face="Arial"><b>%5s</b></font></a>','NET');  
    y{1,9}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''4''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="blue" size="2" face="Arial"><b>%5s</b></font></a>','Vol_K');  
    y{1,10}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''5''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="blue" size="2" face="Arial"><b>%5s</b></font></a>',wbscankind); 
  else
    y{1,1}=sprintf('<font color="red" size="2" face="Arial"><b>%5s</b></font>',[y11cell,num2str(length(ip))]);  
    y{1,2}=sprintf('<font color="red" size="2" face="Arial"><b>%5s</b></font>','M'); 
    y{1,3}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''1''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="red" size="2" face="Arial"><b>%5s</b></font></a>','SYMB');  
    y{1,4}=sprintf('<font color="red" size="2" face="Arial"><b>%5s</b></font>','OPEN');  
    y{1,5}=sprintf('<font color="red" size="2" face="Arial"><b>%5s</b></font>','HIGH');  
    y{1,6}=sprintf('<font color="red" size="2" face="Arial"><b>%5s</b></font>','LOW');  
    y{1,7}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''2''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="red" size="2" face="Arial"><b>%5s</b></font></a>','LAST');  
    y{1,8}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''3''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="red" size="2" face="Arial"><b>%5s</b></font></a>','NET');  
    y{1,9}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''4''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="red" size="2" face="Arial"><b>%5s</b></font></a>','Vol_K');  
    y{1,10}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''5''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="red" size="2" face="Arial"><b>%5s</b></font></a>',wbscankind);         
  end
  y{1,11}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''6''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="blue" size="2" face="Arial"><b>%5s</b></font></a>','PE');  
  y{1,12}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''7''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="blue" size="2" face="Arial"><b>%5s</b></font></a>','CAP_B');
  
  y{1,13}=sprintf('<a href="Javascript: stockRForm.mlmfvar2.value=''8''; stockRForm.mlmfile.value=''wbstmpsort''; stockRForm.submit();"><font color="blue" size="2" face="Arial"><b>%5s</b></font></a>','Sector');
  y{1,14}=[sprintf('<font color="blue" size="2" face="Arial"><b>%5s</b></font>',['[',time1,']',blanks(20)]),...
          sprintf('<font color="black" size="2" face="Arial"><b>%5s</b></font>','COMPANY NAME + PROFILE LINK')];
         
  y1=ohlcvn(ip,:);
  for i=1:length(ip)
    dp=find(namelist(ip(i),:)=='$');
    if (ip(i)<market(1))
      datadmar='AMX ';
    elseif ((ip(i)>=market(1))&(ip(i)<market(2)))
      datadmar='OTC ';
    else
      datadmar='NYS ';
    end
    if (length(dp)>0)
      namet=namelist(ip(i),1:max([1 dp(1)-1]));
    else
      namet=namelist(ip(i),:);
    end
    if ohlcvn(ip(i),6)<0
      y{i+1,1}=sprintf('<font color="red" size="2" face="Arial"><b>%4s</b></font>',num2str(i));
      y{i+1,2}=sprintf('<font color="red" size="2" face="Arial"><b>%1s</b></font>',datadmar(1));
      y{i+1,3}=sprintf(['<font color="red" size="2" face="Arial"><b><a href="javascript: stockRForm.mlmfvar.value=''',YLFN,'%6s''; stockRForm.mlmfile.value=''',LINKForm,'''; stockRForm.submit();">%6s</a></b></font>'],namet,namet);
      y{i+1,4}=sprintf('<font color="red" size="2" face="Arial"><b>%8.2f</b></font>',ohlcvn(ip(i),1));
      y{i+1,5}=sprintf('<font color="red" size="2" face="Arial"><b>%8.2f</b></font>',ohlcvn(ip(i),2));
      y{i+1,6}=sprintf('<font color="red" size="2" face="Arial"><b>%8.2f</b></font>',ohlcvn(ip(i),3));
      y{i+1,7}=sprintf('<font color="red" size="2" face="Arial"><b>%8.2f</b></font>',ohlcvn(ip(i),4));
      y{i+1,8}=sprintf('<font color="red" size="2" face="Arial"><b>%8.2f</b></font>',ohlcvn(ip(i),6));
      y{i+1,9}=sprintf('<font color="red" size="2" face="Arial"><b>%7d</b></font>',round(ohlcvn(ip(i),5)*100));
      if ischar(wbfilter(1))==1
        y{i+1,10}=sprintf('<font color="red" size="2" face="Arial"><b>%2s</b></font>','NA');
      else
        y{i+1,10}=sprintf('<font color="red" size="2" face="Arial"><b>%8.2f</b></font>',wbfilter(i));
      end
    else
      y{i+1,1}=sprintf('<font color="blue" size="2" face="Arial"><b>%4s</b></font>',num2str(i));
      y{i+1,2}=sprintf('<font color="blue" size="2" face="Arial"><b>%1s</b></font>',datadmar(1));
      y{i+1,3}=sprintf(['<font color="blue" size="2" face="Arial"><b><a href="javascript: stockRForm.mlmfvar.value=''',YLFN,'%6s''; stockRForm.mlmfile.value=''',LINKForm,'''; stockRForm.submit();">%6s</a></b></font>'],namet,namet);        
      y{i+1,4}=sprintf('<font color="blue" size="2" face="Arial"><b>%8.2f</b></font>',ohlcvn(ip(i),1));
      y{i+1,5}=sprintf('<font color="blue" size="2" face="Arial"><b>%8.2f</b></font>',ohlcvn(ip(i),2));
      y{i+1,6}=sprintf('<font color="blue" size="2" face="Arial"><b>%8.2f</b></font>',ohlcvn(ip(i),3));
      y{i+1,7}=sprintf('<font color="blue" size="2" face="Arial"><b>%8.2f</b></font>',ohlcvn(ip(i),4));
      y{i+1,8}=sprintf('<font color="blue" size="2" face="Arial"><b>%8.2f</b></font>',ohlcvn(ip(i),6));
      y{i+1,9}=sprintf('<font color="blue" size="2" face="Arial"><b>%7d</b></font>',round(ohlcvn(ip(i),5)*100));
      if ischar(wbfilter(1))==1
        y{i+1,10}=sprintf('<font color="blue" size="2" face="Arial"><b>%2s</b></font>','NA');
      else
        y{i+1,10}=sprintf('<font color="blue" size="2" face="Arial"><b>%8.2f</b></font>',wbfilter(i));
      end     
    end
    if ~(PE(i)==0)
      if PE(i)>0
        y{i+1,11}=sprintf('<font color="black" size="2" face="Arial"><b>%8.2f</b></font>',PE(i));
      else
        y{i+1,11}=sprintf('<font color="red" size="2" face="Arial"><b>(%8.2f)</b></font>',abs(PE(i)));
      end
    else
      y{i+1,11}=sprintf('<font color="blue" size="2" face="Arial"><b>%5s</b></font>','NA');        
    end
    if ~(CAP(i)==0)      
      y{i+1,12}=sprintf('<font color="black" size="2" face="Arial"><b>%8.3f</b></font>',CAP(i)); 
    else
      y{i+1,12}=sprintf('<font color="blue" size="2" face="Arial"><b>%5s</b></font>','NA');         
    end  
    
    if sectorind(i)>0
      y{i+1,13}=sprintf('<font color="black" size="2" face="Arial"><b>%5.2f</b></font>',sectorind(i));
    else
      y{i+1,13}=sprintf('<font color="black" size="2" face="Arial"><b>%8d</b></font>',sectorind(i));
    end
    yc14=sprintf('<font color="blue" size="2" face="Arial"><b>%50s</b></font>',namelistd{ip(i)});
    y{i+1,14}=sprintf(['<a href="http://finance.yahoo.com/q/pr?s=',namet,'" target="_blank">',yc14,'</a>']);
    
  end
  
  load TUcontroler TUcontrolid % to control Test Users output results 1 - no short, all others for short
  outstruct.fpwusername=fpwusername;
  outstruct.fpwusername4=fpwusername4;
  outstruct.fpwclientdirectory=fpwclientdirectory;
  outstruct.fpwulvl=instruct.fpwulvl;
  cd(fpwserverplace);
  cids=fpwloginstatus(fpwusername,clock);
  templatefile = which('MarketpulseR.html');
  eval(['!del ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\tMarketpulseR.html']);
  
  newlength=length(ip)+1;
  if (strcmp(fpwusername(1:4),'User')==1)&(length(ip)>1)&(TUcontrolid~=1)
    newlength=min([6 max([0 fix((length(ip))/2)])])+1;
    y=y(1:newlength,:); 
    y{1,1}=[y{1,1},'*'];
  end

  if (nargin == 1)
    if (rem(newlength-1,100)~=0)|(newlength==1)
      pagesnum=fix((newlength-1)/100)+1;
    else
      pagesnum=fix((newlength-1)/100);
    end
    totaloutnum=y{1,1};
    
    yyyy={};yyyy{1,1}=' ';
    outstruct.mpgfoutputlinkstat=' ';
    if pagesnum>1
      for i=1:pagesnum
        if i==1
          linknameh=[fpwclientdirectory,fpwusername,'\stock\tMarketpulseR.html']; 
        else   
          linknameh=[fpwclientdirectory,fpwusername,'\stock\tMarketpulseR',sprintf('%02d',i),'.html'];  
        end
        yyyy{1,i}=['<a href="',linknameh,'" target="_self">',sprintf('%2d',i),'</a>'];
      end
      outstruct.mpgfoutputlinkstat='Clicking below links for more outputs - 100 per page';
    end
    outstruct.mpgfoutputlink =yyyy;
  
    if (strcmp(fpwusername(1:4),'User')==1)
      if newlength<length(ip)+1
        outstruct.mpgfoutputlinkstat=['*: There are actually ',num2str(length(ip)),' outputs, test users are limited to partial results.'];
      end
    end
    
    for i=pagesnum:-1:1
      y{1,1}=' ';
      if i==1
        y{1,1} = totaloutnum; 
        if newlength<=101
          outstruct.mpgfoutput = y;
          retstr = htmlrep(outstruct, templatefile);
          str = htmlrep(outstruct, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\tMarketpulseR.html'],'noheader');
        else      
          outstruct.mpgfoutput = [y(1:51,:); y(1,:); y(52:101,:)];
          retstr = htmlrep(outstruct, templatefile);
          str = htmlrep(outstruct, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\tMarketpulseR.html'],'noheader');  
        end
      elseif i<pagesnum
        eval(['outstruct.mpgfoutput = [y(1,:); y(',num2str(100*(i-1)+2),':',num2str(100*(i-1)+51),',:); y(1,:); y(',num2str(100*(i-1)+52),':',num2str(100*(i-1)+101),',:)];']);
        str = htmlrep(outstruct, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\tMarketpulseR',sprintf('%02d',i),'.html'],'noheader');  
      elseif (i==pagesnum)&(i~=1)
        eval(['outstruct.mpgfoutput = [y(1,:); y(',num2str(100*(i-1)+2),':length(y),:)];']);    
        str = htmlrep(outstruct, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\tMarketpulseR',sprintf('%02d',i),'.html'],'noheader');  
      end
    end 
  elseif (nargin == 2)
    retstr = htmlrep(outstruct, templatefile, outfile);
  end
end