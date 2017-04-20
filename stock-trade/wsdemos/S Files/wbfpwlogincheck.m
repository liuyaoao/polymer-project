function retstr = wbfpwlogincheck(instruct, outfile)

% Author(s): N. Zhu, 11-15-2003
% This is a WB (Web-Based) mirror program to <dzhckout.m> in desktop version
%save c:\matlab\stock\myfirsttest.mat
wbfpwbasic;
directnow=cd;
cd(fpwserverplace);
retstr = char('');
s={};

% Checking users' status
totalnumavailable=[1 1 1 1];
if 1 %fpwloginstatus('User01')==1 temperarily locked 1/21/2007
  s.s01='NA';
  totalnumavailable(1)=0;
else
  s.s01='<a href="javascript: fpwloginForm.fpwusername.value=''User01''; fpwloginForm.fpwpassword.value=''12345543''; fpwloginForm.mlmfile.value=''wbfpwlogin''; fpwloginForm.target=''_self''; fpwloginForm.submit();">OK</a>';    
end

if fpwloginstatus('User02')==1 %temperarily locked 1/21/2007
  s.s02='NA';
  totalnumavailable(2)=0;
else
  s.s02='<a href="javascript: fpwloginForm.fpwusername.value=''User02''; fpwloginForm.fpwpassword.value=''12345543''; fpwloginForm.mlmfile.value=''wbfpwlogin''; fpwloginForm.target=''_self''; fpwloginForm.submit();">OK</a>';     
end

if 1 %fpwloginstatus('User03')==1 temperarily locked 1/21/2007
  s.s03='NA';
  totalnumavailable(3)=0;
else
  s.s03='<a href="javascript: fpwloginForm.fpwusername.value=''User03''; fpwloginForm.fpwpassword.value=''12345543''; fpwloginForm.mlmfile.value=''wbfpwlogin''; fpwloginForm.target=''_self''; fpwloginForm.submit();">OK</a>'; 
end

if fpwloginstatus('User04')==1
  s.s04='NA';
  totalnumavailable(4)=0;
else
  s.s04='<a href="javascript: fpwloginForm.fpwusername.value=''User04''; fpwloginForm.fpwpassword.value=''12345543''; fpwloginForm.mlmfile.value=''wbfpwlogin''; fpwloginForm.target=''_self''; fpwloginForm.submit();">OK</a>';    
end

% Check if trading hours
tradinghours=0;
timevalue=clock;
cd([Wherematlab,'stock']);
markethourst;
cd(fpwserverplace);
timecal=timevalue(4)+timevalue(5)/60;
datetoday=[timevalue(2:3) timevalue(1)-2000];
if (timecal>openhourt-2)&(timecal<closehourt+2)&(dn(datetoday)<=5)
  if closehourt>openhourt
    tradinghours=1;
  end
end

% Arrange available users
if tradinghours==1
  if sum(totalnumavailable)>1
    % find the last available id to make sure at least one is available when it is really available
    b=find(totalnumavailable==1);
    ii=b(length(b))-1;
    for i=1:ii
      if (ceil(100*rand)<65)&(totalnumavailable(i)==1)
        eval(['s.s0',sprintf('%1d',i),'=''NA'';']);
      end
    end
  end
else
  if sum(totalnumavailable)>1
    b=find(totalnumavailable==1);
    ii=b(length(b))-1;      
    for i=1:ii
      if (ceil(100*rand)<35)&(totalnumavailable(i)==1)
        eval(['s.s0',sprintf('%1d',i),'=''NA'';']);
      end
    end  
  end
end

% Rotating middle small Pictur
fpwserverplaceimages=[fpwserverplace,'\images'];
middlesmallnum=sprintf('%02d',ceil(50*rand));
if exist([fpwserverplaceimages,'\middlesmall',middlesmallnum,'.jpg'],'file')==2
  s.msfnum=['images\middlesmall',middlesmallnum,'.jpg'];
else
  s.msfnum=['images\middlesmall06.jpg'];
end

% Rotating top long banner logo
toplongnum=sprintf('%1d',ceil(9*rand));
if exist([fpwserverplaceimages,'\toplong',toplongnum,toplongnum,'1.jpg'],'file')==2
  s.tlbnum=['images\toplong',toplongnum,toplongnum,'1.jpg'];
else
  s.tlbnum=['images\toplong111.jpg'];
end
if exist([fpwserverplaceimages,'\toplong',toplongnum,toplongnum,'1.jpg'],'file')==2
  s.tlsnum=['images\toplong',toplongnum,toplongnum,'2.jpg'];
else
  s.tlsnum=['images\toplong112.jpg'];
end

todaynum=clock;
chanceare=ceil(50*rand);
if chanceare<40
  if (todaynum(2)==1)&(abs(todaynum(3)-1)<=2)         % New Year
    if chanceare<13
      s.msfnum=['images\middlesmall11.jpg'];
    elseif chanceare<27
      s.msfnum=['images\middlesmall54.jpg']; 
    elseif chanceare<40
      s.msfnum=['images\middlesmall57.jpg'];
    end
    s.tlbnum=['images\toplong111.jpg']; 
    s.tlsnum=['images\toplong112.jpg'];     
  elseif (todaynum(2)==7)&(abs(todaynum(3)-4)<=1)     % National Day
    if chanceare<10
      s.msfnum=['images\middlesmall59.jpg'];
    elseif chanceare<20
      s.msfnum=['images\middlesmall52.jpg']; 
    elseif chanceare<30
      s.msfnum=['images\middlesmall55.jpg'];
    elseif chanceare<40
      s.msfnum=['images\middlesmall56.jpg'];      
    end
    s.tlbnum=['images\toplong111.jpg']; 
    s.tlsnum=['images\toplong112.jpg'];     
  elseif (todaynum(2)==9)&(abs(todaynum(3)-11)<=1)    % 911 Memory Day
    if chanceare<20
      s.msfnum=['images\middlesmall58.jpg'];
    elseif chanceare<40
      s.msfnum=['images\middlesmall10.jpg'];
    end
    s.tlbnum=['images\toplong111.jpg']; 
    s.tlsnum=['images\toplong112.jpg']; 
  elseif (todaynum(2)==12)&(abs(todaynum(3)-25)<=1)   % Xmas Day
    if chanceare<13
      s.msfnum=['images\middlesmall43.jpg'];
    elseif chanceare<27
      s.msfnum=['images\middlesmall51.jpg']; 
    elseif chanceare<40
      s.msfnum=['images\middlesmall53.jpg'];
    end
    s.tlbnum=['images\toplong111.jpg']; 
    s.tlsnum=['images\toplong112.jpg'];     
  end
end

% output results
templatefile = which('wbfpwloginb.html');
retstr = htmlrep(s, templatefile);