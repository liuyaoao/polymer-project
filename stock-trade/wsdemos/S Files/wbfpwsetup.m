function retstr = wbfpwsetup(instruct, outfile)

% Author(s): N. Zhu, 11-15-2003
% This is a WB (Web-Based) mirror program to <wsozc3*> and more in desktop version

wbfpwbasic;
cd(fpwserverplace);

retstr = char('');
global fpwusername fpwusername4
fpwusername=instruct.mlid{1};
if strcmp(upper(instruct.fpwsource),'FPWANY300')
  fpwCPAL=4;
else
  fpwCPAL=3;
end
fpwloginIP='192.168.2.8';
fpwcheckil;

if fpwcheckilpass==1
  cd([Wherematlab,'pattern']);
  %save c:\matlab\pattern\mybugfpwtempfile
  tTry=0; save wstry tTry
  fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
  fseek(fid1,-50,1); fprintf(fid1,[time,' SETG\n']); fclose(fid1);
  clear fid1
  fpwulvl=str2num(instruct.fpwulvl);
                   
  eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwfrontout']);
  name=fpwout.name; mname=fpwout.mname; Mname1=mname; Name1=name;
  datem=fpwout.datem; stock=fpwout.stock; tradeh=fpwout.tradeh; tradeo=fpwout.tradeo;
  if ~strcmp(upper(name),'ZZXY')
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
    [qww qiw]=sort(tradeh(:,3));
    tradeh=tradeh(qiw,:);
    tradeo=tradeo(qiw,:);
    TradeD=TradeD(qiw,:);    
  end
  
  Fig1=figure('pos',[2 4 635 434],'color','w','visible','off');
  zhu221=axes('position',[0.08 0.59 .405 .345]);
  zhu223=axes('position',[0.08 0.085 .405 .355]);
  zhu222=axes('position',[0.555 0.59 .425 .345]);
  zhu224=axes('position',[0.555 0.085 .425 .355]);
  
  if ~strcmp(instruct.WhereOrderFrom,'SETG')
    if ~strcmp(instruct.WhereOrderFrom,'TLST')
      zhu33gg=1;
    else
      zhu33gg=str2num(instruct.zhu33gg);
      hdoutmxi=str2num(instruct.hdoutmxi);
      zhu33gg=max([1 min([zhu33gg hdoutmxi-3])]);
      %save c:\matlab\pattern\mysetbughere.mat
    end
    zhu51gg=25; % option 5, 8 10, 15 25
  else
    zhu33gg=str2num(instruct.zhu33gg);
    zhu51gg=str2num(instruct.zhu51gg);
  end
  
  Fsetg=zhu33gg;
  Tsetg=min([length(tradeh(:,1)) zhu33gg+3]);
  if Tsetg - Fsetg < 3
    Fsetg=max([1 Tsetg-3]);
  end
  dailybarnumsh=zhu51gg+0; % change 0 to positive integer to show more daily data at each side
  rnli=0;  
  
  for i = Fsetg:Tsetg
    enterprice=tradeh(i,1);
    closeprice=tradeh(i,4);
    direc=tradeh(i,2); % long or short
    if direc==1
      Notefls='Buy'; 
    else
      Notefls='Sell';
    end
    mp=[tradeo(i,1)-tradeh(i,3)+dailybarnumsh+1 tradeo(i,2)]; % partial object
    Xp=tradeh(i,7); % exit way
    Wp=tradeh(i,8:9); % entry day (1-5) and time (0-24)
    Np=tradeh(i,6); % net
    mpgr=sign(tradeh(i,6)*1000);
    hduring=tradeh(i,5)-tradeh(i,3)+1;
    
    % get real stock and datem for ZZXY
    if ~strcmp(upper(Name1),'ZZXY')
      tradeh(i,13)=0;
    end
    if tradeh(i,13)~=rnli
      if length(Mname1)==1  
        name=noempty(runnamelist{tradeh(i,13)});
        marketrun=noempty(runnamelist{tradeh(i,13)});
        if strcmp(fpwout.MMFS,'Future')
          if length(marketrun)==1
            marketrun(2)='_';
          end        
          if strcmp(fpwout.MM12,'No.1')
            eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data4\',noempty(instruct.marketrun),'output']);
          elseif strcmp(fpwout.MM12,'No.2')
            eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data5\',noempty(instruct.marketrun),'output']);
          else
            eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data0\',noempty(instruct.marketrun),'output']);        
          end
        else
          if strcmp(fpwout.MM12,'No.1')
            eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\stock1\rts',noempty(instruct.marketrun)]);
          elseif strcmp(fpwout.MM12,'No.2')
            eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\stock2\rts',noempty(instruct.marketrun)]);
          else
            eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\stockd1\rts',noempty(instruct.marketrun)]);        
          end         
        end  
      else        
        eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\data21\fpwoutput',num2str(tradeh(i,13))]);  
        name=fpwout.name; mname=fpwout.mname;        
      end
      stock=fpwout.stock;
      datem=fpwout.datem;
      rnli=tradeh(i,13);
    end        
    stock1=stock(max([1 tradeh(i,3)-dailybarnumsh]):min([length(stock(:,1))-2 tradeh(i,5)+dailybarnumsh]),:);
    datem1=datem(max([1 tradeh(i,3)-dailybarnumsh]):min([length(stock(:,1))-2 tradeh(i,5)+dailybarnumsh]),:);
    leftnumber=tradeh(i,3)-max([1 tradeh(i,3)-dailybarnumsh]);
    rightnumber=min([length(stock(:,1))-2 tradeh(i,5)+dailybarnumsh])-tradeh(i,5);
    if rightnumber>=leftnumber
      stock1(1:length(stock1(:,1)),6)=[zeros(leftnumber,1);ones(hduring,1);zeros(rightnumber,1)];
      datem1=datem(tradeh(i,3)-leftnumber+2:tradeh(i,3)+rightnumber+2,:);
    else
      clear stock1 datem1
      stock1(:,1:5)=stock(length(stock(:,1))-(2*leftnumber+hduring)+1:length(stock(:,1)),:);
      datem1=datem(length(stock(:,1))-(2*leftnumber+hduring)+1:length(stock(:,1)),:);
      adding6c=zeros(length(stock1(:,1)),1);
      adding6ci=length(adding6c)-length(datem(:,1))+tradeh(i,3);
      for jkj=1:hduring
        adding6c(adding6ci+jkj-1,1)=1;
      end
      stock1(:,6)=adding6c;
      clear adding6c adding6ci jkj
    end
    clear leftnumber rightnumber

    eval(['subplot(zhu22',int2str(i-Fsetg+1),');']);
    wsbarcm(stock1,datem1,tTry,enterprice,closeprice,mp,direc,mpgr,Xp,Wp(1),Np);    
    chgstcf(datem1);
    title(['# ',int2str(i),' of ',int2str(length(tradeh(:,1))),', ',Notefls,'-',upper([mname,name]),', WkDayNo:',int2str(Wp(1)),', Time:',sprintf('%2d:%02d',fix(Wp(2)),round(rem(Wp(2),1)*60))]);
    set(get(gca,'title'),'color','b');
    if ((i-Fsetg+1==1)|(i-Fsetg+1==3))
        ylabel('Prnce');
    end
    if (i-Fsetg+1==1); fpwout1.zhu32gg1=date2str(TradeD(i,1:3)); fpwout1.fpwmname1=mname; fpwout1.fpwname1=name; end
    if (i-Fsetg+1==2); fpwout1.zhu32gg2=date2str(TradeD(i,1:3)); fpwout1.fpwmname2=mname; fpwout1.fpwname2=name; end
    if (i-Fsetg+1==3); fpwout1.zhu32gg3=date2str(TradeD(i,1:3)); fpwout1.fpwmname3=mname; fpwout1.fpwname3=name; end
    if (i-Fsetg+1==4); fpwout1.zhu32gg4=date2str(TradeD(i,1:3)); fpwout1.fpwmname4=mname; fpwout1.fpwname4=name; end
    clear stock1 datem1
  end 
  if i<2
    fpwout1.zhu32gg2=date2str(TradeD(i,1:3)); fpwout1.fpwmname2=mname; fpwout1.fpwname2=name;
    fpwout1.zhu32gg3=date2str(TradeD(i,1:3)); fpwout1.fpwmname3=mname; fpwout1.fpwname3=name;
    fpwout1.zhu32gg4=date2str(TradeD(i,1:3)); fpwout1.fpwmname4=mname; fpwout1.fpwname4=name;
  elseif i<3
    fpwout1.zhu32gg3=date2str(TradeD(i,1:3)); fpwout1.fpwmname3=mname; fpwout1.fpwname3=name;
    fpwout1.zhu32gg4=date2str(TradeD(i,1:3)); fpwout1.fpwmname4=mname; fpwout1.fpwname4=name;
  elseif i<4
    fpwout1.zhu32gg4=date2str(TradeD(i,1:3)); fpwout1.fpwmname4=mname; fpwout1.fpwname4=name;
  end  
  
  if i-Fsetg+1~=4
    for j=i-Fsetg+2:4
      eval(['delete(subplot(zhu22',int2str(j),'));']);
    end
  end
  set(Fig1,'inverthardcopy','off'); hold off
  set(Fig1,'PaperPosition',[.25 .25 7.2 5]);
  cd([fpwserverplace,fpwclientdirectory,fpwusername,'\pattern']);
  drawnow;
  wsprintjpeg(Fig1,'setupjpeg.jpeg'); 
  close(Fig1);
  
  fpwout1.setupjpeg=[fpwclientdirectory,fpwusername,'\pattern\setupjpeg.jpeg'];
  fpwout1.fpwusername=fpwusername;
  fpwout1.fpwusername4=fpwusername4;
  fpwout1.fpwulvl=instruct.fpwulvl;
  fpwout1.outMXI=num2str(max([1 length(tradeh(:,1))-3]));
  fpwout1.fpwsource=instruct.fpwsource;
  fpwout1.zhu33gg=num2str(Fsetg);
  fpwout1.zhu51gg=num2str(zhu51gg);

  cd(fpwserverplace);
  cids=fpwloginstatus(fpwusername,clock);
  templatefile = which('wbfpwsetup.html');    
  if (nargin == 1)
    retstr = htmlrep(fpwout1, templatefile);     
  elseif (nargin == 2)
    retstr = htmlrep(fpwout1, templatefile, outfile);
  end  
end