function [instatus,intime,lat,outtime,loginle,loginIP2]=fpwloginstatus(fpwusername,lastacttime1,loginid1,loginIPh)

% function [instatus,intime,lat,outtime,loginle,loginIP2]=fpwloginstatus(fpwusername,lastacttime1,loginid1,loginIPh)
% fpwusername: wbfpw user name (if only this var entered, just to retrive user's loginstatus data
% lastacttime: to add an action stamp to loginstatus mat file, means what is the last action time, whatever action.
%              if only the first two vars entered, review and add time stamp, optional
% loginid1 : 0 - out or 1 - in; used to change loginstatus, if this enterd, to change login status, optional
% loginIPh  : sting, where loged in from, like '128.456.4.23'; optional
%
% instatus : 1 - in, 0 - out
% intime : last logintime
% lat    : last action time
% outtime: last logouttime
% loginle : user authority level
% loginIP2: where last action oder from, used to prevent multi-login.

global fpwserverplace fpwclientdirectory
fpwclientinfodire='\webclient1992816372146245525x051069z053063tmdtnndyournameinfofpw\'; % '\history\';
if exist([fpwserverplace,fpwclientdirectory,fpwusername,fpwclientinfodire,'fpwloginstatus.mat'])==2
  eval(['load ',fpwserverplace,fpwclientdirectory,fpwusername,fpwclientinfodire,'fpwloginstatus.mat']); 
else
  logouttime=clock; logouttime(1)=logouttime(1)-1; logintime=clock; loginlevel=0;
end
if nargin>1
  lastacttime=lastacttime1;
  if nargin>=3
    loginid=loginid1;
    if loginid==0
      logouttime=clock;
    else 
      logintime=clock;
    end
  end
  if nargin==4
    fpwloginIP=loginIPh;
  end
  eval(['save ',fpwserverplace,fpwclientdirectory,fpwusername,fpwclientinfodire,'fpwloginstatus logintime logouttime fpwloginIP loginid lastacttime loginlevel']);
end
instatus=loginid;
intime=logintime;
lat=lastacttime;
outtime=logouttime;
loginle=loginlevel;
loginIP2=fpwloginIP;