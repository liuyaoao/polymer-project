function retstr = wbfpwregi(instruct, outfile)

% Author(s): N. Zhu, 11-15-2003
% This is a WB (Web-Based) mirror program to <> in desktop version

wbfpwbasic;
cd(fpwserverplace);
retstr = char('');
WhereOrderFrom=instruct.WhereOrderFrom;

markchosen='0000000000000004';
ErrorP='';
if strcmp(WhereOrderFrom,'SLFE')
  if noempty(instruct.wfrFirstName)>0
    s.wfrFirstName=noempty(instruct.wfrFirstName);
  else
    ErrorP=[ErrorP,'No First Name, '];
    s.wfrFirstName=' ';
  end

  if noempty(instruct.wfrLastName)>0
    s.wfrLastName=noempty(instruct.wfrLastName);
  else
    ErrorP=[ErrorP,'No Last Name, '];
    s.wfrLastName=' ';
  end  
  
  % plus check email
  if noempty(instruct.wfrEmail)>0
    bb=noempty(instruct.wfrEmail);
    if length(strfind(bb,'@'))~=1
      ErrorP=[ErrorP,'Email @ Wrong, '];
    elseif length(strfind(bb,'.'))==0
      ErrorP=[ErrorP,'Email No Dot, '];   
    elseif strfind(bb,'@')==1       
      ErrorP=[ErrorP,'Email No User, '];
    else
      cc=strfind(bb,'.');
      if length(bb)-cc(length(cc))<2
        ErrorP=[ErrorP,'Email Domain error, ']; 
      end
    end
    s.wfrEmail=bb;
  else
    ErrorP=[ErrorP,'No Email, '];
    s.wfrEmail=' ';
  end  
  
  if noempty(instruct.wfrAddress)>0
    s.wfrAddress=instruct.wfrAddress;
    while s.wfrAddress(1)==' '
      s.wfrAddress=s.wfrAddress(2:length(s.wfrAddress));
    end
  else
    s.wfrAddress=' ';
  end  
  
  if noempty(instruct.wfrCity)>0
    s.wfrCity=instruct.wfrCity;
    while s.wfrCity(1)==' '
      s.wfrCity=s.wfrCity(2:length(s.wfrCity));
    end
  else
    s.wfrCity=' ';
  end  
  
  if noempty(instruct.wfrZip)>0
    s.wfrZip=instruct.wfrZip;
    while s.wfrZip(1)==' '
      s.wfrZip=s.wfrZip(2:length(s.wfrZip));
    end    
  else
    s.wfrZip=' ';
  end  
  
  if isfield(instruct,'wfrState')
    if noempty(instruct.wfrState)>0
      s.wfrState=instruct.wfrState;
    else
      ErrorP=[ErrorP,'No State, '];
      s.wfrState=' ';
    end
  else
    ErrorP=[ErrorP,'No State, '];
    s.wfrState=' '; 
  end
  
  if isfield(instruct,'wfrulevel')
    if noempty(instruct.wfrulevel)>0
      s.wfrulevel=instruct.wfrulevel;
    else
      ErrorP=[ErrorP,'No User Level, '];
      s.wfrulevel=' ';
    end
  else
    ErrorP=[ErrorP,'No User Level, '];
    s.wfrulevel=' '; 
  end
  
  if s.wfrulevel=='1.0'; s.wfrufee='USD99.00';end
  if s.wfrulevel=='1.1'; s.wfrufee='USD149.00';end
  if s.wfrulevel=='1.2'; s.wfrufee='USD149.00';end
  if s.wfrulevel=='1.3'; s.wfrufee='USD149.00';end 
  if s.wfrulevel=='1.4'; s.wfrufee='USD199.00';end
  if s.wfrulevel=='2.0'; s.wfrufee='USD599.00';end
  if s.wfrulevel=='3.0'; s.wfrufee='USD1499.00';end
  if s.wfrulevel=='4.0'
    s.wfrufee='USD1999.00';
  else
    s.wfrufee=' ';
  end    
      
  s.wfrCountry=instruct.wfrCountry;
  if noempty(instruct.wfrPhoneNumber)>0
    s.wfrPhoneNumber=instruct.wfrPhoneNumber;
    while s.wfrPhoneNumber(1)==' '
      s.wfrPhoneNumber=s.wfrPhoneNumber(2:length(s.wfrPhoneNumber));
    end
  else
    ErrorP=[ErrorP,'No PhoneNumber.'];
    s.wfrPhoneNumber=' ';
  end

  % feedback remarks
  fpwregim=str2mat('NYSE','OTC','AMEX','CME','CBOT','LME','CEC','Index','Metals',...
      'Financial','Energy','Currencies','Grains','Soft','Stocks','Under 1 year','1-3 years','3-10 years','Over 10 years');
  for i=1:15
    if isfield(instruct,['MARK',num2str(i+10)])
      markchosen(i)='1';
    end
  end
  if isfield(instruct,['MARK26'])
    if strcmp(instruct.MARK26,'Under 1 Year')
      markchosen(16)='0';
    elseif strcmp(instruct.MARK26,'1-3 Years')
      markchosen(16)='1';
    elseif strcmp(instruct.MARK26,'3-10 Years')
      markchosen(16)='2';
    elseif strcmp(instruct.MARK26,'Over 10 Years')
      markchosen(16)='3';        
    end
  end
  s.markchosen=markchosen;
  s.wfrremark=instruct.wfrremark;
  wfrremark=s.wfrremark;
  nomoreup=0;
  if length(ErrorP)==0
    if ~length(strfind(s.wfrremark,'Thank you very much'))
      cd([fpwserverplace,fpwclientdirectory,'register']);
      load regisn
      cd(fpwserverplace);
      s.wfrremark1=sprintf('<font color="blue" size="3" face="Arial"><b>Thank you very much. Please see remark area at the bottom.</b></font>');
      wfrremark=s.wfrremark;
      if (strcmp(wfrremark,'Your Remarks: ')==1)|(length(wfrremark)==0)
        s.wfrremark=['Thank you very much, your register No. is RF',num2str(regiserial),'. our representative will soon contact with you to complete your registration. ',time];
      else
        s.wfrremark=['Your remarks: "',s.wfrremark,'" Thank you very much, your register No. is RF',num2str(regiserial),'. our representative will soon contact with you to complete your registration. ',time];
      end
      retstr = htmlrep(s, 'wbfpwregi.html',[fpwserverplace,fpwclientdirectory,'register\RF',num2str(regiserial),'.html'],'noheader');
      cd([fpwserverplace,fpwclientdirectory,'register']);
      eval(['save RF',num2str(regiserial),' s']);
      regiserial=regiserial+1;
      save regisn regiserial
      cd(fpwserverplace);
      nomoreup=1;
    end
    if ~strcmp(s.wfrremark,'Thank you very much, you just registered.')
      if ~length(strfind(s.wfrremark,'Thank you very much, our representative will soon contact with you to complete your registration.'))
        if nomoreup==1; regiserial=regiserial-1; end
        if (strcmp(wfrremark,'Your Remarks: ')==1)|(length(wfrremark)==0)
          s.wfrremark=['Thank you very much, our representative will soon contact with you to complete your registration. Your register No. is RF',num2str(regiserial),'. ',time];
        else
          s.wfrremark=['Your remarks: "',wfrremark,'"  Thank you very much, our representative will soon contact with you to complete your registration. Your register No. is RF',num2str(regiserial),'. ',time];
        end
      else
        s.wfrremark='Thank you very much, you just registered.';   
      end
    end
    s.wfrremark1=sprintf('<font color="blue" size="3" face="Arial"><b>Thank you very much. Please see remark area at the bottom.</b></font>');
  else
    s.wfrremark1=sprintf('<font color="red" size="3" face="Arial"><b>Error:</b></font> %80s',ErrorP); 
  end 
elseif strcmp(WhereOrderFrom,'LOGI')
  s.wfrremark='Your Remarks: ';
  s.wfrremark1=sprintf('<font color="black" size="3" face="Arial"><b>Required Fields</b></font>');
  s.wfrFirstName=' ';
  s.wfrLastName=' '; 
  s.wfrEmail=' ';
  s.wfrAddress=' ';
  s.wfrCity=' ';
  s.wfrState=' ';
  s.wfrZip=' ';
  s.wfrCountry='United States';
  s.wfrPhoneNumber=' ';
  s.wfrTradingH=' ';  
  s.markchosen=markchosen;
  s.wfrulevel='0'; 
  s.wfrufee=' ';
end 

cd(fpwserverplace);
templatefile = which('wbfpwregi.html');
if (nargin == 1)
  retstr = htmlrep(s, templatefile);
elseif (nargin == 2)
  retstr = htmlrep(s, templatefile, outfile);
end 