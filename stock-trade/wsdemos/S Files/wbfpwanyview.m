function retstr = wbfpwanyview(instruct,outfile)

% Author(s): N. Zhu, 5-9-2006
% This is used to show user's Any input data at lower part in a new window.

wbfpwbasic;
cd(fpwserverplace);
retstr = char('');
fpwusername=instruct.mlid{1};
fpwCPAL=3;
fpwloginIP='192.168.2.8';
fpwcheckil;

if fpwcheckilpass==1
  eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,'\pattern\fpwfrontout']);   
  global mname name stock datem
  name=fpwout.name; mname=fpwout.mname; Mname1=mname; Name1=name; 
  datem=fpwout.datem; stock=fpwout.stock; 
  tradeh=fpwout.tradeh; tradeo=fpwout.tradeo; tradeeach=fpwout.tradeeach;
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
  TradeD=datem(tradeh(:,3),1:3);
  wafw=instruct.outAnyU;
  watw=instruct.outAnyD; 
  
  TD=TradeD; TDT=[TD(:,1:3) tradeh(:,9)];
  
  if ((length(findstr(wafw,'LABAC'))>0)|(length(findstr(watw,'LABAC'))>0))+...
    ((length(findstr(upper(wafw),'VCRAF'))>0)|(length(findstr(upper(watw),'VCRAF'))>0))+...
    ((length(findstr(upper(wafw),'STATOUT'))>0)|(length(findstr(upper(watw),'STATOUT'))>0))>1
    error('  VCRAF, STATOUT and LABAC could not work at the same time.');
  end
  if (length(findstr(wafw,'LABAC'))>0)|(length(findstr(watw,'LABAC'))>0)
    [LABAC LABACONH]=lotsabac(tradeh,datem);
  end
  
  o=stock(:,1); h=stock(:,2); l=stock(:,3); c=stock(:,4); v=stock(:,5); TH=tradeh;
  
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
  i=tradeh(:,3);
  vf15mi=0;
  ii=(1:length(TH(:,1)))';
  wstd350b;
  
  fpwviewform='8.2f';
  fpwviewformi=strfind(upper(watw),'FORM');
  if length(fpwviewformi)
    fpwviewform=noempty(watw(fpwviewformi(1)+4:length(watw)));
    watw=watw(1:fpwviewformi(1)-1);
  end
  fpwmat2view=eval(watw); % lower Any Part
  
  mywbfpwhistrect='';
  mywbfpwhistrect=[mywbfpwhistrect,sprintf(' \n')];
  mywbfpwhistrect=[mywbfpwhistrect,'Your input data '' ',watw,' '' are:',sprintf(' \n\n')];
  if ~ischar(fpwmat2view)
    if sum(sum(abs(rem(fpwmat2view,1))))==0
      fpwviewform='7.0f';
    end
    mywbfpwhistrec=ningstrrep(ningmat2str(fpwmat2view,fpwviewform),';',[char(10) char(32)],'[',' ',']','');
  else
    mywbfpwhistrec=fpwmat2view;
  end
  s.mywbfpwhistrec=[mywbfpwhistrect,mywbfpwhistrec];
else
  s.mywbfpwhistrec='wrong user information.';  
end
s.fpwusername=fpwusername;
s.fpwusername4=instruct.mlid4;
s.fpwulvl=instruct.fpwulvl;
s.fpwshowtitle='Here is the Any Data Output for the Lower Part.';
s.myShowingTitle='Interface During Developing';

cids=fpwloginstatus(fpwusername,clock);
templatefile = which('wbfpwhistrec1.html');
if (nargin == 1)
  retstr = htmlrep(s, templatefile);
elseif (nargin == 2)
  retstr = htmlrep(s, templatefile, outfile);
end