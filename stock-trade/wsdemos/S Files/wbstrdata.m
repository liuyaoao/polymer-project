function retstr = wbstrdata(instruct, outfile)

% Author(s): N. Zhu, 11-15-2003
% This is a WB (Web-Based) mirror program to <> in desktop version

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
      mnamehere=instruct.hdfpwfstype;  
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
    ToD='D';
    fpwdataspan='DD';
  elseif strcmp(WhereOrderFrom,'SLFE')
    name=noempty(instruct.fpwsymbol);
    global mname; 
    mname=instruct.hdfpwfstype;  
    FirstorS=str2num(instruct.FirstorS);
    fpwdataspan=instruct.fpwdataspan;
  elseif strcmp(WhereOrderFrom,'LINK')
    name=noempty(instruct.mlmfvar);
    global mname;
    mname=upper(name(1));
    name=name(2:length(name));      
    FirstorS=0;
    ToD='D';
    fpwdataspan='DD';      
  end
  
  if (length(name)==0)|(length(name)>6)
    error('Entered wrong symbol.');
  end
    
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
        stock=[stock;[fpwnltlast(stocknameph(1),1:4) fpwnltlast(stocknameph(1),5)*1000]];
      end
    end
    cd([Wherematlab,'pattern']);
  end  
  
  if (FirstorS==0) % FirstorS is used to control scope range, reset to 0 by fpwsymbol on change, to 1 by GO button
    fpwdataspan='DD'; 
    if length(stock)==0
      error('No data available for this stock, please check the symbol.');
    end
  
    if strcmp(WhereOrderFrom,'MPLG')
      fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
      fseek(fid1,-50,1); fprintf(fid1,[time,' MPGR: ',upper(mname),'-',upper(name),'\n']); fclose(fid1);
      clear fid1
    elseif strcmp(WhereOrderFrom,'SLFE')
      fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
      fseek(fid1,-50,1); fprintf(fid1,[time,' SLFR: ',upper(mname),'-',upper(name),'\n']); fclose(fid1);
      clear fid1
    elseif strcmp(WhereOrderFrom,'LINK')
      fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
      fseek(fid1,-50,1); fprintf(fid1,[time,' LNKR: ',upper(mname),'-',upper(name),'\n']); fclose(fid1);
      clear fid1       
    end
    fpwdataft=[max([1 length(datem(:,1))-374]) length(datem(:,1))];
  else    
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
    
    fpwdataft(1)=datef2(startd,datem);
    fpwdataft(2)=datef2(endd,datem);
    if fpwdataft(1)>fpwdataft(2)
      fpwdataft=fpwdataft([2 1]);
    end
  end
  Datem=datem;Stock=stock;
  
  % firstly find out tthe raw [stock datem]
  ToD=fpwdataspan(1);
  if ToD=='D'
    stock=stock(fpwdataft(1):fpwdataft(2),:);
    datem=datem(fpwdataft(1):fpwdataft(2),:);
    if fpwdataspan(2)=='W'
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
    elseif fpwdataspan(2)=='M'
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
    if upper(mname)=='S'
      stock(:,5)=stock(:,5)/1000;          
    end      
  else
    tickind=str2num(fpwdataspan(2:3));
    edate=datem(fpwdataft(1),:); %date from the 'From' date
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
          stock=stgetdaa(name,'t');
          stocklongdata=1;    
          if length(stock)>0          
            fffff=find((stock(:,1)==edate(1))&(stock(:,2)==edate(2))&(stock(:,3)==edate(3)));
            if length(fffff)>0
              stock=stock(fffff,:);
            else
              stock=stock(1:min([250 length(stock(:,1))]),:); 
            end
            datemfroms=stock(1,1:3);  
            datemends=stock(length(stock(:,1)),1:3);
          end          
        end        
      end
      if length(stock)>0
        datemt=stock(:,1:5);
        stockt=stock(:,6:10);
        if upper(mname)=='F'
          stockt(:,5)=stockt(:,5)*1000;
        else
          stockt(:,5)=stockt(:,5)/100;          
        end
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
          stock=stgetdaa(name,'t');
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
            datemt=[datemt;stock(i,1:5)];
            indexf=i+1;
          else
            if (stock(i-1,2)~=stock(i,2))&(indexf<i)
              stockt=[stockt;wsohlcv(stock(indexf:i-1,6:10))];
              datemt=[datemt;stock(i-1,1:5)];
              indexf=i;
            end
          end
        end
        if upper(mname)=='F'
          stockt(:,5)=stockt(:,5)*1000;
        else
          stockt(:,5)=stockt(:,5)/100;          
        end
      end
    end
    if length(stock)==0
      if upper(mname)=='S'
        stock=stgetdaa(name,'t',tickind/5*250);
        if length(stock)>0
          datemt=stock(:,1:5);
          stockt=stock(:,6:10);
          stockt(:,5)=stockt(:,5)/100;
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
  
  % to output maximum 375 bars per run
  datem=datem(1:min([375 length(datem(:,1))]),:);
  stock=stock(1:min([375 length(stock(:,1))]),:);   
  datem=datem(length(datem(:,1)):-1:1,:);
  stock=stock(length(stock(:,1)):-1:1,:);
 
  s.rdataResults=[datem stock]; 
  s.fpwusername=fpwusername;
  s.fpwusername4=fpwusername4;
  s.FSfpwfstype=mname;
  s.FSfpwsymbol=name;
  s.FSFirstorS='1';
  if stocklongdata==1 
    s.FSfpwFdate=date2str(datemfroms);
    s.FSfpwTdate=date2str(datemends);            
  else
    s.FSfpwFdate=date2str(Datem(fpwdataft(1),:));
    s.FSfpwTdate=date2str(Datem(fpwdataft(2),:));
  end
  s.FSfpwdataspan=fpwdataspan; 
  datestringout=[];
  for i=1:length(Datem(:,1))
    datestringout=[datestringout,sprintf('%02d%02d%02d',Datem(i,1:3))];
  end
  s.FSdatadatem=datestringout;
  s.FSfpwfindex=num2str(fpwdataft(1));
  s.FSfpwtindex=num2str(fpwdataft(2));
  s.fpwMXI=num2str(length(Datem(:,1)));  
  eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\fpwstrdata s stock datem']);
else
  if exist([fpwserverplace,fpwclientdirectory,fpwusername,'\stock\fpwstrdata.mat'])==2
    eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\stock\fpwstrdata']);
  else
    s.fpwusername=fpwusername;
    s.fpwusername4=fpwusername4;
    s.FSfpwfstype='S';
    s.FSfpwsymbol='UrSym';  
    s.FSFirstorS='0';
    s.rdataResults=[];     
    s.FSfpwFdate='01/03/90';
    s.FSfpwTdate='09/11/01';
    s.FSfpwdataspan='DD';
    s.FSdatadatem='010101010201010301010401010501010601070101';
    s.FSfpwfindex='1';
    s.FSfpwtindex='1';
    s.fpwMXI='1';
  end
end 
s.fpwusername=fpwusername;
s.fpwusername4=fpwusername4;

cd(fpwserverplace);
cids=fpwloginstatus(fpwusername,clock);
if ~(strcmp(upper(fpwusername(1:4)),'USER'))
  templatefile = which('wbstrdata.html');
else
  templatefile = which('wbstrdata_nlink.html');
end
s.fpwcurrentm=[s.FSfpwfstype,s.FSfpwsymbol];
s.fpwulvl=instruct.fpwulvl;
if (nargin == 1)
  retstr = htmlrep(s, templatefile);
elseif (nargin == 2)
  retstr = htmlrep(s, templatefile, outfile);
end 
end