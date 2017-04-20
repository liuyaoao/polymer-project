function retstr = wbnpwfbook(instruct, outfile)

% Author(s): Ning Zhu, 1-17-2011
% This is a WB (Web-Based) NP World Fact Book Edit/Review program

retstr = char('');
WhereOrderFrom=instruct.WhereOrderFrom;
Wherematlab='c:\matlab\';
fpwserverplace=[Wherematlab,'toolbox\webserver\wsdemos'];

npwfUserLevel=str2num(instruct.npwfUserLevel);
npwfUserName=instruct.npwfUserName;
npwfRunIndex=instruct.npwfRunIndex; %1-Review, 2-Save

s.npwfUserLevel='1';
s.npwfUserName='Ning ZHU';
s.npwfRunIndex=instruct.npwfRunIndex;

if strcmp(WhereOrderFrom,'SELF')
  npwfCountry=instruct.npwfCountry;
  nw=upper(npwfCountry);
  if length(noempty(npwfCountry))==0
    npwfCountry='us';  
  end
  s.npwfCountry=npwfCountry;
  if (strcmp(nw,'XX'))
    s.npwfMapPlace='images/mapworld.gif';
  else
    s.npwfMapPlace=['https://www.cia.gov/library/publications/the-world-factbook/graphics/maps/newmaps/',noempty(npwfCountry),'-map.gif'];
  end
  s.npwfCIAPlace=['https://www.cia.gov/library/publications/the-world-factbook/geos/',noempty(npwfCountry),'.html'];
  if (strcmp(nw,'XX'))|(strcmp(nw,'EE'))|(strcmp(nw,'XQ'))|(strcmp(nw,'ZH'))|(strcmp(nw,'XO'))|(strcmp(nw,'OO'))|(strcmp(nw,'PG'))|(strcmp(nw,'ZN'))
    s.npwfFlagPlace='images/NPLogoSmall.jpg';
    if (strcmp(nw,'XX'))
      s.npwfFlagPlace='images/unflag.gif'; 
    end
  else
    s.npwfFlagPlace=['https://www.cia.gov/library/publications/the-world-factbook/graphics/flags/large/',noempty(npwfCountry),'-lgflag.gif'];
  end
else
  npwfCountry='us'; 
  s.npwfCountry='us';
  s.npwfFlagPlace='https://www.cia.gov/library/publications/the-world-factbook/graphics/flags/large/us-lgflag.gif';
  s.npwfMapPlace='https://www.cia.gov/library/publications/the-world-factbook/graphics/maps/newmaps/us-map.gif';
  s.npwfCIAPlace=['https://www.cia.gov/library/publications/the-world-factbook/geos/us.html'];
end

if strcmp(npwfRunIndex,'11') % Review
  if (exist([fpwserverplace,'\WSQSIFPW\NPCARD\NPWFB\',noempty(npwfCountry),'.MAT'])==2)
    eval(['load ',fpwserverplace,'\WSQSIFPW\NPCARD\NPWFB\',noempty(npwfCountry),'.MAT'])
    for j=1:6
      for i=1:5
        eval(['s.npwf',int2str(j),int2str(i),'2=MywfData.npwf',int2str(j),int2str(i),'2;'])  
      end
    end  
    s.StatusReport=['Data loaded. One can edit and then save changes. ',time1];
  else
    for j=1:6
      for i=1:5
        eval(['s.npwf',int2str(j),int2str(i),'2=''No Data Yet.'';'])
      end
    end  
    s.StatusReport=['No data yet for this country. You can create one and then save them now. ',time1];
  end
  
  if strcmp(instruct.npwfUserLevel,'0')
    s.StatusReport=['Please choose a country or a location. ',time1];  
  end 
  
  templatefile = which('MPsimulationR1.html');
  str = htmlrep(s, templatefile,[fpwserverplace,'\WSQSIFPW\NPCARD\twbfpwinputR1.html'],'noheader');
  s.npwfReport='/WSQSIFPW/NPCARD/twbfpwinputR1.html';
elseif strcmp(npwfRunIndex,'12')
  for j=1:6
    for i=1:5
      eval(['MywfData.npwf',int2str(j),int2str(i),'2=instruct.npwf',int2str(j),int2str(i),'2;'])  
    end
  end
  eval(['save ',fpwserverplace,'\WSQSIFPW\NPCARD\NPWFB\',noempty(npwfCountry),'.MAT MywfData'])
  s.StatusReport=['Data saved. ',time1];
end

cd(fpwserverplace);

if strcmp(upper(instruct.npwfDMYH),'ENGLISH')
  if strcmp(npwfRunIndex,'11')
    templatefile = which('wbnpwfbooks1.html');
  else
    templatefile = which('MPsimulationR1.html');
    str = htmlrep(s, templatefile,[fpwserverplace,'\WSQSIFPW\NPCARD\twbfpwinputR1.html'],'noheader');
    s.npwfReport='/WSQSIFPW/NPCARD/twbfpwinputR1.html';
  end
else
  if strcmp(npwfRunIndex,'11')
    templatefile = which('wbnpwfbooksc1.html');
  else
    templatefile = which('MPsimulationR1.html');
    str = htmlrep(s, templatefile,[fpwserverplace,'\WSQSIFPW\NPCARD\twbfpwinputR1.html'],'noheader');
    s.npwfReport='/WSQSIFPW/NPCARD/twbfpwinputR1.html';
  end
end

if (nargin == 1)
  retstr = htmlrep(s, templatefile);
elseif (nargin == 2)
  retstr = htmlrep(s, templatefile, outfile);
end