function retstr = wbnewpoint(instruct, outfile)

% Author(s): Ning Zhu, 8-22-2010
% This is a WB (Web-Based) NP card number generating and verifying program

% User level:
% Level 1: Can training to enter data and check what data should use, npRunIndex: 11
% level 2: Can check NP Card Number valid or not, npRunIndex: 11, 13
% Level 3: Can check NP Card Number valid or not and see the account details, npRunIndex: 11, 13, 14
% Level 4: Can generate card number and save to database, npRunIndex: 11, 12, 13, 14
% Level 5: Will have the authority to see what the real actual card number is when showrealnumber==1.
% level 6: Will have the authority to see what the real actual card number is no matter showrealnumber's set

retstr = char('');
WhereOrderFrom=instruct.WhereOrderFrom;
Wherematlab='c:\matlab\';
SDsource='c:\bmi_data\ud\';
fpwserverplace=[Wherematlab,'toolbox\webserver\wsdemos'];
npCardNumind=0;
showrealnumber=0; % to show the real number if level is level 5 or higher

npUserLevel=str2num(instruct.npUserLevel);
if length(npUserLevel)==0 % it happens when not open from other link.
  npUserLevel=4;   % During test period, set to level 4, otherwise to level 1 only
end
npUserName=instruct.npUserName;
npUserName='Ning ZHU';

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                                                                          %
    %    Need to Make a UserName & UserLevel Database to Maintain Security.    %
    %                                                                          %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% NPCARDSSN:[SSN ANnumber Zip BankName +/-mmddyyyy];
% NPEMAILP: individual memebers's email list (limited to 35 letters)
% NPCNTAXID:[TaxID ANumber Zip BankName]
% NPEMAILC: Commercial memebers's email list (limited to 35 letters)

if (exist([fpwserverplace,'\WSQSIFPW\NPCARD\NPCARDSSN.mat'])==2)
  eval(['load ',fpwserverplace,'\WSQSIFPW\NPCARD\NPCARDSSN.mat'])
else
  NPCARDSSN='';
end

if (exist([fpwserverplace,'\WSQSIFPW\NPCARD\NPCNTAXID.mat'])==2)
  eval(['load ',fpwserverplace,'\WSQSIFPW\NPCARD\NPCNTAXID.mat'])
else
  NPCNTAXID='';
end

markchosen='0000';
markchosenn=[0 0 0 0];
for i=1:4
  if isfield(instruct,['MARK',num2str(i+32)])
    markchosen(i)='1';
    markchosenn(i)=1;
  end
end
ErrorP='';
npRunIndex=str2num(instruct.npRunIndex);

if (npRunIndex==11)|(npRunIndex==12)

  npFamilyName=upper(noempty(instruct.npFamilyName));
  if length(npFamilyName)==0
    if markchosenn(1)==1
     ErrorP=[ErrorP,'Did not fill Family Name correctly. '];
    end
  end
  
  npFullName=upper(instruct.npFullName);
  if length(npFullName)>0
    npFullName=strrep(npFullName,'  ',' ');
    if length(npFullName)>0
      if (npFullName(1)==' ')
        if length(npFullName)>1
          npFullName=npFullName(2:length(npFullName)); 
        else
          npFullName='';  
          if markchosenn(1)==1
            ErrorP=[ErrorP,'Did not fill Full Name correctly. '];
          end
        end
      end
    end
    if length(npFullName)>0
      if (npFullName(length(npFullName))==' ')
        if length(npFullName)>1
          npFullName=npFullName(1:length(npFullName)-1); 
        else
          npFullName='';  
          if markchosenn(1)==1
            ErrorP=[ErrorP,'Did not fill Full Name correctly. '];
          end
        end
      end
    end
  end
  
  if markchosenn(1)==1
    if length(findstr(npFullName,npFamilyName))==0
      ErrorP=[ErrorP,'Family Name missed in the Full Name. '];
    else
      nameinname=findstr(npFullName,npFamilyName);
      if strcmp(npFullName(nameinname(length(nameinname)):length(npFullName)),npFamilyName)~=1
        ErrorP=[ErrorP,'Family Name should be in the end of the Full Name. '];
      end
    end
  end
        
  npMonth=str2num(instruct.npMonth);
  npDay=str2num(instruct.npDay);
  npYear=str2num(noempty(instruct.npYear));
  if length(npYear)==1
    if (datenum(clock)-datenum([npYear npMonth npDay]))/365>100 % too old to open an account
      if markchosenn(1)==1
        ErrorP=[ErrorP,'Are you sure abour your age? '];
      end
    elseif (datenum(clock)-datenum([npYear npMonth npDay]))/365<16 % only 16 years old or older can open an account
      if markchosenn(1)==1
        ErrorP=[ErrorP,'You are too young to open NP Account. '];      
      end
    end
  else
    if markchosenn(1)==1
      ErrorP=[ErrorP,'Did not fill your birth year information correctly. '];      
    end
  end
  
  monthdn=[31 29 31 30 31 30 31 31 30 31 30 31];
  if monthdn(npMonth)-npDay<0
    ErrorP=[ErrorP,'Entered a wrong date. '];  
  end
  if (rem(1600+npYear-2012,4)~=0)&(npMonth==2)&(npDay==29)
    ErrorP=[ErrorP,['No Feb. 29th in ',num2str(npYear),'. ']];  
  end
  
  npSSN=noempty(instruct.npSSN);
  npSSN=strrep(npSSN,'-','');
  npSSN=strrep(npSSN,'X','');
  if (length(npSSN)~=9)|(length(str2num(npSSN))==0)
    if markchosenn(1)==1
      ErrorP=[ErrorP,'Did not fill correct SSN number. '];      
    end
  end
  
  npCompanyName=instruct.npCompanyName;
  if length(npCompanyName)>0
    npCompanyName=strrep(npCompanyName,'  ',' ');
    if length(npCompanyName)>0
      if (npCompanyName(1)==' ')
        if length(npCompanyName)>1
          npCompanyName=npCompanyName(2:length(npCompanyName)); 
        else
          npCompanyName='';  
          if markchosenn(2)==1
            ErrorP=[ErrorP,'Did not fill Company Name correctly. '];
          end
        end
      end
    end
    if length(npCompanyName)>0
      if (npCompanyName(length(npCompanyName))==' ')
        if length(npCompanyName)>1
          npCompanyName=npCompanyName(1:length(npCompanyName)-1); 
        else
          npCompanyName='';  
          if markchosenn(2)==1
            ErrorP=[ErrorP,'Did not fill Company Name correctly. '];
          end
        end
      end
    end
  end
  
  npCNTaxID=noempty(instruct.npCNTaxID);
  npCNTaxID=strrep(npCNTaxID,'-','');
  npCNTaxID=strrep(npCNTaxID,'.','');
  npCNTaxID=strrep(npCNTaxID,'X','');
  if (length(npCNTaxID)~=9)|(length(str2num(npCNTaxID))==0)
    if markchosenn(2)==1
      ErrorP=[ErrorP,'Did not fill correct Company Tax ID. '];      
    end
  end
  
  % Check SSN or TaxID current list to see duplicate
  if markchosenn(1)==1
    if length(NPCARDSSN)>0
      if length(find(NPCARDSSN(:,1)-str2num(npSSN)==0))>0
        ErrorP=[ErrorP,'This SSN ID has been used to open a NP Account'];
      end
    end
  else
    if length(NPCNTAXID)>0
      if length(find(NPCNTAXID(:,1)-str2num(npCNTaxID)==0))>0
        ErrorP=[ErrorP,'This Tax ID has been used to open a NP Account'];
      end
    end
  end
  
  npCNFamilyName=noempty(instruct.npCNFamilyName);
  if length(npCNFamilyName)==0
    if markchosenn(2)==1
      ErrorP=[ErrorP,'Did not fill manager Family Name correctly. '];
    end
  end
  
  npCNFullName=instruct.npCNFullName;
  if length(npCNFullName)>0
    npCNFullName=strrep(npCNFullName,'  ',' ');
    if length(npCNFullName)>0
      if (npCNFullName(1)==' ')
        if length(npCNFullName)>1
          npCNFullName=npCNFullName(2:length(npCNFullName)); 
        else
          npCNFullName='';  
          if markchosenn(2)==1
            ErrorP=[ErrorP,'Did not fill manager Full Name correctly. '];
          end
        end
      end
    end
    if length(npCNFullName)>0
      if (npCNFullName(length(npCNFullName))==' ')
        if length(npCNFullName)>1
          npCNFullName=npCNFullName(1:length(npCNFullName)-1); 
        else
          npCNFullName='';  
          if markchosenn(2)==1
            ErrorP=[ErrorP,'Did not fill manager Full Name correctly. '];
          end
        end
      end
    end
  end
  
  if markchosenn(2)==1
    if length(findstr(npCNFullName,npCNFamilyName))==0
      ErrorP=[ErrorP,'Manager Family Name missed in the Full name. '];
    else
      nameinname=findstr(npCNFullName,npCNFamilyName);
      if strcmp(npCNFullName(nameinname(length(nameinname)):length(npCNFullName)),npCNFamilyName)~=1
        ErrorP=[ErrorP,'Manager Family Name should be in the end part of the Full Name. '];
      end
    end
  end
  
  npCNPosition=noempty(instruct.npCNPosition);
  if length(npCNPosition)==0
    if markchosenn(2)==1
      ErrorP=[ErrorP,'Did not fill manager Position correctly. '];
    end
  end
  
  npEmail=noempty(instruct.npEmail);
  if length(npEmail)>0
    if length(strfind(npEmail,'@'))~=1
      ErrorP=[ErrorP,'Email has no @ sign, '];
    elseif length(strfind(npEmail,'.'))==0
      ErrorP=[ErrorP,'Email has no dot, '];   
    elseif npEmail(1)=='@'       
      ErrorP=[ErrorP,'Email has no username, '];
    else
      cc=strfind(npEmail,'.');
      if length(npEmail)-cc(length(cc))<2
      ErrorP=[ErrorP,'Email domain name error, ']; 
      end
    end
  else
    ErrorP=[ErrorP,'No Email, '];
  end  
  
  npAddress=instruct.npAddress;
  if length(npAddress)>0
    npAddress=strrep(npAddress,'  ',' ');
    if length(npAddress)>0
      if (npAddress(1)==' ')
        if length(npAddress)>1
          npAddress=npAddress(2:length(npAddress)); 
        else
          npAddress='';  
          ErrorP=[ErrorP,'Did not fill Address information correctly. '];
        end
      end
    end
    if length(npAddress)>0
      if (npAddress(length(npAddress))==' ')
        if length(npAddress)>1
          npAddress=npAddress(1:length(npAddress)-1); 
        else
          npAddress='';  
          ErrorP=[ErrorP,'Did not fill Address information correctly. '];
        end
      end
    end
  end
  
  npCity=instruct.npCity;
  if length(npCity)>0
    npCity=strrep(npCity,'  ',' ');
    if length(npCity)>0
      if (npCity(1)==' ')
        if length(npCity)>1
          npCity=npCity(2:length(npCity)); 
        else
          npCity='';  
          ErrorP=[ErrorP,'Did not fill City information correctly. '];
        end
      end
    end
    if length(npCity)>0
      if (npCity(length(npCity))==' ')
        if length(npCity)>1
          npCity=npCity(1:length(npCity)-1); 
        else
          npCity='';  
          ErrorP=[ErrorP,'Did not fill City information correctly. '];
        end
      end
    end
  end
  
  npZip=noempty(instruct.npZip);
  npZip=strrep(npZip,'X','');
  if (length(npZip)~=5)|(length(str2num(npZip))==0)
    ErrorP=[ErrorP,'Did not fill correct ZIP information. '];      
  end
  
  npPhoneNumber=noempty(instruct.npPhoneNumber);
  npPhoneNumber=strrep(npPhoneNumber,'-','');
  npPhoneNumber=strrep(npPhoneNumber,'.','');
  npPhoneNumber=strrep(npPhoneNumber,'X','');
  if (length(npPhoneNumber)~=10)|(length(str2num(npPhoneNumber))==0)
    ErrorP=[ErrorP,'Did not fill correct Phone number. '];      
  end
  
  npState=instruct.npState;
  if length(npState)>2
    ErrorP=[ErrorP,'Choose the state where the address is located in. '];   
  end
  npCountry='United States'; % So far, only work in USA.
  npBankName=instruct.npBankName;
  
  if sum(markchosenn(1:2))==0
    ErrorP=[ErrorP,'Please Choose Individual or Commercial. ']; 
  end
  if (sum(markchosenn(3:4))==0)&(markchosenn(1)==1)
    ErrorP=[ErrorP,'Please Choose Your Gender. ']; 
  end
    
  if length(ErrorP)==0
  % calculate card number and save, if needed.
    npCardNum='0000000000000000000'; 
    if markchosenn(1)==1 % Check individual data

      if npMonth>1
        dnoty=sum(monthdn(1:npMonth-1))+npDay;
      else
        dnoty=npDay;
      end
      
      if markchosenn(3)==1 %male+100(+222),female+500(-222)
        dnoty=dnoty+100;
        ncnd4to6=rem(npYear+222,1000);
        ncnd7to11=str2num(npBankName)+fix(dnoty/100);
      else
        dnoty=dnoty+500;
        ncnd4to6=rem(npYear-222,1000);
        ncnd7to11=str2num(npBankName)-fix(dnoty/100);
      end
      
      CCN1=sprintf('%03d',dnoty);
      CCN2=sprintf('%03d',ncnd4to6);
      CCN3=sprintf('%05d',ncnd7to11);
      CCN4=[npSSN(7:9),npZip(1:2)];
      
      % To get stable output, fix choose order as below. 
      % So, when run '11' or '12', one will get the same results.
      % If one wants to get randum number, just change below condition to '1==1'
      if 1==0
        my100num=0:99;
        my100numf=my100num*0;
        for ii=1:length(my100numf)-1
          my100numfi=min([length(my100num) fix(rand*(length(my100num)-1))+1+round(2*rand)]);
          my100numf(ii)=my100num(my100numfi);
          if my100numfi==1
            my100num=my100num(2:length(my100num));
          elseif my100numfi==length(my100num)
            my100num=my100num(1:length(my100num)-1); 
          else
            my100num=[my100num(1:my100numfi-1) my100num(my100numfi+1:(length(my100num)))];
          end
        end
        my100numf(length(my100numf))=my100num;
        clear ii my100num my100numfi
      else
        my100numf=[41 91 32 59 83 57 80 68 40 16 84 95 87 43 94 22 17 38 58 29 14 24 50 55 33,...
                 28 26 52 27 47  2 74 23 79 51 48 82 99 72 46  7 36 89 97  1 85 18 61 70 44,...
                 98  6 90 21 11 71 15  9 63 42 35 13 62 56 77 78 66 31  5 30  4 96 60 75 81,...
                 10  3 88 12 67 37 45 69 65 64 54 73 86 92 34 25 53  0 20 76 93  8 49 39 19];
      end
      
      luhnchecked=0; luhncheckedi=1;
      while luhnchecked==0
        CCN5=[sprintf('%02d',my100numf(luhncheckedi)),'0'];
        npCardNum=[CCN1,CCN2,CCN3,CCN4,CCN5];
        luhncheckedi=luhncheckedi+1;
        
        % find luhncheck number for the 19th digit
        [lcpass lcrem]=luhntest(npCardNum);
        if lcpass~=1
          npCardNum(length(npCardNum))=num2str(10-lcrem);
        end
        
        % To Check if this number has been used
        if (exist([fpwserverplace,'\WSQSIFPW\NPCARD\',npCardNum,'.mat'])==0)
          if length(NPCARDSSN)>0
            if length(find(NPCARDSSN(:,2)-str2num(npCardNum)==0))==0
              luhnchecked=1;
            else
              npRemark=['SSO 1 - Strange Thing Happen: ',npCardNum]; 
            end
          else
            luhnchecked=1;
          end
        end
      end
    else % Check commercial data
      CCN1='9';
      CCN2=npCNTaxID(1:5);
      CCN3=npBankName;
      CCN4=npCNTaxID(6:9);
      CCN5=[npZip(1:3),'0'];
      npCardNum=[CCN1,CCN2,CCN3,CCN4,CCN5];
      
      % find luhncheck number for the 19th digit
      [lcpass lcrem]=luhntest(npCardNum);
      if lcpass~=1
        npCardNum(length(npCardNum))=num2str(10-lcrem);
      end
    end 
    
    % generate keys npKeys then output fake card number npANumber
    % If one wants to fix reshuffle otder change below to 1==0
    if 1==1
      my100num=1:26;
      my100numf=my100num*0;
      for ii=1:length(my100numf)-1
        my100numfi=min([length(my100num) fix(rand*(length(my100num)-1))+1+round(2*rand)]);
        my100numf(ii)=my100num(my100numfi);
        if my100numfi==1
          my100num=my100num(2:length(my100num));
        elseif my100numfi==length(my100num)
          my100num=my100num(1:length(my100num)-1); 
        else
          my100num=[my100num(1:my100numfi-1) my100num(my100numfi+1:(length(my100num)))];
        end
      end
      my100numf(length(my100numf))=my100num;
      Keyseeds=['ABCDEFGHIJKLMNOPQRSTUVWXYZ'];
      npKeys=Keyseeds(my100numf(1:length(npCardNum)+1));
      clear ii my100num my100numfi my100numf Keyseeds
    else
      npKeys='ABCSDREQFPGOHNIMJLKZ';
    end
    
    % To generate the front printing Card Number
    [mMnN Indi]=sort(abs(npKeys(1:length(npCardNum))));
    npANumber='0000000000000000000';
    for ii=1:length(npCardNum)
      npANumber(Indi(ii))=npCardNum(ii);
    end
    npCardNumind=1;
  end
  
elseif (npRunIndex==13)|(npRunIndex==14)
    
  ErrorP=''; npRemarkind=0;
  
  npANumber=noempty(instruct.npANumber);
  npANumber=strrep(npANumber,'-','');
  if (length(npANumber)~=19)|(length(str2num(npANumber))==0)
    ErrorP=[ErrorP,'Did not fill a correct NP Account number. '];      
  end
  
  npKeys=upper(noempty(instruct.npKeys));
  npKeys=strrep(npKeys,'-','');
  npKeys=strrep(npKeys,'.','');
  if (length(npKeys)~=20)
    ErrorP=[ErrorP,'Did not fill the correct 20 NP Keys. '];      
  end
  
  if (length(find(abs(npKeys)>90))>0)|(length(find(abs(npKeys)<65))>0)
    ErrorP=[ErrorP,'Keys consist of only alphabet letters. '];
  end
  
  % Find the real backside real NP number
  if length(ErrorP)==0
    npCardNum='0000000000000000000';
    [mMnN Indi]=sort(abs(npKeys(1:length(npANumber))));
    npCardNum=npANumber(Indi);
    realnumber=[npCardNum(1:4),' ',npCardNum(5:8),' ',npCardNum(9:12),' ',npCardNum(13:16),' ',npCardNum(17:19)];
    
    % Check Status and out put npRemark
    if (exist([fpwserverplace,'\WSQSIFPW\NPCARD\',npCardNum,'.mat'])==2)
      if str2num(npCardNum(1))~=9
        if length(NPCARDSSN)>0
          if length(find(NPCARDSSN(:,2)-str2num(npCardNum)==0))==1
            npRemarkind=1;
            npRemark='This is a valid individual NP card. For detailed information about it, ';
            npRemark=[npRemark,'click Details button, if you are authorized. '];
          else
            if (npUserLevel>=3)
              npRemark=['SSO 2 - Strange Thing Happen: ',npCardNum];
            else
              npRemark='SSO 2 - Strange Thing Happen. '
            end
          end
        else
          npRemarkind=0;
          npRemark='This is not a valid NP card. ';
        end
      else
        if length(NPCNTAXID)>0
          if length(find(NPCNTAXID(:,2)-str2num(npCardNum)==0))==1
            npRemarkind=1;
            npRemark='This is a valid commercial NP card. For detailed information about it, ';
            npRemark=[npRemark,'click Details button, if you are authorized. '];
          else
            if (npUserLevel>=3)
              npRemark=['SSO 2 - Strange Thing Happen: ',npCardNum];
            else
              npRemark='SSO 2 - Strange Thing Happen. '
            end
          end
        else
          npRemarkind=0;
          npRemark='This is not a valid NP card. ';
        end
      end
    else
      npRemark='This is not a valid NP card. ';
      npRemarkind=0;
    end
    
    % Compare Keys:
    if (npRemarkind==1)
      eval(['load ',fpwserverplace,'\WSQSIFPW\NPCARD\',npCardNum,'.mat']);
      if strcmp(upper(noempty(npKeys)),upper(noempty(BZSTRU.npKeys)))~=1
        npRemarkind=0;
        npRemark='Account Number and Keys do not match. ';
      end
    end
  else
    npRemark=ErrorP;
  end
end

% Prepare data for output back to user

if npRunIndex==10 % whne to initialize the program from other webpage later
  s.npRemark='Write Your Remarks to NP Here: ';
  s.npRemark1='Please answer all questions, fill in all applicable items.';
  s.markchosen='0000';
  s.npFamilyName=' ';
  s.npFullName=' ';
  s.npMonth='5';
  s.npDay='16';
  s.npYear='XXXX';
  s.npSSN='XXX-XX-XXXX';
  s.npCompanyName=' ';
  s.npCNTaxID='XX-XXXXXXX';
  s.npCNFamilyName=' ';
  s.npCNFullName=' ';
  s.npCNPosition='Chairman, CEO, CFO or others';
  s.npEmail='someone@some.com';
  s.npAddress=' ';
  s.npCity=' ';
  s.npZip='XXXXX';
  s.npPhoneNumber='XXX-XXX-XXXX';
  s.npState='NY';
  s.npCountry='United States';
  s.npBankName='00001';
  s.npANumber=' ';
  s.npKeys=' ';
end

if (npRunIndex==11)|(npRunIndex==12)
  s.markchosen=markchosen;
  if npCardNumind==1;
    realnumber=[npCardNum(1:4),' ',npCardNum(5:8),' ',npCardNum(9:12),' ',npCardNum(13:16),' ',npCardNum(17:19)];
    if npRunIndex==11
      if ((showrealnumber==1)&(npUserLevel==5))|(npUserLevel==6)
        s.npRemark=['All information has been correctly answered. NP Card is ready to issue. The real card number is ',realnumber];
      else
        s.npRemark=['All information has been correctly answered. NP Card is ready to issue.'];
      end
    else
      if ((showrealnumber==1)&(npUserLevel==5))|(npUserLevel==6)
        s.npRemark=['NP Card number has been confirmed and saved to the database as shown above. The real card number is ',realnumber,'. Please write down them in a safe place'];  
      else
        s.npRemark=['NP Card number has been confirmed and saved to the database as shown above. Please write down them in a safe place'];  
      end
    end
    s.npRemark1='Please answer all questions, fill in all applicable items.';
    s.npANumber=[npANumber(1:4),'  ',npANumber(5:8),'  ',npANumber(9:12),'  ',npANumber(13:16),'  ',npANumber(17:19)];
    s.npKeys=[npKeys(1:5),'  ',npKeys(6:10),'  ',npKeys(11:15),'  ',npKeys(16:20)];
  else
    s.npRemark1=ErrorP;
    if length(ErrorP)==0
      s.npRemark1='Please answer all questions, fill in all applicable items.';
    else
      s.npRemark='Please see Note message on the top.';
    end
    s.npANumber=' ';
    s.npKeys=' ';
  end
  
  if length(npFamilyName)>0
    s.npFamilyName=upfirst(npFamilyName);
  else
    s.npFamilyName=' '; 
  end
  
  if length(npFullName)>0
    s.npFullName=upfirst(npFullName);
  else
    s.npFullName=' '; 
  end
  s.npMonth=num2str(npMonth);
  s.npDay=num2str(npDay);
  
  if length(npYear)>0
    s.npYear=num2str(npYear);
  else
    s.npYear='XXXX';
  end
  
  if length(npSSN)==9
    s.npSSN=[npSSN(1:3),'-',npSSN(4:5),'-',npSSN(6:9)];
  else
    if length(npSSN)==0
      s.npSSN='XXX-XX-XXXX';
    else
      s.npSSN=npSSN;  
    end
  end
    
  if length(npCompanyName)>0
    s.npCompanyName=upfirst(npCompanyName);
  else
    s.npCompanyName=' ';
  end
  
  if length(npCNTaxID)==9
    s.npCNTaxID=[npCNTaxID(1:2),'-',npCNTaxID(3:9)];
  else
    if length(npCNTaxID)==0
      s.npCNTaxID='XX-XXXXXXX';
    else
      s.npCNTaxID=npCNTaxID;
    end
  end
  
  if length(npCNFamilyName)>0
    s.npCNFamilyName=upfirst(npCNFamilyName);
  else
    s.npCNFamilyName=' ';
  end

  if length(npCNFullName)>0
    s.npCNFullName=upfirst(npCNFullName);
  else
    s.npCNFullName=' ';
  end
  
  if length(npCNPosition)>0
    s.npCNPosition=upper(npCNPosition);
    if strcmp(noempty(upper('Chairman, CEO, CFO or others')),noempty(upper(npCNPosition)))
      s.npCNPosition='Chairman, CEO, CFO or others';  
    end
  else
    s.npCNPosition='Chairman, CEO, CFO or others';
  end
  
  if length(npEmail)>0
    s.npEmail=lower(npEmail);
  else
    s.npEmail='someone@some.com';
  end
  
  if length(npAddress)>0
    s.npAddress=upfirst(npAddress);
  else
    s.npAddress=' ';
  end
  
  if length(npCity)>0
    s.npCity=upfirst(npCity);  
  else
    s.npCity=' ';
  end
  
  if length(npZip)>0
    s.npZip=npZip;
  else
    s.npZip='XXXXX';
  end
  
  if length(npPhoneNumber)==10
    s.npPhoneNumber=[npPhoneNumber(1:3),'-',npPhoneNumber(4:6),'-',npPhoneNumber(7:10)];
  else
    if length(npPhoneNumber)==0
      s.npPhoneNumber='XXX-XXX-XXXX';
    else
      s.npPhoneNumber=npPhoneNumber;    
    end
  end
  
  s.npState=npState;
  s.npCountry=npCountry;
  s.npBankName=npBankName;
  
end

if (npRunIndex==13)|(npRunIndex==14)
  if npRunIndex==13
    s=instruct; 
    if npUserLevel>=2
      s.npRemark=npRemark;
    else
      s.npRemark=['Sorry, your UserLevel does not allow you to perform this operation'];
    end
  else
    if (npRemarkind==1)&(npUserLevel>=3)
      s=BZSTRU; 
      markchosen=s.markchosen;
      if markchosen(1)=='1'
        npRemark='This is a valid individual NP card. Its detailed information ';  
      else
        npRemark='This is a valid commercial NP card. Its detailed information ';
      end
      if ((showrealnumber==1)&(npUserLevel==5))|(npUserLevel==6)
        npRemark=[npRemark,'has been shown in the above. The real card number is: ',realnumber,'.'];
      else
        npRemark=[npRemark,'has been shown in the above.'];
      end
      s.npRemark=npRemark;
    else
      s=instruct; 
      if npUserLevel<3
        s.npRemark=['Sorry, your UserLevel does not allow you to perform this operation']; 
      else
        s.npRemark=npRemark; 
      end
    end
  end
  s.markchosen=markchosen;
  s.npANumber=[npANumber(1:4),'  ',npANumber(5:8),'  ',npANumber(9:12),'  ',npANumber(13:16),'  ',npANumber(17:19)];
  s.npKeys=[npKeys(1:5),'  ',npKeys(6:10),'  ',npKeys(11:15),'  ',npKeys(16:20)];
end

s.npUserLevel=num2str(npUserLevel); % restore back to original user level in case after 14 run
s.npUserName=npUserName; % restore back to original user name in case after 14 run
s.npDMYH=time;  
s.npRunIndex=num2str(npRunIndex);
s.npComment='';

% To save and update the confirmed information to the database
if (npRunIndex==12)&(npCardNumind==1)
  s.npANumber=npANumber;
  s.npKeys=npKeys;
  if (npUserLevel>=4)
    BZSTRU=s;
    NPEMAILPc='                                   ';     
    NPEMAILPc(1:min([35 length(npEmail)]))=npEmail(1:min([35 length(npEmail)])); 
    eval(['save ',fpwserverplace,'\WSQSIFPW\NPCARD\',npCardNum,'.mat BZSTRU']);    
    if markchosenn(1)==1
      if markchosenn(3)==1
        NPCARDSSN=[NPCARDSSN;[str2num(npSSN) str2num(npCardNum) str2num(npZip) str2num(npBankName) 10000*npDay+1000000*npMonth+npYear]];
      else
        NPCARDSSN=[NPCARDSSN;[str2num(npSSN) str2num(npCardNum) str2num(npZip) str2num(npBankName) -(10000*npDay+1000000*npMonth+npYear)]];
      end
      eval(['save ',fpwserverplace,'\WSQSIFPW\NPCARD\NPCARDSSN.mat NPCARDSSN']);
      % add email here: load and save
      if exist([fpwserverplace,'\WSQSIFPW\NPCARD\NPEMAILP.MAT']);
        eval(['load ',fpwserverplace,'\WSQSIFPW\NPCARD\NPEMAILP.MAT']);
        NPEMAILP=[NPEMAILP;NPEMAILPc];
      else
        NPEMAILP=NPEMAILPc;
      end
      eval(['save ',fpwserverplace,'\WSQSIFPW\NPCARD\NPEMAILP.MAT NPEMAILP']);
    else
      NPCNTAXID=[NPCNTAXID;[str2num(npCNTaxID) str2num(npCardNum) str2num(npZip) str2num(npBankName)]];
      eval(['save ',fpwserverplace,'\WSQSIFPW\NPCARD\NPCNTAXID.mat NPCNTAXID']);
      if exist([fpwserverplace,'\WSQSIFPW\NPCARD\NPEMAILC.MAT']);
        eval(['load ',fpwserverplace,'\WSQSIFPW\NPCARD\NPEMAILC.MAT']);
        NPEMAILC=[NPEMAILC;NPEMAILPc];
      else
        NPEMAILC=NPEMAILPc;
      end
      eval(['save ',fpwserverplace,'\WSQSIFPW\NPCARD\NPEMAILC.MAT NPEMAILC']);
    end
  else
    s.npRemark=['Sorry, your UserLevel does not allow you to perform this operation'];
  end
  s.npANumber=[npANumber(1:4),'  ',npANumber(5:8),'  ',npANumber(9:12),'  ',npANumber(13:16),'  ',npANumber(17:19)];
  s.npKeys=[npKeys(1:5),'  ',npKeys(6:10),'  ',npKeys(11:15),'  ',npKeys(16:20)];
end

s.npComment=  ['Below are the generated NP card number and its associated keys (',s.npDMYH,'):'];
if (npRunIndex==13)
  s.npComment=['To enter NP card number and its associated keys below to Check (',s.npDMYH,'):'];
end
if (npRunIndex==14)
  if (npRemarkind==1)&(npUserLevel>=3)
    s.npDMYH=BZSTRU.npDMYH;
    s.npComment=['Below were the generated NP card number and its associated keys (',s.npDMYH,'):'];
  else
    s.npComment=['To enter NP card number and its associated keys below to Check (',s.npDMYH,'):'];
  end
end
if length(ErrorP)~=0
  s.npComment=['To enter NP card number and its associated keys below to Check (',s.npDMYH,'):'];  
end

cd(fpwserverplace);
templatefile = which('wbnewpoint.html');
if (nargin == 1)
  retstr = htmlrep(s, templatefile);
elseif (nargin == 2)
  retstr = htmlrep(s, templatefile, outfile);
end 