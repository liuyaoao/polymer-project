function retstr = wbstmpsls(instruct, outfile)

% Author(s): N. Zhu, 11-15-2003
% This is a WB (Web-Based) mirror program to <stsimulp>, <stsiedit>, <stsirun> and more in desktop version

wbfpwbasic;
cd(fpwserverplace);

retstr = char('');
fpwusername=instruct.mlid{1};
fpwCPAL=2;
fpwloginIP='192.168.2.8';
fpwcheckil;

if fpwcheckilpass==1
  WhereOrderFrom=instruct.WhereOrderFrom;
  if isfield(instruct,'tntvalue')
    tntvalue=instruct.tntvalue;
  else
    tntvalue='T';
  end
  cd([Wherematlab,'stock']);
    
  fid1=fopen([fpwserverplace,fpwclientdirectory,fpwusername,'\history\history.txt'],'at');
  fseek(fid1,-50,1); fprintf(fid1,[time,'PPLN\n']); fclose(fid1);
  clear fid1

  mpplistnet=instruct.mpplistnet;
  thousandnum=str2num(instruct.thousandnum);
  addminus=str2num(instruct.addminus); 
  thousandnum=thousandnum+addminus;
  fpwGL=instruct.fpwGL;
    
  if fpwGL(1)=='A'
    if strcmp(mpplistnet,'L')
      TLi=[str2num(instruct.TLinextl) str2num(instruct.TLinexth)];
      [mystrh thousandnum]=wbstsimulist(fpwusername,1,thousandnum,TLi);
      smps.TLoutput=mystrh; clear mystrh
    else
      [mystrh thousandnum]=wbstsimunet(fpwusername,1,thousandnum,tntvalue);
    end
  else
    mystrh='Here is';
  end
  
  if ~strcmp(mpplistnet,'L')
    smps.fpwzoneoutput=mystrh; clear mystrh 
  end
  
  smps.wbstsimulist=[fpwclientdirectory,fpwusername,'/stock/twbstsimulist.html'];
  smps.fpwusername=fpwusername;
  smps.fpwusername4=fpwusername4;
  smps.fpwulvl=instruct.fpwulvl;
  smps.mpplistnet=mpplistnet;
  smps.thousandnum=num2str(thousandnum);
  smps.addminus=num2str(addminus);  
  smps.tntvalue=tntvalue;
  if strcmp(fpwGL,'BA')
    smps.tradedollar=[fpwclientdirectory,fpwusername,'/stock/tradenumber.jpeg'];
  elseif strcmp(fpwGL,'BB')
    smps.tradedollar=[fpwclientdirectory,fpwusername,'/stock/dollarposi.jpeg'];
  elseif strcmp(fpwGL,'BC')
    smps.tradedollar=[fpwclientdirectory,fpwusername,'/stock/withspyhedge.jpeg'];
  elseif strcmp(fpwGL,'BD')
    smps.tradedollar=[fpwclientdirectory,fpwusername,'/stock/DNNET.jpeg'];
  end
  
  cd([fpwserverplace,fpwclientdirectory,fpwusername,'\stock']);
  templatefile = which('wbstsimulist.html');
  str = htmlrep(smps, templatefile,[fpwserverplace,fpwclientdirectory,fpwusername,'\stock\twbstsimulist.html'],'noheader');
  
  cids=fpwloginstatus(fpwusername,clock);
  if fpwGL(1)=='A'
    if strcmp(mpplistnet,'L')
      smps.TLinextl=num2str(TLi(1));
      smps.TLinexth=num2str(TLi(2));
      templatefile = which('wbstmpsls2.html');    
      %templatefile = which('wbstsimulist.html');    
    else
      templatefile = which('wbstmpsls1.html');
    end
  else
    templatefile = which('wbstmpsls3.html');
  end
  if (nargin == 1)
    retstr = htmlrep(smps, templatefile);     
  elseif (nargin == 2)
    retstr = htmlrep(smps, templatefile, outfile);
  end
  
end