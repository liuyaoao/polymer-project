function retstr = wbfpwregi(instruct, outfile)

% Author(s): N. Zhu, 11-15-2003
% This is a WB (Web-Based) mirror program to <> in desktop version

wbfpwbasic;
cd(fpwserverplace);
retstr = char('');
if isfield(instruct,'WhereOrderFrom')
  WhereOrderFrom=instruct.WhereOrderFrom;
else
  WhereOrderFrom='LOGI';
end

markchosen='1';
ErrorP='';
if strcmp(WhereOrderFrom,'SLFE')
  if noempty(instruct.fdkName)>0
    s.fdkName=noempty(instruct.fdkName);
  else
    ErrorP=[ErrorP,'No Name, '];
    s.fdkName=' ';
  end
  
  % plus check email
  if noempty(instruct.fdkEmail)>0
    bb=noempty(instruct.fdkEmail);
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
    s.fdkEmail=bb;
  else
    ErrorP=[ErrorP,'No Email, '];
    s.fdkEmail=' ';
  end  
  
  if noempty(instruct.fdkSubject)>0
    s.fdkSubject=instruct.fdkSubject;
    while s.fdkSubject(1)==' '
      s.fdkSubject=s.fdkSubject(2:length(s.fdkSubject));
    end
  else
    s.fdkSubject=' ';
    ErrorP=[ErrorP,'No Subject, '];
  end  
  
  if noempty(instruct.fdkContent)>0
    s.fdkContent=instruct.fdkContent;
  else
    s.fdkContent=' ';
    %ErrorP=[ErrorP,'No Content, '];
  end   
  
  if isfield(instruct,['fdkType'])
    if strcmp(instruct.fdkType,'site comment')
      s.fdkType2='Site Comment';
      markchosen='0';
    elseif strcmp(instruct.fdkType,'others')
      markchosen='2';    
      s.fdkType2='Others';
    else
      markchosen='1';   
      s.fdkType2='Tech Problem';
    end
  end
  s.markchosen=markchosen;
  
  s.fdkTime=time;
  s.fdkRemark=instruct.fdkRemark;
  nomoreup=0;
  if length(ErrorP)==0
    if ~length(strfind(s.fdkRemark,'Notes from FPW: Thank you very much'))
      cd([fpwserverplace,fpwclientdirectory,'FeedBack']);
      load fdkn
      cd(fpwserverplace);
      %eval(['save FDK',num2str(fdkserial),' s']);
      s.fdkRemark=['Notes from FPW: Thank you very much, we will answer your question as soon as possible. This communication ID is FDK',num2str(fdkserial),'. ',s.fdkTime];
      s.fdkNumber=['FDK',num2str(fdkserial)];
      retstr = htmlrep(s, 'wbfpwfeedback1.html',[fpwserverplace,fpwclientdirectory,'FeedBack\FDK',num2str(fdkserial),'.html'],'noheader');
      fdkserial=fdkserial+1;
      cd([fpwserverplace,fpwclientdirectory,'FeedBack']);
      save fdkn fdkserial
      cd(fpwserverplace);
      nomoreup=1;
    else
      s.fdkRemark='Notes from FPW: Thank you very much, you just sent.';   
    end
  else
    s.fdkRemark=['Notes from FPW: ',ErrorP];
  end 
elseif strcmp(WhereOrderFrom,'LOGI')
  s.fdkRemark='Notes from FPW: ';
  s.fdkName=' ';
  s.fdkEmail=' ';
  s.fdkSubject=' ';
  s.fdkContent=' ';
  s.markchosen='1';
end 

cd(fpwserverplace);
templatefile = which('wbfpwfeedback.html');
if (nargin == 1)
  retstr = htmlrep(s, templatefile);
elseif (nargin == 2)
  retstr = htmlrep(s, templatefile, outfile);
end 