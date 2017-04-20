% add noise database directories:

global Rsddataplace Rstdataplace tickdayplacesc
global Rstdataplacesc Rfddataplace Wherematlab DIRDETOK mname
global Rftdataplace Realcleandataft Realcleandatafd Realcleandataftd

global Ddatahist1 Ddatahist2 Ddatahist3 Ddatahist4 Ddatahist5 Ddatapit
       Ddatapit=1;Ddatahist1=zeros(1,8); Ddatahist2=zeros(1,8);
       Ddatahist3=zeros(1,8);Ddatahist4=zeros(1,8);Ddatahist5=zeros(1,8);
global Tdatahist1 Tdatahist2 Tdatahist3 Tdatahist4 Tdatahist5 Tdatapit
       Tdatapit=1;Tdatahist1=zeros(1,10); Tdatahist2=Tdatahist1;
       Tdatahist3=zeros(1,10);Tdatahist4=zeros(1,10);Tdatahist5=zeros(1,10);       
       
global TGSHOW SCREENSIZE fpwserverplace fpwclientdirectory websiteplace
TGSHOW=0; SCREENSIZE=[1 1 1024 768];       
       
CHOOSEyourpcname=1400; % 1100(same for PCQUOTE and 2400) 1400 3700, 

if CHOOSEyourpcname==1100
  % for Dell 1100 notebook, PCQUOTE and 2400
  Realcleandataft='c:\matlab\data\realdata\tick\';  % clean tick data if add noise by <tdgetdat>
  Realcleandatafd='c:\matlab\data\realdata\daily\'; % clean daily data if add noise by <tdgetdat>
  Realcleandataftd='c:\matlab\pattern\realdata\';  % clean tick/daily data if add noise by <noisclen>
  Rfddataplace='c:\matlab\data\future\daily\';  
    % futures daily database - filename in futures name, 30M/200M
    % but stock and future zones database is under zones here, 40M/2G
  Rftdataplace='c:\matlab\data\future\tick\';
    % futures tick database - filename in futures name for every half year, 160M/3G
  tickdayplacesc='c:\matlab\data\future\stocktd\'; 
    % stock tick/day database - filename in date for all stocks,130M/10G
  Rsddataplace='c:\matlab\data\stock\';
    % stock daily database - filename in stocks name, 730M/3G
  Rstdataplace='c:\matlab\data\ticstock\';
    % stock tick database - filename in stocks name for every half year, 10M/40G
  Rstdataplacesc='c:\matlab\data\tikstock\'; 
    % stock tick database in stocks name for stock centre  120M/12G
elseif CHOOSEyourpcname==1400  
  % for server Dell PowerEdge 1400SC
  Realcleandataft='d:\data\realdata\tick\';  % clean tick data if add noise by <tdgetdat>
  Realcleandatafd='d:\data\realdata\daily\'; % clean daily data if add noise by <tdgetdat>
  Realcleandataftd='c:\matlab\pattern\realdata\';  % clean tick/daily data if add noise by <noisclen>
  Rfddataplace='d:\data\future\daily\';  
    % futures daily database - filename in futures name, 30M/200M
    % but stock and future zones database is under zones here, 40M/2G
  Rftdataplace='d:\data\future\tick\';
    % futures tick database - filename in futures name for every half year, 160M/3G
  tickdayplacesc='d:\data\future\stocktd\'; 
    % stock tick/day database - filename in date for all stocks,130M/10G
  Rsddataplace='d:\data\stock\';
    % stock daily database - filename in stocks name, 730M/3G
  Rstdataplace='d:\data\ticstock\';
    % stock tick database - filename in stocks name for every half year, 10M/40G
  Rstdataplacesc='d:\data\tikstock\'; 
    % stock tick database in stocks name for stock centre  120M/12G
elseif CHOOSEyourpcname==3700
  % for Dell 3700 notebook
  Realcleandataft='e:\realdata\tick\';  % clean tick data if add noise by <tdgetdat>
  Realcleandatafd='e:\realdata\daily\'; % clean daily data if add noise by <tdgetdat>
  Realcleandataftd='c:\matlab\pattern\realdata\';  % clean tick/daily data if add noise by <noisclen>
  Rfddataplace='e:\data\future\daily\';  
    % futures daily database - filename in futures name, 30M/200M
    % but stock and future zones database is under zones here, 40M/2G
  Rftdataplace='e:\data\future\tick\';
    % futures tick database - filename in futures name for every half year, 160M/3G
  tickdayplacesc='e:\data\future\stocktd\'; 
    % stock tick/day database - filename in date for all stocks,130M/10G
  Rsddataplace='d:\data\stock\';
    % stock daily database - filename in stocks name, 730M/3G
  Rstdataplace='d:\data\ticstock\';
    % stock tick database - filename in stocks name for every half year, 10M/40G
  Rstdataplacesc='d:\data\tikstock\'; 
    % stock tick database in stocks name for stock centre  120M/12G
end

DIRDETOK=0; mname='S';
Wherematlab='c:\matlab\';
SDsource='c:\bmi_data\ud\';

global fpwserverplace fpwclientdirectory
fpwserverplace=[Wherematlab,'toolbox\webserver\wsdemos'];
fpwclientdirectory='\WSQSIFPW\';  % this subdire nested immediately under <fpwserverplace>
                                     % may seperately nested anywhere later
websiteplace=''; %'http://192.168.2.8';                                     
                                     
                                     
                                     
                                     